Received: from eggs.gnu.org ([209.51.188.92]:42243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h240N-0006F9-GM
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:08:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h240K-00010G-Bw
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:08:54 -0500
Date: Fri, 8 Mar 2019 11:28:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190308002828.GK7722@umbus.fritz.box>
References: <20190307223548.20516-1-clg@kaod.org>
	<20190307223548.20516-8-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="roRPt/Cw7eYGd+Rv"
Content-Disposition: inline
In-Reply-To: <20190307223548.20516-8-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 07/15] ppc/pnv: add SerIRQ routing
 registers
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


--roRPt/Cw7eYGd+Rv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 11:35:40PM +0100, C=E9dric Le Goater wrote:
> This is just a simple reminder that SerIRQ routing should be
> addressed.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---

Applied, thanks.

>  include/hw/ppc/pnv_lpc.h |  2 ++
>  hw/ppc/pnv_lpc.c         | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)
>=20
> diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
> index 242b18081caa..413579792ed1 100644
> --- a/include/hw/ppc/pnv_lpc.h
> +++ b/include/hw/ppc/pnv_lpc.h
> @@ -55,6 +55,8 @@ typedef struct PnvLpcController {
>      MemoryRegion opb_master_regs;
> =20
>      /* OPB Master LS registers */
> +    uint32_t opb_irq_route0;
> +    uint32_t opb_irq_route1;
>      uint32_t opb_irq_stat;
>      uint32_t opb_irq_mask;
>      uint32_t opb_irq_pol;
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index 6df694e0abc1..641e2046db92 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -39,6 +39,8 @@ enum {
>  };
> =20
>  /* OPB Master LS registers */
> +#define OPB_MASTER_LS_ROUTE0    0x8
> +#define OPB_MASTER_LS_ROUTE1    0xC
>  #define OPB_MASTER_LS_IRQ_STAT  0x50
>  #define   OPB_MASTER_IRQ_LPC            0x00000800
>  #define OPB_MASTER_LS_IRQ_MASK  0x54
> @@ -521,6 +523,12 @@ static uint64_t opb_master_read(void *opaque, hwaddr=
 addr, unsigned size)
>      uint64_t val =3D 0xfffffffffffffffful;
> =20
>      switch (addr) {
> +    case OPB_MASTER_LS_ROUTE0: /* TODO */
> +        val =3D lpc->opb_irq_route0;
> +        break;
> +    case OPB_MASTER_LS_ROUTE1: /* TODO */
> +        val =3D lpc->opb_irq_route1;
> +        break;
>      case OPB_MASTER_LS_IRQ_STAT:
>          val =3D lpc->opb_irq_stat;
>          break;
> @@ -547,6 +555,12 @@ static void opb_master_write(void *opaque, hwaddr ad=
dr,
>      PnvLpcController *lpc =3D opaque;
> =20
>      switch (addr) {
> +    case OPB_MASTER_LS_ROUTE0: /* TODO */
> +        lpc->opb_irq_route0 =3D val;
> +        break;
> +    case OPB_MASTER_LS_ROUTE1: /* TODO */
> +        lpc->opb_irq_route1 =3D val;
> +        break;
>      case OPB_MASTER_LS_IRQ_STAT:
>          lpc->opb_irq_stat &=3D ~val;
>          pnv_lpc_eval_irqs(lpc);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--roRPt/Cw7eYGd+Rv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyBtywACgkQbDjKyiDZ
s5LMGRAAjGBy+35hL1blQ90lC5P/VJF0kWnntbcPTpnkhX6Cp6/+Snq+/NbaG87d
sp/+ZZx5RgCrdWlTGjtWcEe18bTO2CZ027LoaYHeAGY6ntbD5OlbHcuyLpAIGPJ3
RPPc4goVSPppL3FAXsnqhFrUX83neu6KZ+yA6etWA1Wu6zvyVsyvrDdFYIHxZpZy
2ZSIvQcaMCY2UQrBGHwB7/iCU+ijx7dw4EkgqaWTBe7Txi0GzoYdpo4qR3VyaE3Q
YMQ8qQx97VmvqDvsxeMexIR5vEy/6md12izfN6geTpJftn2fIvIBeIq/IBNiWvWq
gOvgUlpaZdiw+P5KZKt9Z1Jbh8GAhuAFxzxSircCikf4DZdcTD4lYFEZV9V3sEzB
Xfxb331hWNtud4iN8LwwAb1P01MM5E0fr68UAK3vKJBgYGWhAwpWTSdQXLzWC2Fj
LLrHMemMuff1A92bxaDYYX4fWP5UVsNqz7a15QcbiwWJf93iWaEUwtqEYYUYMzAE
4m8pOGNwyWU75pqZrgw6Ou9Qz5ODvyubmKE1EImUgZU3d9Qnqo3v8kOJkpD+y2ww
CNG9bpXZquyC4UY72fPiFrteFOmlQX7dhLbW6Ch1VhknWHUUYc/wKVfDRcuGhyTA
nxKOYbw6jZwPSte6KMx/Z0Gk/OMNo+mGTBU23fCDJ4Zn3MhwAgo=
=9QwE
-----END PGP SIGNATURE-----

--roRPt/Cw7eYGd+Rv--
