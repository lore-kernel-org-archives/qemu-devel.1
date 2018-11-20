Received: from eggs.gnu.org ([2001:4830:134:3::10]:40626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPCYu-0005kO-84
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:23:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPCYr-0005dw-I9
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:23:56 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPCYr-0005cB-At
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:23:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id r11-v6so3355354wmb.2
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 12:23:53 -0800 (PST)
References: <1542735761-16176-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3bfff029-f88a-ef68-846c-1cacd0800d26@redhat.com>
Date: Tue, 20 Nov 2018 21:23:49 +0100
MIME-Version: 1.0
In-Reply-To: <1542735761-16176-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] MAINTAINERS: Assign some more files in
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

On 20/11/18 18:42, Thomas Huth wrote:
> I apparently missed some more files and even a complete machine (the
> "imx25-pdk") in my previous patch... but now we should hopefully have
> a completely coverage for all available ARM boards.
> 
> Fixes: 95a5db3ae5698b49c63144610ad02913e780c828
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Dropped smmu* files from this patch
> 
>   MAINTAINERS | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1032406..36ffc01 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -533,6 +533,18 @@ L: qemu-arm@nongnu.org
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

> +F: tests/ds1338-test.c

This last entry is weird alone (at least without the hw/timer/ds1338.c 
device listed).

This RTC is also used by the aspeed/realview/versatilepb boards.

> +
>   i.MX31 (kzm)
>   M: Peter Chubb <peter.chubb@nicta.com.au>
>   M: Peter Maydell <peter.maydell@linaro.org>
> @@ -615,6 +627,7 @@ R: Andrew Baumann <Andrew.Baumann@microsoft.com>
>   R: Philippe Mathieu-Daudé <f4bug@amsat.org>
>   L: qemu-arm@nongnu.org
>   S: Odd Fixes
> +F: hw/arm/raspi.c
>   F: hw/arm/raspi_platform.h
>   F: hw/*/bcm283*
>   F: include/hw/arm/raspi*
> @@ -641,6 +654,7 @@ F: hw/arm/z2.c
>   F: hw/*/pxa2xx*
>   F: hw/misc/mst_fpga.c
>   F: include/hw/arm/pxa.h
> +F: include/hw/arm/sharpsl.h

I think hw/gpio/zaurus.c goes there too.

>   
>   SABRELITE / i.MX6
>   M: Peter Maydell <peter.maydell@linaro.org>
> 

Regards,

Phil.
