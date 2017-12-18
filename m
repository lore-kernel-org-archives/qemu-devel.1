Received: from eggs.gnu.org ([2001:4830:134:3::10]:39358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQtl0-0005E1-5R
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:38:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQtkz-0008Rp-0f
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:38:54 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:35147)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eQtky-0008Pi-HS
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:38:52 -0500
Date: Mon, 18 Dec 2017 22:38:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171218113826.GD4786@umbus.fritz.box>
References: <1509710516-21084-1-git-send-email-yi.l.liu@linux.intel.com>
	<1509710516-21084-3-git-send-email-yi.l.liu@linux.intel.com>
	<cddc6820-86d8-4db2-126a-94edd86fbffe@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Content-Disposition: inline
In-Reply-To: <cddc6820-86d8-4db2-126a-94edd86fbffe@redhat.com>
Subject: Re: [Qemu-devel] [RESEND PATCH 2/6] memory: introduce
 AddressSpaceOps and IOMMUObject
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: "Liu, Yi L" <yi.l.liu@linux.intel.com>, qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, alex.williamson@redhat.com, tianyu.lan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, jasowang@redhat.com, peterx@redhat.com


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2017 at 11:21:59AM +0100, Auger Eric wrote:
> Hi Yi L,
>=20
> On 03/11/2017 13:01, Liu, Yi L wrote:
> > From: Peter Xu <peterx@redhat.com>
> >=20
> > AddressSpaceOps is similar to MemoryRegionOps, it's just for address
> > spaces to store arch-specific hooks.
> >=20
> > The first hook I would like to introduce is iommu_get(). Return an
> > IOMMUObject behind the AddressSpace.
>=20
> David had an objection in the past about this method, saying that
> several IOMMUs could translate a single AS?
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01610.html
>=20
> On ARM I think it works in general:
> In
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bi=
ndings/pci/pci-iommu.txt,
> it is said
> "a given PCI device can only master through one IOMMU"

That's using a platform specific meaning of what "one IOMMU" means.
In general what's several IOMMUs and what's one IOMMU which responds
to several address regions is not distinguishable from the device's
point of view.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo3qLIACgkQbDjKyiDZ
s5IlKRAAoRPbXW+JQYFCfup+F4wt+EixuWmLmdX+pZHK14MBM+G6dWh6zPMwEXCG
AFnewdsPUrLFINACs3Crns1apvcS944D6esv4H6oAPGiF3OjQvh6ZF2ZEGUHJc86
3lQVk2SPjRs+EDCEXydb7vJrmH++hZ8Spm4aWPX2lG+EHHfSoUYIGnNZE1i7sdY0
f4uDuiQMD36iZEshxjgrI9oIYFJ9iPfQdcAQPOlv45MwWyNwFPUOQhFlIllCSnoa
1qX7TYXNHbSnU8gVfHszTuf715Yz4PQFvPZI20Vv8pfA84zdoE++zCN1mJK2vexN
l6thIQvSYDtx4k5OH7112Jg1EsT1wbAdycHrY5CjdHXbqEvDd0HBgZMbRMD6YK57
X6i0p5//ttE+NDFC6oNwNyhxMokHh9ZVu0etNe0BKaYyB41zU0jlAVufWA5VQM9h
hwWl972Cftq8jkeaYMh4OuYoZQ1icjr3PqJy/S+mlEQypmRZnhnZqCFuKl1RHAID
erieJF0wZ3V5MRiIDvOcpFipc0hb+ZCq2gmcxMKQ/4jrCgCs5SUzm8ZQ1M3HLGyE
7o3Qco0NmAjaNc9CLco/DV1WkU9fDzQcRWlOH3VEw5iQIkYELj4O9MkB4TlxdtzW
k1N51bS/Wjxhb1uZN9oKJzFURlbzwJ1cqIAdhnhcMR9kZf/yUjk=
=FrnT
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--
