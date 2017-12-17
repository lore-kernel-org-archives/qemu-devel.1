Received: from eggs.gnu.org ([2001:4830:134:3::10]:40298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eQRWN-00076o-G2
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 00:29:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eQRWL-0004w0-KU
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 00:29:55 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:39638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eQRWL-0004vf-DP
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 00:29:53 -0500
Received: by mail-wr0-x242.google.com with SMTP id a41so11250732wra.6
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 21:29:53 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 17 Dec 2017 06:29:45 +0100
Message-Id: <20171217052945.12782-2-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] scsi: replace hex constants with #defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Sense keys have nice #defines in scsi/constants.h, use them.

Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scsi/utils.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scsi/utils.c b/scsi/utils.c
index 61bc1a8e2b..ddae650a99 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -339,16 +339,16 @@ int scsi_convert_sense(uint8_t *in_buf, int in_len,
 int scsi_sense_to_errno(int key, int asc, int ascq)
 {
     switch (key) {
-    case 0x00: /* NO SENSE */
-    case 0x01: /* RECOVERED ERROR */
-    case 0x06: /* UNIT ATTENTION */
+    case NO_SENSE:
+    case RECOVERED_ERROR:
+    case UNIT_ATTENTION:
         /* These sense keys are not errors */
         return 0;
-    case 0x0b: /* COMMAND ABORTED */
+    case ABORTED_COMMAND: /* COMMAND ABORTED */
         return ECANCELED;
-    case 0x02: /* NOT READY */
-    case 0x05: /* ILLEGAL REQUEST */
-    case 0x07: /* DATA PROTECTION */
+    case NOT_READY:
+    case ILLEGAL_REQUEST:
+    case DATA_PROTECT:
         /* Parse ASCQ */
         break;
     default:
-- 
2.14.3
