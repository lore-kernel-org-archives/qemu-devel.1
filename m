Received: from eggs.gnu.org ([2001:4830:134:3::10]:59807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePfaQ-0004J0-Hd
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 21:18:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePfaM-0001vF-Hi
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 21:18:54 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171214145255.31545-1-andrew.smirnov@gmail.com>
	<20171214145255.31545-16-andrew.smirnov@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c8081a26-929f-4c9c-d1cd-09501bd83274@amsat.org>
Date: Thu, 14 Dec 2017 23:18:40 -0300
MIME-Version: 1.0
In-Reply-To: <20171214145255.31545-16-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 15/15] sdhci: Implement write method of
 ACMD12ERRSTS register
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

Hi Andrey,

On 12/14/2017 11:52 AM, Andrey Smirnov wrote:
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

I have a more complete patch coming implementing the
CTRL2_VOLTAGE_SWITCH (LSB part of the ACMD12ERRSTS register) but in the
meaning time your patch is fine.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/sd/sdhci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 758af067f9..cb9e0db9fb 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1139,6 +1139,9 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>          s->admasysaddr = (s->admasysaddr & (0x00000000FFFFFFFFULL |
>                  ((uint64_t)mask << 32))) | ((uint64_t)value << 32);
>          break;
> +    case SDHC_ACMD12ERRSTS:
> +        MASKED_WRITE(s->acmd12errsts, mask, value);
> +        break;
>      case SDHC_FEAER:
>          s->acmd12errsts |= value;
>          s->errintsts |= (value >> 16) & s->errintstsen;
> 
