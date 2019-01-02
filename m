Received: from eggs.gnu.org ([208.118.235.92]:58887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gehiy-0006W7-22
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:42:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gehiu-0000wA-TT
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:42:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gehiu-0000vc-Mk
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:42:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so26818229wmb.3
	for <qemu-devel@nongnu.org>; Wed, 02 Jan 2019 06:42:20 -0800 (PST)
References: <1546433583-18397-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <10359753-9573-629b-5c76-7c148e66cb91@redhat.com>
Date: Wed, 2 Jan 2019 15:42:17 +0100
MIME-Version: 1.0
In-Reply-To: <1546433583-18397-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add ARM-related files for
 hw/[misc|input|timer]/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 1/2/19 1:53 PM, Thomas Huth wrote:
> Some of the files in hw/input/, hw/misc/ and hw/timer/ are only
> used by one of the ARM machines, so we can assign these files to
> the corresponding boards.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 180695f..693abdf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -510,6 +510,7 @@ F: hw/intc/arm*
>  F: hw/intc/gic_internal.h
>  F: hw/misc/a9scu.c
>  F: hw/misc/arm11scu.c
> +F: hw/misc/arm_l2x0.c
>  F: hw/timer/a9gtimer*
>  F: hw/timer/arm*
>  F: include/hw/arm/arm*.h
> @@ -582,6 +583,7 @@ L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/arm/integratorcp.c
>  F: hw/misc/arm_integrator_debug.c
> +F: include/hw/misc/arm_integrator_debug.h

OK

>  
>  MCIMX6UL EVK / i.MX6ul
>  M: Peter Maydell <peter.maydell@linaro.org>
> @@ -601,7 +603,9 @@ L: qemu-arm@nongnu.org
>  S: Odd Fixes
>  F: hw/arm/mcimx7d-sabre.c
>  F: hw/arm/fsl-imx7.c
> +F: hw/misc/imx7_*.c
>  F: include/hw/arm/fsl-imx7.h
> +F: include/hw/misc/imx7_*.h
>  F: hw/pci-host/designware.c
>  F: include/hw/pci-host/designware.h

OK

>  
> @@ -635,6 +639,10 @@ M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
>  S: Odd Fixes
>  F: hw/arm/nseries.c
> +F: hw/input/lm832x.c
> +F: hw/input/tsc2005.c
> +F: hw/misc/cbus.c
> +F: hw/timer/twl92230.c

OK

>  
>  Palm
>  M: Andrzej Zaborowski <balrogg@gmail.com>
> @@ -642,6 +650,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
>  S: Odd Fixes
>  F: hw/arm/palm.c
> +F: hw/input/tsc210x.c

OK

>  
>  Raspberry Pi
>  M: Peter Maydell <peter.maydell@linaro.org>
> @@ -678,6 +687,7 @@ F: hw/display/tc6393xb.c
>  F: hw/gpio/max7310.c
>  F: hw/gpio/zaurus.c
>  F: hw/misc/mst_fpga.c
> +F: hw/misc/max111x.c
>  F: include/hw/arm/pxa.h
>  F: include/hw/arm/sharpsl.h

OK

>  
> @@ -688,10 +698,10 @@ L: qemu-arm@nongnu.org
>  S: Odd Fixes
>  F: hw/arm/sabrelite.c
>  F: hw/arm/fsl-imx6.c
> -F: hw/misc/imx6_src.c
> +F: hw/misc/imx6_*.c
>  F: hw/ssi/imx_spi.c
>  F: include/hw/arm/fsl-imx6.h
> -F: include/hw/misc/imx6_src.h
> +F: include/hw/misc/imx6_*.h
>  F: include/hw/ssi/imx_spi.h

New models for the MCIMX6UL EVK might eventually match here.

>  
>  Sharp SL-5500 (Collie) PDA
> @@ -802,7 +812,9 @@ R: Joel Stanley <joel@jms.id.au>
>  L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/*/*aspeed*
> +F: hw/misc/pca9552.c
>  F: include/hw/*/*aspeed*
> +F: include/hw/misc/pca9552*.h
>  F: hw/net/ftgmac100.c
>  F: include/hw/net/ftgmac100.h

OK

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
