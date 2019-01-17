Received: from eggs.gnu.org ([209.51.188.92]:51073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gk5k5-0005hk-Rb
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:21:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gk5k1-0001NA-Qc
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:21:47 -0500
Received: from mga18.intel.com ([134.134.136.126]:12773)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gk5jz-0000yg-JR
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:21:43 -0500
Date: Thu, 17 Jan 2019 19:17:44 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190117111744.GD11760@yangzhon-Virtual>
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-4-yang.zhong@intel.com>
	<bb109ff0-8475-73f6-c33d-52044de758ac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb109ff0-8475-73f6-c33d-52044de758ac@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 03/37] hw/arm/Makefile.objs:
 CONFIG_VIRT created for virt board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com, Yang Zhong <yang.zhong@intel.com>

On Wed, Jan 16, 2019 at 01:01:07PM +0100, Thomas Huth wrote:
> On 2019-01-15 15:10, Yang Zhong wrote:
> > make virt code configurable and the new CONFIG_VIRT definitions
> > added to the default-configs/arm-softmmu.mak to replace CONFIG_ACPI
> > in arm board.
> > 
> > Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> > ---
> >  default-configs/arm-softmmu.mak | 2 +-
> >  hw/arm/Makefile.objs            | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> > index 2420491aac..3903d1ada3 100644
> > --- a/default-configs/arm-softmmu.mak
> > +++ b/default-configs/arm-softmmu.mak
> > @@ -147,7 +147,7 @@ CONFIG_PCIE_PORT=y
> >  CONFIG_XIO3130=y
> >  CONFIG_IOH3420=y
> >  CONFIG_I82801B11=y
> > -CONFIG_ACPI=y
> > +CONFIG_VIRT=y
> >  CONFIG_SMBIOS=y
> >  CONFIG_ASPEED_SOC=y
> >  CONFIG_GPIO_KEY=y
> > diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> > index 50c7b4a927..25ff98fdbc 100644
> > --- a/hw/arm/Makefile.objs
> > +++ b/hw/arm/Makefile.objs
> > @@ -1,5 +1,5 @@
> > -obj-y += boot.o virt.o sysbus-fdt.o
> > -obj-$(CONFIG_ACPI) += virt-acpi-build.o
> > +obj-y += boot.o sysbus-fdt.o
> > +obj-$(CONFIG_VIRT) += virt.o virt-acpi-build.o
> >  obj-$(CONFIG_DIGIC) += digic_boards.o
> >  obj-$(CONFIG_EXYNOS4) += exynos4_boards.o
> >  obj-$(CONFIG_HIGHBANK) += highbank.o
> > 
> 
> I just gave this a try, and seems like it breaks building the arm
> machines: CONFIG_ACPI is still required. So maybe better not remove that
> switch in this patch yet, to keep the git history bisectable?
>
  Yes, Thomas, virt-acpi-build.c still call common acpi functions.
  Let me still keep "obj-$(CONFIG_ACPI) += virt-acpi-build.o" and 
  set CONFIG_VIRT only for virt.c file. thanks!

  Regards,

  Yang
 
>  Thomas
