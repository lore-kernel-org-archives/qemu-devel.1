Received: from eggs.gnu.org ([2001:4830:134:3::10]:55862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTOyx-0002X1-Gh
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 05:55:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTOyw-0007S1-Mj
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 05:55:55 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 14 Jun 2018 11:55:40 +0200
Message-Id: <20180614095544.31549-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] block: Remove deprecated -drive options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

We deprecated a bunch of -drive options in 2.10, so let's remove them
for 3.0.

v2:
- Simplified hd-geo-test code after removing test cases [Markus]
- Split patch 3 and 4 so that the deprecation warning code can be easily
  restored if we ever need it again [Markus]

Kevin Wolf (4):
  block: Remove deprecated -drive geometry options
  block: Remove deprecated -drive option addr
  block: Remove deprecated -drive option serial
  block: Remove dead deprecation warning code

 include/hw/block/block.h  |   1 -
 include/sysemu/blockdev.h |   3 --
 block/block-backend.c     |   1 -
 blockdev.c                | 110 ----------------------------------------------
 device-hotplug.c          |   4 --
 hw/block/block.c          |  27 ------------
 hw/block/nvme.c           |   1 -
 hw/block/virtio-blk.c     |   1 -
 hw/ide/qdev.c             |   1 -
 hw/scsi/scsi-disk.c       |   1 -
 hw/usb/dev-storage.c      |   1 -
 tests/ahci-test.c         |   6 +--
 tests/hd-geo-test.c       |  37 +++-------------
 tests/ide-test.c          |   8 ++--
 hmp-commands.hx           |   1 -
 qemu-doc.texi             |  15 -------
 qemu-options.hx           |  14 +-----
 17 files changed, 15 insertions(+), 217 deletions(-)

-- 
2.13.6
