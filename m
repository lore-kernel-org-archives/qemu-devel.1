Received: from eggs.gnu.org ([2001:4830:134:3::10]:44782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fY09N-0003iX-Ir
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fY09J-0003bn-K1
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:25:41 -0400
Received: from mail-qt0-x236.google.com ([2607:f8b0:400d:c0d::236]:37686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fY09J-0003bV-Do
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:25:37 -0400
Received: by mail-qt0-x236.google.com with SMTP id a18-v6so420988qtj.4
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 19:25:37 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180626220029.19088-1-jcd@tribudubois.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <58358d1c-57b2-3d6c-8cba-cd7ee53631c2@amsat.org>
Date: Tue, 26 Jun 2018 23:25:32 -0300
MIME-Version: 1.0
In-Reply-To: <20180626220029.19088-1-jcd@tribudubois.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] i.mx7d: Change IRQ number type from
 hwaddr to int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-devel@nongnu.org, peter.maydell@linaro.org, peter.chubb@nicta.com.au, andrew.smirnov@gmail.com

On 06/26/2018 07:00 PM, Jean-Christophe Dubois wrote:
> The qdev_get_gpio_in() function accept an int as second parameter.
> 
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/arm/fsl-imx7.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
> index e15aadb587..44fde03cbe 100644
> --- a/hw/arm/fsl-imx7.c
> +++ b/hw/arm/fsl-imx7.c
> @@ -324,7 +324,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
>              FSL_IMX7_ECSPI4_ADDR,
>          };
>  
> -        static const hwaddr FSL_IMX7_SPIn_IRQ[FSL_IMX7_NUM_ECSPIS] = {
> +        static const int FSL_IMX7_SPIn_IRQ[FSL_IMX7_NUM_ECSPIS] = {
>              FSL_IMX7_ECSPI1_IRQ,
>              FSL_IMX7_ECSPI2_IRQ,
>              FSL_IMX7_ECSPI3_IRQ,
> @@ -349,7 +349,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
>              FSL_IMX7_I2C4_ADDR,
>          };
>  
> -        static const hwaddr FSL_IMX7_I2Cn_IRQ[FSL_IMX7_NUM_I2CS] = {
> +        static const int FSL_IMX7_I2Cn_IRQ[FSL_IMX7_NUM_I2CS] = {
>              FSL_IMX7_I2C1_IRQ,
>              FSL_IMX7_I2C2_IRQ,
>              FSL_IMX7_I2C3_IRQ,
> @@ -515,7 +515,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
>              FSL_IMX7_USB3_ADDR,
>          };
>  
> -        static const hwaddr FSL_IMX7_USBn_IRQ[FSL_IMX7_NUM_USBS] = {
> +        static const int FSL_IMX7_USBn_IRQ[FSL_IMX7_NUM_USBS] = {
>              FSL_IMX7_USB1_IRQ,
>              FSL_IMX7_USB2_IRQ,
>              FSL_IMX7_USB3_IRQ,
> 
