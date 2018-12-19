Received: from eggs.gnu.org ([2001:4830:134:3::10]:41792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbm-0001yl-VX
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbk-0005uB-Al
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:34 -0500
Date: Wed, 19 Dec 2018 17:34:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181219063449.GS30570@umbus.fritz.box>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<20181218063911.2112-24-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8DtChEGCcMdSgkU2"
Content-Disposition: inline
In-Reply-To: <20181218063911.2112-24-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 23/34] target/ppc: convert xxspltib to
 vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org


--8DtChEGCcMdSgkU2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:39:00PM -0800, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/translate/vsx-impl.inc.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
> index 8ab1290026..d88d6bbd74 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -1356,9 +1356,10 @@ static void gen_xxspltw(DisasContext *ctx)
> =20
>  static void gen_xxspltib(DisasContext *ctx)
>  {
> -    unsigned char uim8 =3D IMM8(ctx->opcode);
> -    TCGv_i64 vsr =3D tcg_temp_new_i64();
> -    if (xS(ctx->opcode) < 32) {
> +    uint8_t uim8 =3D IMM8(ctx->opcode);
> +    int rt =3D xT(ctx->opcode);
> +
> +    if (rt < 32) {
>          if (unlikely(!ctx->altivec_enabled)) {
>              gen_exception(ctx, POWERPC_EXCP_VPU);
>              return;
> @@ -1369,10 +1370,7 @@ static void gen_xxspltib(DisasContext *ctx)
>              return;
>          }
>      }
> -    tcg_gen_movi_i64(vsr, pattern(uim8));
> -    set_cpu_vsrh(xT(ctx->opcode), vsr);
> -    set_cpu_vsrl(xT(ctx->opcode), vsr);
> -    tcg_temp_free_i64(vsr);
> +    tcg_gen_gvec_dup8i(vsr_full_offset(rt), 16, 16, uim8);
>  }
> =20
>  static void gen_xxsldwi(DisasContext *ctx)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8DtChEGCcMdSgkU2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwZ5okACgkQbDjKyiDZ
s5KFlRAArhi1PXWh+dDi4L3ox9ImeBCtGTwX6FSB0QIeaqw5aBRTBVB9G9uF9H/n
XyQCRIM3fckBjiAbt2Ft4tjgPgJW0gevitzTdDud2R8lLW5xT0p2leOycMKi1JEy
XLrcfGK6xbYe6tDI1Pqm7tSDyKw8YGDynBfIyRff18XduTZxuye601WweEGMt8cc
VjOaUc1cFi8iwq0F3H5wfoE2VAA459aeZLQOkgFsE8VecFLZ542cqkglmnqIr7gm
hivMkt4rTIctiSp2vbyw95qBZKhOoStwesIVPOFaBfQniZ9Hu0zpbxu2/W4Q5SPW
H7sRACdlK9EAAW7FKFI8QbUO+WPRcAyCZQg1J0fkeuPRs8b67BHDiSxwROCO/iI3
r+4AzpV756ld0v/UMkx7ngoL/vxboSqmysEqjcs5bpIPiM8qOCMh/esbT9PpLLLt
i4zEiKS0PL7D+2Qwryre9SueM4beOtuBnYjDBwkEaKJ1u9V3pt0r5mf7vsu3Mr/E
i6w2/2RJVf0NC8wLzvUvKPGGBW00dEPvDexJ26+7zt8GxGiVx2C8o8IB3eqa6nfj
BzcQAjrgTxLPCLN2/YYe6QUlUSfF8e4GdgUlXEcbHgm3jdiWvw2Q+wEn3qQe0AKV
E4MtCqEgpzegT+sZxvxk/wh5DX0NwQKIjEC7fkEVx2pbaxuwqJI=
=+KY9
-----END PGP SIGNATURE-----

--8DtChEGCcMdSgkU2--
