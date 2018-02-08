Received: from eggs.gnu.org ([2001:4830:134:3::10]:60878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ejvc6-0000Cr-0G
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 18:28:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ejvc2-0000it-PE
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 18:28:21 -0500
Date: Fri, 9 Feb 2018 10:28:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180208232810.GC11634@umbus.fritz.box>
References: <151751446151.11348.15065690714406381610.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Content-Disposition: inline
In-Reply-To: <151751446151.11348.15065690714406381610.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] spapr: add missing break in
 h_get_cpu_characteristics()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2018 at 08:47:41PM +0100, Greg Kurz wrote:
> Detected by Coverity (CID 1385702). This fixes the recently added hyperca=
ll
> to let guests properly apply Spectre and Meltdown workarounds.
>=20
> Fixes: c59704b25473 "target/ppc/spapr: Add H-Call H_GET_CPU_CHARACTERISTI=
CS"
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.12, thanks.

> ---
>  hw/ppc/spapr_hcall.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 4d0e6eb0cf1d..596f58378a40 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1697,6 +1697,7 @@ static target_ulong h_get_cpu_characteristics(Power=
PCCPU *cpu,
>      switch (safe_indirect_branch) {
>      case SPAPR_CAP_FIXED:
>          characteristics |=3D H_CPU_CHAR_BCCTRL_SERIALISED;
> +        break;
>      default: /* broken */
>          assert(safe_indirect_branch =3D=3D SPAPR_CAP_BROKEN);
>          break;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlp83QgACgkQbDjKyiDZ
s5LWQhAAkUmluj3q60Ys1bKqxBc/8T5DrBw653Ija1UyouGvuXJQsTI4ME4lCH5S
0HYXMiq7myMV8roEGY0l0nNFsfX4tQZOEZX4pMYVWLsDkC8ttZXpNoTj8tuOWnGH
wLCPCPk3nbjGFGXpoG2m2Q6wUT2l43jeBgnjm495kSpnzy6l4aNtI6OO3JOSBFuc
ruy/VKk7/X1s8mYBE4TMDT0E3nbDwRBTPZ7D8y6nAR0vmNQkhL6knCQBUrvQiwcA
+A+V6CbZM7OidVvyR9Nb6Hb0yzvJC9icihO7IeUQCWTtp63SZVk5HMh/XRRZLkSz
WIPo47fTF8nuo05AAQZfoXeWNyvn/TosADavszdf1aHzUdnbOhb+M46p9AMbZUso
vfJD2RmTMabK8t3wIvcJjG4TWxBqhA8ireMQFomGId06bDyKlyCViZU73t8X2Vpk
4MSpwAV6sLVnq9S0I43D+QPnLoFKGD/t5EuFXfSoUL8LSqI1gFb8RV4D9UfxpWSG
415vHSpv52FuuQNKmahsLI6HiObyS4dpaR+vtUP4QOBzLlZi9Q9Vb0bBbzh2nRqS
8qQC0cuBFiOHysrvROpno+ruWQoiggCyAxKV1bebu0QIcgU2luoy/2HxXjxLSC/4
+nnXt8aXiFwCBAsX6Ynq+T/UxwqeU/a5iwfajhAgOv1OPBFJXxc=
=OsDv
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
