Received: from eggs.gnu.org ([209.51.188.92]:34618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1kXq-0003LA-SY
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 23:22:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1kXq-0002NN-1k
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 23:22:10 -0500
Date: Thu, 7 Mar 2019 15:11:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190307041117.GJ7722@umbus.fritz.box>
References: <20190306085032.15744-1-clg@kaod.org>
	<20190306085032.15744-17-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Re2uCLPLNzqOLVJA"
Content-Disposition: inline
In-Reply-To: <20190306085032.15744-17-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 16/27] ppc/pnv: lpc: fix OPB address ranges
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


--Re2uCLPLNzqOLVJA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 09:50:21AM +0100, C=E9dric Le Goater wrote:

This absolutely needs a commit message explaining why/how they were
wrong in the first place.

> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
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

--Re2uCLPLNzqOLVJA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyAmeUACgkQbDjKyiDZ
s5KHoA/5AWuK+2J3QoHbgR+S3R2TQDxoVzeAz6xWaObGSUSNLG1CpyvfXu2imoK4
g9EqZNPGD14XTDFtNypkEt5P3gdwfQHON1Qn/OafYjKeoJz+W3wXFTjxVb6YeN18
rgzfA95/jUYdPcVE4AJtu34p15O83I3jZZA+SokDdalb000tIYr6JU2UfFJbLLxt
9I/Vf2P+dgWkl5sLuRDe7ANkaNEXsgRTgP711VacIAWIgwaGrPoHtli8+DNBmCkx
OqgIR8U87qxyqcd8DxSgmR+GAQfcHDxut0RCFbBMemrhZKg7OmsQeXQufxWx/Vx4
mLaZ4ojBgiEmZMYmiGxz1Jg9H8BFoknpu09k0dwj0vii5Eyn7V5YxreJ8ACFg4pi
6BVZBYMLEZ4tJh/CFIp+0SeaqgOxf9lfper0ocn8ta1NGlb+JUMZEKdiwH96A6/7
lippUrAjo244j+8W7MgypyTw5uZxuKXuLtlPL9HF17O6+CSbdOtWs88kd1itLL9t
2RUJ6MIZNNozqEOKghTxuAUyYn55PFvkdq2Yu+bie89k4vdtReUn2dB0sDMJXfEU
hph58Rm0H2IoFgank0K0oD5mHUICeuVREdDZA+qpEIr7BlMUilAokH+1gY8YNZok
Y4143N3gtGMXZjgTV0OlgcslBI78CwCL+EN6PZYaE05T/ZIV8YI=
=o+hT
-----END PGP SIGNATURE-----

--Re2uCLPLNzqOLVJA--
