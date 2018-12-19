Received: from eggs.gnu.org ([2001:4830:134:3::10]:41752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbm-0001yL-1c
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbk-0005tc-3C
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:33 -0500
Date: Wed, 19 Dec 2018 17:38:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181219063809.GW30570@umbus.fritz.box>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<20181218063911.2112-28-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hSsVBZHIO2Q9XETc"
Content-Disposition: inline
In-Reply-To: <20181218063911.2112-28-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 27/34] target/ppc: Use helper_mtvscr for
 reset and gdb
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


--hSsVBZHIO2Q9XETc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:39:04PM -0800, Richard Henderson wrote:
> Not setting flush_to_zero from gdb_set_avr_reg was a bug.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/translate_init.inc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index b83097141c..292b1df700 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -601,10 +601,9 @@ static void spr_write_excp_vector(DisasContext *ctx,=
 int sprn, int gprn)
> =20
>  static inline void vscr_init(CPUPPCState *env, uint32_t val)
>  {
> -    env->vscr =3D val;
>      /* Altivec always uses round-to-nearest */
>      set_float_rounding_mode(float_round_nearest_even, &env->vec_status);
> -    set_flush_to_zero(vscr_nj, &env->vec_status);
> +    helper_mtvscr(env, val);
>  }
> =20
>  #ifdef CONFIG_USER_ONLY
> @@ -9556,7 +9555,7 @@ static int gdb_set_avr_reg(CPUPPCState *env, uint8_=
t *mem_buf, int n)
>      }
>      if (n =3D=3D 32) {
>          ppc_maybe_bswap_register(env, mem_buf, 4);
> -        env->vscr =3D ldl_p(mem_buf);
> +        helper_mtvscr(env, ldl_p(mem_buf));
>          return 4;
>      }
>      if (n =3D=3D 33) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hSsVBZHIO2Q9XETc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwZ51EACgkQbDjKyiDZ
s5LmuRAAsxcdh491aKW+hB92Qg0Jj50/DgiieVWn/AEpEgVombQ282NlvLTOepvT
VhbZYt3MMpTkiW/Wb+UXz2Mxn+h7ZWxuZle4CZuGFuM1jRVHh7QF1u/Qc7IckgGw
mx44lcSdaSKlMy3NlOLfu2ElARAEnsXb03UE7tghijeTeVpQN8/qzBsaSuRUZ8U0
sGayHMZQgwCmYfIWNODK4Xe0zMCinYe1nesXLOQIsaMaIqVuPlCcPBcqP4wozvd5
EmbJ9/o4kt+uT/7QBCFrD/9qJcn6XA3oA5Zgof7Sx4196OQpL3deuwSY1jQP/ZUy
QJEwHaBEf6sD7SgUNfrkg3l/HC+OTNNxi/RLsuHMhZlBLlXHDFbCvpC0Zt5zz0r5
c65S+li4lCPlDFTuE28iO1noWowi6RW7HdvcF7xHeakyfZP0c0WWMe7ONY4+AjDp
9i5KLVUejbgQLWFBNaaUi/h90nip5GVz4ulgxaacW3fSBhUtAYJjFnygpAnR8thO
yHgYFeCtz/qEZYvUkrIlK3JvVZ/Dh7uwXl0ENLANbtV91dKOW2zeKvo68jAhfaFA
EH3rWMVIZpiVNitG8qpmmDez143XJfOJ7hUqvxp0hX9F19Kvv2fGM4btOA8g4ec9
JMGqa7V3Q8gI3tzAHlJSE442aKpXfsHDL2tNxjH1I5pJC5nhfCc=
=1HMf
-----END PGP SIGNATURE-----

--hSsVBZHIO2Q9XETc--
