Received: from eggs.gnu.org ([2001:4830:134:3::10]:55100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwZ-0005cu-A4
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzwY-0001JT-Fl
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:15 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:37364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dDzwY-0001IY-9x
	for qemu-devel@nongnu.org; Thu, 25 May 2017 17:05:14 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Thu, 25 May 2017 23:04:43 +0200
Message-Id: <20170525210508.4910-2-aurelien@aurel32.net>
In-Reply-To: <20170525210508.4910-1-aurelien@aurel32.net>
References: <20170525210508.4910-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 01/26] target/s390x: remove dead code in
 translate.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/translate.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 4bd16d9f99..850df26ce1 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -5455,10 +5455,7 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
             gen_io_start();
         }
 
-        status = NO_EXIT;
-        if (status == NO_EXIT) {
-            status = translate_one(env, &dc);
-        }
+        status = translate_one(env, &dc);
 
         /* If we reach a page boundary, are single stepping,
            or exhaust instruction count, stop generation.  */
-- 
2.11.0
