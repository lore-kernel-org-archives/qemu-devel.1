Received: from eggs.gnu.org ([2001:4830:134:3::10]:60542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEoXx-00060x-79
	for qemu-devel@nongnu.org; Sat, 05 May 2018 00:11:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEoXw-0001Xi-2A
	for qemu-devel@nongnu.org; Sat, 05 May 2018 00:11:45 -0400
Date: Sat, 5 May 2018 12:20:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180505022052.GG13229@umbus.fritz.box>
References: <cover.1525423550.git.balaton@eik.bme.hu>
	<39f72851afe39e24596a4aa328f4e9672cd37fd8.1525423550.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BRF4e1IEQp0HoEFj"
Content-Disposition: inline
In-Reply-To: <39f72851afe39e24596a4aa328f4e9672cd37fd8.1525423550.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH] ppc440_pcix: Fix a typo in setting a
 register (Coverity CID1390577)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>


--BRF4e1IEQp0HoEFj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 10:45:50AM +0200, BALATON Zoltan wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Applied to ppc-for-2.13.  There won't be a pull request until after
I'm back from holidays in a month, though. Sorry.

> ---
>  hw/ppc/ppc440_pcix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
> index b1307e6..d8af04b 100644
> --- a/hw/ppc/ppc440_pcix.c
> +++ b/hw/ppc/ppc440_pcix.c
> @@ -257,7 +257,7 @@ static void ppc440_pcix_reg_write4(void *opaque, hwad=
dr addr,
>          break;
>      case PCIX0_PIM2SAL:
>          s->pim[2].sa &=3D 0xffffffff00000000ULL;
> -        s->pim[2].sa =3D val;
> +        s->pim[2].sa |=3D val;
>          ppc440_pcix_update_pim(s, 2);
>          break;
>      case PCIX0_PIM2LAL:

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BRF4e1IEQp0HoEFj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrtFQIACgkQbDjKyiDZ
s5JooBAA2j2hlFMAgCxFJjyq0qPWWTMrxsyb63W/B7lgTnRKmJnwMDPhHyBpBWQT
Vx0S6g/nMZFiWhOazdiThhiTyGp+758IM6QfNzgifPuVKa41yNhjndnOVciTZhbm
6vsKseIBP58JPK8WBM2yRdzhkWa7qAxNmzhGIo1VMW3HiTMICsyy3VDRuVvdTjjv
Gqxvyq8Te0JZi5HSGC0GPcOh1Hej5i2+Nykr6eA+j92agQaCBM1PsA3DEsYVrgae
94X+QS7Oc7t7IuF8acP7eDdD+R8lCPwl8b1KyUEcNJveLQTVgyibksXtYgCUahfs
HCFw/F8sFX6/2XVSeu1LCNkfvzeHFujRSH208mZPAkzmmRQFPgviDUC491mRUYui
x0MINQoZ9lqZ86Zjt2EeL3t6uX4X4ZY0lJxMO5OiO2t9JEbqy8UY5RRyU4Ptb/+G
5YUvzZViOD/YUDORbFafyKydwMCC3PiQQ6B+URri/qC/Sz0wGkDwRuVRdJGuItnL
6VEyIdQNX7WCOY5cDjwfoVoBaCkW7RWGx/71uBtJ5p/e++VeGF1Kz6TUhY576nVE
oGrPMBUnBFhKHhigvbfGJDcspi+ua8VDOGHgm30lv+McZzPGU5q/p8Z+WqNQhGd+
Cc/IMf2lEa1tUQYkkaVWMgqNq7ZiKkAER34NW6VYO1a9i+Olmj4=
=lZ78
-----END PGP SIGNATURE-----

--BRF4e1IEQp0HoEFj--
