Received: from eggs.gnu.org ([2001:4830:134:3::10]:34427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzApz-0005Wh-6W
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 20:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzApy-0001Py-45
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 20:13:27 -0400
Date: Mon, 2 Oct 2017 21:12:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171003001257.GA7087@localhost.localdomain>
References: <20170927195635.16014-1-ehabkost@redhat.com>
	<20170927195635.16014-5-ehabkost@redhat.com>
	<59CCD0150200007800180507@prv-mh.provo.novell.com>
	<20170928131234.GP4115@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170928131234.GP4115@localhost.localdomain>
Subject: [Qemu-devel] xen-pci-passthrough PCI Express support? (Re:
 [Xen-devel] [PATCH v2 4/5] pci: Add INTERFACE_CONVENTIONAL_PCI_DEVICE to
 Conventional PCI devices)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Beulich <JBeulich@suse.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, David Gibson <dgibson@redhat.com>, Jiri Slaby <jslaby@suse.cz>, Hannes Reinecke <hare@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Marcel Apfelbaum <marcel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org, Laine Stump <laine@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@imgtec.com>, Alistair Francis <alistair23@gmail.com>, John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On Thu, Sep 28, 2017 at 10:12:34AM -0300, Eduardo Habkost wrote:
> On Thu, Sep 28, 2017 at 02:33:57AM -0600, Jan Beulich wrote:
> > >>> On 27.09.17 at 21:56, <ehabkost@redhat.com> wrote:
> > > --- a/hw/xen/xen_pt.c
> > > +++ b/hw/xen/xen_pt.c
> > > @@ -964,6 +964,10 @@ static const TypeInfo xen_pci_passthrough_info = {
> > >      .instance_size = sizeof(XenPCIPassthroughState),
> > >      .instance_finalize = xen_pci_passthrough_finalize,
> > >      .class_init = xen_pci_passthrough_class_init,
> > > +    .interfaces = (InterfaceInfo[]) {
> > > +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> > > +        { },
> > > +    },
> > >  };
> > 
> > Passed through devices can be both PCI and PCIe, so following
> > the description of the patch I don't think these can be statically
> > given either property. Granted quite a bit of PCIe specific
> > functionality may be missing in the Xen code ...
> 
> This is just static data about what the device type supports, not
> about what a given device instance really is.  Deciding if the
> device is PCIe or Conventional at runtime is out of the scope of
> this series.
> 
> That said, if passed through PCI Express devices are really
> supported, it looks like this should be marked as hybrid.

Can anybody confirm if PCI Express devices are really supported
by xen-pci-passthrough?

I suggest we add only INTERFACE_CONVENTIONAL_PCI_DEVICE to the
class info until we confirm that.

(In other words, apply this patch as-is, and add
INTERFACE_PCIE_DEVICE later as a follow-up patch if appropriate.)

-- 
Eduardo
