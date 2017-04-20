Received: from eggs.gnu.org ([2001:4830:134:3::10]:52798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d11Qr-0005yf-US
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 22:02:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d11Qr-0001I1-0M
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 22:02:53 -0400
Date: Thu, 20 Apr 2017 11:48:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170420014857.GC13992@umbus.fritz.box>
References: <20170420014417.GA6677@tungsten.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline
In-Reply-To: <20170420014417.GA6677@tungsten.ozlabs.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] target/ppc: Fix emulated userspace
 access to USPRG3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 20, 2017 at 11:44:17AM +1000, Sam Bobroff wrote:
> On a fully emulated Power8 system, user space is currently unable to
> read from USPRG3 (SPR number 0x103) because it receives an illegal
> instruction exception.
>=20
> However the ISA indicates that it should have read access (to the
> content of SPR 0x113, similar to some other registers with user space
> read-only counterparts).
>=20
> This patch registers the new SPR for Book 3S processors and has it
> provide read-only access to SPR 0x113.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Heh.  I merged a more or less equivalent patch from someone else just
this morning.

> ---
>  target/ppc/translate_init.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index c1a901455c..f863875835 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8235,6 +8235,14 @@ static void gen_spr_power8_rpr(CPUPPCState *env)
>  #endif
>  }
> =20
> +static void gen_spr_book3s_usprg3(CPUPPCState *env)
> +{
> +    spr_register(env, SPR_USPRG3, "USPRG3",
> +                 &spr_read_ureg, SPR_NOACCESS,
> +                 &spr_read_ureg, SPR_NOACCESS,
> +                 0x00000000);
> +}
> +
>  static void init_proc_book3s_common(CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> @@ -8243,6 +8251,7 @@ static void init_proc_book3s_common(CPUPPCState *en=
v)
>      gen_spr_book3s_pmu_sup(env);
>      gen_spr_book3s_pmu_user(env);
>      gen_spr_book3s_ctrl(env);
> +    gen_spr_book3s_usprg3(env);
>  }
> =20
>  static void init_proc_970(CPUPPCState *env)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY+BOGAAoJEGw4ysog2bOSuv0P/2SGKvZj37YUWTZOcPdUXMcQ
0TYJSFE4lkYxuxD+bfmFKlnbThjvAsnE4z3SCrSV1ul9VYUi9FCBRciOOwv69k4A
zL4INXFYcQfQHHhtzfD0oAQ+3gOa04lLg93pkspgdXc+mdSLPhCgUOMNJ9MPWaCo
0nasrpGukIo00ukkEZCjvilGilNaBl5LzClfVx9W8bH+N8IMSKA12eJ77qSvACih
Up5sTxW0E0syZOKJwNQ53AkJEaxSvZefMxbXIB/Iprpjw4qoA8JrxX7QJzcMZvYA
tEDhZEsE445VRd21/pARECT4uAHwZbIAC6XfzzcHr8Ce1ih4/pHA2DaXdxqp5eo6
60tk1qi0XvCBZDL4/TLrj5J+Xzuq2Z+chWKzYpDXSbO0CjiI3bBgAigSSn/LqTA2
1s70kl6D5xOheTJAIF/BDPY4U1EzvCy9pLVsYK5+bBrnuxgoCspUGGkO+4MF2qJf
5JfNgCOPd8KjtGXkBa4lXsJSO8jOSOuUs8UgSNIn1iJSEQLEINP6l/dMYX6Akl9w
wAzNEWG5JBd/sOshfEOgq8f6ebo1t9DGwzHBgTEQC0eTAqVUXEaGHSvEtV3xxSR6
pb7nDheWLxkznslxzkah3Muh2Zpezc/izkNuY1zAwGkVDfbv2vnXdzoQQt1YSjHD
+Oya8Nr0vXnqgb3IYwtS
=Lmtg
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
