Received: from eggs.gnu.org ([2001:4830:134:3::10]:50643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0TMi-0003M1-CA
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0TMh-0004QY-IF
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:12:36 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:49307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e0TMh-0004Pf-Bi
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:12:35 -0400
Received: by mail-wr0-x22a.google.com with SMTP id p10so11327083wrc.6
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 07:12:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170918195100.17593-10-andrew.smirnov@gmail.com>
References: <20170918195100.17593-1-andrew.smirnov@gmail.com>
	<20170918195100.17593-10-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Oct 2017 15:12:13 +0100
Message-ID: <CAFEAcA9CZCLzUfZyNLbUF7tkDW+2HWNKk2+MLvx109VgoXNrEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 09/17] imx_fec: Use correct length for
 packet size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 18 September 2017 at 20:50, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> Use 'frame_size' instead of 'len' when calling qemu_send_packet(),
> failing to do so results in malformed packets send in case when that
> packed is fragmented into multiple DMA transactions.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  hw/net/imx_fec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index 6045ffe673..c45b9648d9 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -532,7 +532,7 @@ static void imx_enet_do_tx(IMXFECState *s, uint32_t index)
>                  }
>              }
>              /* Last buffer in frame.  */
> -            qemu_send_packet(qemu_get_queue(s->nic), frame, len);
> +            qemu_send_packet(qemu_get_queue(s->nic), frame, frame_size);
>              ptr = frame;
>              frame_size = 0;
>              if (bd.option & ENET_BD_TX_INT) {

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
