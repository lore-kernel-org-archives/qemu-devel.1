Received: from eggs.gnu.org ([209.51.188.92]:38567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkOJy-0004qR-T2
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 02:12:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkOJy-00010j-78
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 02:12:06 -0500
Received: from mga17.intel.com ([192.55.52.151]:5214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gkOJx-0000w7-Tq
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 02:12:06 -0500
Date: Fri, 18 Jan 2019 15:08:23 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190118070823.GA13961@yangzhon-Virtual>
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-24-yang.zhong@intel.com>
	<8f2984fd-68e4-eb00-d384-2bcddeefa049@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f2984fd-68e4-eb00-d384-2bcddeefa049@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 23/37] build: convert pci.mak to
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, sameo@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com, Yang Zhong <yang.zhong@intel.com>

On Wed, Jan 16, 2019 at 12:41:17PM +0100, Thomas Huth wrote:
> 
> The e1000e is a PCI-e device, so maybe this should rather depend on
> "PCIE" instead?
> 
  Thanks Thomas, yes, i will change this.  Yang

> With that fixed:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> 
> >  config RTL8139_PCI
> >      bool
> > +    default y
> > +    depends on PCI
> >  
> >  config VMXNET3_PCI
> >      bool
> > +    default y
> > +    depends on PCI
> [...]
> > diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
> > index cbf5c5d761..f23c542d27 100644
> > --- a/hw/usb/Kconfig
> > +++ b/hw/usb/Kconfig
> > @@ -3,21 +3,31 @@ config USB
> >  
> >  config USB_UHCI
> >      bool
> > +    default y
> > +    depends on PCI
> >  
> >  config USB_OHCI
> >      bool
> > +    default y
> > +    depends on PCI
> >  
> >  config USB_EHCI
> >      bool
> > +    default y
> > +    depends on PCI
> 
> We might need a USB_EHCI_PCI switch in the future (since there is also
> _SYSBUS which could be used without PCI), but I think that can be done
> in a later patch.
>
   Thanks Thomas, we can put this patch in second stage. Yang
 
>  Thomas
