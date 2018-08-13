Received: from eggs.gnu.org ([2001:4830:134:3::10]:59390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH37-0005Or-7w
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH33-00072l-4C
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:37 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55744 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fpH32-00071c-PW
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:33 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 13 Aug 2018 19:52:36 +0200
Message-Id: <1534182832-554-12-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 11/87] target/mips: Implement CP0 Config1.WR
 bit functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Stefan Markovic <smarkovic@wavecomp.com>

Add testing Config1.WR bit into watch exception handling logic.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index af9714b..219de72 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5562,6 +5562,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 5:
         case 6:
         case 7:
+            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_1e0i(mfc0_watchlo, arg, sel);
             rn = "WatchLo";
             break;
@@ -5579,6 +5580,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 5:
         case 6:
         case 7:
+            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_1e0i(mfc0_watchhi, arg, sel);
             rn = "WatchHi";
             break;
@@ -6261,6 +6263,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 5:
         case 6:
         case 7:
+            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_0e1i(mtc0_watchlo, arg, sel);
             rn = "WatchLo";
             break;
@@ -6278,6 +6281,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 5:
         case 6:
         case 7:
+            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_0e1i(mtc0_watchhi, arg, sel);
             rn = "WatchHi";
             break;
@@ -6964,6 +6968,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 5:
         case 6:
         case 7:
+            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_1e0i(dmfc0_watchlo, arg, sel);
             rn = "WatchLo";
             break;
@@ -6981,6 +6986,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 5:
         case 6:
         case 7:
+            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_1e0i(mfc0_watchhi, arg, sel);
             rn = "WatchHi";
             break;
@@ -7645,6 +7651,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 5:
         case 6:
         case 7:
+            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_0e1i(mtc0_watchlo, arg, sel);
             rn = "WatchLo";
             break;
@@ -7662,6 +7669,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 5:
         case 6:
         case 7:
+            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_0e1i(mtc0_watchhi, arg, sel);
             rn = "WatchHi";
             break;
-- 
2.7.4
