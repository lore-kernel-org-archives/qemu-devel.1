Received: from eggs.gnu.org ([209.51.188.92]:42434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJgm4-0005Gb-Pi
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:59:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJgm2-0002aj-Mo
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:59:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJglt-0002OH-39
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:58:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id c12so131250wrt.8
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 08:58:48 -0700 (PDT)
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-15-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <46bcb836-b4db-db2f-26a3-c2827c95e940@redhat.com>
Date: Thu, 25 Apr 2019 17:58:44 +0200
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-15-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 14/29] hw/arm: Express
 dependencies of collie with Kconfig
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
> Add Kconfig dependencies for the Strongarm collie machine.
> This patch is based on earlier work by Ákos Kovács (i.e.
> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/arm-softmmu.mak | 3 +--
>  hw/arm/Kconfig                  | 7 +++++++
>  hw/arm/Makefile.objs            | 2 +-
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index af78e7c892..25e8f717ac 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -25,6 +25,7 @@ CONFIG_GUMSTIX=y
>  CONFIG_SPITZ=y
>  CONFIG_TOSA=y
>  CONFIG_Z2=y
> +CONFIG_COLLIE=y
>  
>  CONFIG_VGA=y
>  CONFIG_TMP421=y
> @@ -97,5 +98,3 @@ CONFIG_GPIO_KEY=y
>  CONFIG_MSF2=y
>  CONFIG_FW_CFG_DMA=y
>  CONFIG_PCI_EXPRESS_DESIGNWARE=y
> -
> -CONFIG_STRONGARM=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 785e383411..325133c129 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -168,6 +168,13 @@ config STELLARIS
>  
>  config STRONGARM
>      bool
> +    select PXA2XX
> +
> +config COLLIE
> +    bool
> +    select PFLASH_CFI01
> +    select ZAURUS  # scoop
> +    select STRONGARM
>  
>  config SX1
>      bool
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index 00328d1b0b..729e711b87 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -17,7 +17,7 @@ obj-$(CONFIG_TOSA) += tosa.o
>  obj-$(CONFIG_Z2) += z2.o
>  obj-$(CONFIG_REALVIEW) += realview.o
>  obj-$(CONFIG_STELLARIS) += stellaris.o
> -obj-$(CONFIG_STRONGARM) += collie.o
> +obj-$(CONFIG_COLLIE) += collie.o
>  obj-$(CONFIG_VERSATILE) += versatilepb.o
>  obj-$(CONFIG_VEXPRESS) += vexpress.o
>  obj-$(CONFIG_ZYNQ) += xilinx_zynq.o
> 
