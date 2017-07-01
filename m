Received: from eggs.gnu.org ([2001:4830:134:3::10]:57770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dRDbi-0004CR-HX
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 04:18:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dRDbh-00027c-Ab
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 04:18:22 -0400
Date: Sat, 1 Jul 2017 17:51:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170701075138.GK13989@umbus.fritz.box>
References: <149881542765.17418.16611868807694688341.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AYsPlKobQGgtCvjI"
Content-Disposition: inline
In-Reply-To: <149881542765.17418.16611868807694688341.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH] spapr: fix bogus function name in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-ppc@nongnu.org


--AYsPlKobQGgtCvjI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2017 at 11:37:07AM +0200, Greg Kurz wrote:
> $ git grep spapr_ppc_reset
> hw/ppc/spapr.c: * as part of spapr_ppc_reset().
>=20
> $ git grep ppc_spapr_reset
> hw/ppc/spapr.c:static void ppc_spapr_reset(void)
> hw/ppc/spapr.c:    mc->reset =3D ppc_spapr_reset;
> hw/ppc/spapr_hcall.c:        /* If ppc_spapr_reset() did not set up a HPT
>  but one is necessary
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.10.

> ---
>  hw/ppc/spapr.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0ee9fac50bd4..43a1cb5725d6 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1973,7 +1973,7 @@ static void spapr_boot_set(void *opaque, const char=
 *boot_device,
>   * Unlike PCI DR devices, LMB DR devices explicitly register this reset
>   * routine. Reset for PCI DR devices will be handled by PHB reset routine
>   * when it walks all its children devices. LMB devices reset occurs
> - * as part of spapr_ppc_reset().
> + * as part of ppc_spapr_reset().
>   */
>  static void spapr_drc_reset(void *opaque)
>  {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AYsPlKobQGgtCvjI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZV1SKAAoJEGw4ysog2bOSL/kQAI7hmWUqhIcESIRW1ghXUWie
nstSVbetb2w05c7k4GPFrFlVTiPzGKTj04rJAyFw4C87ERmELMhungAj/XaM6pHI
Y/zBduLW4q9wJsSVLrQPmPuZ0a1HMpd0zHlslaHwGcNzQNPUzlO14zoyIxLW7w2i
u7MJ5GyWFL1OVQ2ZoG3Dch6sx/HA3ZxuKPiAgbosCsX5fvXvz+RXRPvVnt4PzIgW
dxwA4niv8/RQoY1L6H0L8REy3G8qXZdWxXgg+rooqGvasU0fhtd8WU2dqg3Qfuwf
C3W0cjV5EZ0N8/quljGs000Ni9PeTxiLb0tPojTwnCg20UfjEVM6R3jXQCv7gBeX
tb2hTydKChFSQgRo1CgxN9qUZXxTwHpOljSZilZRMHrikjO+/KVEKbYY7RBp7d/E
OK3XbGkM/kTFLkJNKAnWLANZjDwDqOi0KQ4YqCQ5/KoW10ESmg7kQLeystXkS0Av
25PM+gg9VrbVBe27Bxz3o1ee9fnH3ZhR/8N7KYJeSiYWnVIWxGkh/9PaLszu7jNf
iVetg6EC2P1UvJOjHu6Ecsgekx+Y0yj9AACQkmhOxW9K0n+T52e8nz4DtSAfkXy6
O4fOCTFMGVHJ8XZaR6wc61+6NMENoG4+iN9rmODKZkDktNoHFCCyYmR87uCTc5lP
b4nfV7rl2MBN2dkNKhlq
=Nkzg
-----END PGP SIGNATURE-----

--AYsPlKobQGgtCvjI--
