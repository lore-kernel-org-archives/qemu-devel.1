Received: from eggs.gnu.org ([2001:4830:134:3::10]:52346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dy7Uq-0005mO-IQ
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dy7Up-0007Tu-Jv
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:27:16 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170918195100.17593-1-andrew.smirnov@gmail.com>
	<20170918195100.17593-7-andrew.smirnov@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <46b536c8-db38-0f89-3a8d-703ddad78923@amsat.org>
Date: Fri, 29 Sep 2017 21:19:37 -0300
MIME-Version: 1.0
In-Reply-To: <20170918195100.17593-7-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 06/17] imx_fec: Use MIN instead
 of explicit ternary operator
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, yurovsky@gmail.com
List-ID: <qemu-devel.nongnu.org>

On 09/18/2017 04:50 PM, Andrey Smirnov wrote:
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>   hw/net/imx_fec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index 989c11be5f..8a77136d38 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -1074,7 +1074,7 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
>                             TYPE_IMX_FEC, __func__);
>               break;
>           }
> -        buf_len = (size <= s->regs[ENET_MRBR]) ? size : s->regs[ENET_MRBR];
> +        buf_len = MIN(size, s->regs[ENET_MRBR]);

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>           bd.length = buf_len;
>           size -= buf_len;
>   
> 
