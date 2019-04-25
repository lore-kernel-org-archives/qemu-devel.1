Received: from eggs.gnu.org ([209.51.188.92]:40839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJn42-0003nu-97
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJn40-0007D1-CS
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:41:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJn40-0007AB-5Q
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:41:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so1587005wre.7
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 15:41:55 -0700 (PDT)
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-10-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <039c6aea-ed08-02c4-7cad-f721c79a259d@redhat.com>
Date: Fri, 26 Apr 2019 00:41:49 +0200
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-10-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 09/29] hw/arm: Express
 dependencies of the OMAP machines with Kconfig
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
> Add Kconfig dependencies for the OMAP machines (cheetah, n800, n810,
> sx1 and sx1-v1).
> This patch is slightly based on earlier work by Ákos Kovács (i.e.
> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/arm-softmmu.mak | 17 ++++-------------
>  hw/arm/Kconfig                  | 25 +++++++++++++++++++++++++
>  hw/arm/Makefile.objs            |  3 ++-
>  3 files changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 0a4d293f8a..b7ed3c530b 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -12,16 +12,16 @@ CONFIG_HIGHBANK=y
>  CONFIG_INTEGRATOR=y
>  CONFIG_FSL_IMX31=y
>  CONFIG_MUSICPAL=y
> +CONFIG_MUSCA=y
> +CONFIG_CHEETAH=y

I can't find a working Cheetah option rom, but could test some asm.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +CONFIG_SX1=y
> +CONFIG_NSERIES=y
>  
>  CONFIG_VGA=y
>  CONFIG_NAND=y
>  CONFIG_ECC=y
>  CONFIG_SERIAL=y
>  CONFIG_MAX7310=y
> -CONFIG_TWL92230=y
> -CONFIG_TSC2005=y
> -CONFIG_LM832X=y
> -CONFIG_TMP105=y
>  CONFIG_TMP421=y
>  CONFIG_PCA9552=y
>  CONFIG_STELLARIS=y
> @@ -39,9 +39,7 @@ CONFIG_ALLWINNER_EMAC=y
>  CONFIG_IMX_FEC=y
>  CONFIG_FTGMAC100=y
>  CONFIG_DS1338=y
> -CONFIG_PFLASH_CFI01=y
>  CONFIG_MICRODRIVE=y
> -CONFIG_USB_MUSB=y
>  CONFIG_PLATFORM_BUS=y
>  CONFIG_VIRTIO_MMIO=y
>  
> @@ -61,15 +59,8 @@ CONFIG_ZYNQ_DEVCFG=y
>  
>  CONFIG_ARM11SCU=y
>  CONFIG_DIGIC=y
> -CONFIG_OMAP=y
> -CONFIG_TSC210X=y
> -CONFIG_BLIZZARD=y
> -CONFIG_ONENAND=y
> -CONFIG_TUSB6010=y
>  CONFIG_MAINSTONE=y
>  CONFIG_MPS2=y
> -CONFIG_MUSCA=y
> -CONFIG_NSERIES=y
>  CONFIG_RASPI=y
>  CONFIG_REALVIEW=y
>  CONFIG_ZAURUS=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index b9f3c3c232..71126254ff 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -2,6 +2,11 @@ config ARM_VIRT
>      bool
>      imply VFIO_PLATFORM
>  
> +config CHEETAH
> +    bool
> +    select OMAP
> +    select TSC210X
> +
>  config DIGIC
>      bool
>      select PTIMER
> @@ -58,9 +63,25 @@ config NETDUINO2
>  
>  config NSERIES
>      bool
> +    select OMAP
> +    select TMP105   # tempature sensor
> +    select BLIZZARD # LCD/TV controller
> +    select ONENAND
> +    select TSC210X  # touchscreen/sensors/audio
> +    select TSC2005  # touchscreen/sensors/keypad
> +    select LM832X   # GPIO keyboard chip
> +    select TWL92230 # energy-management
> +    select TUSB6010
>  
>  config OMAP
>      bool
> +    select FRAMEBUFFER
> +    select I2C
> +    select ECC
> +    select NAND
> +    select PFLASH_CFI01
> +    select SD
> +    select SERIAL
>  
>  config PXA2XX
>      bool
> @@ -74,6 +95,10 @@ config STELLARIS
>  config STRONGARM
>      bool
>  
> +config SX1
> +    bool
> +    select OMAP
> +
>  config VERSATILE
>      bool
>  
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index fa57c7c770..8302b8df1d 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -9,7 +9,8 @@ obj-$(CONFIG_MAINSTONE) += mainstone.o
>  obj-$(CONFIG_MUSICPAL) += musicpal.o
>  obj-$(CONFIG_NETDUINO2) += netduino2.o
>  obj-$(CONFIG_NSERIES) += nseries.o
> -obj-$(CONFIG_OMAP) += omap_sx1.o palm.o
> +obj-$(CONFIG_SX1) += omap_sx1.o
> +obj-$(CONFIG_CHEETAH) += palm.o
>  obj-$(CONFIG_PXA2XX) += gumstix.o spitz.o tosa.o z2.o
>  obj-$(CONFIG_REALVIEW) += realview.o
>  obj-$(CONFIG_STELLARIS) += stellaris.o
> 
