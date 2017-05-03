Received: from eggs.gnu.org ([2001:4830:134:3::10]:40568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d5mbC-0002nq-Q0
	for qemu-devel@nongnu.org; Wed, 03 May 2017 01:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d5mbB-0004MI-Tu
	for qemu-devel@nongnu.org; Wed, 03 May 2017 01:13:14 -0400
Date: Wed, 3 May 2017 15:12:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170503051242.GK10741@umbus.fritz.box>
References: <20170429123707.16675-1-aik@ozlabs.ru>
	<20170502182550.5edb9565.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QxIEt88oQPsT6QmF"
Content-Disposition: inline
In-Reply-To: <20170502182550.5edb9565.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH qemu v5] memory/iommu: QOM'fy IOMMU
 MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>


--QxIEt88oQPsT6QmF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 02, 2017 at 06:25:50PM +0200, Cornelia Huck wrote:
> On Sat, 29 Apr 2017 22:37:07 +1000
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
> > This defines new QOM object - IOMMUMemoryRegion - with MemoryRegion
> > as a parent.
> >=20
> > This moves IOMMU-related fields from MR to IOMMU MR. However to avoid
> > dymanic QOM casting in fast path (address_space_translate, etc),
> > this adds an @is_iommu boolean flag to MR and provides new helper to
> > do simple cast to IOMMU MR - memory_region_get_iommu. The flag
> > is set in the instance init callback. This defines
> > memory_region_is_iommu as memory_region_get_iommu()!=3DNULL.
> >=20
> > This switches MemoryRegion to IOMMUMemoryRegion in most places except
> > the ones where MemoryRegion may be an alias.
> >=20
> > This defines memory_region_init_iommu_type() to allow creating
> > IOMMUMemoryRegion subclasses. In order to support custom QOM type,
> > this splits memory_region_init() to object_initialize() +
> > memory_region_do_init.
> >=20
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>=20
> >  /**
> > + * memory_region_init_iommu_type: Initialize a memory region of a cust=
om type
> > + * that translates addresses
> > + *
> > + * An IOMMU region translates addresses and forwards accesses to a tar=
get
> > + * memory region.
> > + *
> > + * @typename: QOM class name
> > + * @iommumr: the #IOMMUMemoryRegion to be initialized
>=20
> <bikeshed>
> I find "iommumr" terribly hard to read. Maybe iommu_mr is better? (Lots
> of times in this patch.)
> </bikeshed>

Fwiw, I tend to agree.

/me wonders what an IO murmurer is.

>=20
> The s390 parts look fine.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QxIEt88oQPsT6QmF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZCWbKAAoJEGw4ysog2bOSUHMP/RlKF+UrbAKR3bzkBJbIjYR5
/Mb+HQmRKv/g9S5PgwwTH8L1DePvWBaGWmvBP/rFDGC12jI18fdn27hJph0yuUuh
SpH3LjwWbzess0PkvTt/5hkRUVsl7ff443k6ZM2zAfxpN6zll+XRy3B0fbQ/0EI+
CXV7eAA77jrBvHP5i2X76lAHBytgltabbzA6rRg/ziKDCWsnz4xlOJ7SVYRXILvA
3wMdidVCEq8mCPWqxmjNkihlCYdUeJd4ZsQhovkJb7kUTB8C/u6c33u4k/BV2YIv
wd30UjLTHlS9NyxFnWRa1GCE4la3YoBBdHy8A5F6oyi1teLGCTSNGLSKp2dv3k0u
eSoNFCuVC7zgcceHsAV/39eUS27YZIqy5lCoT5iXCIf8BU8rgiUrE8I+8DKvgWxo
3MU0tPZpcaZKC0fY7Yihhag48D9ZBK5MekP76sJM632DDlhidpclgw+xJVGsLmUE
MRzYjAtp3+cuBtNPTrnMdrWUM99GH9Qu/CgNDbZpGAL0I1h/cKCC/U1CBEBVGPct
Uqmh0N4P5jZpb1LWarokTcOQevyn6I2FGIvPekmKVB10pD/Fkx6AG65i/mv+HPrE
2MFfXUEF/KD+TotjHfMw/DzshtlZ31mCW4GgqGU9LEpTumoWNR+kulAS6fTMq9Qb
YCSo/sugj4iYybJ0Ud4T
=Eyqi
-----END PGP SIGNATURE-----

--QxIEt88oQPsT6QmF--
