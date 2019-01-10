Received: from eggs.gnu.org ([209.51.188.92]:46114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghbsJ-000325-FJ
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghbsG-0007Nw-E4
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:04:03 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 10 Jan 2019 17:03:34 +0200
Message-Id: <cover.1547132561.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 0/6] Acquire the AioContext during _realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

As discussed yesterday, this series acquires the AioContext in the
_realize() functions of several devices before making use of their
block backends. This fixes at least a couple of crashes (in virtio-blk
and scsi).

Berto

Alberto Garcia (6):
  block: Acquire the AioContext in virtio_blk_device_realize()
  block: Acquire the AioContext in scsi_*_realize()
  block: Acquire the AioContext in floppy_drive_realize()
  block: Acquire the AioContext in nvme_realize()
  block: Acquire the AioContext in ide_dev_initfn()
  block: Acquire the AioContext in usb_msd_storage_realize()

 hw/block/fdc.c        | 15 +++++++++++----
 hw/block/nvme.c       | 13 ++++++++++---
 hw/block/virtio-blk.c | 22 +++++++++++++++-------
 hw/ide/qdev.c         | 17 ++++++++++++-----
 hw/scsi/scsi-disk.c   | 24 +++++++++++++++++++-----
 hw/usb/dev-storage.c  |  5 +++++
 6 files changed, 72 insertions(+), 24 deletions(-)

-- 
2.11.0
