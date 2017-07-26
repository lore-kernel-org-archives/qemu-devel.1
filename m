Received: from eggs.gnu.org ([2001:4830:134:3::10]:56666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daDTc-0004Ls-QL
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daDTb-0004Ae-Ja
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:59:12 -0400
Date: Wed, 26 Jul 2017 13:56:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170726035602.GO8978@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100550805.27487.16069660631488548584.stgit@bahia>
	<a33ca4ee-9f73-c1d0-1348-970e628dae3b@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JfVplkuTfB13Rsg5"
Content-Disposition: inline
In-Reply-To: <a33ca4ee-9f73-c1d0-1348-970e628dae3b@ozlabs.ru>
Subject: Re: [Qemu-devel] [Qemu-ppc] [for-2.11 PATCH 02/26] spapr_pci: use
 memory_region_add_subregion() with DMA windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--JfVplkuTfB13Rsg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2017 at 01:33:04PM +1000, Alexey Kardashevskiy wrote:
> On 26/07/17 03:58, Greg Kurz wrote:
> > Passing a null priority to memory_region_add_subregion_overlap() is
> > strictly equivalent to calling memory_region_add_subregion().
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

In fact, this cleanup makes sense on its own.  So, I've started a
ppc-for-2.11 branch and applied this to it.

>=20
> > ---
> >  hw/ppc/spapr_pci.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 70a99a032267..3fe7f3145467 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1752,8 +1752,8 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
> >                         i, sphb->dtbusname);
> >              return;
> >          }
> > -        memory_region_add_subregion_overlap(&sphb->iommu_root, 0,
> > -                                            spapr_tce_get_iommu(tcet),=
 0);
> > +        memory_region_add_subregion(&sphb->iommu_root, 0,
> > +                                    spapr_tce_get_iommu(tcet));
> >      }
> > =20
> >      sphb->msi =3D g_hash_table_new_full(g_int_hash, g_int_equal, g_fre=
e, g_free);
> >=20
> >=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JfVplkuTfB13Rsg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll4EtIACgkQbDjKyiDZ
s5IPMA//TYSMlXWXLFwwWEoE1SpEtQDh+744tTJnZzFNHfa/skWpLFpKXmElGQTw
XvIL7Ms90vtpK6p3eFfl5k3kVazkdxR7c3EOCSdg9CClVJbIp6cJ7T3MP5hKGxaE
7vlegt4tQkKjoa8V5zSdtSjYOW5YKmmQ1mInwUc8MLt/2oTEZijMRYmhctEBz/mk
7l1HOa+Nw+LDzuPOuKhQIogjLH/jHeB8lgdYCq+OX+VkQ/oqQbbkgFmfD9t37PA0
j0AYKeMcuU3JrCWUDcTHumIP25n/2aDOKU7oamdNmgVhXwzXDAs2KSUzJ7gGuM/O
5KrEhd8B6jhK56g+oRtOsVl3b1NS9rVHn5qyvRlUNduojs52rMkJ4tUzea/eEJXq
uWEJrMoFdmqhaKeU9VskNYlbUS9QPUJG3sMJtfwa6ekdnyOCwTJUThXlmCjUjQ/R
KaVZCH2K+GP422OO3hL4YPQL6IabLWdbmVSN4gJVC6GgL6/IXUwMuPmcWpIe/Vso
Y/8fNXYofih4CrR0kLFAJ/d1zLyC9HRKsBBWosqOofWiR7eXVN03MIOO+gB1zQc4
vrZnAkwvxbLzzsfOYjT+PWcExDaARo5cJadYWXDnt8zIxGC1ZOgMynQTGY6A1qVE
NeQlJDg1VGDrGzSe61v2hAPcZuEriojH9e8qozvtRrG8NkSfCiA=
=KwnM
-----END PGP SIGNATURE-----

--JfVplkuTfB13Rsg5--
