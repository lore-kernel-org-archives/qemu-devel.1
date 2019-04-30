Received: from eggs.gnu.org ([209.51.188.92]:38665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLNji-0003kD-PO
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLNjh-0002l0-Op
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:03:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLNjh-0002kT-Gy
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:03:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id o4so7913263wra.3
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 01:03:31 -0700 (PDT)
References: <20190430071405.16714-1-thuth@redhat.com>
	<20190430071405.16714-12-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8b16e1b6-08a5-5f7a-1a59-f37679cd1fff@redhat.com>
Date: Tue, 30 Apr 2019 10:03:28 +0200
MIME-Version: 1.0
In-Reply-To: <20190430071405.16714-12-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 11/30] hw/arm: Express dependencies of
 stellaris with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Rob Herring <robh@kernel.org>, qemu-block@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>, Antony Pavlov <antonynpavlov@gmail.com>, Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>, Cedric Le Goater <clg@kaod.org>, John Snow <jsnow@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Philippe Mathieu-Daude <f4bug@amsat.org>, Jean-Christophe Dubois <jcd@tribudubois.net>, Andrew Jeffery <andrew@aj.id.au>, Peter Chubb <peter.chubb@nicta.com.au>, Aurelien Jarno <aurelien@aurel32.net>

On 4/30/19 9:13 AM, Thomas Huth wrote:
> This patch is slightly based on earlier work by Ákos Kovács (i.e.
> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
> 
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/arm-softmmu.mak |  7 +------
>  hw/arm/Kconfig                  | 11 +++++++++++
>  2 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index b7ed3c530b..3f82d635e4 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -16,6 +16,7 @@ CONFIG_MUSCA=y
>  CONFIG_CHEETAH=y
>  CONFIG_SX1=y
>  CONFIG_NSERIES=y
> +CONFIG_STELLARIS=y
>  
>  CONFIG_VGA=y
>  CONFIG_NAND=y
> @@ -24,16 +25,10 @@ CONFIG_SERIAL=y
>  CONFIG_MAX7310=y
>  CONFIG_TMP421=y
>  CONFIG_PCA9552=y
> -CONFIG_STELLARIS=y
> -CONFIG_STELLARIS_INPUT=y
> -CONFIG_STELLARIS_ENET=y
> -CONFIG_SSD0303=y
> -CONFIG_SSD0323=y
>  CONFIG_DDC=y
>  CONFIG_SII9022=y
>  CONFIG_ADS7846=y
>  CONFIG_MAX111X=y
> -CONFIG_SSI_SD=y
>  CONFIG_SSI_M25P80=y
>  CONFIG_ALLWINNER_EMAC=y
>  CONFIG_IMX_FEC=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 71126254ff..e5a8ae5ef9 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -91,6 +91,17 @@ config REALVIEW
>  
>  config STELLARIS
>      bool
> +    select ARM_V7M
> +    select CMSDK_APB_WATCHDOG
> +    select I2C
> +    select PL011 # UART
> +    select PL022 # Serial port
> +    select PL061 # GPIO
> +    select SSD0303 # OLED display
> +    select SSD0323 # OLED display
> +    select SSI_SD
> +    select STELLARIS_INPUT
> +    select STELLARIS_ENET # ethernet
>  
>  config STRONGARM
>      bool
> 
