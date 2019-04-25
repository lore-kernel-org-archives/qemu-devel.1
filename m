Received: from eggs.gnu.org ([209.51.188.92]:51046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJfM4-0003Jy-Jr
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJfM3-0007u6-Kc
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:28:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJfM3-0007tI-Do
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:28:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so30576228wrw.13
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 07:28:03 -0700 (PDT)
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-8-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <472cdca7-a01f-632f-bbac-633db846c605@redhat.com>
Date: Thu, 25 Apr 2019 16:27:58 +0200
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-8-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 07/29] hw/arm: Express
 dependencies of the fsl-imx31 machine with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, Rob Herring <robh@kernel.org>, qemu-block@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>, Joel Stanley <joel@jms.id.au>, Antony Pavlov <antonynpavlov@gmail.com>, Alistair Francis <alistair@alistair23.me>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Cedric Le Goater <clg@kaod.org>, John Snow <jsnow@redhat.com>, Andrew Jeffery <andrew@aj.id.au>, Philippe Mathieu-Daude <f4bug@amsat.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Jan Kiszka <jan.kiszka@web.de>

On 4/18/19 8:00 PM, Thomas Huth wrote:
> Add Kconfig dependencies for the fsl-imx31 / kzm machine.
> This patch is slightly based on earlier work by Ákos Kovács (i.e.
> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/arm-softmmu.mak | 3 +--
>  hw/arm/Kconfig                  | 4 ++++
>  hw/misc/Kconfig                 | 2 ++
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 6195b75f48..7f94811ccb 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -10,6 +10,7 @@ CONFIG_PCI_TESTDEV=y
>  CONFIG_EXYNOS4=y
>  CONFIG_HIGHBANK=y
>  CONFIG_INTEGRATOR=y
> +CONFIG_FSL_IMX31=y
>  
>  CONFIG_VGA=y
>  CONFIG_NAND=y
> @@ -68,7 +69,6 @@ CONFIG_TSC210X=y
>  CONFIG_BLIZZARD=y
>  CONFIG_ONENAND=y
>  CONFIG_TUSB6010=y
> -CONFIG_IMX=y
>  CONFIG_MAINSTONE=y
>  CONFIG_MPS2=y
>  CONFIG_MUSCA=y
> @@ -115,7 +115,6 @@ CONFIG_ALLWINNER_A10_PIC=y
>  CONFIG_ALLWINNER_A10=y
>  
>  CONFIG_FSL_IMX6=y
> -CONFIG_FSL_IMX31=y
>  CONFIG_FSL_IMX25=y
>  CONFIG_FSL_IMX7=y
>  CONFIG_FSL_IMX6UL=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index ad3b1f9b40..9087b7d714 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -98,6 +98,10 @@ config FSL_IMX25
>  
>  config FSL_IMX31
>      bool
> +    select SERIAL
> +    select IMX
> +    select IMX_I2C
> +    select LAN9118

Similarly to my comment on patch 6 of this series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  
>  config FSL_IMX6
>      bool
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 5f67d0d6d9..385e1b0cec 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -76,6 +76,8 @@ config ECCMEMCTL
>  config IMX
>      bool
>      select PTIMER
> +    select SSI
> +    select USB_EHCI_SYSBUS
>  
>  config STM32F2XX_SYSCFG
>      bool
> 
