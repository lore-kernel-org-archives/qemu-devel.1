Received: from eggs.gnu.org ([209.51.188.92]:50093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h367J-0007h8-GB
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 17:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h364X-00065k-Rv
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 17:33:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h364X-000650-KN
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 17:33:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id d17so2941410wre.10
	for <qemu-devel@nongnu.org>; Sun, 10 Mar 2019 14:33:29 -0700 (PDT)
References: <1551968334-18982-1-git-send-email-thuth@redhat.com>
	<1551968334-18982-20-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7e477c03-59d0-f6a4-a557-a8f5740d259a@redhat.com>
Date: Sun, 10 Mar 2019 22:33:27 +0100
MIME-Version: 1.0
In-Reply-To: <1551968334-18982-20-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 19/29] hw/arm: Express dependencies of
 the MPS2 boards with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Hi Thomas,

On 3/7/19 3:18 PM, Thomas Huth wrote:
> Add Kconfig dependencies for the mps2-an* machines.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/arm-softmmu.mak | 20 +-------------------
>  hw/arm/Kconfig                  | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index b6f3d60..b8509fd 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -27,6 +27,7 @@ CONFIG_Z2=y
>  CONFIG_COLLIE=y
>  CONFIG_ASPEED_SOC=y
>  CONFIG_NETDUINO2=y
> +CONFIG_MPS2=y
>  
>  CONFIG_VGA=y
>  CONFIG_SSI_M25P80=y
> @@ -35,28 +36,9 @@ CONFIG_IMX_FEC=y
>  CONFIG_FRAMEBUFFER=y
>  
>  CONFIG_DIGIC=y
> -CONFIG_MPS2=y
>  CONFIG_RASPI=y
>  CONFIG_NRF51_SOC=y
>  
> -CONFIG_CMSDK_APB_TIMER=y
> -CONFIG_CMSDK_APB_DUALTIMER=y
> -CONFIG_CMSDK_APB_UART=y
> -CONFIG_CMSDK_APB_WATCHDOG=y
> -
> -CONFIG_MPS2_FPGAIO=y
> -CONFIG_MPS2_SCC=y
> -
> -CONFIG_TZ_MPC=y
> -CONFIG_TZ_MSC=y
> -CONFIG_TZ_PPC=y
> -CONFIG_ARMSSE=y
> -CONFIG_IOTKIT_SECCTL=y
> -CONFIG_IOTKIT_SYSCTL=y
> -CONFIG_IOTKIT_SYSINFO=y
> -CONFIG_ARMSSE_CPUID=y
> -CONFIG_ARMSSE_MHU=y
> -
>  CONFIG_FSL_IMX6=y
>  CONFIG_FSL_IMX25=y
>  CONFIG_FSL_IMX7=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 743c78b..32c8663 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -308,6 +308,13 @@ config ASPEED_SOC
>  
>  config MPS2
>      bool
> +    select ARMSSE
> +    select LAN9118
> +    select MPS2_FPGAIO
> +    select MPS2_SCC
> +    select PL022    # Serial port
> +    select PL080    # DMA controller
> +    select TZ_MPC

Can we move TZ_MPC to ARMSSE?

>  config FSL_IMX7
>      bool
> @@ -347,6 +354,17 @@ config ARM11MPCORE
>  
>  config ARMSSE
>      bool
> +    select ARMSSE_CPUID
> +    select ARMSSE_MHU
> +    select CMSDK_APB_TIMER
> +    select CMSDK_APB_DUALTIMER
> +    select CMSDK_APB_UART
> +    select CMSDK_APB_WATCHDOG
> +    select IOTKIT_SECCTL
> +    select IOTKIT_SYSCTL
> +    select IOTKIT_SYSINFO
> +    select TZ_MSC
> +    select TZ_PPC
>  
>  config ARMSSE_CPUID
>      bool
> 
