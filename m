Received: from eggs.gnu.org ([209.51.188.92]:44063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJgqV-00009v-3j
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:03:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJgqT-0000lz-6J
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:03:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJgqR-0000hV-Jn
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:03:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id s18so224774wrp.0
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:03:30 -0700 (PDT)
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-13-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b0e5f10d-3a2e-0244-6f73-b7323b3cc95e@redhat.com>
Date: Thu, 25 Apr 2019 18:03:26 +0200
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-13-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 12/29] hw/arm: Express
 dependencies of the PXA2xx machines with Kconfig
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
> Add Kconfig dependencies for the PXA2xx machines (akita, borzoi,
> connex and verdex gumstix, tosa, mainstone, spitz, terrier and z2).
> This patch is based on earlier work by Ákos Kovács (i.e.
> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/arm-softmmu.mak | 15 ++++--------
>  hw/arm/Kconfig                  | 42 +++++++++++++++++++++++++++++++++
>  hw/arm/Makefile.objs            |  5 +++-
>  3 files changed, 51 insertions(+), 11 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index df7d9421e0..f39a854f2e 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -19,22 +19,20 @@ CONFIG_STELLARIS=y
>  CONFIG_REALVIEW=y
>  CONFIG_VERSATILE=y
>  CONFIG_VEXPRESS=y
> +CONFIG_MAINSTONE=y
> +CONFIG_GUMSTIX=y
> +CONFIG_SPITZ=y
> +CONFIG_TOSA=y
> +CONFIG_Z2=y
>  
>  CONFIG_VGA=y
> -CONFIG_NAND=y
> -CONFIG_ECC=y
> -CONFIG_SERIAL=y
> -CONFIG_MAX7310=y
>  CONFIG_TMP421=y
>  CONFIG_PCA9552=y
> -CONFIG_ADS7846=y
> -CONFIG_MAX111X=y
>  CONFIG_SSI_M25P80=y
>  CONFIG_ALLWINNER_EMAC=y
>  CONFIG_IMX_FEC=y
>  CONFIG_FTGMAC100=y
>  CONFIG_DS1338=y
> -CONFIG_MICRODRIVE=y
>  CONFIG_PLATFORM_BUS=y
>  CONFIG_VIRTIO_MMIO=y
>  
> @@ -42,16 +40,13 @@ CONFIG_NETDUINO2=y
>  
>  CONFIG_PL330=y
>  CONFIG_CADENCE=y
> -CONFIG_PXA2XX=y
>  CONFIG_FRAMEBUFFER=y
>  CONFIG_XILINX_SPIPS=y
>  CONFIG_ZYNQ_DEVCFG=y
>  
>  CONFIG_DIGIC=y
> -CONFIG_MAINSTONE=y
>  CONFIG_MPS2=y
>  CONFIG_RASPI=y
> -CONFIG_ZAURUS=y
>  CONFIG_ZYNQ=y
>  CONFIG_STM32F2XX_TIMER=y
>  CONFIG_STM32F2XX_USART=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index b786cfc5bd..101de74260 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -48,6 +48,9 @@ config INTEGRATOR
>  
>  config MAINSTONE
>      bool
> +    select PXA2XX
> +    select PFLASH_CFI01
> +    select SMC91C111
>  
>  config MUSICPAL
>      bool
> @@ -85,6 +88,43 @@ config OMAP
>  
>  config PXA2XX
>      bool
> +    select FRAMEBUFFER
> +    select I2C
> +    select SERIAL
> +    select SD
> +    select SSI
> +    select USB_OHCI
> +
> +config GUMSTIX
> +    bool
> +    select PFLASH_CFI01
> +    select SMC91C111
> +    select PXA2XX
> +
> +config TOSA
> +    bool
> +    select ZAURUS  # scoop
> +    select MICRODRIVE
> +    select PXA2XX
> +
> +config SPITZ
> +    bool
> +    select ADS7846 # display
> +    select MAX111X # A/D converter
> +    select WM8750  # audio codec
> +    select MAX7310 # GPIO expander
> +    select ZAURUS  # scoop
> +    select NAND    # memory
> +    select ECC     # Error-correcting for NAND
> +    select MICRODRIVE
> +    select PXA2XX
> +
> +config Z2
> +    bool
> +    select PFLASH_CFI01
> +    select WM8750
> +    select PL011 # UART
> +    select PXA2XX
>  
>  config REALVIEW
>      bool
> @@ -217,6 +257,8 @@ config MSF2
>  
>  config ZAURUS
>      bool
> +    select NAND
> +    select ECC
>  
>  config A9MPCORE
>      bool
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index bd0b45a799..00328d1b0b 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -11,7 +11,10 @@ obj-$(CONFIG_NETDUINO2) += netduino2.o
>  obj-$(CONFIG_NSERIES) += nseries.o
>  obj-$(CONFIG_SX1) += omap_sx1.o
>  obj-$(CONFIG_CHEETAH) += palm.o
> -obj-$(CONFIG_PXA2XX) += gumstix.o spitz.o tosa.o z2.o
> +obj-$(CONFIG_GUMSTIX) += gumstix.o
> +obj-$(CONFIG_SPITZ) += spitz.o
> +obj-$(CONFIG_TOSA) += tosa.o
> +obj-$(CONFIG_Z2) += z2.o
>  obj-$(CONFIG_REALVIEW) += realview.o
>  obj-$(CONFIG_STELLARIS) += stellaris.o
>  obj-$(CONFIG_STRONGARM) += collie.o
> 
