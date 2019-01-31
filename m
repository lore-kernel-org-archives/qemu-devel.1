Received: from eggs.gnu.org ([209.51.188.92]:41624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gpJkT-0008GE-Lh
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gpJkS-0003Md-Rh
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:19:49 -0500
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:36482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1gpJkS-0003Lx-F8
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:19:48 -0500
From: Sven Schnelle <svens@stackframe.org>
Date: Thu, 31 Jan 2019 22:19:31 +0100
Message-Id: <20190131211931.16216-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/scsi: print SCSI command as hex number in
 trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>

Otherwise it's hard for people fluent in SCSI to read the traces.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 hw/scsi/trace-events | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index 2fe8a7c062..a71c5596ac 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -8,9 +8,9 @@ scsi_req_data_canceled(int target, int lun, int tag, int len) "target %d lun %d
 scsi_req_dequeue(int target, int lun, int tag) "target %d lun %d tag %d"
 scsi_req_continue(int target, int lun, int tag) "target %d lun %d tag %d"
 scsi_req_continue_canceled(int target, int lun, int tag) "target %d lun %d tag %d"
-scsi_req_parsed(int target, int lun, int tag, int cmd, int mode, int xfer) "target %d lun %d tag %d command %d dir %d length %d"
-scsi_req_parsed_lba(int target, int lun, int tag, int cmd, uint64_t lba) "target %d lun %d tag %d command %d lba %"PRIu64
-scsi_req_parse_bad(int target, int lun, int tag, int cmd) "target %d lun %d tag %d command %d"
+scsi_req_parsed(int target, int lun, int tag, int cmd, int mode, int xfer) "target %d lun %d tag %d command 0x%x dir %d length %d"
+scsi_req_parsed_lba(int target, int lun, int tag, int cmd, uint64_t lba) "target %d lun %d tag %d command 0x%x lba %"PRIu64
+scsi_req_parse_bad(int target, int lun, int tag, int cmd) "target %d lun %d tag %d command 0x%x"
 scsi_req_build_sense(int target, int lun, int tag, int key, int asc, int ascq) "target %d lun %d tag %d key 0x%02x asc 0x%02x ascq 0x%02x"
 scsi_device_set_ua(int target, int lun, int key, int asc, int ascq) "target %d lun %d key 0x%02x asc 0x%02x ascq 0x%02x"
 scsi_report_luns(int target, int lun, int tag) "target %d lun %d tag %d"
-- 
2.20.1
