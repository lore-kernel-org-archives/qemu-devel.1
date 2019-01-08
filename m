Received: from eggs.gnu.org ([209.51.188.92]:36540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ggju1-00085P-Oq
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 00:26:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ggju1-0003Xl-0v
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 00:26:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:52801)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1ggju0-0003S7-Ox
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 00:26:12 -0500
Date: Tue, 8 Jan 2019 13:22:33 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190108052233.GA27412@yangzhon-Virtual>
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-10-yang.zhong@intel.com>
	<026da2df-387b-d434-fcfd-0eec798e54c4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <026da2df-387b-d434-fcfd-0eec798e54c4@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 09/25] ide: express dependencies with
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

On Thu, Jan 03, 2019 at 04:47:02PM +0100, Thomas Huth wrote:
> On 2018-12-27 07:34, Yang Zhong wrote:
> > From: Paolo Bonzini <pbonzini@redhat.com>
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> [...]
> > diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
> > index 5ec449525f..091f3a81c9 100644
> > --- a/hw/ide/Kconfig
> > +++ b/hw/ide/Kconfig
> > @@ -3,33 +3,44 @@ config IDE_CORE
> >  
> >  config IDE_QDEV
> >      bool
> > +    select IDE_CORE
> >  
> >  config IDE_PCI
> >      bool
> > +    select IDE_CORE
> >  
> >  config IDE_ISA
> >      bool
> > +    select IDE_QDEV
> >  
> >  config IDE_PIIX
> >      bool
> > +    select IDE_QDEV
> >  
> >  config IDE_CMD646
> >      bool
> > +    select IDE_QDEV
> 
> PIIX and CMD646 seem to be derived from TYPE_PCI_IDE, so shouldn't these
> switches rather select IDE_PCI instead? (Or depend on IDE_PCI?)
> 
  Hello Thomas,

  Thanks, you are right. The CONFIG_IDE_PCI=y was removed in this patch,
  so the "select IDE_PCI" should be added here from next patch(convert 
  pci.mak to Kconfig patch). thanks!

  Regards,

  Yang  


> >  config IDE_MACIO
> >      bool
> > +    select IDE_QDEV
> >  
> >  config IDE_MMIO
> >      bool
> > +    select IDE_QDEV
> >  
> >  config IDE_VIA
> >      bool
> > +    select IDE_QDEV
> 
> dito, VIA is a PCI device, too.
> 
  Yes, you are right, i will change this like above. thanks!

  Regards,

  Yang

> >  config MICRODRIVE
> >      bool
> > +    select IDE_QDEV
> >  
> >  config AHCI
> >      bool
> > +    select IDE_QDEV
> >  
> >  config IDE_SII3112
> >      bool
> > +    select IDE_QDEV
> > 
> 
> dito, SII3112 is a PCI device.
> 
>  Thomas

  Yes, thanks for reminder!
  I will add "depends on PCI" in next patches(convert pci.mak to 
  Kconfig patch), thanks

  Regards,

  Yang
