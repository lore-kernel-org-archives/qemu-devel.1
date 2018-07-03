Received: from eggs.gnu.org ([2001:4830:134:3::10]:46227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fa9jb-0006V9-Vf
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fa9ja-0006Rn-QE
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:03:59 -0400
Date: Tue, 3 Jul 2018 11:03:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180703010348.GG3422@umbus.fritz.box>
References: <1530568927-4738-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FBBJgEOSAOerUJIT"
Content-Disposition: inline
In-Reply-To: <1530568927-4738-1-git-send-email-cota@braap.org>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc: set is_jmp on
 ppc_tr_breakpoint_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>


--FBBJgEOSAOerUJIT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 06:02:07PM -0400, Emilio G. Cota wrote:
> The use of GDB breakpoints was broken by b0c2d52 ("target/ppc: convert
> to TranslatorOps", 2018-02-16).
>=20
> Fix it by setting is_jmp, so that we break from the translation loop
> as originally intended.
>=20
> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
> (I'll send this to qemu-stable (for 2.12) once it's on master.)

Applied to ppc-for-3.0.  It's kind of lucky I happened to pick this up
on qemu-ppc - I'm not able to read that all the time.  Things will get
merged much faster if you CC me directly on things to go through the
ppc tree.

> ---
>  target/ppc/translate.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 3a215a1..99c2731 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -7314,6 +7314,7 @@ static bool ppc_tr_breakpoint_check(DisasContextBas=
e *dcbase, CPUState *cs,
>      DisasContext *ctx =3D container_of(dcbase, DisasContext, base);
> =20
>      gen_debug_exception(ctx);
> +    dcbase->is_jmp =3D DISAS_NORETURN;
>      /* The address covered by the breakpoint must be included in
>         [tb->pc, tb->pc + tb->size) in order to for it to be
>         properly cleared -- thus we increment the PC here so that

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FBBJgEOSAOerUJIT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls6y3EACgkQbDjKyiDZ
s5I92BAA30AAkZw/YxxWMI/sK9ikQOZQBz9U/K8CgQsKUS5NhTwJDQxWwkw2y035
BQUgiFqCRmZm2WreX+xNwX01hHNQ6RASUuJ28XGiEjw1qpt+3PS6KL6+x0oSQN74
ma07SuetV7kcdzbgRThmKnRy7o7AvqGnDUWnCNI0csb0f3d5w5AxsUc2KoKqgCUU
SAfFSedKKuQa2oFPkqEzFvTY1QBAB2abD16gsHyioJvWqm4dSIBh85WVKyYjroMG
mglda57+TKqX91C1r0TmJ7UtmIyfIzLjJEgd0ZvcpvV0CAnYImF7/VsRMX2mqmbM
sLFSHeodbaGRrIQ2t6RIhA6YPD9l3TvN+XaBOJR+grpf/2RUHektIzS6xnzQ0d7z
sSNsmZRIKgR+ADlI7u1Qkrqp4Ln7ZbUT5gukBHi1oK+MfJEzLFBPZOCqKBdh5L0u
vXoq12P7b5dS2pe4spBkqjFANHG21IR7BCP5grhRviz1T/9HxtJAfK5EVAztUwwz
HuGElUSUX97jor77oZoDoGaWAWlz4CyXl4ViknPymvOVjejs8eDKUQAq92GLlpEx
XsJOGD78enUcDcGTE5aPROURvValguuTJAd+DbkHpEg6nx0ruN0fC1hWflFVJEay
igDh8S/yVIXX9AyIsjgFnrcTHh3Hm7aJQea/oIDRRUkUXmKF5HE=
=OvfJ
-----END PGP SIGNATURE-----

--FBBJgEOSAOerUJIT--
