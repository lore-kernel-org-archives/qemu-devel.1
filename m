Received: from eggs.gnu.org ([208.118.235.92]:47532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geXXi-0004jZ-4l
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 22:50:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geXXh-00062y-9h
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 22:50:06 -0500
Date: Wed, 2 Jan 2019 13:38:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190102023857.GD27457@umbus.fritz.box>
References: <20181228135235.6859-1-mark.cave-ayland@ilande.co.uk>
	<20181228135235.6859-2-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Content-Disposition: inline
In-Reply-To: <20181228135235.6859-2-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH v2 1/8] target/ppc: implement complete set
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


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 28, 2018 at 01:52:28PM +0000, Mark Cave-Ayland wrote:
> This prepares us for eliminating the use of direct array access within th=
e VMX
> instruction implementations.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Applied to ppc-for-4.0, thanks.

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

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwsJEEACgkQbDjKyiDZ
s5Kjxg//fFukO9lQ9bSY2ILCLt7kxLD/MPszFy6VcTNpuh43sYg0QMXcEDpQB9Qi
ssUmObjIFT6CB9PPuqQCBtGLrgQ6kud8hTjb79gLNlnw77Rtc1/VARyVtWwPjtyM
5YGMLsj3kvNy5nyjtltiZkxyA4taGrxtuVcckLSd9YtyE5lTBy9P9NLL9NKHAMyt
QXdWsJZZm/z0gCai6J8M6CiK4ndohsrHaK1q3eT7jTZv9KxlhwUmLiA5ykG6TmyK
8K6nI97hy9MRE18w1lvdF476Ov6jgqsn+Gv+kV41LAa14sSHYaFKgOShQbYtGE80
4z2HU/XysgsJGXnIQk3EcdLYjM5dRvlF3reYKoSOyQVP34lUOnkUevC4GhXjoi5P
7xX6EWsaYJMJwnJNs2q4bcD4PwM7EjC0yFJDaMAZsDgFvjgi1Yy3X2a2KF/bRE7f
JtOPBHKWlqAvhcD8ofMMkKybXQk6N6XMa47Y5nRdEAl4VW1Eg2x18weAESihws+w
QlKHm3C1rMX6/rWugWXFS2ucZ3K0JcN9EVGNsVK22Y3Kqn+3aShmcKBxOrNu/3dr
crvpcQPRRYkYZeF/86OYT7CVmIwVYksHQuavQEk6lwqq79dpBeXKoiYXQvhYICP0
I6FvcQGFi9mx+1yW1VT8C6/LyzvJ4p6I4p/tlnniIz8DF2ypiOg=
=CMAK
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--
