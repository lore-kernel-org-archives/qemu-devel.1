Received: from eggs.gnu.org ([2001:4830:134:3::10]:57163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fbQRS-0004rX-DH
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:06:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fbQRR-0005NZ-Jq
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:06:30 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  6 Jul 2018 15:06:16 +0200
Message-Id: <20180706130620.5647-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.0 0/4] block: revert removal of
 deprecated options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>

Several -drive options had been marked as deprecated for two releases
and had therefore been removed; unfortunately, libvirt still used at
least two of them (serial number and disk geometry) and the patch
switching away from it is not yet in any released libvirt version.

As agreed, let's revert the removal patches for 3.0; with 3.1, the then
released libvirt versions will be fine. While nobody complained about
the 'addr' option, it is reinstated again as well, but purely to make
all the reverts apply cleanly.

Cornelia Huck (4):
  Revert "block: Remove dead deprecation warning code"
  Revert "block: Remove deprecated -drive option serial"
  Revert "block: Remove deprecated -drive option addr"
  Revert "block: Remove deprecated -drive geometry options"

 block/block-backend.c     |   1 +
 blockdev.c                | 110 ++++++++++++++++++++++++++++++++++++++++++++++
 device-hotplug.c          |   4 ++
 hmp-commands.hx           |   1 +
 hw/block/block.c          |  27 ++++++++++++
 hw/block/nvme.c           |   1 +
 hw/block/virtio-blk.c     |   1 +
 hw/ide/qdev.c             |   1 +
 hw/scsi/scsi-disk.c       |   1 +
 hw/usb/dev-storage.c      |   1 +
 include/hw/block/block.h  |   1 +
 include/sysemu/blockdev.h |   3 ++
 qemu-doc.texi             |  15 +++++++
 qemu-options.hx           |  14 +++++-
 tests/ahci-test.c         |   6 +--
 tests/hd-geo-test.c       |  37 +++++++++++++---
 tests/ide-test.c          |   8 ++--
 17 files changed, 217 insertions(+), 15 deletions(-)

-- 
2.14.4
