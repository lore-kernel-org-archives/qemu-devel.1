Received: from eggs.gnu.org ([2001:4830:134:3::10]:41117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ctPGG-0006vo-0v
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 21:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ctPGF-0002a1-6F
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 21:52:28 -0400
Date: Thu, 30 Mar 2017 12:33:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170330013313.GE21068@umbus.fritz.box>
References: <20170328090530.20052-1-aik@ozlabs.ru>
	<20170328090530.20052-2-aik@ozlabs.ru>
	<20170328114829.25656146@t450s.home>
	<8f7ad62d-0d1c-e917-5b87-f913dab6bb97@ozlabs.ru>
	<20170328210410.3d6cb5d8@t450s.home>
	<0c5842ea-3c9f-94ee-27db-e1ee6ae3a449@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2IUIi54rL+LZyXu+"
Content-Disposition: inline
In-Reply-To: <0c5842ea-3c9f-94ee-27db-e1ee6ae3a449@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH qemu 1/3] memory: Add get_fd() hook for
 IOMMU MR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--2IUIi54rL+LZyXu+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2017 at 10:04:47AM +0200, Paolo Bonzini wrote:
>=20
>=20
> On 29/03/2017 05:04, Alex Williamson wrote:
> >>> What if we used this as a prototype:
> >>>
> >>> int (*get_fd)(IOMMUFdType type, MemoryRegion *iommu);
> >>>
> >>> And then we defined:
> >>>
> >>> typedef enum {
> >>>     SPAPR_IOMMU_TABLE_FD =3D 0,
> >>> } IOMMUFdType; =20
> >>
> >> Where do I put this enum definition? include/exec/memory.h? It does not
> >> have any mention of any platform yet...
> > =20
> > I would assume memory.h, yes.  It seems like the enum is just an
> > abstraction, what does "get fd" mean generically to an IOMMU
> > MemoryRegion?  How can anyone else ever implement that callback if the
> > initial user is assuming that the returned fd is a specific, yet
> > unspecified type.  If the API is "give me an fd for this type of thing"
> > then the IOMMU driver can either provide it or indicate that type is not
> > supported.  There's really no platform knowledge at the memory API
> > level, it's just a type of thing that means something to the driver
> > providing the MemoryRegionIOMMUOps and the caller.
>=20
> I think we should move to a QOM hierarchy like
>=20
>    AbstractMemoryRegion
>       MemoryRegion                  << adds MemoryRegionOps
>       IOMMUMemoryRegion             << adds MemoryRegionIOMMUOps
>         sPAPR_IOMMUMemoryRegion     << adds get_fd

Right, this makes more sense to me than the enum as well.

> but for now I'm okay with Alex's proposal.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2IUIi54rL+LZyXu+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY3GBZAAoJEGw4ysog2bOSxkwP/3WtjbDdHBomrJj3wvzuhVVH
JNBIfEeVHK989PXX682eotP43rDXBk5fVat2xonLij92wqIndsSCUpOJxaAMlld2
HSA45xYgzGBXz16bmXSFqcpVl0QtxoroT3kq3WXt8yKP5l1OHcNK7T2/KewMVPcA
wC3knaxO+qcUk1Y7TE7xZBx5oTixxUgx4KOEpVNSp+DzaLG52yZ3LZz8mOaTH4hJ
lx+OeWc4fgYKvNFja9L3XnQptiIpHswrmmF11KKZjQLgGuZThk0XiY/tTAbslB2w
AR2FnSbYsNQpeIPc1QmqXA2mH3G57vAbXq444ApOZVMvMpFw50FHLY5vdcvnMhLy
5PeSu6jB6H2/lGhlPOZn/AfA8aSySsI4BEexap86uWgCcd4zdAuw4Rz71tz63mPl
OQa4Ts9xYwGBxCwHYfCAkZjmdWUSnuG9M2rccQzQl1NUuV3CbHZnh9Ju9wtNBKIU
V+fuCyRaY2aloCKZrff1RBWllCgRJLPFQSjsfpYs/oeR0dwZArazcPhf+otkf+8r
ZBm3XN2jVB82DIXFtEaFzaLtM0S7i9rc4Xic3jBkwyOI9ffLHUBpJXo14EeFgRIc
G/AThSmbxG6DYLRRtai4jkyITCJN015cjx+5DZV/qaglIWgYi0r3ERwfZuoVBTol
fMUCAZaST6ytQAvaA9Fr
=DaNI
-----END PGP SIGNATURE-----

--2IUIi54rL+LZyXu+--
