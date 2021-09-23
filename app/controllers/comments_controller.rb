class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @prototype = Prototype.find(params[:prototype_id] || params[:id])
    @comments = @prototype.comments.includes(:user)
    if @comment.save
      redirect_to prototype_path(@comment.prototype)
    else
      render "prototypes/show"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end