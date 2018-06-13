Received: from eggs.gnu.org ([2001:4830:134:3::10]:44652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fT4za-0006gk-QJ
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fT4za-0001q7-4G
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:35:14 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 13 Jun 2018 14:34:55 +0200
Message-Id: <20180613123458.24685-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] block: Remove deprecated -drive options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

We deprecated a bunch of -drive options in 2.10, so let's remove them
for 3.0.

Kevin Wolf (3):
  block: Remove deprecated -drive geometry options
  block: Remove deprecated -drive option addr
  block: Remove deprecated -drive option serial

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
 tests/hd-geo-test.c       |  18 --------
 tests/ide-test.c          |   8 ++--
 hmp-commands.hx           |   1 -
 qemu-doc.texi             |  15 -------
 qemu-options.hx           |  14 +-----
 17 files changed, 8 insertions(+), 205 deletions(-)

-- 
2.13.6
