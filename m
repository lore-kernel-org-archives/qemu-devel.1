Received: from eggs.gnu.org ([2001:4830:134:3::10]:43745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ebY7i-00052R-9y
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:46:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ebY7e-0003xz-Cz
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:46:22 -0500
Date: Tue, 16 Jan 2018 13:46:14 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180116134614.1aae30b9@w520.home>
In-Reply-To: <ad143758-227b-55fe-44a6-c62a48f74162@ozlabs.ru>
References: <20180102052805.20498-1-aik@ozlabs.ru>
	<f14c0782-0f25-8bd0-8536-323bfc5fcbe4@redhat.com>
	<ad143758-227b-55fe-44a6-c62a48f74162@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Mon, 15 Jan 2018 15:12:07 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 03/01/18 04:51, Paolo Bonzini wrote:
> > On 02/01/2018 06:28, Alexey Kardashevskiy wrote: =20
> >> This is my current queue of the in-kernel TCE acceleration
> >> enablement.
> >>
> >> Changes since https://lists.gnu.org/archive/html/qemu-devel/2017-12/ms=
g01918.html :
> >> * 3 patches instead of one, one per maintainership area;
> >> * added memory_region_iommu_get_attr();
> >> * removed set_attr() as there is no use for it now;
> >> * folded the chunk in vfio_listener_region_add() under
> >> VFIO_SPAPR_TCE_v2_IOMMU branch as the acceleration is only
> >> enabled when DMA memory is preregistered and this is only supported
> >> by the v2 IOMMU.
> >>
> >> This is based on sha1
> >> ad59cde C=C3=A9dric Le Goater "target/ppc: more use of the PPC_*() mac=
ros".
> >>
> >> Please comment. Thanks.
> >>
> >>
> >>
> >> Alexey Kardashevskiy (3):
> >>   memory/iommu: Add get_attr()
> >>   vfio/spapr: Use iommu memory region's get_attr()
> >>   spapr/iommu: Enable in-kernel TCE acceleration via VFIO KVM device
> >>
> >>  include/exec/memory.h | 22 ++++++++++++++++++++++
> >>  target/ppc/kvm_ppc.h  |  6 ++++++
> >>  hw/ppc/spapr_iommu.c  | 19 +++++++++++++++++++
> >>  hw/vfio/common.c      | 26 ++++++++++++++++++++++++++
> >>  memory.c              | 13 +++++++++++++
> >>  target/ppc/kvm.c      |  7 ++++++-
> >>  hw/vfio/trace-events  |  1 +
> >>  7 files changed, 93 insertions(+), 1 deletion(-)
> >> =20
> >=20
> > Alex, if this is okay for you, please pick it up yourself. =20
>=20
> Alex, ping?

Yeah, I'll pick these up.  Paolo, do you want to throw an explicit Ack
for the first patch?  David, R-b/A-b?  Thanks,

Alex
