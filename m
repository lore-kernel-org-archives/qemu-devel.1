Received: from eggs.gnu.org ([2001:4830:134:3::10]:58094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckEry-0006oW-EP
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:57:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckErx-0008DG-Hw
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:57:30 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:32979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckErx-0008D5-Dz
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:57:29 -0500
Received: by mail-qk0-x244.google.com with SMTP id j127so16936612qke.0
	for <qemu-devel@nongnu.org>; Sat, 04 Mar 2017 10:57:29 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat,  4 Mar 2017 15:56:50 -0300
Message-Id: <20170304185652.10675-4-f4bug@amsat.org>
In-Reply-To: <20170304185652.10675-1-f4bug@amsat.org>
References: <20170304185652.10675-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/5] target-mips: log bad coprocessor0 register
 accesses with LOG_UNIMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/translate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 1fe0ff39f2..5c030a90cd 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4872,7 +4872,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     return;
 
 cp0_unimplemented:
-    LOG_DISAS("mfhc0 %s (reg %d sel %d)\n", rn, reg, sel);
+    qemu_log_mask(LOG_UNIMP, "mfhc0 %s (reg %d sel %d)\n", rn, reg, sel);
     tcg_gen_movi_tl(arg, 0);
 }
 
@@ -4944,7 +4944,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
 
     (void)rn; /* avoid a compiler warning */
 cp0_unimplemented:
-    LOG_DISAS("mthc0 %s (reg %d sel %d)\n", rn, reg, sel);
+    qemu_log_mask(LOG_UNIMP, "mthc0 %s (reg %d sel %d)\n", rn, reg, sel);
 }
 
 static inline void gen_mfc0_unimplemented(DisasContext *ctx, TCGv arg)
@@ -5627,7 +5627,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     return;
 
 cp0_unimplemented:
-    LOG_DISAS("mfc0 %s (reg %d sel %d)\n", rn, reg, sel);
+    qemu_log_mask(LOG_UNIMP, "mfc0 %s (reg %d sel %d)\n", rn, reg, sel);
     gen_mfc0_unimplemented(ctx, arg);
 }
 
@@ -6294,7 +6294,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     return;
 
 cp0_unimplemented:
-    LOG_DISAS("mtc0 %s (reg %d sel %d)\n", rn, reg, sel);
+    qemu_log_mask(LOG_UNIMP, "mtc0 %s (reg %d sel %d)\n", rn, reg, sel);
 }
 
 #if defined(TARGET_MIPS64)
@@ -6928,7 +6928,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     return;
 
 cp0_unimplemented:
-    LOG_DISAS("dmfc0 %s (reg %d sel %d)\n", rn, reg, sel);
+    qemu_log_mask(LOG_UNIMP, "dmfc0 %s (reg %d sel %d)\n", rn, reg, sel);
     gen_mfc0_unimplemented(ctx, arg);
 }
 
@@ -7593,7 +7593,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     return;
 
 cp0_unimplemented:
-    LOG_DISAS("dmtc0 %s (reg %d sel %d)\n", rn, reg, sel);
+    qemu_log_mask(LOG_UNIMP, "dmtc0 %s (reg %d sel %d)\n", rn, reg, sel);
 }
 #endif /* TARGET_MIPS64 */
 
-- 
2.11.0
