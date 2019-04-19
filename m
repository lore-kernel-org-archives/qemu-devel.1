Received: from eggs.gnu.org ([209.51.188.92]:54615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hHb2R-0000ba-Pm
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:27:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hHaq4-0008Jt-Fj
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:14:29 -0400
MIME-Version: 1.0
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-26-thuth@redhat.com>
In-Reply-To: <20190418180057.3593-26-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 19 Apr 2019 14:13:59 -0700
Message-ID: <CAKmqyKM4ZtUmT6U-9Nv=S_3KMVnPzogOkNPrtyqvKz=b+u1AYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Thomas Huth <thuth@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, Rob Herring <robh@kernel.org>, Qemu-block <qemu-block@nongnu.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Joel Stanley <joel@jms.id.au>, Antony Pavlov <antonynpavlov@gmail.com>, Alistair Francis <alistair@alistair23.me>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>, Cedric Le Goater <clg@kaod.org>, John Snow <jsnow@redhat.com>, Andrew Jeffery <andrew@aj.id.au>, Philippe Mathieu-Daude <f4bug@amsat.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Jan Kiszka <jan.kiszka@web.de>

On Thu, Apr 18, 2019 at 11:23 AM Thomas Huth <thuth@redhat.com> wrote:
>
> Add Kconfig dependencies for the NRF51 / microbit machine.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
> --
> 2.21.0
>
>
