Received: from eggs.gnu.org ([2001:4830:134:3::10]:59217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gYPlS-0005os-79
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 01:18:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gYPlO-0008Pl-Vu
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 01:18:58 -0500
Date: Sat, 15 Dec 2018 20:00:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181215090047.GM29278@umbus.fritz.box>
References: <20181213050453.9677-1-cota@braap.org>
	<20181213050453.9677-10-cota@braap.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oiL9LJXJsdjS5rzq"
Content-Disposition: inline
In-Reply-To: <20181213050453.9677-10-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH v5 09/73] ppc: convert to
 helper_cpu_halted_set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--oiL9LJXJsdjS5rzq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 12:03:49AM -0500, Emilio G. Cota wrote:
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: qemu-ppc@nongnu.org
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/translate.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 2b37910248..4bb78f403e 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -1609,8 +1609,7 @@ GEN_LOGICAL2(nor, tcg_gen_nor_tl, 0x03, PPC_INTEGER=
);
>  static void gen_pause(DisasContext *ctx)
>  {
>      TCGv_i32 t0 =3D tcg_const_i32(0);
> -    tcg_gen_st_i32(t0, cpu_env,
> -                   -offsetof(PowerPCCPU, env) + offsetof(CPUState, halte=
d));
> +    gen_helper_cpu_halted_set(cpu_env, t0);
>      tcg_temp_free_i32(t0);
> =20
>      /* Stop translation, this gives other CPUs a chance to run */
> @@ -3584,8 +3583,7 @@ static void gen_sync(DisasContext *ctx)
>  static void gen_wait(DisasContext *ctx)
>  {
>      TCGv_i32 t0 =3D tcg_const_i32(1);
> -    tcg_gen_st_i32(t0, cpu_env,
> -                   -offsetof(PowerPCCPU, env) + offsetof(CPUState, halte=
d));
> +    gen_helper_cpu_halted_set(cpu_env, t0);
>      tcg_temp_free_i32(t0);
>      /* Stop translation, as the CPU is supposed to sleep from now */
>      gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oiL9LJXJsdjS5rzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwUwroACgkQbDjKyiDZ
s5LxXRAAhMZV+oAH5c2ggt1CPFY4tq+BTWLxXJBQDDoKW78D2qduBrUtfE3bNuWy
CH7yVltMmt5sqp+YZtC5igSzH9j4pmszvAu9CrCUBN3f1vlHRzPOXy9TGgcmk2Mm
lJ0M07VEgsgim6R+9WyFCJnWXeRJkgsDjPc/HGmfXPgACQcpIWPeq0MAQuKcyykN
RqQEmJNk2wcUx4v3Y7zv4ZczPkgBudgNOExmjcEmNmXs33aCHo8Lu9pQuQecJv8G
K04FlGpk7zLe3S7WoL+k9YAJf5fkX/vrjIZIyKzgXS0jb5O4/RaeonnwUjHGzLIO
nuXnpD0mPoS+qSBS6Jm0Xj403i3B8WfsOLoYY7BmdP+O+b5HtdtoD8J4t9mCq9RH
vYuT+IxU9W4edPVePkdnPCsTCCfy1BLBQQWLCGFFbfRkbK/IvxMsM9cM4mUvpn6x
ttbAdXwDNcNZo2MOKWGiG1JEA6xwMf1AH1zSB8fJkS9rHaW+XUZBlRLUiOsokWBv
gVV8yEEgHzAtTl1zilqPCISYj9KrKcRJTYuROz7DpUdyeTPhl1mVI19GdFsq29k+
x8bEmX7awByOPoyLtEnIAOLFD6tAmtrzNZl3U9e2PDvmRKxK4TUjB0jjjp6MtpeU
NllQhNI3FvbBYFbfbJQMR5nzA71tdF9JVffNDD9D5rsL1PPpXgA=
=LLAo
-----END PGP SIGNATURE-----

--oiL9LJXJsdjS5rzq--
