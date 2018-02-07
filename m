Received: from eggs.gnu.org ([2001:4830:134:3::10]:59515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejShz-00044K-DQ
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:36:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejShy-0005C6-KT
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:36:31 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  7 Feb 2018 17:36:20 +0100
Message-Id: <20180207163622.29935-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] scsi: add block job opblockers for
 scsi-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

SCSI passthrough bypasses the block layer and issues SCSI commands
directly to the disk.  This breaks write notifiers and dirty bitmaps,
so that scsi-block devices cannot act as a mirror or backup source
(and commit too, even though that shouldn't be possible at all in the
lack of a backing file).  This series adds op blockers for that purpose.

There is currently a blk_op_unblock but no blk_op_block, so patch 2
adds it.

Paolo

Paolo Bonzini (2):
  scsi: add unrealize method for SCSI devices
  scsi: add block job opblockers for scsi-block

 block/block-backend.c          |  9 ++++++
 hw/scsi/scsi-bus.c             |  4 +++
 hw/scsi/scsi-disk.c            | 62 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/scsi/scsi.h         |  1 +
 include/sysemu/block-backend.h |  1 +
 5 files changed, 77 insertions(+)

-- 
2.14.3
