Received: from eggs.gnu.org ([208.118.235.92]:56254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gc6zt-0006io-1Y
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 06:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gc6zo-0007Ik-K6
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 06:05:08 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gc6zo-0007Hq-Et
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 06:05:04 -0500
Received: by mail-yw1-f67.google.com with SMTP id h193so6176540ywc.4
	for <qemu-devel@nongnu.org>; Wed, 26 Dec 2018 03:05:04 -0800 (PST)
MIME-Version: 1.0
References: <20181226034254.17842-1-richard.henderson@linaro.org>
In-Reply-To: <20181226034254.17842-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 26 Dec 2018 12:04:33 +0100
Message-ID: <CAAdtpL5K7P9zko_Dq6vdQSpZyxgOq9AW2Nga0ENDBDB7ndA-NA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: Use lduw_be_p in slirp_input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, jan.kiszka@siemens.com

Le mer. 26 d=C3=A9c. 2018 04:43, Richard Henderson <richard.henderson@linar=
o.org>
a =C3=A9crit :

> The pointer may be unaligned, so we must use our routines for that.
> At the same time, we might as well use the big-endian version
> instead of ntohs.
>
> This fixes sparc64 host SIGBUS during pxe boot.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
>  slirp/slirp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/slirp/slirp.c b/slirp/slirp.c
> index 322edf51eb..a116f43878 100644
> --- a/slirp/slirp.c
> +++ b/slirp/slirp.c
> @@ -851,7 +851,7 @@ void slirp_input(Slirp *slirp, const uint8_t *pkt, in=
t
> pkt_len)
>      if (pkt_len < ETH_HLEN)
>          return;
>
> -    proto =3D ntohs(*(uint16_t *)(pkt + 12));
> +    proto =3D lduw_be_p(pkt + 12);
>      switch(proto) {
>      case ETH_P_ARP:
>          arp_input(slirp, pkt, pkt_len);
> --
> 2.17.2
>
>
>
