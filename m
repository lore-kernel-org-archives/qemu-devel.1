Received: from eggs.gnu.org ([2001:4830:134:3::10]:33424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cv7Wc-00071d-Sb
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cv7WY-00074U-U0
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:20:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cv7WY-00073x-LT
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:20:22 -0400
Date: Mon, 3 Apr 2017 16:20:11 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170403192011.GH1910@thinpad.lan.raisama.net>
References: <20170401004624.30886-1-ehabkost@redhat.com>
	<20170401004624.30886-3-ehabkost@redhat.com>
	<20170403105538.606f5ca9.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170403105538.606f5ca9.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [RFC 02/19] s390: Add FIXME for unexplained
 user_creatable=false line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>

On Mon, Apr 03, 2017 at 10:55:38AM +0200, Cornelia Huck wrote:
> On Fri, 31 Mar 2017 21:46:07 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > TYPE_S390_PCI_HOST_BRIDGE has user_creatable=false but has
> > no comment explaining why. Add a FIXME to document that.
> > 
> > Cc: Frank Blaschka <frank.blaschka@de.ibm.com>
> > Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> > Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> > Cc: Alexander Graf <agraf@suse.de>
> > Cc: Richard Henderson <rth@twiddle.net>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  hw/s390x/s390-pci-bus.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> > index 1ec30c45ce..2c3b960bdf 100644
> > --- a/hw/s390x/s390-pci-bus.c
> > +++ b/hw/s390x/s390-pci-bus.c
> > @@ -867,7 +867,7 @@ static void s390_pcihost_class_init(ObjectClass *klass, void *data)
> >      DeviceClass *dc = DEVICE_CLASS(klass);
> >      HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
> >  
> > -    dc->user_creatable = false;
> > +    dc->user_creatable = false; /*FIXME: explain why */
> >      dc->reset = s390_pcihost_reset;
> >      k->init = s390_pcihost_init;
> >      hc->plug = s390_pcihost_hot_plug;
> 
> (adding some more possibly interested parties)
> 
> We currently have one master s390 phb (and it's been that way since
> s390 pci was introduced). Recently, there has been some remodelling
> going on to make this more similar to what sPAPR does. I think we could
> make this even more similar to sPAPR and have this user createable; but
> I'm currently not sure it's worth the effort. Opinions?

It looks -device s390-pcihost was never possible, anyway, because
no s390x machine has has_dynamic_sysbus=1, and TYPE_PCI_HOST_BRIDGE
is a sys-bus-device.

Also, patch 03/19 on this series would make the explicit
user_creatable=false assignment in s390_pcihost_class_init()
unnecessary.

I don't think it is worth the effort to change that, unless you
have a specific use case that would benefit from it.

-- 
Eduardo
