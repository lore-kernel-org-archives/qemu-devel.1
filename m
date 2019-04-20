Received: from eggs.gnu.org ([209.51.188.92]:43001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hHnc2-0005cn-HO
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:52:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hHnc1-0003Hk-I7
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:52:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hHnc1-0003Gn-CH
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:52:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id o25so8762765wmf.5
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 03:52:49 -0700 (PDT)
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-24-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <50de0d04-04ff-726f-ac39-c0f804dc7ea4@redhat.com>
Date: Sat, 20 Apr 2019 12:52:46 +0200
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-24-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 23/29] hw/arm: Express
 dependencies of the MSF2 / EMCRAFT_SF2 machine with Kconfig
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
> Add Kconfig dependencies for the emcraft-sf2 machine - we also
> distinguish between the machine (CONFIG_EMCRAFT_SF2) and the SoC
> (CONFIG_MSF2) now.

Thanks!

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/arm-softmmu.mak | 3 +--
>  hw/arm/Kconfig                  | 8 ++++++++
>  hw/arm/Makefile.objs            | 3 ++-
>  3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index ef7dd7156a..1455d083d8 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -34,9 +34,9 @@ CONFIG_MPS2=y
>  CONFIG_RASPI=y
>  CONFIG_DIGIC=y
>  CONFIG_SABRELITE=y
> +CONFIG_EMCRAFT_SF2=y
>  
>  CONFIG_VGA=y
> -CONFIG_SSI_M25P80=y
>  CONFIG_IMX_FEC=y
>  
>  CONFIG_NRF51_SOC=y
> @@ -49,5 +49,4 @@ CONFIG_PCIE_PORT=y
>  CONFIG_XIO3130=y
>  CONFIG_IOH3420=y
>  CONFIG_I82801B11=y
> -CONFIG_MSF2=y
>  CONFIG_PCI_EXPRESS_DESIGNWARE=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 065c7acf1b..f5cd63860d 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -331,9 +331,17 @@ config FSL_IMX6UL
>  config NRF51_SOC
>      bool
>  
> +config EMCRAFT_SF2
> +    bool
> +    select MSF2
> +    select SSI_M25P80
> +
>  config MSF2
>      bool
> +    select ARM_V7M
>      select PTIMER
> +    select SERIAL
> +    select SSI
>  
>  config ZAURUS
>      bool
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index fadd69882c..eae9f6c442 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -4,6 +4,7 @@ obj-$(CONFIG_ARM_VIRT) += virt.o
>  obj-$(CONFIG_ACPI) += virt-acpi-build.o
>  obj-$(CONFIG_DIGIC) += digic_boards.o
>  obj-$(CONFIG_EXYNOS4) += exynos4_boards.o
> +obj-$(CONFIG_EMCRAFT_SF2) += msf2-som.o
>  obj-$(CONFIG_HIGHBANK) += highbank.o
>  obj-$(CONFIG_INTEGRATOR) += integratorcp.o
>  obj-$(CONFIG_MAINSTONE) += mainstone.o
> @@ -41,7 +42,7 @@ obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o
>  obj-$(CONFIG_ASPEED_SOC) += aspeed_soc.o aspeed.o
>  obj-$(CONFIG_MPS2) += mps2.o
>  obj-$(CONFIG_MPS2) += mps2-tz.o
> -obj-$(CONFIG_MSF2) += msf2-soc.o msf2-som.o
> +obj-$(CONFIG_MSF2) += msf2-soc.o
>  obj-$(CONFIG_MUSCA) += musca.o
>  obj-$(CONFIG_ARMSSE) += armsse.o
>  obj-$(CONFIG_FSL_IMX7) += fsl-imx7.o mcimx7d-sabre.o
> 
