Received: from eggs.gnu.org ([209.51.188.92]:55178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hDLuP-0004QW-UQ
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 00:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hDLuO-0007bg-7a
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 00:29:25 -0400
Date: Mon, 8 Apr 2019 13:38:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190408033807.GA16627@umbus.fritz.box>
References: <155448184292.8446.8225650773162648595.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <155448184292.8446.8225650773162648595.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH for-4.1 1/2] spapr_pci: Get rid of
 duplicate code for node name creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 06:30:43PM +0200, Greg Kurz wrote:
> According to the changelog of 298a971024534, SpaprPhbState::dtbusname was
> introduced to "make it easier to relate the guest and qemu views of memory
> to each other", hence its name.
>=20
> Use it when creating the PHB node to avoid code duplication.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  hw/ppc/spapr_pci.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index bba3a86dda6c..c70688a0dc23 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2153,7 +2153,6 @@ int spapr_populate_pci_dt(SpaprPhbState *phb, uint3=
2_t intc_phandle, void *fdt,
>                            uint32_t nr_msis, int *node_offset)
>  {
>      int bus_off, i, j, ret;
> -    gchar *nodename;
>      uint32_t bus_range[] =3D { cpu_to_be32(0), cpu_to_be32(0xff) };
>      struct {
>          uint32_t hi;
> @@ -2204,9 +2203,7 @@ int spapr_populate_pci_dt(SpaprPhbState *phb, uint3=
2_t intc_phandle, void *fdt,
>      Error *errp =3D NULL;
> =20
>      /* Start populating the FDT */
> -    nodename =3D g_strdup_printf("pci@%" PRIx64, phb->buid);
> -    _FDT(bus_off =3D fdt_add_subnode(fdt, 0, nodename));
> -    g_free(nodename);
> +    _FDT(bus_off =3D fdt_add_subnode(fdt, 0, phb->dtbusname));
>      if (node_offset) {
>          *node_offset =3D bus_off;
>      }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyqwh8ACgkQbDjKyiDZ
s5KN9BAAs2JgwksKr6qPTrjmOSg1wlaRXEkCsDjpGDI4hLG9Zq02+wEqd1yMGREj
klItwF16q0ACko85Tk5UNyvT2+MEtvnQGQ+fh80sEIieeT3JJwDzRNMaU+Q7c6c+
D9Tj7h2KXguKW3TSdJaSCZXps278aQHM3RBZi3/L2cpqIv56LBO76FpGtFbCG5ye
aJ+ti2XU0Nn9NlWZ3Msm44Dje8AhboUqCUPQ5b87prJ6e4ymkorGAI45o7wrRHPm
hVmwg7JGwEzz4S8W2LUdcKJDQl2zsd7wF1JvQhdsBD6oyLrdsuY37MW2uEkIKITs
xJLAAyFQZ3+YKZOSVS5zUh512fc51DQK0Wvpj7QmagndVbu8W4ge1hg0sXI/MbVA
jPsd8ck+T7N7TSBJe/lbV/m/jF+00dtXzathq3l1Ow02Dxz+ZT+o/BilDg0aqPa7
JX9zle6XAf0t6CeGQtbptu2eczwt5IXKobDEr3FPXo5HhTg4AH+xHPhRFAQ8iJZL
F5uq2IA65J7c+1ftOU06meyE7n64QSCvppjYXE2M9Ngq8gCHuDnqGmYku3wu4SRY
BN4Kocx/fN/OjFYbC+J4QMJg4s5OYn0caMUAz8/pyP+ipucGE1QxTBiVJjSfUdfj
WNbPBTjNEdA6+K/G08p931lcQg+H3NNurqBwf7KkE+Vcku0otwU=
=jfao
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
