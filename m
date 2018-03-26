Received: from eggs.gnu.org ([2001:4830:134:3::10]:49547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f0HkK-0003hU-Sb
	for qemu-devel@nongnu.org; Sun, 25 Mar 2018 22:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f0HkJ-0003J2-Ep
	for qemu-devel@nongnu.org; Sun, 25 Mar 2018 22:20:28 -0400
Date: Mon, 26 Mar 2018 13:20:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180326022012.GB2104@umbus.fritz.box>
References: <20180326001421.0E0937456D7@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline
In-Reply-To: <20180326001421.0E0937456D7@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Fix reserved bit mask of dstst
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 26, 2018 at 01:54:28AM +0200, BALATON Zoltan wrote:
> According to the Vector/SIMD extension documentation bit 6 that is
> currently masked is valid (listed as transient bit) but bits 7 and 8
> should be reserved instead. Fix the mask to match this.

What document can I find information on dstst in?  The ISA documents I
have handy are either too early (the instruction didn't exist yet) or
too late (the instruction was considered obsolete and no details are
given).

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 3457d29..b0d79a3 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -6561,7 +6561,7 @@ GEN_HANDLER(dcbtst, 0x1F, 0x16, 0x07, 0x00000001, P=
PC_CACHE),
>  GEN_HANDLER_E(dcbtls, 0x1F, 0x06, 0x05, 0x02000001, PPC_BOOKE, PPC2_BOOK=
E206),
>  GEN_HANDLER(dcbz, 0x1F, 0x16, 0x1F, 0x03C00001, PPC_CACHE_DCBZ),
>  GEN_HANDLER(dst, 0x1F, 0x16, 0x0A, 0x01800001, PPC_ALTIVEC),
> -GEN_HANDLER(dstst, 0x1F, 0x16, 0x0B, 0x02000001, PPC_ALTIVEC),
> +GEN_HANDLER(dstst, 0x1F, 0x16, 0x0B, 0x01800001, PPC_ALTIVEC),
>  GEN_HANDLER(dss, 0x1F, 0x16, 0x19, 0x019FF801, PPC_ALTIVEC),
>  GEN_HANDLER(icbi, 0x1F, 0x16, 0x1E, 0x03E00001, PPC_CACHE_ICBI),
>  GEN_HANDLER(dcba, 0x1F, 0x16, 0x17, 0x03E00001, PPC_CACHE_DCBA),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlq4WNwACgkQbDjKyiDZ
s5I6Iw/7B45oIg8vNEFLIZWlH38NOSx4gmmkXej5XiLHfRt3w+ZPejGtXMN3aYHL
nbXRAL7E9+RBSy/o83FgL9qbQhJSG9E36LdLQOCGJcvaMhDrIIAKI18IGFKs+2PI
nNDDHzJcgpkuBxfxBpEyrAUBJO0w7SVWYo7siwFSwV4qsSjbbQ4hmdF74RuyJl5q
Hy6/GWnQNd5y0O3DGXcNNyeb3O6bN9GxHdWbJ6H5rVrurhS5zXBCamLvmjiVQSb9
xbyNZcb09aucElEe9rugW6Pvyc4pvW/ONYJpT/X1EMMJyL13eTi30DU6C1i9Td8p
9LsyAHNeV48zmEM9aF8GEp/Qw8hVZEV1yFlOoRlg7od1ETWjGGGYUPv0dOFlwwMr
kBvv008vh0m1hV7j/zjXY9ORes8y7dlk/8gwSJGuMxas4/Wm1kAS6mBp8ByhaPxF
WmaAg2MY56+5d0fWHG0aJn8BFMaBO84olBKnWF5J/DtBjtaOvHn+Vx5kEQrEF+wZ
pUlIY/c11Up+Zm74Re7+3Fsg55ir+tYBOgswZMugXfe84QJVB8BASq/oEsOSP+5J
+KVpfqv8swtUqQ8OrHe5+VYUDNGqIVTqUb2ldbc7xBKtK8ZtKQnjZ9sBtWmRFTqO
KaW+DXKJvFTrUKHTYW+QDajI3P7uzOTnlMS0CqKmLOt6wojdN5E=
=qwb3
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
