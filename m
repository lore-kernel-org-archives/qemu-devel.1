Received: from eggs.gnu.org ([2001:4830:134:3::10]:33481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dRYNv-0006Ik-Iw
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 02:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dRYNs-0003tA-Cq
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 02:29:31 -0400
Date: Sun, 2 Jul 2017 13:58:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170702035819.GO13989@umbus.fritz.box>
References: <201706220003.v5M038Ns005683@linux03a.ddci.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8WA4ILJSyYAmUzbY"
Content-Disposition: inline
In-Reply-To: <201706220003.v5M038Ns005683@linux03a.ddci.com>
Subject: Re: [Qemu-devel] [PATCH] target-ppc: SPR_BOOKE_ESR not set on FP
 exceptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Larson <alarson@ddci.com>
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--8WA4ILJSyYAmUzbY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2017 at 05:03:08PM -0700, Aaron Larson wrote:
> Properly set the book E exception syndrome register when a floating
> point exception occurs.
>=20
> Currently on a book E processor, the POWERPC_EXCP_FP exception handler
> fails to set "env->spr[SPR_BOOKE_ESR] =3D ESR_FP;" as required by the
> book E specification.
>=20
> Signed-off-by: Aaron Larson <alarson@ddci.com>

Applied to ppc-for-2.10.

> ---
>  target/ppc/excp_helper.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 9cb2123..7a82bdd 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -282,6 +282,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
>               * precise in the MSR.
>               */
>              msr |=3D 0x00100000;
> +            env->spr[SPR_BOOKE_ESR] =3D ESR_FP;
>              break;
>          case POWERPC_EXCP_INVAL:
>              LOG_EXCP("Invalid instruction at " TARGET_FMT_lx "\n", env->=
nip);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8WA4ILJSyYAmUzbY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZWG9YAAoJEGw4ysog2bOS+UAP/R58E/l9aF7ND6lI+1/g797k
AdRb4Ard3ErjWWVq9+87EeUgLf8ON/siHdo/SRlglhwW1ICiU+8PRN7Ovj6TkvzR
SckGOYZuceZ+/ri9/k4iDKtRtVaxnZy0vq10pTG67pzBMMtF9KwAwcdQ3BkhRmpm
dVlWhKg/0GYEzgAgpxz5VhoMnxkwKZFSZCa64QtMEUNg1uD9MOETN3hNq2Kygqjx
IAer6DACfCBI61oRL0nFQiFRG2OdtDbeafxMmIg3cMX9yYC2M8SvUkgYzGFTHOWw
1tEzMBd4oZgfy2zUx5D+h3BkEETwL6isB856EkWlD6/lymWBXIwYUwnlx4m0GZT3
cWkUGib9k02VnhBRzMDoy4e7NSu/3FZS/mbvc7LiZi08j1Rd3heEc/s+crrHypvQ
+TOs1Pq2JdpQnFjqYyQGLumsvMEH0Tmh1mMnajKiCYyJjGqvjfKlngxDbv5mwDn/
vhaMQCNWeRSCTmZVapis9wJAy1ZDw0jin+lwh36PMKRh+X3U+2ZW/Zpn4tb9Ilcm
TMCu6LDkGoq+k/zl1AVur7Syhyll255aEnmYaAKaNuEKJHhGRCy978UhPnkSFKdc
ooAFqT2LZLZJZ2gX7J7eE3BJZBevWobuw8ddqrY25ZAOYaOpBbfOuGeyt8J1aNiD
Fpluv/OKHORi7fpF96st
=04IV
-----END PGP SIGNATURE-----

--8WA4ILJSyYAmUzbY--
