Received: from eggs.gnu.org ([2001:4830:134:3::10]:50707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVy7o-0002ig-7F
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:14:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVy7l-0002am-Hy
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:14:52 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 24 Jan 2017 12:39:31 +0300
Message-Id: <a8802cd1d30fd153eac8f3a3ff9fdabf1cb069a5.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 27/31] scsi-disk: add 'fall through' comment to
 switch VERIFY cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Peter Maydell <peter.maydell@linaro.org>

Commit 166dbda7e131 added some extra cases to a switch() such
that the existing code is intended to fall through the new
case statements. It's clear from the commit that this is
intentional, but less clear to subsequent readers of the
code, and not clear at all to static analysis tools like
Coverity. Add a /* fall through */ comment to indicate the
intent. (Fixes CID 1368287.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/scsi/scsi-disk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index c080888..cc06fe5 100644
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
2.1.4
