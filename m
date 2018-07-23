Received: from eggs.gnu.org ([2001:4830:134:3::10]:43705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fhSxM-0003fk-5U
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 01:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fhSxJ-0004n0-6h
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 01:00:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:61813)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1fhSxI-0004mO-Uc
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 01:00:21 -0400
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Mon, 23 Jul 2018 12:59:53 +0800
Message-Id: <20180723045956.27521-1-tiwei.bie@intel.com>
Subject: [Qemu-devel] [RFC 0/3] Supporting programming IOMMU in QEMU
 (vDPA/vhost-user)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, alex.williamson@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: tiwei.bie@intel.com

This patch set introduces a slave message in vhost-user to
allow slave to share its VFIO group fd to master and do the
IOMMU programming based on virtio device's DMA address space
for this group in QEMU.

For the vhost-user backends which support vDPA, they could
leverage this message to ask master to do IOMMU programming
in QEMU for the vDPA device in backend. This is helpful to
support vIOMMU in vDPA.

Tiwei Bie (3):
  vfio: split vfio_get_group() into small functions
  vfio: support getting VFIOGroup from groupfd
  vhost-user: support programming VFIO group in master

 docs/interop/vhost-user.txt    |  16 +++++
 hw/vfio/common.c               | 127 +++++++++++++++++++++++++--------
 hw/virtio/vhost-user.c         |  40 +++++++++++
 include/hw/vfio/vfio-common.h  |   1 +
 include/hw/virtio/vhost-user.h |   2 +
 5 files changed, 158 insertions(+), 28 deletions(-)

-- 
2.18.0
