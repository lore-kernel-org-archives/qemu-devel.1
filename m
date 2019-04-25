Received: from eggs.gnu.org ([209.51.188.92]:55684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJltm-00041q-DB
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJltl-0003Wt-8d
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:27:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJltl-0003W9-2l
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:27:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id j13so1054499wmh.2
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 14:27:16 -0700 (PDT)
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-18-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bc0f2e77-2f6d-bfea-6aef-4ef2f1ce5066@redhat.com>
Date: Thu, 25 Apr 2019 23:27:12 +0200
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-18-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 17/29] hw/arm: Express
 dependencies of netduino / stm32f2xx with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, Rob Herring <robh@kernel.org>, qemu-block@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>, Joel Stanley <joel@jms.id.au>, Antony Pavlov <antonynpavlov@gmail.com>, Alistair Francis <alistair@alistair23.me>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Cedric Le Goater <clg@kaod.org>, John Snow <jsnow@redhat.com>, Andrew Jeffery <andrew@aj.id.au>, Philippe Mathieu-Daude <f4bug@amsat.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Jan Kiszka <jan.kiszka@web.de>

On 4/18/19 8:00 PM, Thomas Huth wrote:
> Netduino only depends on the stm32f205 SoC which in turn depends on
> its components.
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/arm-softmmu.mak | 9 +--------
>  hw/arm/Kconfig                  | 7 +++++++
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index f440a2b1cd..c86a9f5427 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -28,25 +28,18 @@ CONFIG_TOSA=y
>  CONFIG_Z2=y
>  CONFIG_COLLIE=y
>  CONFIG_ASPEED_SOC=y
> +CONFIG_NETDUINO2=y
>  
>  CONFIG_VGA=y
>  CONFIG_SSI_M25P80=y
>  CONFIG_ALLWINNER_EMAC=y
>  CONFIG_IMX_FEC=y
>  
> -CONFIG_NETDUINO2=y
> -
>  CONFIG_FRAMEBUFFER=y
>  
>  CONFIG_DIGIC=y
>  CONFIG_MPS2=y
>  CONFIG_RASPI=y
> -CONFIG_STM32F2XX_TIMER=y
> -CONFIG_STM32F2XX_USART=y
> -CONFIG_STM32F2XX_SYSCFG=y
> -CONFIG_STM32F2XX_ADC=y
> -CONFIG_STM32F2XX_SPI=y
> -CONFIG_STM32F205_SOC=y
>  CONFIG_NRF51_SOC=y
>  
>  CONFIG_CMSDK_APB_TIMER=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 4d0febf644..49306d6419 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -81,6 +81,7 @@ config MUSICPAL
>  
>  config NETDUINO2
>      bool
> +    select STM32F205_SOC
>  
>  config NSERIES
>      bool
> @@ -250,6 +251,12 @@ config RASPI
>  
>  config STM32F205_SOC
>      bool
> +    select ARM_V7M
> +    select STM32F2XX_TIMER
> +    select STM32F2XX_USART
> +    select STM32F2XX_SYSCFG
> +    select STM32F2XX_ADC
> +    select STM32F2XX_SPI
>  
>  config XLNX_ZYNQMP_ARM
>      bool
> 
