Received: from eggs.gnu.org ([209.51.188.92]:40428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jing.zhang.nokia@gmail.com>) id 1guUkQ-0007t4-O9
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 23:05:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jing.zhang.nokia@gmail.com>) id 1guUfj-0007d9-9p
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 23:00:19 -0500
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142]:37513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jing.zhang.nokia@gmail.com>)
	id 1guUfj-0007be-1Y
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 23:00:19 -0500
Received: by mail-it1-x142.google.com with SMTP id l131so20170201ita.2
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 20:00:18 -0800 (PST)
From: jing.zhang.nokia@gmail.com
Date: Thu, 14 Feb 2019 22:56:50 -0500
Message-Id: <1550203010-2682-1-git-send-email-jing.zhang.nokia@gmail.com>
Subject: [Qemu-devel] [PATCH] Increase the number of RARP packets sent after
 live migration from 5 to 10.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jing Zhang <jing.c.zhang@nokia.com>

From: Jing Zhang <jing.c.zhang@nokia.com>

Signed-off-by: Jing Zhang <jing.c.zhang@nokia.com>
---
 include/migration/misc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 4ebf24c..353c77d 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -28,7 +28,7 @@ void blk_mig_init(void);
 static inline void blk_mig_init(void) {}
 #endif
 
-#define SELF_ANNOUNCE_ROUNDS 5
+#define SELF_ANNOUNCE_ROUNDS 10
 
 static inline
 int64_t self_announce_delay(int round)
-- 
2.5.5
