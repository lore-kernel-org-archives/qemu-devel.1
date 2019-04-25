Received: from eggs.gnu.org ([209.51.188.92]:48555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJh49-0002e2-N4
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJh48-0001v5-MB
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:17:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJh48-0001tk-FP
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:17:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id r6so249352wrm.4
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:17:39 -0700 (PDT)
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-14-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0dc4aa08-a0be-ab33-a717-7b8e488e63fc@redhat.com>
Date: Thu, 25 Apr 2019 18:17:36 +0200
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-14-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 13/29] hw/arm: Express
 dependencies of xilinx-zynq with Kconfig
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
> Add Kconfig dependencies for the xilinx-zynq-a9 board.
> This patch is based on earlier work by Ákos Kovács (i.e.
> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/arm-softmmu.mak |  7 +------
>  hw/arm/Kconfig                  | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index f39a854f2e..af78e7c892 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -19,6 +19,7 @@ CONFIG_STELLARIS=y
>  CONFIG_REALVIEW=y
>  CONFIG_VERSATILE=y
>  CONFIG_VEXPRESS=y
> +CONFIG_ZYNQ=y
>  CONFIG_MAINSTONE=y
>  CONFIG_GUMSTIX=y
>  CONFIG_SPITZ=y
> @@ -38,16 +39,11 @@ CONFIG_VIRTIO_MMIO=y
>  
>  CONFIG_NETDUINO2=y
>  
> -CONFIG_PL330=y
> -CONFIG_CADENCE=y
>  CONFIG_FRAMEBUFFER=y
> -CONFIG_XILINX_SPIPS=y
> -CONFIG_ZYNQ_DEVCFG=y
>  
>  CONFIG_DIGIC=y
>  CONFIG_MPS2=y
>  CONFIG_RASPI=y
> -CONFIG_ZYNQ=y
>  CONFIG_STM32F2XX_TIMER=y
>  CONFIG_STM32F2XX_USART=y
>  CONFIG_STM32F2XX_SYSCFG=y
> @@ -100,7 +96,6 @@ CONFIG_SMBUS_EEPROM=y
>  CONFIG_GPIO_KEY=y
>  CONFIG_MSF2=y
>  CONFIG_FW_CFG_DMA=y
> -CONFIG_XILINX_AXI=y
>  CONFIG_PCI_EXPRESS_DESIGNWARE=y
>  
>  CONFIG_STRONGARM=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 101de74260..785e383411 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -201,6 +201,18 @@ config VEXPRESS
>  
>  config ZYNQ
>      bool
> +    select A9MPCORE
> +    select CADENCE # UART
> +    select PFLASH_CFI02
> +    select PL330
> +    select SDHCI
> +    select SSI_M25P80
> +    select USB_EHCI_SYSBUS
> +    select XILINX # UART
> +    select XILINX_AXI
> +    select XILINX_SPI
> +    select XILINX_SPIPS
> +    select ZYNQ_DEVCFG
>  
>  config ARM_V7M
>      bool
> 
