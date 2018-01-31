Received: from eggs.gnu.org ([2001:4830:134:3::10]:60282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1egvoA-0003PI-Ky
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:04:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1egvo7-00050I-TL
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:04:26 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180116013709.13830-1-andrew.smirnov@gmail.com>
	<20180116013709.13830-3-andrew.smirnov@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <05796947-7765-f662-0827-2ac9d2f018ce@amsat.org>
Date: Wed, 31 Jan 2018 14:04:20 -0300
MIME-Version: 1.0
In-Reply-To: <20180116013709.13830-3-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 02/14] hw: i.MX: Convert i.MX6 to use
 TYPE_IMX_USDHC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, yurovsky@gmail.com

On 01/15/2018 10:36 PM, Andrey Smirnov wrote:
> Convert i.MX6 to use TYPE_IMX_USDHC since that's what real HW comes
> with.
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/arm/fsl-imx6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
> index b0d4088290..e6559a8b12 100644
> --- a/hw/arm/fsl-imx6.c
> +++ b/hw/arm/fsl-imx6.c
> @@ -93,7 +93,7 @@ static void fsl_imx6_init(Object *obj)
>      }
>  
>      for (i = 0; i < FSL_IMX6_NUM_ESDHCS; i++) {
> -        object_initialize(&s->esdhc[i], sizeof(s->esdhc[i]), TYPE_SYSBUS_SDHCI);
> +        object_initialize(&s->esdhc[i], sizeof(s->esdhc[i]), TYPE_IMX_USDHC);
>          qdev_set_parent_bus(DEVICE(&s->esdhc[i]), sysbus_get_default());
>          snprintf(name, NAME_SIZE, "sdhc%d", i + 1);
>          object_property_add_child(obj, name, OBJECT(&s->esdhc[i]), NULL);
> 
