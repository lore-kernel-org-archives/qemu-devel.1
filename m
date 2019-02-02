Received: from eggs.gnu.org ([209.51.188.92]:43161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gppKg-0004rz-9b
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 02:03:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gppKc-0006Nn-AK
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 02:03:16 -0500
Received: from mga05.intel.com ([192.55.52.43]:41924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gppKa-0006FU-D6
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 02:03:13 -0500
Date: Sat, 2 Feb 2019 14:59:18 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190202065918.GA9771@yangzhon-Virtual>
References: <20190131073234.18037-1-yang.zhong@intel.com>
	<20190131073234.18037-28-yang.zhong@intel.com>
	<7ff49749-92c8-b0f1-2fd5-6d8a3625f0a3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ff49749-92c8-b0f1-2fd5-6d8a3625f0a3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 27/27] hw/vfio/Makefile.objs: Create new
 CONFIG_* variables for VFIO core and PCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, yang.zhong@intel.com

On Thu, Jan 31, 2019 at 09:48:54AM +0100, Thomas Huth wrote:
> On 2019-01-31 08:32, Yang Zhong wrote:
> > From: Paolo Bonzini <pbonzini@redhat.com>
> > 
> > Make hw/vfio configurable and add new CONFIG_VFIO_* to the
> > default-configs/s390x*-softmmu.mak.  This allow a finer-grain
> > selection of the various VFIO backends.
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  default-configs/arm-softmmu.mak   | 2 ++
> >  default-configs/pci.mak           | 2 ++
> >  default-configs/ppc64-softmmu.mak | 1 +
> >  default-configs/s390x-softmmu.mak | 5 +++--
> >  hw/Makefile.objs                  | 2 +-
> >  hw/vfio/Makefile.objs             | 7 +++----
> >  6 files changed, 12 insertions(+), 7 deletions(-)
> > 
> > diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> > index d2c8b52f6d..e74b994f2a 100644
> > --- a/default-configs/arm-softmmu.mak
> > +++ b/default-configs/arm-softmmu.mak
> > @@ -123,6 +123,8 @@ CONFIG_VERSATILE_PCI=y
> >  CONFIG_VERSATILE_I2C=y
> >  
> >  CONFIG_PCI_EXPRESS_GENERIC_BRIDGE=y
> > +CONFIG_VFIO=$(CONFIG_LINUX)
> > +CONFIG_VFIO_PLATFORM=y
> >  CONFIG_VFIO_XGMAC=y
> >  CONFIG_VFIO_AMD_XGBE=y
> >  
> > diff --git a/default-configs/pci.mak b/default-configs/pci.mak
> > index 83738cbb65..037636fa33 100644
> > --- a/default-configs/pci.mak
> > +++ b/default-configs/pci.mak
> > @@ -47,3 +47,5 @@ CONFIG_VGA_PCI=y
> >  CONFIG_BOCHS_DISPLAY=y
> >  CONFIG_IVSHMEM_DEVICE=$(CONFIG_IVSHMEM)
> >  CONFIG_ROCKER=y
> > +CONFIG_VFIO=$(CONFIG_LINUX)
> > +CONFIG_VFIO_PCI=y
> > diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-softmmu.mak
> > index 7f34ad0528..ccd7b179df 100644
> > --- a/default-configs/ppc64-softmmu.mak
> > +++ b/default-configs/ppc64-softmmu.mak
> > @@ -18,6 +18,7 @@ CONFIG_XICS_SPAPR=$(CONFIG_PSERIES)
> >  CONFIG_XICS_KVM=$(call land,$(CONFIG_PSERIES),$(CONFIG_KVM))
> >  CONFIG_XIVE=$(CONFIG_PSERIES)
> >  CONFIG_XIVE_SPAPR=$(CONFIG_PSERIES)
> > +CONFIG_VFIO_SPAPR=$(CONFIG_PSERIES)
> >  CONFIG_MEM_DEVICE=y
> >  CONFIG_DIMM=y
> >  CONFIG_SPAPR_RNG=y
> > diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
> > index 8bb7e438c8..6f2c6cec18 100644
> > --- a/default-configs/s390x-softmmu.mak
> > +++ b/default-configs/s390x-softmmu.mak
> > @@ -5,7 +5,8 @@ CONFIG_SCLPCONSOLE=y
> >  CONFIG_TERMINAL3270=y
> >  CONFIG_S390_FLIC=y
> >  CONFIG_S390_FLIC_KVM=$(CONFIG_KVM)
> > -CONFIG_VFIO_CCW=$(CONFIG_LINUX)
> >  CONFIG_WDT_DIAG288=y
> > -CONFIG_VFIO_AP=$(CONFIG_LINUX)
> >  CONFIG_S390_CCW_VIRTIO=y
> > +CONFIG_VFIO=$(CONFIG_LINUX)
> > +CONFIG_VFIO_CCW=y
> > +CONFIG_VFIO_AP=y
> > diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> > index 22dd211363..e2fcd6aafc 100644
> > --- a/hw/Makefile.objs
> > +++ b/hw/Makefile.objs
> > @@ -30,7 +30,7 @@ devices-dirs-$(CONFIG_SOFTMMU) += ssi/
> >  devices-dirs-$(CONFIG_SOFTMMU) += timer/
> >  devices-dirs-$(CONFIG_TPM) += tpm/
> >  devices-dirs-$(CONFIG_SOFTMMU) += usb/
> > -devices-dirs-$(CONFIG_LINUX) += vfio/
> > +devices-dirs-$(CONFIG_VFIO) += vfio/
> >  devices-dirs-$(CONFIG_SOFTMMU) += virtio/
> >  devices-dirs-$(CONFIG_SOFTMMU) += watchdog/
> >  devices-dirs-$(CONFIG_SOFTMMU) += xen/
> > diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
> > index 91805893f7..abad8b818c 100644
> > --- a/hw/vfio/Makefile.objs
> > +++ b/hw/vfio/Makefile.objs
> > @@ -1,8 +1,7 @@
> > -obj-$(CONFIG_SOFTMMU) += common.o
> > -obj-$(CONFIG_PCI) += pci.o pci-quirks.o display.o
> > +obj-y += common.o spapr.o
> 
> I had rather expected a "obj-$(CONFIG_VFIO_SPAPR) += spapr.o" here...
> but I guess it doesn't link without spapr.o? Maybe worth to mention that
> in the patch description...
> 

  Yes, The common.c call some functions in spapr.c here. Thanks Thomas.

  Yang 

> Anyway:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> 
> > +obj-$(CONFIG_VFIO_PCI) += pci.o pci-quirks.o display.o
> >  obj-$(CONFIG_VFIO_CCW) += ccw.o
> > -obj-$(CONFIG_SOFTMMU) += platform.o
> > +obj-$(CONFIG_VFIO_PLATFORM) += platform.o
> >  obj-$(CONFIG_VFIO_XGMAC) += calxeda-xgmac.o
> >  obj-$(CONFIG_VFIO_AMD_XGBE) += amd-xgbe.o
> > -obj-$(CONFIG_SOFTMMU) += spapr.o
> >  obj-$(CONFIG_VFIO_AP) += ap.o
> > 
