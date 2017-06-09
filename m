Received: from eggs.gnu.org ([2001:4830:134:3::10]:57170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1dJDDQ-0003yi-Sq
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 02:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1dJDDP-0000Lm-LM
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 02:16:12 -0400
From: Bharat Bhushan <bharat.bhushan@nxp.com>
Date: Fri, 9 Jun 2017 06:16:02 +0000
Message-ID: <AM5PR0401MB2545AFD256A96420ACC44CD89ACE0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1496851287-9428-1-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1496851287-9428-1-git-send-email-eric.auger@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v2 0/8] VIRTIO-IOMMU device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>
Cc: "will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "drjones@redhat.com" <drjones@redhat.com>, "wei@redhat.com" <wei@redhat.com>, "tn@semihalf.com" <tn@semihalf.com>

Hi Eric,

> -----Original Message-----
> From: Eric Auger [mailto:eric.auger@redhat.com]
> Sent: Wednesday, June 07, 2017 9:31 PM
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com;
> peter.maydell@linaro.org; alex.williamson@redhat.com; mst@redhat.com;
> qemu-arm@nongnu.org; qemu-devel@nongnu.org; jean-
> philippe.brucker@arm.com
> Cc: will.deacon@arm.com; robin.murphy@arm.com; kevin.tian@intel.com;
> marc.zyngier@arm.com; christoffer.dall@linaro.org; drjones@redhat.com;
> wei@redhat.com; tn@semihalf.com; Bharat Bhushan
> <bharat.bhushan@nxp.com>
> Subject: [RFC v2 0/8] VIRTIO-IOMMU device
>=20
> This series implements the virtio-iommu device. This is a proof of concep=
t
> based on the virtio-iommu specification written by Jean-Philippe Brucker =
[1].
> This was tested with a guest using the virtio-iommu driver [2] and expose=
d
> with a virtio-net-pci using dma ops.
>=20
> The device gets instantiated using the "-device virtio-iommu-device"
> option. It currently works with ARM virt machine only as the machine must
> handle the dt binding between the virtio-mmio "iommu" node and the PCI
> host bridge node. ACPI booting is not yet supported.
>=20
> This should allow to start some benchmarking activities against pure
> emulated IOMMU (especially ARM SMMU).

I am testing this on ARM64 and see below continuous error prints:

	virtio_iommu_translate sid=3D8 is not known!!
	virtio_iommu_translate sid=3D8 is not known!!
	virtio_iommu_translate sid=3D8 is not known!!
	virtio_iommu_translate sid=3D8 is not known!!
	virtio_iommu_translate sid=3D8 is not known!!
	virtio_iommu_translate sid=3D8 is not known!!
	virtio_iommu_translate sid=3D8 is not known!!
	virtio_iommu_translate sid=3D8 is not known!!
	virtio_iommu_translate sid=3D8 is not known!!
	virtio_iommu_translate sid=3D8 is not known!!=20


Also in guest I do not see device-tree node with virtio-iommu.
I am using qemu-tree you mentioned below and iommu-driver patches published=
 by Jean-P.
Qemu command line have additional ""-device virtio-iommu-device". What I am=
 missing ?

Thanks
-Bharat

>=20
> Best Regards
>=20
> Eric
>=20
> This series can be found at:
> https://github.com/eauger/qemu/tree/virtio-iommu-rfcv2
>=20
> References:
> [1] [RFC 0/3] virtio-iommu: a paravirtualized IOMMU, [2] [RFC PATCH linux=
]
> iommu: Add virtio-iommu driver [3] [RFC PATCH kvmtool 00/15] Add virtio-
> iommu
>=20
> History:
> v1 -> v2:
> - fix redifinition of viommu_as typedef
>=20
> Eric Auger (8):
>   update-linux-headers: import virtio_iommu.h
>   linux-headers: Update for virtio-iommu
>   virtio_iommu: add skeleton
>   virtio-iommu: Decode the command payload
>   virtio_iommu: Add the iommu regions
>   virtio-iommu: Implement the translation and commands
>   hw/arm/virt: Add 2.10 machine type
>   hw/arm/virt: Add virtio-iommu the virt board
>=20
>  hw/arm/virt.c                                 | 116 ++++-
>  hw/virtio/Makefile.objs                       |   1 +
>  hw/virtio/trace-events                        |  14 +
>  hw/virtio/virtio-iommu.c                      | 623 ++++++++++++++++++++=
++++++
>  include/hw/arm/virt.h                         |   5 +
>  include/hw/virtio/virtio-iommu.h              |  60 +++
>  include/standard-headers/linux/virtio_ids.h   |   1 +
>  include/standard-headers/linux/virtio_iommu.h | 142 ++++++
>  linux-headers/linux/virtio_iommu.h            |   1 +
>  scripts/update-linux-headers.sh               |   3 +
>  10 files changed, 957 insertions(+), 9 deletions(-)  create mode 100644
> hw/virtio/virtio-iommu.c  create mode 100644 include/hw/virtio/virtio-
> iommu.h  create mode 100644 include/standard-
> headers/linux/virtio_iommu.h
>  create mode 100644 linux-headers/linux/virtio_iommu.h
>=20
> --
> 2.5.5
