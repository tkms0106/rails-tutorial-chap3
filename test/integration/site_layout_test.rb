require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  def assert_link(path, count=1)
    assert_select "a[href=?]", path, count
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_link root_path, 2
    assert_link help_path
    assert_link about_path
    assert_link contact_path
    assert_link login_path
    assert_link users_path, 0
    assert_link user_path(@user.id), 0
    assert_link edit_user_path(@user.id), 0
    assert_link logout_path, 0
    get contact_path
    assert_select "title", full_title("Contact")
    get signup_path
    assert_select "title", full_title("Sign up")
  end

  test "layout links when logged in" do
    log_in_as @user
    get root_path
    assert_template 'static_pages/home'
    assert_link root_path, 2
    assert_link help_path
    assert_link about_path
    assert_link contact_path
    assert_link login_path, 0
    assert_link users_path
    assert_link user_path(@user.id), 3
    assert_link edit_user_path(@user.id)
    assert_link logout_path
  end
end
