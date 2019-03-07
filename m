Received: from eggs.gnu.org ([209.51.188.92]:57840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1juY-00081J-PH
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:41:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1juX-0006xE-Q9
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:41:34 -0500
Date: Thu, 7 Mar 2019 14:32:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190307033209.GF7722@umbus.fritz.box>
References: <20190306085032.15744-1-clg@kaod.org>
	<20190306085032.15744-14-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KJY2Ze80yH5MUxol"
Content-Disposition: inline
In-Reply-To: <20190306085032.15744-14-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 13/27] ppc/pnv: psi: add a reset handler
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


--KJY2Ze80yH5MUxol
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 09:50:18AM +0100, C=E9dric Le Goater wrote:
> Reset all regs but keep the MMIO BAR enabled as it is at realize time.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Again, I don't like the duplication of information between psi->reg
and psi->bar.  But that's out of scope for this patch, so, applied.

> ---
>  hw/ppc/pnv_psi.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index a2f8d0dece80..e61861bfd3c6 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -442,6 +442,15 @@ static const MemoryRegionOps pnv_psi_xscom_ops =3D {
>      }
>  };
> =20
> +static void pnv_psi_reset(void *dev)
> +{
> +    PnvPsi *psi =3D PNV_PSI(dev);
> +
> +    memset(psi->regs, 0x0, sizeof(psi->regs));
> +
> +    psi->regs[PSIHB_XSCOM_BAR] =3D psi->bar | PSIHB_BAR_EN;
> +}
> +
>  static void pnv_psi_init(Object *obj)
>  {
>      PnvPsi *psi =3D PNV_PSI(obj);
> @@ -511,6 +520,8 @@ static void pnv_psi_realize(DeviceState *dev, Error *=
*errp)
>          psi->regs[xivr] =3D PSIHB_XIVR_PRIO_MSK |
>              ((uint64_t) i << PSIHB_XIVR_SRC_SH);
>      }
> +
> +    qemu_register_reset(pnv_psi_reset, dev);
>  }
> =20
>  static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int xscom=
_offset)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KJY2Ze80yH5MUxol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyAkLkACgkQbDjKyiDZ
s5KZtw/+N2ykVcddgofQmqW0JWvSm7Ly+3RXdcRYR/FdD6AKE9g7oMaOlq1Zlzdk
eU1D/3Vjb/zjfafyijzNWfcBU8JW/A/0ZNKD1Zt15iMuCi1D7yYFfyYNIbEtTZy8
LL8fC21woj2vKOrCxfyc8zmGi6CPIOjuZzx9Lf6TqJeUKj+bL8HgeD+nTgJIUc2q
cA3SRfgaiYYKYiQJMs3E2Ul3W6WWX102GeEvIWLBYFx9Ymcm/MlHKeDDfzFmHwqg
9Sd3jZz3LfmQhXRnVLtrppRB3dhQZpKxjSsRXP56PhO1qd/q8LAM9VVa6R+4fL3i
IPMWT116dTQkZjKfiAPoed/bpCpQ0Ha7noJuI+gr7oynVkdBfqAXzsGkOSOyPKIS
9UZPlV/zhBSxbsORlNjUNW8R37wGXEKiSgclr+c2afqPN/A5HvcQ0dcnRbAXOvuv
53Ki+mliPtNC3RwCWoZ+tGU/Yjt4E+C6hZR4r4o6tcO9aI0q4QOVrhqm6pPtjYLp
VCEZQe9eQxdQMPxGwXblLqxyThTDvxuwGCiXaPZyn2pXAEWJwvzl12o2VsAFhQtf
vlKVWmMdZ0uyEpsOQXNGte0AIfhoWlVsOOblXzz5DmPrSOhMePnqX4TxECNp9gh9
V9U7Gj+0WQMjdVMmQNc8iB3oMwxMPTs4vSItcqC6ewfMNbDubx0=
=w2R8
-----END PGP SIGNATURE-----

--KJY2Ze80yH5MUxol--
