Received: from eggs.gnu.org ([208.118.235.92]:36382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gfRYW-00033t-QI
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:38:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gfRYT-0002o2-If
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:38:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gfRYT-0002nb-9S
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:38:37 -0500
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-21-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b29d2a27-f558-1d15-761b-2cc2f256cd5c@redhat.com>
Date: Fri, 4 Jan 2019 16:38:34 +0100
MIME-Version: 1.0
In-Reply-To: <20181227063419.12981-21-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com, peter.maydell@linaro.org

On 2018-12-27 07:34, Yang Zhong wrote:
> remove default-configs/hyperv.mak and make dependencies
> with Kconfig.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/hyperv.mak       | 2 --
>  default-configs/i386-softmmu.mak | 1 -
>  hw/hyperv/Kconfig                | 1 +
>  hw/i386/Kconfig                  | 2 ++
>  4 files changed, 3 insertions(+), 3 deletions(-)
>  delete mode 100644 default-configs/hyperv.mak
> 
> diff --git a/default-configs/hyperv.mak b/default-configs/hyperv.mak
> deleted file mode 100644
> index 5d0d9fd830..0000000000
> --- a/default-configs/hyperv.mak
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -CONFIG_HYPERV=$(CONFIG_KVM)
> -CONFIG_HYPERV_TESTDEV=y
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
> index d2e58edd17..eb2d22de3c 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -1,6 +1,5 @@
>  # Default configuration for i386-softmmu
>  
> -include hyperv.mak
>  CONFIG_VMXNET3_PCI=y
>  CONFIG_VIRTIO_VGA=y
>  CONFIG_IPMI=y
> diff --git a/hw/hyperv/Kconfig b/hw/hyperv/Kconfig
> index be724b7f8b..632c3a675b 100644
> --- a/hw/hyperv/Kconfig
> +++ b/hw/hyperv/Kconfig
> @@ -1,5 +1,6 @@
>  config HYPERV
>      bool
> +    depends on KVM
>  
>  config HYPERV_TESTDEV
>      bool

Should HYPERV_TESTDEV maybe get a "depends on HYPERV", too?

> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 695a67f88d..af4b81bae1 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -11,6 +11,8 @@ config PC
>      select I8257
>      select MC146818RTC
>      select TPM_TIS if TPM
> +    select HYPERV
> +    select HYPERV_TESTDEV
>  
>  config PC_PCI
>      bool
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
