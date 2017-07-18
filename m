Received: from eggs.gnu.org ([2001:4830:134:3::10]:48119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaOY-0004ka-To
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaOY-0003WO-6x
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:51:06 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dXaOY-0003V5-1A
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:51:06 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 18 Jul 2017 23:50:37 +0200
Message-Id: <20170718215050.3812-19-aurelien@aurel32.net>
In-Reply-To: <20170718215050.3812-1-aurelien@aurel32.net>
References: <20170718215050.3812-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PULL 18/31] target/sh4: Eliminate unused XREG macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>

From: Richard Henderson <rth@twiddle.net>

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20170718200255.31647-15-rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index bc6f33970b..e5b88ac568 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -357,7 +357,6 @@ static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
 #define FREG(x)    cpu_fregs[(x) ^ ctx->fbank]
 
 #define XHACK(x) ((((x) & 1 ) << 4) | ((x) & 0xe))
-#define XREG(x)  FREG(XHACK(x))
 /* Assumes lsb of (x) is always 0 */
 #define DREG(x)  ((x) ^ ctx->fbank)
 
-- 
2.11.0
