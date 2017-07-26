Received: from eggs.gnu.org ([2001:4830:134:3::10]:56690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daDTe-0004MD-8j
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:59:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daDTb-0004AL-8e
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:59:14 -0400
Date: Wed, 26 Jul 2017 13:53:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170726035357.GN8978@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100550805.27487.16069660631488548584.stgit@bahia>
	<a33ca4ee-9f73-c1d0-1348-970e628dae3b@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hNG1vEeyG8BCaHbQ"
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


--hNG1vEeyG8BCaHbQ
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

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

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

--hNG1vEeyG8BCaHbQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll4ElQACgkQbDjKyiDZ
s5IGyxAAz937hkdVrNOAf51lwjxNNk4CLKLgiSn6USAcb2gFZYcx6hll/PWepY5Z
ka4c/TC1FmoohbMVuPZh3RMJJsSt9OQ/BNeaTm13R/DP5RVc1B7iucGq6UjvTwC4
ReBllCMYCWjKXQslyUHwj3obn3pCD3f9iMMC6ImT8dBEuApPAFTK0G/wUy6yRg6w
zuyhtFnH2cuR8/tTj03e8Qm5zSqZNwOrtMFVWfJ49seHiwpdLiXsOBY6kKkqlcYk
kmIO2He6WrqkroN/OAZpJN7tgrEwhXeiDqimgWRTS6K/yxFNKAZoqk4viZUgi2DC
p15QLRwzYfCg10nhYkaO0RzPB+d6X2b6ctjHw4CvokAMRoBNCWQhgf2h2fDe8Zt4
Tgz5W5LN4e2QpeqzTeI806nADW74u0EfBIqAK8sfw5YnANg24Dt659nGjYSxlZaQ
RA+dyzH3yhwIzLs37wKb/KSo+EfB0UvpX8W2DjX5qSmQbKcbgC8UIylJazWRIeau
CEnzNumBieuYVakU7FPIK+cIBwS9+sIU1VIbtuP2jKtnEwJ6Q0Wg3ykphxqjikna
RB8so0wNMPL2LbY5BWY7QrWTeJbgkFl90mmHrXkFkRn+tmEc+g/4aN5UcaGAzWJH
hMD3V9QuxKOONy0arW9oB+qrSTGyczAtqv/cLOVPIm3pUQTC5+0=
=TM6R
-----END PGP SIGNATURE-----

--hNG1vEeyG8BCaHbQ--
