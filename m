Received: from eggs.gnu.org ([2001:4830:134:3::10]:36413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxH-0008VP-Ba
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxC-0007MS-1y
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:11 -0500
Received: from mail.kernel.org ([198.145.29.136]:56456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxB-0007IQ-O4
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:05 -0500
Date: Thu, 19 Jan 2017 23:09:01 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484860116-25361-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 00/17] virtio, vhost, pc: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

The following changes since commit 23eb9e6b6d5315171cc15969bbc755f258004df0:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-01-16' into staging (2017-01-17 13:53:50 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 2943b53f682f54548e7ddcf2ebb6c6d12d8dc821:

  virtio: force VIRTIO_F_IOMMU_PLATFORM (2017-01-19 23:00:31 +0200)

----------------------------------------------------------------
virtio, vhost, pc: fixes, features

writeable fw cfg blobs which will be used for guest to host
communication
fixes and cleanups all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Eduardo Habkost (1):
      pc: Add 2.9 machine-types

Jason Wang (2):
      vhost_net: device IOTLB support
      virtio: force VIRTIO_F_IOMMU_PLATFORM

Laszlo Ersek (2):
      fw-cfg: turn FW_CFG_FILE_SLOTS into a device property
      fw-cfg: bump "x-file-slots" to 0x20 for 2.9+ machine types

Michael S. Tsirkin (9):
      fw-cfg: support writeable blobs
      virtio: drop an obsolete comment
      virtio_mmio: add standard header file
      virtio-mmio: switch to linux headers
      pci_regs: update to latest linux
      virtio_crypto: header update
      update-linux-headers.sh: support __bitwise
      vhost: drop VHOST_F_DEVICE_IOTLB
      virtio: fix up max size checks

Paolo Bonzini (1):
      virtio-net: enable ioeventfd even if vhost=off

Stefan Hajnoczi (2):
      Revert "virtio: turn vq->notification into a nested counter"
      virtio: disable notifications again after poll succeeded

 docs/specs/fw_cfg.txt                          |  36 +-
 hw/lm32/lm32_hwsetup.h                         |   2 +-
 include/hw/compat.h                            |  10 +-
 include/hw/i386/pc.h                           |   2 +
 include/hw/loader.h                            |   7 +-
 include/hw/nvram/fw_cfg.h                      |   3 +-
 include/hw/nvram/fw_cfg_keys.h                 |   3 +-
 include/hw/virtio/vhost-backend.h              |  13 +
 include/hw/virtio/vhost.h                      |   4 +
 include/standard-headers/linux/pci_regs.h      |   1 -
 include/standard-headers/linux/virtio_crypto.h | 481 +++++++++++++------------
 include/standard-headers/linux/virtio_mmio.h   | 141 ++++++++
 linux-headers/linux/vhost.h                    |   2 -
 hw/arm/virt-acpi-build.c                       |   2 +-
 hw/core/loader.c                               |  18 +-
 hw/i386/acpi-build.c                           |   4 +-
 hw/i386/pc_piix.c                              |  15 +-
 hw/i386/pc_q35.c                               |  13 +-
 hw/net/vhost_net.c                             |   1 +
 hw/nvram/fw_cfg.c                              | 110 +++++-
 hw/virtio/vhost-backend.c                      |  99 +++++
 hw/virtio/vhost.c                              | 166 +++++++--
 hw/virtio/virtio-bus.c                         |   5 +-
 hw/virtio/virtio-mmio.c                        |  95 ++---
 hw/virtio/virtio-pci.c                         |   3 +-
 hw/virtio/virtio.c                             |  54 ++-
 net/tap.c                                      |   1 +
 scripts/update-linux-headers.sh                |   2 +-
 28 files changed, 895 insertions(+), 398 deletions(-)
 create mode 100644 include/standard-headers/linux/virtio_mmio.h
