Received: from eggs.gnu.org ([209.51.188.92]:50539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJhBr-0000M6-Bb
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJhBp-0001YU-Fo
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:25:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJhBn-0001Wo-FT
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:25:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id r6so280968wrm.4
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:25:34 -0700 (PDT)
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-16-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c7599e97-8ccb-d7fa-93de-1001490ff243@redhat.com>
Date: Thu, 25 Apr 2019 18:25:30 +0200
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-16-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 15/29] hw/arm: Express
 dependencies of the aspeed boards with Kconfig
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
> Dependencies have been determined by looking at hw/arm/aspeed.c
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/arm-softmmu.mak |  7 +------
>  hw/arm/Kconfig                  | 10 ++++++++++
>  2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 25e8f717ac..2580584281 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -26,15 +26,12 @@ CONFIG_SPITZ=y
>  CONFIG_TOSA=y
>  CONFIG_Z2=y
>  CONFIG_COLLIE=y
> +CONFIG_ASPEED_SOC=y
>  
>  CONFIG_VGA=y
> -CONFIG_TMP421=y
> -CONFIG_PCA9552=y
>  CONFIG_SSI_M25P80=y
>  CONFIG_ALLWINNER_EMAC=y
>  CONFIG_IMX_FEC=y
> -CONFIG_FTGMAC100=y
> -CONFIG_DS1338=y
>  CONFIG_PLATFORM_BUS=y
>  CONFIG_VIRTIO_MMIO=y
>  
> @@ -92,8 +89,6 @@ CONFIG_I82801B11=y
>  CONFIG_ACPI=y
>  CONFIG_ARM_VIRT=y
>  CONFIG_SMBIOS=y
> -CONFIG_ASPEED_SOC=y
> -CONFIG_SMBUS_EEPROM=y
>  CONFIG_GPIO_KEY=y
>  CONFIG_MSF2=y
>  CONFIG_FW_CFG_DMA=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 325133c129..abeaa54d88 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -254,6 +254,16 @@ config FSL_IMX6
>  
>  config ASPEED_SOC
>      bool
> +    select DS1338
> +    select FTGMAC100
> +    select I2C
> +    select PCA9552
> +    select SERIAL
> +    select SMBUS_EEPROM
> +    select SSI
> +    select SSI_M25P80
> +    select TMP105
> +    select TMP421
>  
>  config MPS2
>      bool
> 
