Received: from eggs.gnu.org ([2001:4830:134:3::10]:43081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1gRXXK-0000wK-Tu
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:12:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1gRXXG-0003WC-Qw
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:11:58 -0500
From: Bharat Bhushan <bharat.bhushan@nxp.com>
Date: Tue, 27 Nov 2018 07:11:46 +0000
Message-ID: <VI1PR04MB48456BBF709F364C8E9B08269AD00@VI1PR04MB4845.eurprd04.prod.outlook.com>
References: <20181122171538.12359-1-eric.auger@redhat.com>
In-Reply-To: <20181122171538.12359-1-eric.auger@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v9 00/17] VIRTIO-IOMMU device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>, "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>
Cc: "kevin.tian@intel.com" <kevin.tian@intel.com>, "tn@semihalf.com" <tn@semihalf.com>, "peterx@redhat.com" <peterx@redhat.com>

Hi Eric,

> -----Original Message-----
> From: Eric Auger <eric.auger@redhat.com>
> Sent: Thursday, November 22, 2018 10:45 PM
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
> devel@nongnu.org; qemu-arm@nongnu.org; peter.maydell@linaro.org;
> mst@redhat.com; jean-philippe.brucker@arm.com
> Cc: kevin.tian@intel.com; tn@semihalf.com; Bharat Bhushan
> <bharat.bhushan@nxp.com>; peterx@redhat.com
> Subject: [RFC v9 00/17] VIRTIO-IOMMU device
>=20
> This series rebases the virtio-iommu device on qemu 3.1.0-rc2 and
> implements the v0.8(.1) virtio-iommu spec [1]. The pci proxy for the virt=
io-
> iommu device is now available and needs to be instantiated from the
> command line using "-device virtio-iommu-pci".
> The iommu machvirt option is not used anymore to instantiate the virtio-
> iommu.
>=20
> At the moment the virtio-iommu-device only is functional in the ARM virt
> machine. Indeed, besides its instantiation, links between the PCIe end po=
ints
> and the IOMMU must be described. This is achieved by DT or ACPI
> description (IORT). This description currently only is done in ARM virt.
>=20
> Best Regards
>=20
> Eric
>=20
> This series can be found at:
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit
> hub.com%2Feauger%2Fqemu%2Ftree%2Fv3.1.0-rc2-virtio-iommu-
> v0.9&amp;data=3D02%7C01%7Cbharat.bhushan%40nxp.com%7C031e61e2a2f3
> 4e3b945a08d6509e2918%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%
> 7C636785037552135579&amp;sdata=3Dv99FRL1dQC%2BPTofwwqqoKGNiiqJ%2F
> lGBX3KJB0IUKbQU%3D&amp;reserved=3D0
>=20
> References:
> [1] [PATCH v3 0/7] Add virtio-iommu driver
>=20
> [2] guest branch featuring the virtio-iommu driver v0.8.1 + ACPI
>     integration not yet officially released by Jean.
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit
> hub.com%2Feauger%2Flinux%2Ftree%2Fvirtio-iommu-
> v0.8.1&amp;data=3D02%7C01%7Cbharat.bhushan%40nxp.com%7C031e61e2a2f
> 34e3b945a08d6509e2918%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C636785037552135579&amp;sdata=3DEjHA9BZ6rNX36YFKkNocBQtoz3uf3bdn
> 5T9NSJ6SaRg%3D&amp;reserved=3D0
>=20
> Testing:
> - tested with guest using virtio-net-pci
>   (,vhost=3Doff,iommu_platform,disable-modern=3Doff,disable-legacy=3Don)
>   and virtio-blk-pci
> - VFIO/VHOST integration is not part of this series
> - When using the virtio-blk-pci, some EDK2 FW versions feature
>   unmapped transactions and in that case the guest fails to boot.

I have tested this series with virtio and VFIO both
Tested-by: Bharat Bhushan <bharat.bhushan@nxp.com>

Thanks
-Bharat
>=20
> History:
>=20
> v8 -> v9:
> - virtio-iommu-pci device needs to be instantiated from the command
>   line (RID is not imposed anymore).
> - tail structure properly initialized
>=20
> v7 -> v8:
> - virtio-iommu-pci added
> - virt instantiation modified
> - DT and ACPI modified to exclude the iommu RID from the mapping
> - VIRTIO_IOMMU_F_BYPASS, VIRTIO_F_VERSION_1 features exposed
>=20
> v6 -> v7:
> - rebase on qemu 3.0.0-rc3
> - minor update against v0.7
> - fix issue with EP not on pci.0 and ACPI probing
> - change the instantiation method
>=20
> v5 -> v6:
> - minor update against v0.6 spec
> - fix g_hash_table_lookup in virtio_iommu_find_add_as
> - replace some error_reports by qemu_log_mask(LOG_GUEST_ERROR, ...)
>=20
> v4 -> v5:
> - event queue and fault reporting
> - we now return the IOAPIC MSI region if the virtio-iommu is instantiated
>   in a PC machine.
> - we bypass transactions on MSI HW region and fault on reserved ones.
> - We support ACPI boot with mach-virt (based on IORT proposal)
> - We moved to the new driver naming conventions
> - simplified mach-virt instantiation
> - worked around the disappearing of pci_find_primary_bus
> - in virtio_iommu_translate, check the dev->as is not NULL
> - initialize as->device_list in virtio_iommu_get_as
> - initialize bufstate.error to false in virtio_iommu_probe
>=20
> v3 -> v4:
> - probe request support although no reserved region is returned at
>   the moment
> - unmap semantics less strict, as specified in v0.4
> - device registration, attach/detach revisited
> - split into smaller patches to ease review
> - propose a way to inform the IOMMU mr about the page_size_mask
>   of underlying HW IOMMU, if any
> - remove warning associated with the translation of the MSI doorbell
>=20
> v2 -> v3:
> - rebase on top of 2.10-rc0 and especially
>   [PATCH qemu v9 0/2] memory/iommu: QOM'fy IOMMU MemoryRegion
> - add mutex init
> - fix as->mappings deletion using g_tree_ref/unref
> - when a dev is attached whereas it is already attached to
>   another address space, first detach it
> - fix some error values
> - page_sizes =3D TARGET_PAGE_MASK;
> - I haven't changed the unmap() semantics yet, waiting for the
>   next virtio-iommu spec revision.
>=20
> v1 -> v2:
> - fix redifinition of viommu_as typedef
>=20
> Eric Auger (17):
>   update-linux-headers: Import virtio_iommu.h
>   linux-headers: Partial update for virtio-iommu v0.8
>   virtio-iommu: Add skeleton
>   virtio-iommu: Decode the command payload
>   virtio-iommu: Add the iommu regions
>   virtio-iommu: Endpoint and domains structs and helpers
>   virtio-iommu: Implement attach/detach command
>   virtio-iommu: Implement map/unmap
>   virtio-iommu: Implement translate
>   virtio-iommu: Implement probe request
>   virtio-iommu: Expose the IOAPIC MSI reserved region when relevant
>   virtio-iommu: Implement fault reporting
>   virtio_iommu: Handle reserved regions in translation process
>   virtio-iommu-pci: Add virtio iommu pci support
>   hw/arm/virt: Add the virtio-iommu device tree mappings
>   hw/arm/virt-acpi-build: Introduce fill_iort_idmap helper
>   hw/arm/virt-acpi-build: Add virtio-iommu node in IORT table
>=20
>  hw/arm/virt-acpi-build.c                      |   91 +-
>  hw/arm/virt.c                                 |   57 +-
>  hw/virtio/Makefile.objs                       |    1 +
>  hw/virtio/trace-events                        |   26 +
>  hw/virtio/virtio-iommu.c                      | 1040 +++++++++++++++++
>  hw/virtio/virtio-pci.c                        |   51 +
>  hw/virtio/virtio-pci.h                        |   14 +
>  include/hw/acpi/acpi-defs.h                   |   21 +-
>  include/hw/arm/virt.h                         |    2 +
>  include/hw/pci/pci.h                          |    1 +
>  include/hw/virtio/virtio-iommu.h              |   65 ++
>  include/standard-headers/linux/virtio_ids.h   |    1 +
>  include/standard-headers/linux/virtio_iommu.h |  159 +++
>  linux-headers/linux/virtio_iommu.h            |    1 +
>  qdev-monitor.c                                |    1 +
>  scripts/update-linux-headers.sh               |    3 +
>  16 files changed, 1501 insertions(+), 33 deletions(-)  create mode 10064=
4
> hw/virtio/virtio-iommu.c  create mode 100644 include/hw/virtio/virtio-
> iommu.h  create mode 100644 include/standard-
> headers/linux/virtio_iommu.h
>  create mode 100644 linux-headers/linux/virtio_iommu.h
>=20
> --
> 2.17.2
