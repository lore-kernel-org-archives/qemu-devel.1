Received: from eggs.gnu.org ([2001:4830:134:3::10]:36988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjs1J-00070s-Jw
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:33:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjs1I-0007PC-RP
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:33:37 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjs1I-0007NW-KK
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:33:36 -0500
Received: by mail-wm0-x235.google.com with SMTP id n11so22017099wma.0
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 10:33:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7be6454441c7b61a02e22aa2d6f81f0c047d4312.1488504063.git.balaton@eik.bme.hu>
References: <cover.1488504063.git.balaton@eik.bme.hu>
	<7be6454441c7b61a02e22aa2d6f81f0c047d4312.1488504063.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 18:33:14 +0000
Message-ID: <CAFEAcA-qq_5A4p364Faz-Ms57HjmbbrSOa64ZGmtb336MATzyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 11/13] sm501: Add some more missing
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

On 10 December 2016 at 02:05, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> This is to allow clients to initialise these without failing as long
> as no 2D engine function is called that would use the written value.
> Saved values are not used yet (may get used when more of 2D engine is
> added sometimes) and clients normally only write to most of these
> registers, nothing is known to ever read them but they are documented
> as read/write so also implement read for these.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>
> v2: Fixed mask of video_control register for a read only bit
>     Changed IRQ status register to write ignored as IRQ is not implemented
> v3: Squashed read implementation into this patch
>
>  hw/display/sm501.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 106 insertions(+), 1 deletion(-)
>

> @@ -1454,6 +1558,7 @@ static void sm501_reset(SM501State *s)
>      s->misc_timing = 0;
>      s->power_mode_control = 0;
>      s->dc_panel_control = 0x00010000; /* FIFO level 3 */
> +    s->dc_video_control = 0;
>      s->dc_crt_control = 0x00010000;
>      s->twoD_control = 0;
>  }

You want to reset all these new fields, not just one of them.
If you do that then you can add
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
