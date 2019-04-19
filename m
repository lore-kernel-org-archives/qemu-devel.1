Received: from eggs.gnu.org ([209.51.188.92]:54615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hHb2U-0000ba-25
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hHaoR-0007gV-Dk
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:12:48 -0400
MIME-Version: 1.0
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-27-thuth@redhat.com>
In-Reply-To: <20190418180057.3593-27-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 19 Apr 2019 14:12:19 -0700
Message-ID: <CAKmqyKM-G06FAJ1AJ4Cp0MRV+0oYPbpAbLtZPM9xWFuZ9MBQQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 26/29] hw/arm: Express
 dependencies of the ZynqMP zcu102 machine with Kconfig
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

On Thu, Apr 18, 2019 at 11:15 AM Thomas Huth <thuth@redhat.com> wrote:
>
> This cleans up most settings in default-configs/aarch64-softmmu.mak.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  default-configs/aarch64-softmmu.mak |  4 ----
>  hw/arm/Kconfig                      | 11 +++++++++++
>  hw/display/Kconfig                  |  1 +
>  3 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/default-configs/aarch64-softmmu.mak b/default-configs/aarch64-softmmu.mak
> index 4ea9add003..3a4b15e7e8 100644
> --- a/default-configs/aarch64-softmmu.mak
> +++ b/default-configs/aarch64-softmmu.mak
> @@ -3,10 +3,6 @@
>  # We support all the 32 bit boards so need all their config
>  include arm-softmmu.mak
>
> -CONFIG_AUX=y
> -CONFIG_DDC=y
> -CONFIG_DPCD=y
> -CONFIG_XLNX_ZYNQMP=y
>  CONFIG_XLNX_ZYNQMP_ARM=y
>  CONFIG_XLNX_VERSAL=y
>  CONFIG_ARM_SMMUV3=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 708eae19e5..32e4cc50e5 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -277,6 +277,17 @@ config STM32F205_SOC
>
>  config XLNX_ZYNQMP_ARM
>      bool
> +    select AHCI
> +    select ARM_GIC
> +    select CADENCE
> +    select DDC
> +    select DPCD
> +    select SDHCI
> +    select SSI
> +    select SSI_M25P80
> +    select XILINX_AXI
> +    select XILINX_SPIPS
> +    select XLNX_ZYNQMP
>
>  config XLNX_VERSAL
>      bool
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index 0577e68c8e..bb95f8d6a4 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -108,6 +108,7 @@ config VIRTIO_VGA
>
>  config DPCD
>      bool
> +    select AUX
>
>  config ATI_VGA
>      bool
> --
> 2.21.0
>
>
