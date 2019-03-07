Received: from eggs.gnu.org ([209.51.188.92]:38823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2352-0002zC-8c
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:09:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2351-0002y0-62
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:09:40 -0500
Date: Fri, 8 Mar 2019 10:59:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190307235909.GB7722@umbus.fritz.box>
References: <20190307223548.20516-1-clg@kaod.org>
	<20190307223548.20516-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PAKmkkBo0+rTwAqJ"
Content-Disposition: inline
In-Reply-To: <20190307223548.20516-4-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 03/15] ppc/pnv: lpc: fix OPB address
 ranges
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


--PAKmkkBo0+rTwAqJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 11:35:36PM +0100, C=E9dric Le Goater wrote:
> The PowerNV LPC Controller exposes different sets of registers for
> each of the functional units it encompasses, among which the OPB
> (On-Chip Peripheral Bus) Master and Arbitrer and the LPC HOST
> Controller.
>=20
> The mapping addresses of each register range are correct but the sizes
> are too large. Fix the sizes and define the OPB Arbitrer range to fill
> the gap between the OPB Master registers and the LPC HOST Controller
> registers.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>=20
>  Changes in v2 :
>=20
>   - wrote a commit log
>=20
>  hw/ppc/pnv_lpc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index 9b18ce55e391..547be609cafe 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -89,10 +89,11 @@ enum {
>  #define LPC_FW_OPB_SIZE         0x10000000
> =20
>  #define LPC_OPB_REGS_OPB_ADDR   0xc0010000
> -#define LPC_OPB_REGS_OPB_SIZE   0x00002000
> +#define LPC_OPB_REGS_OPB_SIZE   0x00000060
> +#define LPC_OPB_REGS_OPBA_ADDR  0xc0011000
> +#define LPC_OPB_REGS_OPBA_SIZE  0x00000008
>  #define LPC_HC_REGS_OPB_ADDR    0xc0012000
> -#define LPC_HC_REGS_OPB_SIZE    0x00001000
> -
> +#define LPC_HC_REGS_OPB_SIZE    0x00000100
> =20
>  static int pnv_lpc_dt_xscom(PnvXScomInterface *dev, void *fdt, int xscom=
_offset)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PAKmkkBo0+rTwAqJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyBsE0ACgkQbDjKyiDZ
s5KNqQ/+PvuXb3guti8zFD8dWgSz6UAQQOfibo8nTDdA8yobGfCdm1MO5kWSgVBr
dRif1ZSRTQ3wj1InDlcsnhoRn8I50BYh1LhxcaYWoHmPJd3UgpkKSJX0POgWtf2N
KiCf3//SrOqLVyDVaYf1AObgz2lU3x5CD3+ViPKR8Q4WyomyySfl0nDWhWHT401u
d4+q7xrRRw+GZ57S15NXfvYD46wohrcx/0uW5z6KPpjCy4LZQwrsJzBeL9qHidfE
95shCIR5nApQOYjgrfolycxhqOtYppB1mqSN+bs24VGQyjGe3T7OVIj6DuGpKq3i
p+sNmr6tcqhBvWpSSjEMjNZPzBZM6MDakCf1RT4Fzxn0kVja/DDpe+xltSo0liHI
tX9sVVLVhnK9xBjW8MdS/U0r3NJLPfQD7pzk3e/0ZXliPGIFFc9Vd0TELOBPeBXh
Y0MJFZhqo2GDCADhseLPrdq8mPKjdcsZgwN7bV71U8aNtqrF488rxVa28/MQXx1D
f2yGrxQFj6VTBwFHx+fkqHZobMik0HNNDlyg/JipbBgUvsz/7ag/c3XDfCzo85Ss
Ns6/yE74PWQIUM9jJWXDTI+CsE3TLeIk/ND3i/kQgGsYlKAVHWmlkZIJn65eYSTK
HD/j6UzARvqd4vRM+xc/epwuxO0EbkYdSiMd503O0gm8X1txDEg=
=dPy3
-----END PGP SIGNATURE-----

--PAKmkkBo0+rTwAqJ--
