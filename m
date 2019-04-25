Received: from eggs.gnu.org ([209.51.188.92]:42046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJgl6-0004hi-4g
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJgl5-0001Dd-35
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:58:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJgl4-0001CH-TA
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:57:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id 26so4124333wmj.3
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 08:57:58 -0700 (PDT)
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-19-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4c6269d8-f4ec-04d2-8a17-81e00a2f26a0@redhat.com>
Date: Thu, 25 Apr 2019 17:57:55 +0200
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-19-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 18/29] hw/arm: Express
 dependencies of allwinner / cubieboard with Kconfig
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
> Add dependencies for the Cubitech Cubieboard.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/arm-softmmu.mak | 6 +-----
>  hw/arm/Kconfig                  | 9 +++++++++
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index c86a9f5427..a0b9016e3a 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -7,6 +7,7 @@ CONFIG_ARM_V7M=y
>  # CONFIG_TEST_DEVICES=n
>  
>  CONFIG_ARM_VIRT=y
> +CONFIG_CUBIEBOARD=y
>  CONFIG_EXYNOS4=y
>  CONFIG_HIGHBANK=y
>  CONFIG_INTEGRATOR=y
> @@ -32,7 +33,6 @@ CONFIG_NETDUINO2=y
>  
>  CONFIG_VGA=y
>  CONFIG_SSI_M25P80=y
> -CONFIG_ALLWINNER_EMAC=y
>  CONFIG_IMX_FEC=y
>  
>  CONFIG_FRAMEBUFFER=y
> @@ -60,10 +60,6 @@ CONFIG_IOTKIT_SYSINFO=y
>  CONFIG_ARMSSE_CPUID=y
>  CONFIG_ARMSSE_MHU=y
>  
> -CONFIG_ALLWINNER_A10_PIT=y
> -CONFIG_ALLWINNER_A10_PIC=y
> -CONFIG_ALLWINNER_A10=y
> -
>  CONFIG_FSL_IMX6=y
>  CONFIG_FSL_IMX25=y
>  CONFIG_FSL_IMX7=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 49306d6419..2ef5696900 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -25,6 +25,10 @@ config CHEETAH
>      select OMAP
>      select TSC210X
>  
> +config CUBIEBOARD
> +    bool
> +    select ALLWINNER_A10
> +
>  config DIGIC
>      bool
>      select PTIMER
> @@ -245,6 +249,11 @@ config ARM_V7M
>  
>  config ALLWINNER_A10
>      bool
> +    select AHCI
> +    select ALLWINNER_A10_PIT
> +    select ALLWINNER_A10_PIC
> +    select ALLWINNER_EMAC
> +    select SERIAL
>  
>  config RASPI
>      bool
> 
