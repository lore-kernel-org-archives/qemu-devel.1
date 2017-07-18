Received: from eggs.gnu.org ([2001:4830:134:3::10]:50030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYjQ-0006oO-DP
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYjP-00052g-Ef
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:32 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXYjP-00052P-9l
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:31 -0400
Received: by mail-qt0-x243.google.com with SMTP id 50so2613564qtz.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 13:04:31 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 10:02:49 -1000
Message-Id: <20170718200255.31647-25-rth@twiddle.net>
In-Reply-To: <20170718200255.31647-1-rth@twiddle.net>
References: <20170718200255.31647-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v3 24/30] target/sh4: Implement fpchg
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
 target/sh4/translate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 239a0d9..65cc7d1 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -486,6 +486,11 @@ static void _decode_opc(DisasContext * ctx)
         tcg_gen_xori_i32(cpu_fpscr, cpu_fpscr, FPSCR_SZ);
 	ctx->bstate = BS_STOP;
 	return;
+    case 0xf7fd:                /* fpchg */
+        CHECK_SH4A
+        tcg_gen_xori_i32(cpu_fpscr, cpu_fpscr, FPSCR_PR);
+        ctx->bstate = BS_STOP;
+        return;
     case 0x0009:		/* nop */
 	return;
     case 0x001b:		/* sleep */
-- 
2.9.4
