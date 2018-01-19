Received: from eggs.gnu.org ([2001:4830:134:3::10]:58049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecOe8-0000ie-3S
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 23:51:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecOe3-00070s-Vu
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 23:51:20 -0500
Date: Fri, 19 Jan 2018 15:51:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180119045102.GG30352@umbus.fritz.box>
References: <20180102052805.20498-1-aik@ozlabs.ru>
	<f14c0782-0f25-8bd0-8536-323bfc5fcbe4@redhat.com>
	<ad143758-227b-55fe-44a6-c62a48f74162@ozlabs.ru>
	<20180116134614.1aae30b9@w520.home>
	<2c870510-598c-b3e0-75bf-8e135b68d3bd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1+kiJ7gFzGEgD6MU"
Content-Disposition: inline
In-Reply-To: <2c870510-598c-b3e0-75bf-8e135b68d3bd@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--1+kiJ7gFzGEgD6MU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 09:13:34AM +0100, Paolo Bonzini wrote:
> On 16/01/2018 21:46, Alex Williamson wrote:
> > On Mon, 15 Jan 2018 15:12:07 +1100
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >=20
> >> On 03/01/18 04:51, Paolo Bonzini wrote:
> >>> On 02/01/2018 06:28, Alexey Kardashevskiy wrote: =20
> >>>> This is my current queue of the in-kernel TCE acceleration
> >>>> enablement.
> >>>>
> >>>> Changes since https://lists.gnu.org/archive/html/qemu-devel/2017-12/=
msg01918.html :
> >>>> * 3 patches instead of one, one per maintainership area;
> >>>> * added memory_region_iommu_get_attr();
> >>>> * removed set_attr() as there is no use for it now;
> >>>> * folded the chunk in vfio_listener_region_add() under
> >>>> VFIO_SPAPR_TCE_v2_IOMMU branch as the acceleration is only
> >>>> enabled when DMA memory is preregistered and this is only supported
> >>>> by the v2 IOMMU.
> >>>>
> >>>> This is based on sha1
> >>>> ad59cde C=E9dric Le Goater "target/ppc: more use of the PPC_*() macr=
os".
> >>>>
> >>>> Please comment. Thanks.
> >>>>
> >>>>
> >>>>
> >>>> Alexey Kardashevskiy (3):
> >>>>   memory/iommu: Add get_attr()
> >>>>   vfio/spapr: Use iommu memory region's get_attr()
> >>>>   spapr/iommu: Enable in-kernel TCE acceleration via VFIO KVM device
> >>>>
> >>>>  include/exec/memory.h | 22 ++++++++++++++++++++++
> >>>>  target/ppc/kvm_ppc.h  |  6 ++++++
> >>>>  hw/ppc/spapr_iommu.c  | 19 +++++++++++++++++++
> >>>>  hw/vfio/common.c      | 26 ++++++++++++++++++++++++++
> >>>>  memory.c              | 13 +++++++++++++
> >>>>  target/ppc/kvm.c      |  7 ++++++-
> >>>>  hw/vfio/trace-events  |  1 +
> >>>>  7 files changed, 93 insertions(+), 1 deletion(-)
> >>>> =20
> >>>
> >>> Alex, if this is okay for you, please pick it up yourself. =20
> >>
> >> Alex, ping?
> >=20
> > Yeah, I'll pick these up.  Paolo, do you want to throw an explicit Ack
> > for the first patch?  David, R-b/A-b?  Thanks,
> >=20
> > Alex
>=20
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

I don't love the interface, I preferred some of the things Paolo
suggested in the earlier thread.  Still, it's something Paolo and Alex
seem to have agreed on, and it's not exposed to user or guest, so it's
fixable later.  So,

Acked-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1+kiJ7gFzGEgD6MU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpheTMACgkQbDjKyiDZ
s5IiIg//X0PQE18SVZvdqDozZHq2k2eQPJwDbraffJvr4Et6pNjV3lCL49ZacecG
X+SqeFfhVHzhGbYa/KN0i5btB1RBTR04a7v2SJkIWFIiDjaEAzwJYBA8+EtLWekN
ABj9dSqCX59UfxswAHzgE1V4Y4ITU/p6cwWonhG9HqXT51MFJtPQjlSzhv1r8OUj
CMZBlLXXkJ3G2jq79sccuZHRRFdDBlLbGrvFrP6OevffBsvSDnehv+utNANChtCD
ZKMwqa+muMIhVfKWlBbfIrLkFTyKub35HzQPV4TkBZKCslX6LwJzp6TdWc+8gMT0
RBoz2YYHjutuoT+OYE1OSSRHSLvVtGh6/Mt3cyL01n4sAPNsC+rcb2gmkOSqp84w
koaPxMzZrrfy2DF6HKJoRKDtngT9NIru7JZXyaJQal0KPVR4JyACbUSbEi3+lV/1
oxyy9PimQfGswUgU9zmVOtFqw5zjXuidgQeK014feCNHJXG58RSPNh/tSPJaBq12
MVY8q5OrfeQlLngm5m/oh6i39ngkTtMOnME64UW454Aq2lMTJIHmzkoLklrvM+/C
osF5QAeHzuo144pVHuRS8EesCc6ZP250c+btoHNCIuvsHFXXAAQkgoS4xrJNU1hw
EzS7+ZhAijeiO9Z7SypGrBrMvrS7yHxwZXW+66axK5RVfxbhX/k=
=gOfK
-----END PGP SIGNATURE-----

--1+kiJ7gFzGEgD6MU--
