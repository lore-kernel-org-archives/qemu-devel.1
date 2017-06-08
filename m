Received: from eggs.gnu.org ([2001:4830:134:3::10]:42412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIyt7-0007Vk-UA
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIyt6-0004fS-PP
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:58:18 -0400
Date: Fri, 9 Jun 2017 00:51:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170608145117.GH25805@umbus.fritz.box>
References: <20170607083243.8983-1-aik@ozlabs.ru>
	<20170608074250.GE25805@umbus.fritz.box>
	<b9c81b9d-56ce-b8e6-bedc-5140caf14798@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VaKJWhUROU/xPxjb"
Content-Disposition: inline
In-Reply-To: <b9c81b9d-56ce-b8e6-bedc-5140caf14798@redhat.com>
Subject: Re: [Qemu-devel] [PATCH qemu v7] memory/iommu: QOM'fy IOMMU
 MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Peter Xu <peterx@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>


--VaKJWhUROU/xPxjb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 03:59:27PM +0200, Paolo Bonzini wrote:
>=20
>=20
> On 08/06/2017 09:42, David Gibson wrote:
> > So.. this seems like an only halfway QOMification.  The main init
> > function still takes an ops structure, whereas the QOMish way to do
> > this would be to have the base IOMMUMemoryRegion be an abstract class,
> > and have the IOMMUOps pointers as part of the IOMMUMemoryRegionClass.
> >=20
> > Maybe you can persuade me this is a useful interim step?
>=20
> Well, it's definitely better than nothing, and MR already relies heavily
> on the ops pattern.

Hm, fair point.

> The only changes I'd make are:
>=20
> 1) remove this unnecessary hunk
>=20
> >      snprintf(tmp, sizeof(tmp), "tce-iommu-%x", tcet->liobn);
> > -    memory_region_init_iommu(&tcet->iommu, tcetobj, &spapr_iommu_ops, =
tmp, 0);
> > +    memory_region_init_iommu_type(TYPE_IOMMU_MEMORY_REGION,
> > +                                  &tcet->iommu, tcetobj, &spapr_iommu_=
ops,
> > +                                  tmp, 0);
>=20
> thus delaying the introduction of memory_region_init_iommu_type to the
> next step.
>=20
> 2) Leave is_iommu early in the "should fit in a cache line" part, for
> example after dirty_log_mask, and since we have room move "bool
> ram_device;" there too.

I really think the unsafe use of object_initialize() needs to be fixed
as well.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VaKJWhUROU/xPxjb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOWRiAAoJEGw4ysog2bOSrtEP/0YLT1ln5TnruWUod6+rPGuo
kAL81EjFVn5Rs/b6RvMW4OcM5yIaQqYYnA3YuHPz+CF+KdcSOpGnyEYEoELdqmIa
/qSdxv3hThFqz6VkcwKn3dENY2lyrn3RYIQ/SOIn6IE2rDD2i4F+MKS538PzCkNB
pHnF66mNh+wzKetK0gVC1Lk/c+oOPvSLPNiaZA2JJEKGYtCNykOxGfU82+KB5iEq
XhLhDuYoJH0gyuIohUHI4VlcqVOr2dvgvgFwQ3IjgjAWSmweQAK+hlOXK/3e5T6t
cCKH/FMgcucyVo5v72KX7RheRq2MVWCMXrbctjLReTprgGDd6rMxC+69F/2I7obH
s4Xn2RaINCOMszxvpX8rTYGCvXWAt9sVPk0+GzmwjL8muMJtpVM3IyTYEy++B1DC
OF5itZ0SflwphTjYfVzGYY2eblkfMx1nkUb5Qs61qcFU3GTu1jhY1WIHJ3/JXn3W
8ofy7YbTZmEEgrAYXmrLanP/wKpue5fYnTvqiuRkhglrvlrQuaLMNJV3hH6rkCGU
J5KHzU+tZviGmN/e0YL2j7i12c5DfTw1A5c3E6afiqTshb8oMKJf441XQ5uSV0lS
8UUzSU+5i/bNIeakairKDPhSJHFZeSvBjunuyyzbjNwGSALfDbBz4upoaeeGSKU8
CigoZAN+cRJpSDU/TWXd
=QLGo
-----END PGP SIGNATURE-----

--VaKJWhUROU/xPxjb--
