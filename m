Received: from eggs.gnu.org ([2001:4830:134:3::10]:49776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cTCI9-0007nx-Gt
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 13:46:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cTCI8-00063v-TQ
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 13:46:05 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jan 2017 18:46:00 +0000
Message-Id: <1484592360-23640-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] scsi-disk: add 'fall through' comment to
 switch VERIFY cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

Commit 166dbda7e131 added some extra cases to a switch() such
that the existing code is intended to fall through the new
case statements. It's clear from the commit that this is
intentional, but less clear to subsequent readers of the
code, and not clear at all to static analysis tools like
Coverity. Add a /* fall through */ comment to indicate the
intent. (Fixes CID 1368287.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/scsi/scsi-disk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index bdd1e5f..25e1081 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2157,6 +2157,7 @@ static int32_t scsi_disk_dma_command(SCSIRequest *req, uint8_t *buf)
         DPRINTF("Write %s(sector %" PRId64 ", count %u)\n",
                 (command & 0xe) == 0xe ? "And Verify " : "",
                 r->req.cmd.lba, len);
+        /* fall through */
     case VERIFY_10:
     case VERIFY_12:
     case VERIFY_16:
-- 
2.7.4
