Received: from eggs.gnu.org ([209.51.188.92]:47581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJf9Q-0005ni-BD
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJf9P-0005Og-C4
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:15:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJf9P-0005O3-4y
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:14:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so30523774wra.12
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 07:14:59 -0700 (PDT)
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-7-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cf39902b-267a-ea7e-c513-fa0c9abf639c@redhat.com>
Date: Thu, 25 Apr 2019 16:14:54 +0200
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-7-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 06/29] hw/arm: Express
 dependencies of integratorcp with Kconfig
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

Hi Thomas,

On 4/18/19 8:00 PM, Thomas Huth wrote:
> This patch is slightly based on earlier work by Ákos Kovács (i.e.
> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/arm-softmmu.mak | 8 +-------
>  hw/arm/Kconfig                  | 8 ++++++++
>  hw/display/Kconfig              | 1 +
>  3 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 50a4be3cad..6195b75f48 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -9,6 +9,7 @@ CONFIG_PCI_TESTDEV=y
>  
>  CONFIG_EXYNOS4=y
>  CONFIG_HIGHBANK=y
> +CONFIG_INTEGRATOR=y
>  
>  CONFIG_VGA=y
>  CONFIG_NAND=y
> @@ -33,7 +34,6 @@ CONFIG_ADS7846=y
>  CONFIG_MAX111X=y
>  CONFIG_SSI_SD=y
>  CONFIG_SSI_M25P80=y
> -CONFIG_SMC91C111=y
>  CONFIG_ALLWINNER_EMAC=y
>  CONFIG_IMX_FEC=y
>  CONFIG_FTGMAC100=y
> @@ -50,10 +50,7 @@ CONFIG_ARM11MPCORE=y
>  CONFIG_NETDUINO2=y
>  
>  CONFIG_PL041=y
> -CONFIG_PL050=y

You remove this device but it is used by the realview/versatile/vexpress
(you add it to these machines later in patch 11).

>  CONFIG_PL080=y
> -CONFIG_PL110=y

Ditto,

> -CONFIG_PL181=y

Ditto.

>  CONFIG_PL190=y
>  CONFIG_PL330=y
>  CONFIG_CADENCE=y
> @@ -113,9 +110,6 @@ CONFIG_VERSATILE_I2C=y
>  CONFIG_PCI_EXPRESS=y
>  CONFIG_PCI_EXPRESS_GENERIC_BRIDGE=y
>  
> -CONFIG_INTEGRATOR=y
> -CONFIG_INTEGRATOR_DEBUG=y
> -
>  CONFIG_ALLWINNER_A10_PIT=y
>  CONFIG_ALLWINNER_A10_PIC=y
>  CONFIG_ALLWINNER_A10=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 0ba377ac18..ad3b1f9b40 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -32,6 +32,14 @@ config HIGHBANK
>  
>  config INTEGRATOR
>      bool
> +    select ARM_TIMER
> +    select INTEGRATOR_DEBUG
> +    select PL011 # UART
> +    select PL031 # RTC
> +    select PL050 # keyboard/mouse
> +    select PL110 # pl111 LCD controller
> +    select PL181 # display
> +    select SMC91C111
>  
>  config MAINSTONE
>      bool
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index 72be57a403..a11815c9af 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -21,6 +21,7 @@ config JAZZ_LED
>  
>  config PL110
>      bool
> +    select FRAMEBUFFER
>  
>  config SII9022
>      bool
> 
