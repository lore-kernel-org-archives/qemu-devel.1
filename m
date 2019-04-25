Received: from eggs.gnu.org ([209.51.188.92]:47269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJh0d-0007MB-Gs
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:14:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJh0c-0007Eo-I1
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:14:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJh0c-0007CY-CM
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:14:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so189620wrx.9
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:14:01 -0700 (PDT)
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-25-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4fcfff75-aa44-e1cc-2e14-38faba3a3e47@redhat.com>
Date: Thu, 25 Apr 2019 18:13:58 +0200
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-25-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 24/29] hw/arm: Express
 dependencies for remaining IMX boards with Kconfig
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
> IMX25, IMX7 and IMX6UL were still missing the Kconfig dependencies.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/arm-softmmu.mak |  2 --
>  hw/arm/Kconfig                  | 19 +++++++++++++++++++
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 1455d083d8..6dc388c43e 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -37,7 +37,6 @@ CONFIG_SABRELITE=y
>  CONFIG_EMCRAFT_SF2=y
>  
>  CONFIG_VGA=y
> -CONFIG_IMX_FEC=y
>  
>  CONFIG_NRF51_SOC=y
>  
> @@ -49,4 +48,3 @@ CONFIG_PCIE_PORT=y
>  CONFIG_XIO3130=y
>  CONFIG_IOH3420=y
>  CONFIG_I82801B11=y
> -CONFIG_PCI_EXPRESS_DESIGNWARE=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index f5cd63860d..58439c492a 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -283,6 +283,10 @@ config XLNX_VERSAL
>  
>  config FSL_IMX25
>      bool
> +    select IMX
> +    select IMX_FEC
> +    select IMX_I2C
> +    select DS1338
>  
>  config FSL_IMX31
>      bool
> @@ -296,6 +300,7 @@ config FSL_IMX6
>      select A9MPCORE
>      select IMX
>      select IMX_I2C
> +    select SDHCI
>  
>  config ASPEED_SOC
>      bool
> @@ -321,12 +326,26 @@ config MPS2
>  
>  config FSL_IMX7
>      bool
> +    imply PCI_DEVICES
> +    imply TEST_DEVICES
> +    select A15MPCORE
> +    select PCI
> +    select IMX
> +    select IMX_FEC
> +    select IMX_I2C
> +    select PCI_EXPRESS_DESIGNWARE
> +    select SDHCI
>  
>  config ARM_SMMUV3
>      bool
>  
>  config FSL_IMX6UL
>      bool
> +    select A15MPCORE
> +    select IMX
> +    select IMX_FEC
> +    select IMX_I2C
> +    select SDHCI
>  
>  config NRF51_SOC
>      bool
> 
