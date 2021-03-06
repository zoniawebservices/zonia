class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        contact = @contact
        ContactmailerMailer.contact_email(contact).deliver
        format.html { redirect_to root_path, notice: 'Hi, Will get in touch soon.' }
        format.json { redirect_to root_path, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end

    end
  end


    private
      # Use callbacks to share common setup or constraints between actions.
      def set_contact
        @contact = contact.find(params[:id])
      end


      # Never trust parameters from the scary internet, only allow the white list through.
      def contact_params
        params.require(:contact).permit(:name, :email, :ideaname, :country, :phone, :message, :lead, :management_id )
      end


end
