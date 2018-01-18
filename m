Received: from eggs.gnu.org ([2001:4830:134:3::10]:55584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ec382-0001Z3-BV
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 00:52:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ec37y-00076T-Ln
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 00:52:46 -0500
Date: Thu, 18 Jan 2018 16:48:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180118054840.GT30352@umbus.fritz.box>
References: <20180102052805.20498-1-aik@ozlabs.ru>
	<f14c0782-0f25-8bd0-8536-323bfc5fcbe4@redhat.com>
	<ad143758-227b-55fe-44a6-c62a48f74162@ozlabs.ru>
	<20180116134614.1aae30b9@w520.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wKbYzd8t8rt1PVqr"
Content-Disposition: inline
In-Reply-To: <20180116134614.1aae30b9@w520.home>
Subject: Re: [Qemu-devel] [PATCH qemu 0/3] spapr/iommu: Enable in-kernel TCE
 acceleration via VFIO KVM device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--wKbYzd8t8rt1PVqr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 01:46:14PM -0700, Alex Williamson wrote:
> On Mon, 15 Jan 2018 15:12:07 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
> > On 03/01/18 04:51, Paolo Bonzini wrote:
> > > On 02/01/2018 06:28, Alexey Kardashevskiy wrote: =20
> > >> This is my current queue of the in-kernel TCE acceleration
> > >> enablement.
> > >>
> > >> Changes since https://lists.gnu.org/archive/html/qemu-devel/2017-12/=
msg01918.html :
> > >> * 3 patches instead of one, one per maintainership area;
> > >> * added memory_region_iommu_get_attr();
> > >> * removed set_attr() as there is no use for it now;
> > >> * folded the chunk in vfio_listener_region_add() under
> > >> VFIO_SPAPR_TCE_v2_IOMMU branch as the acceleration is only
> > >> enabled when DMA memory is preregistered and this is only supported
> > >> by the v2 IOMMU.
> > >>
> > >> This is based on sha1
> > >> ad59cde C=E9dric Le Goater "target/ppc: more use of the PPC_*() macr=
os".
> > >>
> > >> Please comment. Thanks.
> > >>
> > >>
> > >>
> > >> Alexey Kardashevskiy (3):
> > >>   memory/iommu: Add get_attr()
> > >>   vfio/spapr: Use iommu memory region's get_attr()
> > >>   spapr/iommu: Enable in-kernel TCE acceleration via VFIO KVM device
> > >>
> > >>  include/exec/memory.h | 22 ++++++++++++++++++++++
> > >>  target/ppc/kvm_ppc.h  |  6 ++++++
> > >>  hw/ppc/spapr_iommu.c  | 19 +++++++++++++++++++
> > >>  hw/vfio/common.c      | 26 ++++++++++++++++++++++++++
> > >>  memory.c              | 13 +++++++++++++
> > >>  target/ppc/kvm.c      |  7 ++++++-
> > >>  hw/vfio/trace-events  |  1 +
> > >>  7 files changed, 93 insertions(+), 1 deletion(-)
> > >> =20
> > >=20
> > > Alex, if this is okay for you, please pick it up yourself. =20
> >=20
> > Alex, ping?
>=20
> Yeah, I'll pick these up.  Paolo, do you want to throw an explicit Ack
> for the first patch?  David, R-b/A-b?  Thanks,

Sorry, I've been so buried in bugs that performance improvements just
haven't made my radar to look at.

=46rom my first look these look workable, though somewhat uglier than
necessary.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wKbYzd8t8rt1PVqr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpgNTUACgkQbDjKyiDZ
s5LNBhAAkfuinTHvJtY4+gccsKDLYK7VRuOWQjs1E8j1req4XPlMcPECfA6ulS4W
lIgIw96SG9s+9iGK4c2xSxwPcsA6Aa7sKsS1FH/XDsE46OGpCQxD2l+7pB2MgfJp
ehc/QPVsbdDnyxEITFjPfijB0OgYBVb9ySguLhxLvI7vnMpWtb0yfcTU1cQorFio
8oXL1MjgSHMeXIafFJ9AOtVkNEKcVrXxfPCXVWmB6kmI/O8f4S++0xMnb2paYXfd
84IHYZSIdYDWtZHeU26FEsNcKDSK9SHiahhjuIjc86/9z/hFk9IOaWCeTdjWpnc+
YftwZv8tq7cw61+Ed/D/C6CJ1Ax74hRseNMz5XuYJ5vS4LVnTqlcQxNFgof0B48T
+7pBGxTBHuDtA2dGRd3Y6EUdi2zwt6z/3529IRVIZNwh0kSYqVFB6ZZcwZBGM4yh
KMCLGt2Gyn9wNxNwNhJLabjqDlwfV4lHe6aMajIzAQvCnowBASUyxN6/al3V9X4Q
hpGtXALGW44YSh7aOyBd51Udx2qPgkNH8Lz6XlbH5qn/ag+5E72vzqLWs7Itkbfu
QvdzMY0fWnRfF9P6g+sIGb4UKXIUUtC7JabdKC2OvVGSqyzg4cXwvy0mlWh92fmc
8mLYoyBnRYsBMCrazsfoEYs5/W3Yuy9K3jzux1VXY9V7mhBpRlw=
=T4Tw
-----END PGP SIGNATURE-----

--wKbYzd8t8rt1PVqr--
