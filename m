Received: from eggs.gnu.org ([209.51.188.92]:49929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJfJE-0001Ed-A9
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJfJD-0005LZ-8T
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:25:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJfJC-0005Kg-Ue
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:25:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so9550099wmf.1
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 07:25:06 -0700 (PDT)
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-6-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <acc9802b-5f72-f9f5-32dd-a03d9b6d7e4e@redhat.com>
Date: Thu, 25 Apr 2019 16:25:03 +0200
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-6-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 05/29] hw/arm: Express
 dependencies of the highbank machines with Kconfig
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
> Add Kconfig dependencies for the highbank machine (and the midway
> machine).
> This patch is slightly based on earlier work by Ákos Kovács (i.e.
> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/arm-softmmu.mak |  9 +--------
>  hw/arm/Kconfig                  | 11 +++++++++++
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 2a11e76cc7..50a4be3cad 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -8,6 +8,7 @@ CONFIG_PCI_DEVICES=y
>  CONFIG_PCI_TESTDEV=y
>  
>  CONFIG_EXYNOS4=y
> +CONFIG_HIGHBANK=y
>  
>  CONFIG_VGA=y
>  CONFIG_NAND=y
> @@ -45,24 +46,17 @@ CONFIG_PLATFORM_BUS=y
>  CONFIG_VIRTIO_MMIO=y
>  
>  CONFIG_ARM11MPCORE=y
> -CONFIG_A15MPCORE=y
>  
>  CONFIG_NETDUINO2=y
>  
> -CONFIG_ARM_TIMER=y
> -CONFIG_PL011=y
> -CONFIG_PL022=y
> -CONFIG_PL031=y
>  CONFIG_PL041=y
>  CONFIG_PL050=y
> -CONFIG_PL061=y
>  CONFIG_PL080=y
>  CONFIG_PL110=y
>  CONFIG_PL181=y
>  CONFIG_PL190=y
>  CONFIG_PL330=y
>  CONFIG_CADENCE=y
> -CONFIG_XGMAC=y
>  CONFIG_PXA2XX=y
>  CONFIG_BITBANG_I2C=y
>  CONFIG_FRAMEBUFFER=y
> @@ -150,7 +144,6 @@ CONFIG_XILINX_AXI=y
>  CONFIG_PCI_EXPRESS_DESIGNWARE=y
>  
>  CONFIG_STRONGARM=y
> -CONFIG_HIGHBANK=y
>  CONFIG_MUSICPAL=y
>  
>  # for realview and versatilepb
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index acd07b2add..0ba377ac18 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -18,6 +18,17 @@ config EXYNOS4
>  
>  config HIGHBANK
>      bool
> +    select A9MPCORE
> +    select A15MPCORE
> +    select AHCI
> +    select ARM_TIMER # sp804
> +    select ARM_V7M
> +    select PL011 # UART
> +    select PL022 # Serial port
> +    select PL031 # RTC
> +    select PL061 # GPIO
> +    select PL310 # cache controller
> +    select XGMAC # ethernet

Similarly to my comment on patch 6 of this series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  
>  config INTEGRATOR
>      bool
> 
