Received: from eggs.gnu.org ([209.51.188.92]:44946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJgsR-0001jB-JP
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJgsQ-0003gI-BG
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:05:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJgsQ-0003f3-5C
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:05:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so126053wra.12
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:05:33 -0700 (PDT)
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-9-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6e0098e3-72e5-cb46-d06c-75eed7116ad7@redhat.com>
Date: Thu, 25 Apr 2019 18:05:29 +0200
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-9-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 08/29] hw/arm: Express
 dependencies of musicpal with Kconfig
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
> This patch is slightly based on earlier work by Ákos Kovács (i.e.
> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/arm-softmmu.mak | 6 +-----
>  hw/arm/Kconfig                  | 5 +++++
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 7f94811ccb..0a4d293f8a 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -11,13 +11,13 @@ CONFIG_EXYNOS4=y
>  CONFIG_HIGHBANK=y
>  CONFIG_INTEGRATOR=y
>  CONFIG_FSL_IMX31=y
> +CONFIG_MUSICPAL=y
>  
>  CONFIG_VGA=y
>  CONFIG_NAND=y
>  CONFIG_ECC=y
>  CONFIG_SERIAL=y
>  CONFIG_MAX7310=y
> -CONFIG_WM8750=y
>  CONFIG_TWL92230=y
>  CONFIG_TSC2005=y
>  CONFIG_LM832X=y
> @@ -40,7 +40,6 @@ CONFIG_IMX_FEC=y
>  CONFIG_FTGMAC100=y
>  CONFIG_DS1338=y
>  CONFIG_PFLASH_CFI01=y
> -CONFIG_PFLASH_CFI02=y
>  CONFIG_MICRODRIVE=y
>  CONFIG_USB_MUSB=y
>  CONFIG_PLATFORM_BUS=y
> @@ -56,14 +55,12 @@ CONFIG_PL190=y
>  CONFIG_PL330=y
>  CONFIG_CADENCE=y
>  CONFIG_PXA2XX=y
> -CONFIG_BITBANG_I2C=y
>  CONFIG_FRAMEBUFFER=y
>  CONFIG_XILINX_SPIPS=y
>  CONFIG_ZYNQ_DEVCFG=y
>  
>  CONFIG_ARM11SCU=y
>  CONFIG_DIGIC=y
> -CONFIG_MARVELL_88W8618=y
>  CONFIG_OMAP=y
>  CONFIG_TSC210X=y
>  CONFIG_BLIZZARD=y
> @@ -137,7 +134,6 @@ CONFIG_XILINX_AXI=y
>  CONFIG_PCI_EXPRESS_DESIGNWARE=y
>  
>  CONFIG_STRONGARM=y
> -CONFIG_MUSICPAL=y
>  
>  # for realview and versatilepb
>  CONFIG_LSI_SCSI_PCI=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 9087b7d714..b9f3c3c232 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -46,7 +46,12 @@ config MAINSTONE
>  
>  config MUSICPAL
>      bool
> +    select BITBANG_I2C
> +    select MARVELL_88W8618
>      select PTIMER
> +    select PFLASH_CFI02
> +    select SERIAL
> +    select WM8750
>  
>  config NETDUINO2
>      bool
> 
