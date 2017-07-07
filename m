Received: from eggs.gnu.org ([2001:4830:134:3::10]:34870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIwT-00034d-90
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIwS-0000uy-ML
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:24:25 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dTIwS-0000uZ-HU
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:24:24 -0400
Received: by mail-qt0-x243.google.com with SMTP id v31so2716690qtb.3
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 19:24:24 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  6 Jul 2017 16:20:58 -1000
Message-Id: <20170707022111.21836-15-rth@twiddle.net>
In-Reply-To: <20170707022111.21836-1-rth@twiddle.net>
References: <20170707022111.21836-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 14/27] target/sh4: Eliminate unused XREG
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
Cc: aurelien@aurel32.net, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index fc743da..b6c3ff9 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -369,7 +369,6 @@ static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
 #define FREG(x)    cpu_fregs[(x) ^ ctx->fbank]
 
 #define XHACK(x) ((((x) & 1 ) << 4) | ((x) & 0xe))
-#define XREG(x)  FREG(XHACK(x))
 /* Assumes lsb of (x) is always 0 */
 #define DREG(x)  ((x) ^ ctx->fbank)
 
-- 
2.9.4
