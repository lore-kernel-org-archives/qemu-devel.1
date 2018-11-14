Received: from eggs.gnu.org ([208.118.235.92]:57673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMtnb-0006HP-EX
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:57:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMtnQ-0000nT-6O
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:57:29 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gMtnO-0000m2-UL
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:57:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id j10so2755054wru.4
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 03:57:21 -0800 (PST)
References: <1542184999-11145-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3ba66e6c-2eeb-2352-252b-75487ad91916@redhat.com>
Date: Wed, 14 Nov 2018 12:57:18 +0100
MIME-Version: 1.0
In-Reply-To: <1542184999-11145-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add entries for missing ARM
 boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Jean-Christophe Dubois <jcd@tribudubois.net>

Hi Thomas,

On 14/11/18 9:43, Thomas Huth wrote:
> Add entries for the boards "mcimx6ul-evk", "mcimx7d-sabre", "raspi2",
> "raspi3", "sabrelite", "vexpress-a15", "vexpress-a9" and "virt".
> While we're at it, also adjust the "i.MX31" section a little bit,
> so that the wildcards there do not match anymore for unrelated files
> (e.g. the new hw/misc/imx6ul_ccm.c file).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 65 insertions(+), 5 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4b8db61..dd8ac65 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -521,14 +521,15 @@ L: qemu-arm@nongnu.org
>   S: Odd Fixes
>   F: hw/arm/gumstix.c
>   
> -i.MX31
> +i.MX31 (kzm)
>   M: Peter Chubb <peter.chubb@nicta.com.au>
>   L: qemu-arm@nongnu.org
> -S: Odd fixes
> -F: hw/*/imx*
> -F: include/hw/*/imx*
> +S: Odd Fixes
>   F: hw/arm/kzm.c
> -F: include/hw/arm/fsl-imx31.h
> +F: hw/*/imx_*
> +F: hw/*/*imx31*
> +F: include/hw/*/imx_*
> +F: include/hw/*/*imx31*
>   
>   Integrator CP
>   M: Peter Maydell <peter.maydell@linaro.org>
> @@ -537,6 +538,28 @@ S: Maintained
>   F: hw/arm/integratorcp.c
>   F: hw/misc/arm_integrator_debug.c
>   
> +MCIMX6UL EVK / i.MX6ul
> +M: Peter Maydell <peter.maydell@linaro.org>
> +R: Jean-Christophe Dubois <jcd@tribudubois.net>
> +L: qemu-arm@nongnu.org
> +S: Odd Fixes
> +F: hw/arm/mcimx6ul-evk.c
> +F: hw/arm/fsl-imx6ul.c
> +F: hw/misc/imx6ul_ccm.c
> +F: include/hw/arm/fsl-imx6ul.h
> +F: include/hw/misc/imx6ul_ccm.h
> +
> +MCIMX7D SABRE / i.MX7
> +M: Peter Maydell <peter.maydell@linaro.org>
> +R: Andrey Smirnov <andrew.smirnov@gmail.com>
> +L: qemu-arm@nongnu.org
> +S: Odd Fixes
> +F: hw/arm/mcimx7d-sabre.c
> +F: hw/arm/fsl-imx7.c
> +F: include/hw/arm/fsl-imx7.h
> +F: hw/pci-host/designware.c
> +F: include/hw/pci-host/designware.h
> +
>   MPS2
>   M: Peter Maydell <peter.maydell@linaro.org>
>   L: qemu-arm@nongnu.org
> @@ -570,6 +593,17 @@ L: qemu-arm@nongnu.org
>   S: Maintained
>   F: hw/arm/palm.c
>   
> +Raspberry Pi
> +M: Peter Maydell <peter.maydell@linaro.org>
> +R: Andrew Baumann <Andrew.Baumann@microsoft.com>
> +R: Philippe Mathieu-Daudé <f4bug@amsat.org>
> +L: qemu-arm@nongnu.org
> +S: Odd Fixes
> +F: hw/arm/raspi_platform.h
> +F: hw/*/bcm283*
> +F: include/hw/arm/raspi*
> +F: include/hw/*/bcm283*
> +
>   Real View
>   M: Peter Maydell <peter.maydell@linaro.org>
>   L: qemu-arm@nongnu.org
> @@ -591,6 +625,19 @@ F: hw/*/pxa2xx*
>   F: hw/misc/mst_fpga.c
>   F: include/hw/arm/pxa.h
>   
> +SABRELITE / i.MX6
> +M: Peter Maydell <peter.maydell@linaro.org>
> +R: Jean-Christophe Dubois <jcd@tribudubois.net>
> +L: qemu-arm@nongnu.org
> +S: Odd Fixes
> +F: hw/arm/sabrelite.c
> +F: hw/arm/fsl-imx6.c
> +F: hw/misc/imx6_src.c
> +F: hw/ssi/imx_spi.c
> +F: include/hw/arm/fsl-imx6.h
> +F: include/hw/misc/imx6_src.h
> +F: include/hw/ssi/imx_spi.h
> +
>   Sharp SL-5500 (Collie) PDA
>   M: Peter Maydell <peter.maydell@linaro.org>
>   L: qemu-arm@nongnu.org
> @@ -604,6 +651,12 @@ L: qemu-arm@nongnu.org
>   S: Maintained
>   F: hw/*/stellaris*
>   
> +Versatile Express
> +M: Peter Maydell <peter.maydell@linaro.org>
> +L: qemu-arm@nongnu.org
> +S: Maintained

Shouldn't this be 'Supported?'
"Someone is actually paid to look after this."

> +F: hw/arm/vexpress.c
> +
>   Versatile PB
>   M: Peter Maydell <peter.maydell@linaro.org>
>   L: qemu-arm@nongnu.org
> @@ -611,6 +664,13 @@ S: Maintained
>   F: hw/*/versatile*
>   F: hw/misc/arm_sysctl.c
>   
> +Virt
> +M: Peter Maydell <peter.maydell@linaro.org>
> +L: qemu-arm@nongnu.org
> +S: Maintained

This one is certainly 'Supported'.

> +F: hw/arm/virt*
> +F: include/hw/arm/virt.h
> +
>   Xilinx Zynq
>   M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>   M: Alistair Francis <alistair@alistair23.me>
> 
