Received: from eggs.gnu.org ([2001:4830:134:3::10]:54047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1egN4B-0000sG-CG
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 22:58:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1egN48-00055s-AA
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 22:58:39 -0500
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:45424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1egN48-00054z-53
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 22:58:36 -0500
Received: by mail-io0-x243.google.com with SMTP id p188so9913705ioe.12
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 19:58:35 -0800 (PST)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Mon, 29 Jan 2018 22:58:27 -0500
Message-Id: <20180130035827.2360-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH] Only print unknown command message in debug
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>

After using QEMU with the sb16 sound card I would see all these messages about some numbered command not being understood. It became annoying after a while to always see this message, so this patch changes things so that the message is only printed when DEBUG is defined. 

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 hw/audio/sb16.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 6ab2f6f89a..45b679c4df 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -632,7 +632,7 @@ static void command (SB16State *s, uint8_t cmd)
     return;
 
  warn:
-    dolog ("warning: command %#x,%d is not truly understood yet\n",
+    ldebug("warning: command %#x,%d is not truly understood yet\n",
            cmd, s->needed_bytes);
     goto exit;
 
-- 
2.14.3 (Apple Git-98)
