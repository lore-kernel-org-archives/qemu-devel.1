Received: from eggs.gnu.org ([209.51.188.92]:40755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1go3cC-0001qj-36
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:54:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1go3cB-0001WL-93
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:54:04 -0500
Date: Mon, 28 Jan 2019 20:19:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190128091911.GD1870@umbus.fritz.box>
References: <20190127090306.30826-1-mark.cave-ayland@ilande.co.uk>
	<20190127090306.30826-2-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Content-Disposition: inline
In-Reply-To: <20190127090306.30826-2-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH v3 1/8] target/ppc: implement complete set
 of Vsr* macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 27, 2019 at 09:02:59AM +0000, Mark Cave-Ayland wrote:
> This prepares us for eliminating the use of direct array access within th=
e VMX
> instruction implementations.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Applied to ppc-for-4.0.

> ---
>  target/ppc/internal.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index c7c0f77dd6..f26a71ffcf 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -206,16 +206,23 @@ EXTRACT_HELPER_SPLIT_3(DCMX_XV, 5, 16, 0, 1, 2, 5, =
1, 6, 6);
> =20
>  #if defined(HOST_WORDS_BIGENDIAN)
>  #define VsrB(i) u8[i]
> +#define VsrSB(i) s8[i]
>  #define VsrH(i) u16[i]
> +#define VsrSH(i) s16[i]
>  #define VsrW(i) u32[i]
> +#define VsrSW(i) s32[i]
>  #define VsrD(i) u64[i]
> +#define VsrSD(i) s64[i]
>  #else
>  #define VsrB(i) u8[15 - (i)]
> +#define VsrSB(i) s8[15 - (i)]
>  #define VsrH(i) u16[7 - (i)]
> +#define VsrSH(i) s16[7 - (i)]
>  #define VsrW(i) u32[3 - (i)]
> +#define VsrSW(i) s32[3 - (i)]
>  #define VsrD(i) u64[1 - (i)]
> +#define VsrSD(i) s64[1 - (i)]
>  #endif
> -
>  static inline void getVSR(int n, ppc_vsr_t *vsr, CPUPPCState *env)
>  {
>      vsr->VsrD(0) =3D env->vsr[n].u64[0];

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxOyQ4ACgkQbDjKyiDZ
s5LM6w//ZEuJDyH/0Ryw6WORT8GzsFl/ow1nlt5cUQQGltIfulHnBT2MGRsDqtN2
PU++5EHxDrXk5ViJtTimPfivUytYLdIA4asMroYCitDfQCGXvU6++WqUKGUUxnVg
SfIqQDkxEPC4FighJhMGwcHkSYo9RX7G+gzZpasGlGn8YeHsTV+uontRF+Tsl4sX
J4B630APZJ1YYtIt5Ip8iW/wPxlv6x1pE7XU0SSZPnDO+51dcjHEzHu0fulI9LO5
LDRHROEH4AwXPbYNDp80AMLpHc/dRsX+fKQwfz3wk1cViU/GDutucgiAGLieigA5
9iPVvBNrY/2R9cXBhh4wR/kVorJHsB0xWxSFC+S8T6kyJhiTeIvKwISSApOnYqte
0lqpt+QwPXt4ewZ2PUgihpXZsWHaIzbmlHs1Wj3TkUSC+UWeLQn7eLO//IKSC3ir
9CkN7oyLB7ebCR47SC+Iy+rW0aHTZiiRNTX8EKLR29OzGigUqcSQpyNr2md38LPN
Jpy082tEqFxcMsM8K6xu6v1hTGpIrT7NLnEaaGa1Y50f+eTbhl2PARTDMnKbVn8N
OpcLjRZNMUB+8g90IlyywDIficMvVrQC8TpEuVXif+3T0fxXbeNhqvVnbHcVkJVI
0FbdxLSobI9+Rw6Rv1wBK7BZHcPwVPVKIpJa8M9wERZ0xi2cn4o=
=7/w3
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--
