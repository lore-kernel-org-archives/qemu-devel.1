Received: from eggs.gnu.org ([209.51.188.92]:45806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ggonN-00012G-Vg
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:39:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ggonL-0006S4-Km
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:39:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:63780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1ggonL-0005y5-81
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:39:39 -0500
Date: Tue, 8 Jan 2019 18:35:47 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190108103547.GE27840@yangzhon-Virtual>
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-21-yang.zhong@intel.com>
	<b29d2a27-f558-1d15-761b-2cc2f256cd5c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b29d2a27-f558-1d15-761b-2cc2f256cd5c@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 20/25] hyperv: express dependencies
 with kconfig
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

On Fri, Jan 04, 2019 at 04:38:34PM +0100, Thomas Huth wrote:
> On 2018-12-27 07:34, Yang Zhong wrote:
> > remove default-configs/hyperv.mak and make dependencies
> > with Kconfig.
> > 
> > Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> > ---
> >  default-configs/hyperv.mak       | 2 --
> >  default-configs/i386-softmmu.mak | 1 -
> >  hw/hyperv/Kconfig                | 1 +
> >  hw/i386/Kconfig                  | 2 ++
> >  4 files changed, 3 insertions(+), 3 deletions(-)
> >  delete mode 100644 default-configs/hyperv.mak
> >
  [...] 
> > diff --git a/hw/hyperv/Kconfig b/hw/hyperv/Kconfig
> > index be724b7f8b..632c3a675b 100644
> > --- a/hw/hyperv/Kconfig
> > +++ b/hw/hyperv/Kconfig
> > @@ -1,5 +1,6 @@
> >  config HYPERV
> >      bool
> > +    depends on KVM
> >  
> >  config HYPERV_TESTDEV
> >      bool
> 
> Should HYPERV_TESTDEV maybe get a "depends on HYPERV", too?
> 
  Thomas, thanks, i will change it.  
  
  Regards,

  Yang 
 
> > diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> > index 695a67f88d..af4b81bae1 100644
> > --- a/hw/i386/Kconfig
> > +++ b/hw/i386/Kconfig
> > @@ -11,6 +11,8 @@ config PC
> >      select I8257
> >      select MC146818RTC
> >      select TPM_TIS if TPM
> > +    select HYPERV
> > +    select HYPERV_TESTDEV
> >  
> >  config PC_PCI
> >      bool
> > 
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
