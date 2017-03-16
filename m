Received: from eggs.gnu.org ([2001:4830:134:3::10]:53750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rimjhim0107@gmail.com>) id 1coTK1-0007Ck-LY
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 07:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rimjhim0107@gmail.com>) id 1coTJy-0002fb-IN
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 07:11:57 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:36333)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rimjhim0107@gmail.com>)
	id 1coTJy-0002fE-C7
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 07:11:54 -0400
Received: by mail-pf0-x243.google.com with SMTP id r137so1632089pfr.3
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 04:11:54 -0700 (PDT)
From: Anishka0107 <rimjhim0107@gmail.com>
Date: Thu, 16 Mar 2017 11:11:33 +0530
Message-Id: <1489642893-4504-1-git-send-email-rimjhim0107@gmail.com>
Subject: [Qemu-devel] [PATCH v2] puv3: always compile-check debug printf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, stefanha@redhat.com, Anishka0107 <rimjhim0107@gmail.com>

     To prevent bitrot of the format string of the debug statement, files with
     conditional debug statements should ensure that printf is compiled always,
     and enclosed within if(0) statements and not in #ifdef.

Signed-off-by: Anishka Gupta <rimjhim0107@gmail.com>
---
 include/hw/unicore32/puv3.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/unicore32/puv3.h b/include/hw/unicore32/puv3.h
index e268484..9fdf0a1 100644
--- a/include/hw/unicore32/puv3.h
+++ b/include/hw/unicore32/puv3.h
@@ -46,8 +46,7 @@
 #define DPRINTF(fmt, ...)
     if (DEBUG_PUV3) {
         fprintf(stderr, "%s: " fmt , __func__, ## __VA_ARGS__)
-    }
-    else {
+    } else {
         do {} while (0)
     }
 
-- 
2.5.0
