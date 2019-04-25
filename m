Received: from eggs.gnu.org ([209.51.188.92]:55924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJluR-0004bc-8I
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJluQ-0003zL-27
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:27:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJluP-0003yg-S3
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:27:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so1362905wre.7
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 14:27:57 -0700 (PDT)
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-26-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d672400a-0a96-c811-a063-672f697a9366@redhat.com>
Date: Thu, 25 Apr 2019 23:27:54 +0200
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-26-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 25/29] hw/arm: Express
 dependencies of the microbit / nrf51 machine with Kconfig
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
> Add Kconfig dependencies for the NRF51 / microbit machine.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/arm-softmmu.mak | 3 +--
>  hw/arm/Kconfig                  | 6 ++++++
>  hw/arm/Makefile.objs            | 3 ++-
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 6dc388c43e..233937f394 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -35,11 +35,10 @@ CONFIG_RASPI=y
>  CONFIG_DIGIC=y
>  CONFIG_SABRELITE=y
>  CONFIG_EMCRAFT_SF2=y
> +CONFIG_MICROBIT=y
>  
>  CONFIG_VGA=y
>  
> -CONFIG_NRF51_SOC=y
> -
>  CONFIG_FSL_IMX25=y
>  CONFIG_FSL_IMX7=y
>  CONFIG_FSL_IMX6UL=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 58439c492a..708eae19e5 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -347,8 +347,14 @@ config FSL_IMX6UL
>      select IMX_I2C
>      select SDHCI
>  
> +config MICROBIT
> +    bool
> +    select NRF51_SOC
> +
>  config NRF51_SOC
>      bool
> +    select I2C
> +    select ARM_V7M
>  
>  config EMCRAFT_SF2
>      bool
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index eae9f6c442..994e67dd0d 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -8,6 +8,7 @@ obj-$(CONFIG_EMCRAFT_SF2) += msf2-som.o
>  obj-$(CONFIG_HIGHBANK) += highbank.o
>  obj-$(CONFIG_INTEGRATOR) += integratorcp.o
>  obj-$(CONFIG_MAINSTONE) += mainstone.o
> +obj-$(CONFIG_MICROBIT) += microbit.o
>  obj-$(CONFIG_MUSICPAL) += musicpal.o
>  obj-$(CONFIG_NETDUINO2) += netduino2.o
>  obj-$(CONFIG_NSERIES) += nseries.o
> @@ -48,4 +49,4 @@ obj-$(CONFIG_ARMSSE) += armsse.o
>  obj-$(CONFIG_FSL_IMX7) += fsl-imx7.o mcimx7d-sabre.o
>  obj-$(CONFIG_ARM_SMMUV3) += smmu-common.o smmuv3.o
>  obj-$(CONFIG_FSL_IMX6UL) += fsl-imx6ul.o mcimx6ul-evk.o
> -obj-$(CONFIG_NRF51_SOC) += nrf51_soc.o microbit.o
> +obj-$(CONFIG_NRF51_SOC) += nrf51_soc.o
> 
