Received: from eggs.gnu.org ([208.118.235.92]:57813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geYK4-0001kH-SZ
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 23:40:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geYK3-0007qm-OA
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 23:40:04 -0500
Date: Wed, 2 Jan 2019 15:29:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190102042756.GR27457@umbus.fritz.box>
References: <cover.1546394798.git.balaton@eik.bme.hu>
	<849bd7369be13cbdc65d6e5e175b8e7f86528d72.1546394798.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1GSL5ZULXUIqbbH1"
Content-Disposition: inline
In-Reply-To: <849bd7369be13cbdc65d6e5e175b8e7f86528d72.1546394798.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH 8/8] MAINTAINERS: Add more files to sam460ex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>


--1GSL5ZULXUIqbbH1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 03:06:38AM +0100, BALATON Zoltan wrote:
> The sm501 model belonged to SH before but that seems to be inactive
> now and latest changes were for sam460ex which is the more active user
> of this device at the moment so let's adopt sm501 for sam460ex.
>=20
> Also add device tree and firmware sources and binaries.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Applied, thanks.

> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 180695f5d3..d2b71f8c4c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1029,8 +1029,14 @@ sam460ex
>  M: BALATON Zoltan <balaton@eik.bme.hu>
>  L: qemu-ppc@nongnu.org
>  S: Maintained
> +F: hw/ppc/sam460ex.c
> +F: hw/ppc/ppc440_pcix.c
> +F: hw/display/sm501*
>  F: hw/ide/sii3112.c
>  F: hw/timer/m41t80.c
> +F: pc-bios/canyonlands.dt[sb]
> +F: pc-bios/u-boot-sam460ex-20100605.bin
> +F: roms/u-boot-sam460ex
> =20
>  SH4 Machines
>  ------------

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1GSL5ZULXUIqbbH1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwsPcwACgkQbDjKyiDZ
s5JOHQ/+MIiE+lsH2GAaO5fRUkyJo9iFHrGIJxJoPL7ABtU94wvSL1bmokiMojF0
isB8go1uPiKqa8bvfK5IomnSbwAwI3noKjfiBiXLrChTJXBPu7Q4Xku5bvO5AkgF
DZKBPkix7u/2hsAzslNI9GksMb5hU7M13/TI5Oz2HPd/cUEfBLFPuAczFVM1xyQs
oqmrwWhHq8Dyg7niC3TzoD6Rw2sKnLRnFrxR2fAGg22Asxmzze5JHmrqg7wWBkBc
pH6lwP8pyb/eejsLYTvU4TmzJNM3R0ENveD6xcSCuYcII/+EsNSwM7VHm4UHxjVs
SxdrDP2CHG0DVb6DgDw+K2psp7vPYeDtphPmRugd3gLQc090JDSCrfivxUtmW/yW
O4h3+YHBS0BRPbMT/F9aQmgoc/DsOhUuk/fay8fTeV+KdHqFAWjLdKGQoz9CuOtC
83ZIojKizF8iKQ6k4B9LI79D7OeOOjSsDM8OVdJJ2rN2DMfEFtxG70f0PdcBWoBL
2utXMM9OF4E24SogLKBRM2aJhXJAQZt4HXxCaNx057TZwJY/rSM11YotEB29eBQp
TkcjWAC7KxODiesX4pMUURW6eQwhpZWI0Xa4nsKRkFGm7hb0GulEbthqjR8Aq+p2
Bw2XcNSaV3LmHci69cBQI1cUzxAVLs8w8kb46CwCN4sv5wnUv6c=
=jhRo
-----END PGP SIGNATURE-----

--1GSL5ZULXUIqbbH1--
