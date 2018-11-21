Received: from eggs.gnu.org ([2001:4830:134:3::10]:54625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPQlu-0003K2-GE
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 06:34:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPQlq-0005xZ-HZ
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 06:34:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPQlq-0005xL-Bm
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 06:34:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id 125so5190377wmh.0
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 03:34:14 -0800 (PST)
References: <1542782568-20059-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6f2cdcdf-225b-44b8-d228-ae4ac3bfd299@redhat.com>
Date: Wed, 21 Nov 2018 12:34:06 +0100
MIME-Version: 1.0
In-Reply-To: <1542782568-20059-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] MAINTAINERS: Assign some more files in
 the hw/arm/ directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>

On 21/11/18 7:42, Thomas Huth wrote:
> I apparently missed some more files and even a complete machine (the
> "imx25-pdk") in my previous patch... but now we should hopefully have
> a completely coverage for all available ARM boards.
> 
> Fixes: 95a5db3ae5698b49c63144610ad02913e780c828
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   v3: Dropped "ds1338-test.c", added some more pxa2xx related files instead
> 
>   MAINTAINERS | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1032406..63c88e1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -533,6 +533,17 @@ L: qemu-arm@nongnu.org
>   S: Odd Fixes
>   F: hw/arm/gumstix.c
>   
> +i.MX25 PDK
> +M: Peter Maydell <peter.maydell@linaro.org>
> +R: Jean-Christophe Dubois <jcd@tribudubois.net>
> +L: qemu-arm@nongnu.org
> +S: Odd Fixes
> +F: hw/arm/fsl-imx25.c
> +F: hw/arm/imx25_pdk.c
> +F: hw/misc/imx25_ccm.c
> +F: include/hw/arm/fsl-imx25.h
> +F: include/hw/misc/imx25_ccm.h
> +
>   i.MX31 (kzm)
>   M: Peter Chubb <peter.chubb@nicta.com.au>
>   M: Peter Maydell <peter.maydell@linaro.org>
> @@ -615,6 +626,7 @@ R: Andrew Baumann <Andrew.Baumann@microsoft.com>
>   R: Philippe Mathieu-Daudé <f4bug@amsat.org>
>   L: qemu-arm@nongnu.org
>   S: Odd Fixes
> +F: hw/arm/raspi.c
>   F: hw/arm/raspi_platform.h
>   F: hw/*/bcm283*
>   F: include/hw/arm/raspi*
> @@ -639,8 +651,12 @@ F: hw/arm/spitz.c
>   F: hw/arm/tosa.c
>   F: hw/arm/z2.c
>   F: hw/*/pxa2xx*
> +F: hw/display/tc6393xb.c
> +F: hw/gpio/max7310.c
> +F: hw/gpio/zaurus.c
>   F: hw/misc/mst_fpga.c
>   F: include/hw/arm/pxa.h
> +F: include/hw/arm/sharpsl.h
>   
>   SABRELITE / i.MX6
>   M: Peter Maydell <peter.maydell@linaro.org>
> 
