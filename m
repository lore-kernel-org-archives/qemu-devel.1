Received: from eggs.gnu.org ([2001:4830:134:3::10]:41889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzX5t-0000ZC-Fh
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 19:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzX5s-0000wI-Ie
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 19:59:21 -0400
Date: Wed, 4 Oct 2017 10:34:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171003233453.GN3260@umbus.fritz.box>
References: <150703999112.6139.714822137654210421.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tpyx7gKuSYt+mjHM"
Content-Disposition: inline
In-Reply-To: <150703999112.6139.714822137654210421.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc: use 0 instead of
 fdt_path_offset(fdt, "/")
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>


--tpyx7gKuSYt+mjHM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2017 at 04:13:11PM +0200, Greg Kurz wrote:
> The offset of the root node is guaranteed to be 0.
>=20
> This doesn't fix anything, it's just trivial cleanup of the two
> remaining places where this was done under hw/ppc.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.11.

> ---
>  hw/ppc/pnv.c   |    3 +--
>  hw/ppc/spapr.c |    3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index d46d91c76f5c..84b2389ea60b 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -92,8 +92,7 @@ static int get_cpus_node(void *fdt)
>      int cpus_offset =3D fdt_path_offset(fdt, "/cpus");
> =20
>      if (cpus_offset < 0) {
> -        cpus_offset =3D fdt_add_subnode(fdt, fdt_path_offset(fdt, "/"),
> -                                      "cpus");
> +        cpus_offset =3D fdt_add_subnode(fdt, 0, "cpus");
>          if (cpus_offset) {
>              _FDT((fdt_setprop_cell(fdt, cpus_offset, "#address-cells", 0=
x1)));
>              _FDT((fdt_setprop_cell(fdt, cpus_offset, "#size-cells", 0x0)=
));
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ff87f155d55e..352ff3d614e8 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -353,8 +353,7 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachine=
State *spapr)
> =20
>          cpus_offset =3D fdt_path_offset(fdt, "/cpus");
>          if (cpus_offset < 0) {
> -            cpus_offset =3D fdt_add_subnode(fdt, fdt_path_offset(fdt, "/=
"),
> -                                          "cpus");
> +            cpus_offset =3D fdt_add_subnode(fdt, 0, "cpus");
>              if (cpus_offset < 0) {
>                  return cpus_offset;
>              }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tpyx7gKuSYt+mjHM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnUHpsACgkQbDjKyiDZ
s5JyDhAAt+y4WmXRqBeBCz4h3UXGL4MR1gCiC2uX05QCDPlmewpwq6kJPzzbjzxa
eqWMqFkaxg5pKGLkyAKRve1SvMlZv5zPZ882+y7qm4PlFkg+cUlMS4Id2V8VItTO
p8xuRZslvToPSsoyMKTpa/D5PIXY6GyU4hw6DdFbbzPjgGCmBT1Vlk+IJ023w433
9sEIlN0lZMpcugVh+XITFqdl03Di8EsXCje6BQynJLH95JpQaCz0vNViLdpcE5RB
VA26jo2tMxbQQXTQWpB77XuZcgqM8K2NbVAypfnzyl+gfZQHcVhIObg3zWV3GPdw
Fi52iLgIJNRImTAZwDKNF2l5QhKZBJ6yyAS9WyXXk8u/sOImwJDMugtmUBRb1IWK
CyiK2TbjRhwl7OHXmIjRzoRAhVjgLR0m3Bl7Q6t6lAoId4syRVnnjiyBYybSS7t7
TG4KzX29XwG4RZdMbjfdh6+ewhThMDOfmwyhJCfEjS9pJTRQHaWKLQ1pGIhRPfD+
1vDz9pYgVkUNihxVg5MnClylZikG6FCAjfSix6HgZhWDkh37C/Wo+DkHKQ2FWXtf
cm7OsTBLPqtoegCrUwdYADpF/9z+vKqFzSHjLDpOmQ/6vFj76Ux9Zf+sy6Xb1DLv
HPxMOFsa+OOdQAivezV4+k4UnVBIvyDwnEnmKoXskwtU+C3Cr50=
=UBQU
-----END PGP SIGNATURE-----

--tpyx7gKuSYt+mjHM--
