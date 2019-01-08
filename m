Received: from eggs.gnu.org ([209.51.188.92]:45835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ggnXJ-0001fA-QV
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 04:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ggnXI-0007c2-UT
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 04:19:01 -0500
Received: from mga12.intel.com ([192.55.52.136]:27099)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1ggnXI-0007Tq-M7
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 04:19:00 -0500
Date: Tue, 8 Jan 2019 17:15:23 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190108091523.GD27840@yangzhon-Virtual>
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-18-yang.zhong@intel.com>
	<ac00d820-95b3-5e36-f971-0f0d5f305209@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac00d820-95b3-5e36-f971-0f0d5f305209@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 17/25] i2c: express dependencies with
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, sameo@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com, yang.zhong@intel.com

On Fri, Jan 04, 2019 at 04:30:01PM +0100, Thomas Huth wrote:
> On 2018-12-27 07:34, Yang Zhong wrote:
> > From: Paolo Bonzini <pbonzini@redhat.com>
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> > ---
> [...]
> > diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> > index 8ce968bfff..8ddce09ead 100644
> > --- a/hw/display/Kconfig
> > +++ b/hw/display/Kconfig
> > @@ -24,9 +24,11 @@ config PL110
> >  
> >  config SII9022
> >      bool
> > +    depends on I2C
> >  
> >  config SSD0303
> >      bool
> > +    depends on I2C
> >  
> >  config SSD0323
> >      bool
> > @@ -70,6 +72,7 @@ config MILKYMIST_TMU2
> >  
> >  config SM501
> >      bool
> > +    depends on I2C
> >  
> >  config TCX
> >      bool
> 
> I think XLNX_ZYNQMP_ARM likely needs "depends on I2C" nowadays, too ?
> 
>  Thomas

  Thomas, thanks for comments!
  Since this is pure ARM's config, we will move this "config XLNX_ZYNQMP_ARM" into ./hw/arm/Kconfig.
  otehr platforms will be in next steps. thanks! 

  ./hw/arm/Makefile.objs:obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zynqmp.o xlnx-zcu102.o
  ./hw/display/Makefile.objs:obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx_dp.o
  ./hw/dma/Makefile.objs:obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx_dpdma.o
  ./hw/dma/Makefile.objs:common-obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zdma.o
  ./default-configs/aarch64-softmmu.mak:CONFIG_XLNX_ZYNQMP_ARM=y

  Regards,

  Yang
