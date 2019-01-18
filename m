Received: from eggs.gnu.org ([209.51.188.92]:41656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkOa0-0008Rg-1T
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 02:28:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkOZs-00055r-57
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 02:28:36 -0500
Received: from mga14.intel.com ([192.55.52.115]:46988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gkOZm-00050r-Ud
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 02:28:28 -0500
Date: Fri, 18 Jan 2019 15:24:43 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190118072443.GB13961@yangzhon-Virtual>
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-25-yang.zhong@intel.com>
	<4fe7900d-13c9-348e-3e14-89dc80251c3e@redhat.com>
	<310f0d5d-c2e3-c46c-1d06-4fb2df486303@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <310f0d5d-c2e3-c46c-1d06-4fb2df486303@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 24/37] build: convert sound.mak to
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

On Wed, Jan 16, 2019 at 02:51:37PM +0100, Thomas Huth wrote:
> On 2019-01-16 14:48, Thomas Huth wrote:
> > On 2019-01-15 15:10, Yang Zhong wrote:
> >> From: Paolo Bonzini <pbonzini@redhat.com>
> >>
> >> There is really nothing special in these devices; they are just
> >> ISA devices.  Instead of including them for each target,
> >> set CONFIG_ISA to true, and make the devices default to present
> >> whenever ISA is available.  More conversion of ISA devices will
> >> follow.
> > [...]
> >> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
> >> index 301cc83279..c7003e4284 100644
> >> --- a/default-configs/ppc-softmmu.mak
> >> +++ b/default-configs/ppc-softmmu.mak
> >> @@ -1,8 +1,8 @@
> >>  # Default configuration for ppc-softmmu
> >>  
> >> -include sound.mak
> >>  include usb.mak
> >>  CONFIG_PCI=y
> >> +ONFIG_ISA=y
> > 
> > Typo: CONFIG_ISA please
> 
> Or should it even be CONFIG_ISA_BUS ? At least that's the name of the
> switch that you use in the other patches ...
> 
  Hello Thomas,

  Yes, We should change this to CONFIG_ISA_BUS here and the patch's 
  description will be changed correspondingly.

  Regards,

  Yang
>  Thomas
