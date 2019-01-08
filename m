Received: from eggs.gnu.org ([209.51.188.92]:46354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ggopF-00028n-JC
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:41:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ggopE-0002L7-NZ
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:41:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:26251)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1ggopE-0002HT-F1
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:41:36 -0500
Date: Tue, 8 Jan 2019 18:38:00 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190108103800.GF27840@yangzhon-Virtual>
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-21-yang.zhong@intel.com>
	<b29d2a27-f558-1d15-761b-2cc2f256cd5c@redhat.com>
	<a8965a62-df89-c324-33dd-787d4cadda75@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8965a62-df89-c324-33dd-787d4cadda75@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com, yang.zhong@intel.com

On Fri, Jan 04, 2019 at 08:50:23PM +0100, Paolo Bonzini wrote:
> On 04/01/19 16:38, Thomas Huth wrote:
> > On 2018-12-27 07:34, Yang Zhong wrote:
> >> remove default-configs/hyperv.mak and make dependencies
> >> with Kconfig.
> >>
> >> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> >> ---
> >>  default-configs/hyperv.mak       | 2 --
> >>  default-configs/i386-softmmu.mak | 1 -
> >>  hw/hyperv/Kconfig                | 1 +
> >>  hw/i386/Kconfig                  | 2 ++
> >>  4 files changed, 3 insertions(+), 3 deletions(-)
> >>  delete mode 100644 default-configs/hyperv.mak
> >>
> >> diff --git a/default-configs/hyperv.mak b/default-configs/hyperv.mak
> >> deleted file mode 100644
> >> index 5d0d9fd830..0000000000
> >> --- a/default-configs/hyperv.mak
> >> +++ /dev/null
> >> @@ -1,2 +0,0 @@
> >> -CONFIG_HYPERV=$(CONFIG_KVM)
> >> -CONFIG_HYPERV_TESTDEV=y
> >> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
> >> index d2e58edd17..eb2d22de3c 100644
> >> --- a/default-configs/i386-softmmu.mak
> >> +++ b/default-configs/i386-softmmu.mak
> >> @@ -1,6 +1,5 @@
> >>  # Default configuration for i386-softmmu
> >>  
> >> -include hyperv.mak
> >>  CONFIG_VMXNET3_PCI=y
> >>  CONFIG_VIRTIO_VGA=y
> >>  CONFIG_IPMI=y
> >> diff --git a/hw/hyperv/Kconfig b/hw/hyperv/Kconfig
> >> index be724b7f8b..632c3a675b 100644
> >> --- a/hw/hyperv/Kconfig
> >> +++ b/hw/hyperv/Kconfig
> >> @@ -1,5 +1,6 @@
> >>  config HYPERV
> >>      bool
> >> +    depends on KVM
> >>  
> >>  config HYPERV_TESTDEV
> >>      bool
> > 
> > Should HYPERV_TESTDEV maybe get a "depends on HYPERV", too?
> 
> Yes, and also a "default y if PC".  That makes the "select
> HYPERV_TESTDEV" unnecessary below.
> 
> Paolo

  Thanks Paolo, i will also add this.

  Regards,

  Yang
> 
> >> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> >> index 695a67f88d..af4b81bae1 100644
> >> --- a/hw/i386/Kconfig
> >> +++ b/hw/i386/Kconfig
> >> @@ -11,6 +11,8 @@ config PC
> >>      select I8257
> >>      select MC146818RTC
> >>      select TPM_TIS if TPM
> >> +    select HYPERV
> >> +    select HYPERV_TESTDEV
> >>  
> >>  config PC_PCI
> >>      bool
> >>
> > 
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > 
