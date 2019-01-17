Received: from eggs.gnu.org ([209.51.188.92]:40761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk59n-0007WU-HI
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:44:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk4yj-0001TU-IF
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:32:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gk4yj-0001T9-AM
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:32:53 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-32-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a379acd3-ff78-ca65-d9a7-d90f16c9f1f1@redhat.com>
Date: Thu, 17 Jan 2019 11:32:49 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-32-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 31/37] ptimer: express dependencies
 with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com

On 2019-01-15 15:11, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  hw/Kconfig       | 2 ++
>  hw/net/Kconfig   | 2 ++
>  hw/timer/Kconfig | 6 ++++++
>  3 files changed, 10 insertions(+)
> 
> diff --git a/hw/Kconfig b/hw/Kconfig
> index 55743a958a..f9d88986a0 100644
> --- a/hw/Kconfig
> +++ b/hw/Kconfig
> @@ -55,6 +55,8 @@ source riscv/Kconfig
>  # Symbols used by multiple targets
>  config XILINX
>      bool
> +    select PTIMER # for hw/timer/xilinx_timer.c
>  
>  config XILINX_AXI
>      bool
> +    select PTIMER # for hw/dma/xilinx_axidma.c
> diff --git a/hw/net/Kconfig b/hw/net/Kconfig
> index 5a30fdcc17..a9aa60f9a7 100644
> --- a/hw/net/Kconfig
> +++ b/hw/net/Kconfig
> @@ -45,6 +45,7 @@ config SMC91C111
>  
>  config LAN9118
>      bool
> +    select PTIMER
>  
>  config NE2000_ISA
>      bool
> @@ -96,6 +97,7 @@ config VIRTIO_NET
>  
>  config ETSEC
>      bool
> +    select PTIMER
>  
>  config ROCKER
>      bool
> diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
> index e1a6e7469b..a021c742de 100644
> --- a/hw/timer/Kconfig
> +++ b/hw/timer/Kconfig
> @@ -1,8 +1,10 @@
>  config ARM_TIMER
>      bool
> +    select PTIMER
>  
>  config ARM_MPTIMER
>      bool
> +    select PTIMER
>  
>  config A9_GTIMER
>      bool
> @@ -36,12 +38,14 @@ config XLNX_ZYNQMP
>  
>  config ALTERA_TIMER
>      bool
> +    select PTIMER
>  
>  config MC146818RTC
>      bool
>  
>  config ALLWINNER_A10_PIT
>      bool
> +    select PTIMER
>  
>  config STM32F2XX_TIMER
>      bool
> @@ -51,6 +55,8 @@ config SUN4V_RTC
>  
>  config CMSDK_APB_TIMER
>      bool
> +    select PTIMER
>  
>  config CMSDK_APB_DUALTIMER
>      bool
> +    select PTIMER
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
