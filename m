Received: from eggs.gnu.org ([209.51.188.92]:54776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hHb2T-0000hW-CF
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hHap4-0007vF-P6
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:13:27 -0400
MIME-Version: 1.0
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-21-thuth@redhat.com>
In-Reply-To: <20190418180057.3593-21-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 19 Apr 2019 14:12:58 -0700
Message-ID: <CAKmqyKMk-346_m5=9Tbk7e_WFHkMe5EdiBX2efGASoQcsWBpTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 20/29] hw/arm: Express
 dependencies of the raspi machines with Kconfig
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

On Thu, Apr 18, 2019 at 11:25 AM Thomas Huth <thuth@redhat.com> wrote:
>
> Most of the code is directly controlled by the CONFIG_RASPI switch,
> so not much to add here additionally.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  default-configs/arm-softmmu.mak | 4 +---
>  hw/arm/Kconfig                  | 3 +++
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 31d31d3f4a..22bff20b32 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -31,15 +31,13 @@ CONFIG_COLLIE=y
>  CONFIG_ASPEED_SOC=y
>  CONFIG_NETDUINO2=y
>  CONFIG_MPS2=y
> +CONFIG_RASPI=y
>
>  CONFIG_VGA=y
>  CONFIG_SSI_M25P80=y
>  CONFIG_IMX_FEC=y
>
> -CONFIG_FRAMEBUFFER=y
> -
>  CONFIG_DIGIC=y
> -CONFIG_RASPI=y
>  CONFIG_NRF51_SOC=y
>
>  CONFIG_FSL_IMX6=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 466b143fdf..e68a29ca2b 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -257,6 +257,9 @@ config ALLWINNER_A10
>
>  config RASPI
>      bool
> +    select FRAMEBUFFER
> +    select PL011 # UART
> +    select SDHCI
>
>  config STM32F205_SOC
>      bool
> --
> 2.21.0
>
>
