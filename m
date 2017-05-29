Received: from eggs.gnu.org ([2001:4830:134:3::10]:38799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFQHb-0006Ts-UV
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFQHa-00074N-9y
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:51 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:42840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dFQHZ-000725-VL
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:50 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 29 May 2017 21:24:12 +0200
Message-Id: <20170529192440.5990-2-aurelien@aurel32.net>
In-Reply-To: <20170529192440.5990-1-aurelien@aurel32.net>
References: <20170529192440.5990-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v2 01/29] target/s390x: remove dead code in
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

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/translate.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 97ca639a34..f7598184a6 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -5467,10 +5467,7 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
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
