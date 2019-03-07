Received: from eggs.gnu.org ([209.51.188.92]:57841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1juY-00081K-PK
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:41:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1juX-0006x9-Pj
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:41:34 -0500
Date: Thu, 7 Mar 2019 14:30:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190307033053.GE7722@umbus.fritz.box>
References: <20190306085032.15744-1-clg@kaod.org>
	<20190306085032.15744-13-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mR8QP4gmHujQHb1c"
Content-Disposition: inline
In-Reply-To: <20190306085032.15744-13-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 12/27] ppc/pnv: psi: add a PSIHB_REG macro
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


--mR8QP4gmHujQHb1c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 09:50:17AM +0100, C=E9dric Le Goater wrote:
> This is a simple helper to translate XSCOM addresses to MMIO addresses
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

A worthy cleanup, regardless of anything else.  Applied.

> ---
>  hw/ppc/pnv_psi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index c872be0b9c0d..a2f8d0dece80 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -114,6 +114,8 @@
>  #define PSIHB_BAR_MASK                  0x0003fffffff00000ull
>  #define PSIHB_FSPBAR_MASK               0x0003ffff00000000ull
> =20
> +#define PSIHB_REG(addr) (((addr) >> 3) + PSIHB_XSCOM_BAR)
> +
>  static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
>  {
>      MemoryRegion *sysmem =3D get_system_memory();
> @@ -392,13 +394,13 @@ static void pnv_psi_reg_write(PnvPsi *psi, uint32_t=
 offset, uint64_t val,
>   */
>  static uint64_t pnv_psi_mmio_read(void *opaque, hwaddr addr, unsigned si=
ze)
>  {
> -    return pnv_psi_reg_read(opaque, (addr >> 3) + PSIHB_XSCOM_BAR, true);
> +    return pnv_psi_reg_read(opaque, PSIHB_REG(addr), true);
>  }
> =20
>  static void pnv_psi_mmio_write(void *opaque, hwaddr addr,
>                                uint64_t val, unsigned size)
>  {
> -    pnv_psi_reg_write(opaque, (addr >> 3) + PSIHB_XSCOM_BAR, val, true);
> +    pnv_psi_reg_write(opaque, PSIHB_REG(addr), val, true);
>  }
> =20
>  static const MemoryRegionOps psi_mmio_ops =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mR8QP4gmHujQHb1c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyAkG0ACgkQbDjKyiDZ
s5L84hAAjuonLxaWFmWqSAEcJyF/Q5aXz5iCv0GFd3cRcnD0IHYETQDQozk314qJ
nUXzaQb/U2xT3pGstEw9hoCQtkNIPP/u1ndpuRyPvnLOXRSU2jKoAuOoRu5Nbs1c
KDV4ALS0I4LrDoVdcYo0uY6pgxn2NZ5pKFVyXsMv9hy37VZfToFaC1wi3w/tLn2H
OLTIum0jJ5bl5fmNUfgjrQm/ixcyeGM/VYgFm4ruubrPQOFLc6XlB+dTvjlkL72v
9X2+iQ3dWZlJ9q2SiadfOcR/iJ/sxOiZ9Fpmpx9/ecRMZ8evrwqehAii0oGbL5FK
H63+G3HPCG/VNVykAMCWRTJS2ymuXkmbACKPVkwfGdhaA4SXgK1tf74H4a9+VPu3
dGKsGV5ubW7tgImzeAq/p5WlYWCDC/xx/jg6oHuX3G3Y2mEsmMPM6prCXgEMtIVh
IOS2VdeZ18hl5BmD/Cnx3YU+98ySjHWqKeL2Qzld8uxIfaHIHVvy67KEIlmCRqA9
Zy8D3Dy7pVh0KAomuyzRg8OAbb0a1tDr1hwYPAMROR61Giem0q44mo1Rawp1+N8u
xVTLsP1fVNQFK8Y0lf6ZRdqYi3Nwzdx6Amvd0Z0ZJ9LQJzj+LFm7qD346xRcvWvk
yyNJBzuKZtVjv46z1SecQJITUdathWU6bkFc+qW3NOfKucSqQrA=
=7J7r
-----END PGP SIGNATURE-----

--mR8QP4gmHujQHb1c--
