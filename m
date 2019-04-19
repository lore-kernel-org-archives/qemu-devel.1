Received: from eggs.gnu.org ([209.51.188.92]:51971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hHalo-0006fr-4l
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:10:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hHaln-0006ad-4v
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:10:04 -0400
MIME-Version: 1.0
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-14-thuth@redhat.com>
In-Reply-To: <20190418180057.3593-14-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 19 Apr 2019 14:09:34 -0700
Message-ID: <CAKmqyKObGO3+s6QsF7TQBTxEx4DRm-GjM9gorv+tvJzC=YsTqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Thomas Huth <thuth@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, Rob Herring <robh@kernel.org>, Qemu-block <qemu-block@nongnu.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Joel Stanley <joel@jms.id.au>, Antony Pavlov <antonynpavlov@gmail.com>, Alistair Francis <alistair@alistair23.me>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>, Cedric Le Goater <clg@kaod.org>, John Snow <jsnow@redhat.com>, Andrew Jeffery <andrew@aj.id.au>, Philippe Mathieu-Daude <f4bug@amsat.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Jan Kiszka <jan.kiszka@web.de>

On Thu, Apr 18, 2019 at 11:18 AM Thomas Huth <thuth@redhat.com> wrote:
>
> Add Kconfig dependencies for the xilinx-zynq-a9 board.
> This patch is based on earlier work by =C3=81kos Kov=C3=A1cs (i.e.
> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  default-configs/arm-softmmu.mak |  7 +------
>  hw/arm/Kconfig                  | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
> index f39a854f2e..af78e7c892 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -19,6 +19,7 @@ CONFIG_STELLARIS=3Dy
>  CONFIG_REALVIEW=3Dy
>  CONFIG_VERSATILE=3Dy
>  CONFIG_VEXPRESS=3Dy
> +CONFIG_ZYNQ=3Dy
>  CONFIG_MAINSTONE=3Dy
>  CONFIG_GUMSTIX=3Dy
>  CONFIG_SPITZ=3Dy
> @@ -38,16 +39,11 @@ CONFIG_VIRTIO_MMIO=3Dy
>
>  CONFIG_NETDUINO2=3Dy
>
> -CONFIG_PL330=3Dy
> -CONFIG_CADENCE=3Dy
>  CONFIG_FRAMEBUFFER=3Dy
> -CONFIG_XILINX_SPIPS=3Dy
> -CONFIG_ZYNQ_DEVCFG=3Dy
>
>  CONFIG_DIGIC=3Dy
>  CONFIG_MPS2=3Dy
>  CONFIG_RASPI=3Dy
> -CONFIG_ZYNQ=3Dy
>  CONFIG_STM32F2XX_TIMER=3Dy
>  CONFIG_STM32F2XX_USART=3Dy
>  CONFIG_STM32F2XX_SYSCFG=3Dy
> @@ -100,7 +96,6 @@ CONFIG_SMBUS_EEPROM=3Dy
>  CONFIG_GPIO_KEY=3Dy
>  CONFIG_MSF2=3Dy
>  CONFIG_FW_CFG_DMA=3Dy
> -CONFIG_XILINX_AXI=3Dy
>  CONFIG_PCI_EXPRESS_DESIGNWARE=3Dy
>
>  CONFIG_STRONGARM=3Dy
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
> --
> 2.21.0
>
>
