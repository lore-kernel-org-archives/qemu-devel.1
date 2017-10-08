Received: from eggs.gnu.org ([2001:4830:134:3::10]:38694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1e1LGT-0001xF-U8
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 19:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1e1LGQ-0000LV-O3
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 19:45:45 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59713)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrew@aj.id.au>) id 1e1LGQ-0000KV-Gj
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 19:45:42 -0400
Message-ID: <1507506331.5452.145.camel@aj.id.au>
From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 09 Oct 2017 10:15:31 +1030
In-Reply-To: <20170920064915.30027-1-clg@kaod.org>
References: <20170920064915.30027-1-clg@kaod.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-0w7ioayN+VPQluXk95iq"
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] watchdog/aspeed: fix variable type to
 store reload value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, "Anton D . Kachalov" <mouse@yandex-team.ru>


--=-0w7ioayN+VPQluXk95iq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2017-09-20 at 08:49 +0200, C=C3=A9dric Le Goater wrote:
> Initially from Anton D. Kachalov" <mouse@yandex-team.ru> but the SoB was
> missing.
>=C2=A0
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> [clg: change commit log and subject
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0replace UL suffix by ULL ]
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Acked-by: Andrew Jeffery <andrew@aj.id.au>

> ---
> =C2=A0hw/watchdog/wdt_aspeed.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=C2=A0
> diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
> index 22bce364d7b5..95f6ad186d72 100644
> --- a/hw/watchdog/wdt_aspeed.c
> +++ b/hw/watchdog/wdt_aspeed.c
> @@ -100,13 +100,13 @@ static uint64_t aspeed_wdt_read(void *opaque, hwadd=
r offset, unsigned size)
> =C2=A0
> =C2=A0static void aspeed_wdt_reload(AspeedWDTState *s, bool pclk)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0=C2=A0uint32_t reload;
> +=C2=A0=C2=A0=C2=A0=C2=A0uint64_t reload;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (pclk) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reload =3D muldiv64=
(s->regs[WDT_RELOAD_VALUE], NANOSECONDS_PER_SECOND,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0s->pclk_freq);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reload =3D s->regs[WDT_R=
ELOAD_VALUE] * 1000;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reload =3D s->regs[WDT_R=
ELOAD_VALUE] * 1000ULL;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (aspeed_wdt_is_enabled(s)) {
--=-0w7ioayN+VPQluXk95iq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJZ2ribAAoJEJ0dnzgO5LT5lmsQALkSsXvPxuAs01GtLGH3nQFu
2bqlNJXfqJvQOnqSbT+leHs9byaK0dYOM7yVXtaHg7sdmnEDgUNgiEZCpO/heFRm
93ynm/k74kl2y8FyXtCpPSTz8ZlTzyN2c412sZ+XRtO77698OkiJ2536ne9AAAcS
7DM03UkzU47oYLJbFEs7eU5L6fWZObnybkYg18fqXHPNKECQW8EI2I8w7IaZ2aef
KE/d4WbwzNQyevcpMxTtbsFqIX4S9pmtQzBnpyM2kEeuTX7Guvs4oXeJC0fILB2S
+sL1HYGXel9sCk90TPQiQ35WqHXEgfjJFFr/Q+ZdrXN+RjtmonKfu29xW3XEnMnl
payLqmLDOfYVihLA7OBPHk1xwNOl7ZmoOnvu5YrnDtAwZnOMEbyBG0ZLqVhiS7iO
mt/Hd5qS0lBuakGdr8cradJlRC9sR+dEpYNGF4COpdGUMYnIm8KZKV/iA7rIL6Ws
5NoCP0RBMcZIzG+wO0qJbnydIF4vSntHNAVqOwSENfbKCP5uaSOtgotQfJmnBWfU
yG8CA3b+wRk7QgcaV+c9oy/QtPzDKqSvrQhsPRG5aA9DfrqFfRk3+ozC8vGHw/XP
DUwE3W2kBVPL07IDCIxAJ3xuf+UOrY+soegQujLWHTznPZh/yiojaHOTs5ZLPjby
fdmNyDnDItlbXfdfRYZj
=1qxk
-----END PGP SIGNATURE-----

--=-0w7ioayN+VPQluXk95iq--
