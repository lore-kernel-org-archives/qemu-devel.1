Received: from eggs.gnu.org ([2001:4830:134:3::10]:53960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eD1mh-00043C-Eb
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 00:23:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eD1mf-00037y-Rv
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 00:23:19 -0500
Date: Fri, 10 Nov 2017 14:18:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171110031818.GH7732@umbus.fritz.box>
References: <1467696699-8941-9-git-send-email-david@gibson.dropbear.id.au>
	<52275d2d-0a93-fe92-56ed-7841fa5a79dc@redhat.com>
	<518a60a2-9c65-9eda-471c-83596e746bfb@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Hlh2aiwFLCZwGcpw"
Content-Disposition: inline
In-Reply-To: <518a60a2-9c65-9eda-471c-83596e746bfb@ozlabs.ru>
Subject: Re: [Qemu-devel] [PULL,
 08/14] spapr_pci/spapr_pci_vfio: Support Dynamic DMA Windows (DDW)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Laurent Vivier <lvivier@redhat.com>, peter.maydell@linaro.org, agraf@suse.de, qemu-devel@nongnu.org, alex.williamson@redhat.com, qemu-ppc@nongnu.org


--Hlh2aiwFLCZwGcpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2017 at 09:52:12AM +1100, Alexey Kardashevskiy wrote:
> On 07/11/17 19:42, Laurent Vivier wrote:
> > On 05/07/2016 07:31, David Gibson wrote:
> >> From: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>
> >> This adds support for Dynamic DMA Windows (DDW) option defined by
> >> the SPAPR specification which allows to have additional DMA window(s)
> >>
> >> The "ddw" property is enabled by default on a PHB but for compatibility
> >> the pseries-2.6 machine and older disable it.
> >> This also creates a single DMA window for the older machines to
> >> maintain backward migration.
> >>
> >> This implements DDW for PHB with emulated and VFIO devices. The host
> >> kernel support is required. The advertised IOMMU page sizes are 4K and
> >> 64K; 16M pages are supported but not advertised by default, in order to
> >> enable them, the user has to specify "pgsz" property for PHB and
> >> enable huge pages for RAM.
> >=20
> > Why is it not advirtised by default?
>=20
> I do not remember clearly but this kind of automation is usually less
> manageable. What if we do not want huge IOMMU pages for some reason?

The reason is basically for migration.  Because of the compatibility
requirements for that, we generally try to avoid making any guest
visible changes to the virtual machine based on host capabilities or
configuration because it makes migration a total nightmare.


That said, in this case the difference which we'd need here -
availability of hugepages in the guest, is *already* guest visible for
the normal (non IOMMU) page mapping.  So maybe automatically changing
the IOMMU mask as well would be ok.  Or at least no worse than we have
already.

> > When we start qemu with hugepage memory ("mount -t hugetlbfs none
> > /mnt/kvm_hugepage" and ".. -mem-path /mnt/kvm_hugepage .."), we have an
> > ugly message:
> >=20
> > "qemu-kvm: System page size 0x1000000 is not enabled in page_size_mask
> > (0x11000). Performance may be slow"
> >=20
> > I understand if we want to use this with VFIO, we need something like
> > "-global spapr-pci-host-bridge.pgsz=3D0x1011000".
> >=20
> > But is it needed if we don't use VFIO?
>=20
> Yes, TCE tables are still created in KVM so the size matters.
>=20
> > Is it a way QEMU adds automatically the 0x1000000 mask to page_size_mas=
k?
>=20
> No. That thing which decides about -mem-path should also add the pgsz mas=
k.
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Hlh2aiwFLCZwGcpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloFGncACgkQbDjKyiDZ
s5I02xAAq3ud5ee1homd04tLNmGCKMVfzkV4puVyrpPbvmS3p2XBoexjP8psSDWe
IECwGxHavUAMFk8IEc02WmVxWQX5wr4JIi5a+p+KoRHV2JYkxA4++mNZbY9Ns9Tw
2Fs7tlFuDwl1/Mirj5zVqbWMVCB/jrkiuxPvkwY4pgAU+Po5fda7Ty32BNmLZc0R
bhwLsnrfafJkc0j/ymRBo6Qx6GwNR4BeCkNseA9rhY35rB7HHRnMSFB6/HEPqbQJ
R6PRzOsUXS1cEQQ9iXmvjNk+fZHBQ6UbKsFOo2AsoFMI/VxWHO35HN97wHmX+g5s
xPC/j05r7gFjJlpxum+JB3AkERjbmVEBNNWiRbIGwxHHOSuDRHimyuQ1GrmMWvhx
PP5ff6HDr0ktIuP19/cgf6AuMZHV5JTt6BMsS5U0O7FEUscsQlsk/EZWvZ0f6VWW
YJd8+DbCOnMhxADTzn871NVcSmcrbAR9WjwC+HYlOw3M+aMbuxm8JrueSCX1m6lh
D3agcrsNZypcQHQW/RhH8xd60BTBZEwIyUtBDAfkHtmt3XJhISEY2yD1XEX9GAd2
HTZ8/3voGkNFWTqPAE3Biefn45judf4BBvSSV0WifUXQ7wKnzxddkCPn80GHG3QK
ZQReNktNeJJfWIwZKccZEviVJzUuLFkgPHVYWy43BzBMM+yzlNE=
=aGb0
-----END PGP SIGNATURE-----

--Hlh2aiwFLCZwGcpw--
