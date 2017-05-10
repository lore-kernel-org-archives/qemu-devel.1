Received: from eggs.gnu.org ([2001:4830:134:3::10]:34537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d8WHq-0001zy-4z
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:24:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d8WHn-0008Aj-19
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:24:34 -0400
Date: Wed, 10 May 2017 21:24:25 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170510212407-mutt-send-email-mst@kernel.org>
References: <20170510092903.23649-1-marcel@redhat.com>
	<fc62fe0c-01b3-8744-64f4-d03a2adf06f2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc62fe0c-01b3-8744-64f4-d03a2adf06f2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Revert "hw/pci: disable pci-bridge's shpc
 by default"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org

On Wed, May 10, 2017 at 05:38:45PM +0200, Paolo Bonzini wrote:
> 
> 
> On 10/05/2017 11:29, Marcel Apfelbaum wrote:
> > +++ b/hw/pci-bridge/pci_bridge_dev.c
> > @@ -163,7 +163,7 @@ static Property pci_bridge_dev_properties[] = {
> >      DEFINE_PROP_ON_OFF_AUTO(PCI_BRIDGE_DEV_PROP_MSI, PCIBridgeDev, msi,
> >                              ON_OFF_AUTO_AUTO),
> >      DEFINE_PROP_BIT(PCI_BRIDGE_DEV_PROP_SHPC, PCIBridgeDev, flags,
> > -                    PCI_BRIDGE_DEV_F_SHPC_REQ, false),
> > +                    PCI_BRIDGE_DEV_F_SHPC_REQ, true),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >  
> > diff --git a/include/hw/compat.h b/include/hw/compat.h
> > index 846b90e..eff021f 100644
> > --- a/include/hw/compat.h
> > +++ b/include/hw/compat.h
> > @@ -18,10 +18,6 @@
> >          .property = "old-multiple-chip-handling",\
> >          .value    = "on",\
> >      },{\
> > -        .driver   = "pci-bridge",\
> > -        .property = "shpc",\
> > -        .value    = "on",\
> > -    },{\
> 
> Unless we make a conscious decision to break PCI bridge backwards
> compatibility, you now have to disable it for 2.9 and leave this
> HW_COMPAT_2_8 hunk intact.  Peter Xu has a patch to add the 2.10 machine
> types.
> 
> Paolo
> 
> >          .driver   = TYPE_PCI_DEVICE,\
> >          .property = "x-pcie-extcap-init",\
> >          .value    = "off",\
> > -- 2.9.3


It's going upstream now, I just need to rebase.

-- 
MST
