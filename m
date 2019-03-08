Received: from eggs.gnu.org ([209.51.188.92]:42241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h240N-0006F8-FM
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:08:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h240J-0000zM-Td
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:08:53 -0500
Date: Fri, 8 Mar 2019 11:33:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190308003335.GP7722@umbus.fritz.box>
References: <20190307223548.20516-1-clg@kaod.org>
	<20190307223548.20516-13-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MOLI6A2k/lnHENyK"
Content-Disposition: inline
In-Reply-To: <20190307223548.20516-13-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 12/15] ppc/pnv: activate XSCOM tests for
 POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--MOLI6A2k/lnHENyK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 11:35:45PM +0100, C=E9dric Le Goater wrote:
> We now have enough support to let the XSCOM test run on POWER9.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>  tests/pnv-xscom-test.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/tests/pnv-xscom-test.c b/tests/pnv-xscom-test.c
> index 974f8da5b240..63d464048d53 100644
> --- a/tests/pnv-xscom-test.c
> +++ b/tests/pnv-xscom-test.c
> @@ -39,7 +39,6 @@ static const PnvChip pnv_chips[] =3D {
>          .cfam_id    =3D 0x120d304980000000ull,
>          .first_core =3D 0x1,
>      },
> -#if 0 /* POWER9 support is not ready yet */
>      {
>          .chip_type  =3D PNV_CHIP_POWER9,
>          .cpu_model  =3D "POWER9",
> @@ -47,7 +46,6 @@ static const PnvChip pnv_chips[] =3D {
>          .cfam_id    =3D 0x220d104900008000ull,
>          .first_core =3D 0x0,
>      },
> -#endif
>  };
> =20
>  static uint64_t pnv_xscom_addr(const PnvChip *chip, uint32_t pcba)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MOLI6A2k/lnHENyK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyBuF4ACgkQbDjKyiDZ
s5KHwA/9EoP3S66WqEPWewuNDPiecUUJPKZm4+W6+CCGTei0P8/7jGHR6zAuzW9M
Vn6BCXnrjs1MA8ZgWUQBRJmK7WFy77ZNq6DwFyg6dXRscvb2NWrr/NHcwkP/0s5L
m+aQybk5hN31MYNepGCCyQuEanPNJ99wvEiWx2JkeSE6Hc1oCujZxEiKjqcgzsda
e2bOz88fTSGWROq4NUrxMJ0snow2crEftbeRl7/mkEjMjrBzG+uIUDmQjhcpQLhT
cRJ5OsGdXeVqHI92gLPijo74X2cwu6utbbMBujJ2CwL/dRksdLFlH/8WdI4poUwJ
HLgGr1sJi1U1vBKX2BwoHhw6425xOhY1aIMoMrP0FUt2V03x/L/Y1QRcLuo8qALL
mfHq48mv5ih2+4XhpXB7g7OmnD9pD1ErJlaW7Encj1+lskJKuUtE/bHGcAVhO5MX
KwyQfE0a7dgT6zFfhpJgW6QQqG/2oP05UDHJhqrN4eLLeelhWYhGRhnrt6xVP87z
9GRqFUEOHcLOzoezBL0girLmfj4nC4WO3nblRXa2kF60BbaxHLJoqihCofrkZc2X
JyZhdaxxx2vHtc/0VFVaTgvUhFxz/9w97gtQNHEeqiQwFmTMQN0j1S0cFIEwaC4P
ltMU7BAPxhZEzsmWGpq+Nv7DFd3LTx8+xmnGfNFA968s/JmNg0U=
=ShVF
-----END PGP SIGNATURE-----

--MOLI6A2k/lnHENyK--
