Received: from eggs.gnu.org ([2001:4830:134:3::10]:56553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyW-0004oR-L5
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyV-0007KU-Rj
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:12 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhyV-0007KB-Kk
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:11 -0500
Received: by mail-wm0-x241.google.com with SMTP id b76so11199761wmg.1
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:16:11 -0800 (PST)
Received: from 640k.lan (dynamic-adsl-78-12-251-125.clienti.tiscali.it.
	[78.12.251.125]) by smtp.gmail.com with ESMTPSA id
	f125sm2751101wme.45.2017.12.20.09.16.09 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 20 Dec 2017 09:16:09 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:45 +0100
Message-Id: <1513790098-9815-34-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 33/46] scsi: replace hex constants with #defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Sense keys have nice #defines in scsi/constants.h, use them.

Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scsi/utils.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scsi/utils.c b/scsi/utils.c
index 61bc1a8..ddae650 100644
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
1.8.3.1
