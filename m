Received: from eggs.gnu.org ([2001:4830:134:3::10]:49793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYj3-0006PA-Eq
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYj2-0004ji-5a
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:09 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXYj2-0004jb-17
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:08 -0400
Received: by mail-qt0-x241.google.com with SMTP id p25so2578944qtp.2
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 13:04:07 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 10:02:39 -1000
Message-Id: <20170718200255.31647-15-rth@twiddle.net>
In-Reply-To: <20170718200255.31647-1-rth@twiddle.net>
References: <20170718200255.31647-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v3 14/30] target/sh4: Eliminate unused XREG
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 9473cbd..019862d 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -362,7 +362,6 @@ static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
 #define FREG(x)    cpu_fregs[(x) ^ ctx->fbank]
 
 #define XHACK(x) ((((x) & 1 ) << 4) | ((x) & 0xe))
-#define XREG(x)  FREG(XHACK(x))
 /* Assumes lsb of (x) is always 0 */
 #define DREG(x)  ((x) ^ ctx->fbank)
 
-- 
2.9.4
