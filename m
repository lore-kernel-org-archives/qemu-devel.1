Received: from eggs.gnu.org ([2001:4830:134:3::10]:49639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alastair@d-silva.org>) id 1dXQBB-0000v0-Q5
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alastair@d-silva.org>) id 1dXQB8-0008Km-OG
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:56:37 -0400
From: "Alastair D'Silva" <alastair@d-silva.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-8-f4bug@amsat.org>
In-Reply-To: <20170718061005.29518-8-f4bug@amsat.org>
Date: Tue, 18 Jul 2017 20:23:42 +1000
Message-ID: <045101d2ffaf$ef4b60e0$cde222a0$@d-silva.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-au
Subject: Re: [Qemu-devel] [PATCH 07/29] ds1338: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?'Philippe_Mathieu-Daud=C3=A9'?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, 'Peter Maydell' <peter.maydell@linaro.org>, 'Corey Minyard' <cminyard@mvista.com>
Cc: qemu-devel@nongnu.org, 'Eric Blake' <eblake@redhat.com>

I'm not sure this makes sense - we're dealing with time here.

--=20
Alastair D'Silva           mob: 0423 762 819
skype: alastair_dsilva     msn: alastair@d-silva.org
blog: http://alastair.d-silva.org    Twitter: @EvilDeece



> -----Original Message-----
> From: Philippe Mathieu-Daud=C3=A9 =
[mailto:philippe.mathieu.daude@gmail.com]
> On Behalf Of Philippe Mathieu-Daud=C3=A9
> Sent: Tuesday, 18 July 2017 4:10 PM
> To: qemu-trivial@nongnu.org; Peter Maydell <peter.maydell@linaro.org>;
> Alastair D'Silva <alastair@d-silva.org>; Corey Minyard
> <cminyard@mvista.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>; =
qemu-devel@nongnu.org;
> Eric Blake <eblake@redhat.com>
> Subject: [PATCH 07/29] ds1338: use QEMU_IS_ALIGNED macro
>=20
> Applied using the Coccinelle semantic patch
> scripts/coccinelle/use_osdep.cocci
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/timer/ds1338.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c index
> 3849b74a68..a77fe14514 100644
> --- a/hw/timer/ds1338.c
> +++ b/hw/timer/ds1338.c
> @@ -65,7 +65,7 @@ static void capture_current_time(DS1338State *s)
>      s->nvram[1] =3D to_bcd(now.tm_min);
>      if (s->nvram[2] & HOURS_12) {
>          int tmp =3D now.tm_hour;
> -        if (tmp % 12 =3D=3D 0) {
> +        if (QEMU_IS_ALIGNED(tmp, 12)) {
>              tmp +=3D 12;
>          }
>          if (tmp <=3D 12) {
> @@ -154,7 +154,7 @@ static int ds1338_send(I2CSlave *i2c, uint8_t =
data)
>                  if (data & HOURS_PM) {
>                      tmp +=3D 12;
>                  }
> -                if (tmp % 12 =3D=3D 0) {
> +                if (QEMU_IS_ALIGNED(tmp, 12)) {
>                      tmp -=3D 12;
>                  }
>                  now.tm_hour =3D tmp;
> --
> 2.13.2
>=20
>=20
> ---
> This email has been checked for viruses by AVG.
> http://www.avg.com
