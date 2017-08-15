Received: from eggs.gnu.org ([2001:4830:134:3::10]:48111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dhkne-0002BU-O7
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 18:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dhknb-0003p8-Km
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 18:59:02 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:38113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dhknb-0003nZ-8u
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 18:58:59 -0400
Received: by mail-lf0-x243.google.com with SMTP id y15so1415338lfd.5
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 15:58:57 -0700 (PDT)
Date: Wed, 16 Aug 2017 00:58:54 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170815225854.GP4859@toto>
References: <1502807418-9994-1-git-send-email-peter.maydell@linaro.org>
	<a7372d5b-5826-7a50-20ca-73081f1bb4c6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7372d5b-5826-7a50-20ca-73081f1bb4c6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] mmio-interface: Mark as not user
 creatable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, patches@linaro.org, KONRAD Frederic <frederic.konrad@adacore.com>

On Tue, Aug 15, 2017 at 06:16:22PM +0200, Thomas Huth wrote:
> On 15.08.2017 16:30, Peter Maydell wrote:
> > The mmio-interface device is not something we want to allow
> > users to create on the command line:
> >  * it is intended as an implementation detail of the memory
> >    subsystem, which gets created and deleted by that
> >    subsystem on demand; it makes no sense to create it
> >    by hand on the command line
> >  * it uses a pointer property 'host_ptr' which can't be
> >    set on the command line
> > 
> > Mark the device as not user_creatable to avoid confusion.
> > 
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  hw/misc/mmio_interface.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/hw/misc/mmio_interface.c b/hw/misc/mmio_interface.c
> > index da154e5..894e980 100644
> > --- a/hw/misc/mmio_interface.c
> > +++ b/hw/misc/mmio_interface.c
> > @@ -111,6 +111,11 @@ static void mmio_interface_class_init(ObjectClass *oc, void *data)
> >      dc->realize = mmio_interface_realize;
> >      dc->unrealize = mmio_interface_unrealize;
> >      dc->props = mmio_interface_properties;
> > +    /* Reason: pointer property "host_ptr", and this device
> > +     * is an implementation detail of the memory subsystem,
> > +     * not intended to be created directly by the user.
> > +     */
> > +    dc->user_creatable = false;
> >  }
> >  
> >  static const TypeInfo mmio_interface_info = {
> > 
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
