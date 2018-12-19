Received: from eggs.gnu.org ([2001:4830:134:3::10]:41768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbm-0001ya-BL
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbj-0005sj-C4
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:34 -0500
Date: Wed, 19 Dec 2018 17:32:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181219063233.GQ30570@umbus.fritz.box>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<20181218063911.2112-22-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2D20dG0OqTzqkNh7"
Content-Disposition: inline
In-Reply-To: <20181218063911.2112-22-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 21/34] target/ppc: nand, nor,
 eqv are now generic vector operations
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


--2D20dG0OqTzqkNh7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:38:58PM -0800, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/translate/vmx-impl.inc.c | 26 +++-----------------------
>  1 file changed, 3 insertions(+), 23 deletions(-)
>=20
> diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
> index 529ae0e5f5..329131d30b 100644
> --- a/target/ppc/translate/vmx-impl.inc.c
> +++ b/target/ppc/translate/vmx-impl.inc.c
> @@ -277,34 +277,14 @@ static void glue(gen_, name)(DisasContext *ctx)    =
                     \
>             16, 16);                                                     \
>  }
> =20
> -#define GEN_VXFORM_VN(name, vece, tcg_op, opc2, opc3)                   \
> -static void glue(gen_, name)(DisasContext *ctx)                         \
> -{                                                                       \
> -    if (unlikely(!ctx->altivec_enabled)) {                              \
> -        gen_exception(ctx, POWERPC_EXCP_VPU);                           \
> -        return;                                                         \
> -    }                                                                   \
> -                                                                        \
> -    tcg_op(vece,                                                        \
> -           avr64_offset(rD(ctx->opcode), true),                         \
> -           avr64_offset(rA(ctx->opcode), true),                         \
> -           avr64_offset(rB(ctx->opcode), true),                         \
> -           16, 16);                                                     \
> -                                                                        \
> -    tcg_gen_gvec_not(vece,                                              \
> -                     avr64_offset(rD(ctx->opcode), true),               \
> -                     avr64_offset(rD(ctx->opcode), true),               \
> -                     16, 16);                                           \
> -}
> -
>  /* Logical operations */
>  GEN_VXFORM_V(vand, MO_64, tcg_gen_gvec_and, 2, 16);
>  GEN_VXFORM_V(vandc, MO_64, tcg_gen_gvec_andc, 2, 17);
>  GEN_VXFORM_V(vor, MO_64, tcg_gen_gvec_or, 2, 18);
>  GEN_VXFORM_V(vxor, MO_64, tcg_gen_gvec_xor, 2, 19);
> -GEN_VXFORM_VN(vnor, MO_64, tcg_gen_gvec_or, 2, 20);
> -GEN_VXFORM_VN(veqv, MO_64, tcg_gen_gvec_xor, 2, 26);
> -GEN_VXFORM_VN(vnand, MO_64, tcg_gen_gvec_and, 2, 22);
> +GEN_VXFORM_V(vnor, MO_64, tcg_gen_gvec_nor, 2, 20);
> +GEN_VXFORM_V(veqv, MO_64, tcg_gen_gvec_eqv, 2, 26);
> +GEN_VXFORM_V(vnand, MO_64, tcg_gen_gvec_nand, 2, 22);
>  GEN_VXFORM_V(vorc, MO_64, tcg_gen_gvec_orc, 2, 21);
> =20
>  #define GEN_VXFORM(name, opc2, opc3)                                    \

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2D20dG0OqTzqkNh7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwZ5gAACgkQbDjKyiDZ
s5IP5xAAy3FbIwHUIP4wBDDmy64POb0104bjEzy10OCVCIWW/rQHvUwHB8BNwGoM
TYE8amTBhnSIXYtXJvEB192jd05KDMI3+06YRqbRWNhJiIFeCwJ8zTjB9Ml8KwGk
qsvFtXISAZsOV3uaaWeHtvjAMOFjAq9O1k858vxrB/J/nt3iAmbfJNCfEDK/TY81
Okj9wIpQp8X6fsYMqdVZ2ptglGeTLDAlhxAifXWKwO2h4pDjDeQb/kp/bSVcnT3a
lsHEz65nMqMtMbYJHSqon3qHCacXiUTASIRGm33/yqV3ZLV3byrXvHzxSD/7OxCn
b5f6JhDXGuwIVhxWDPn0m0Xk9LdMt0bT0V2gXQXVJ8tzSFN/IIY/KUB4lXXo/J4C
iWb8YIo3tHHyKOcUa7PMaaoK7ClFLg/W6fs1rSxHNIvyjgRvzA0DfYa8TeJJTHXQ
x8Drz6c1DD9l7eENG3maTw4F2dRHaNfnKngV9ov1eBt0mpsvnF1x4hb20WTIY6lM
CEwiA019PreSBCP27S65ttWeM8u3cnGy187jsS+EUJKXPbIBp+ol6lN9Semj9CtP
Zw6iXKPA3543B2+YAojePv0niy7SoagBNsKzWngTckCp07n8ww65ONW3mVf2DGfl
miaM5at76tBBX7Y2LwUP20+q8WnwkdxySGLx2JnW78vTrHFi99k=
=SXNV
-----END PGP SIGNATURE-----

--2D20dG0OqTzqkNh7--
