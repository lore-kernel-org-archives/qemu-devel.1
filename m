Received: from eggs.gnu.org ([2001:4830:134:3::10]:54379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqMRJ-0003Nv-Hg
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:52:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqMRG-0008Lf-DB
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:52:05 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56554 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fqMRG-0008LL-5t
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:52:02 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 16 Aug 2018 19:49:00 +0200
Message-Id: <1534441747-4197-9-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534441747-4197-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534441747-4197-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 08/15] target/mips: Implement CP0 Config1.WR
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
Cc: peter.maydell@linaro.org

From: Stefan Markovic <smarkovic@wavecomp.com>

Add testing Config1.WR bit into watch exception handling logic.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index ae3aaab..395368b 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5521,6 +5521,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 5:
         case 6:
         case 7:
+            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_1e0i(mfc0_watchlo, arg, sel);
             rn = "WatchLo";
             break;
@@ -5538,6 +5539,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 5:
         case 6:
         case 7:
+            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_1e0i(mfc0_watchhi, arg, sel);
             rn = "WatchHi";
             break;
@@ -6220,6 +6222,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 5:
         case 6:
         case 7:
+            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_0e1i(mtc0_watchlo, arg, sel);
             rn = "WatchLo";
             break;
@@ -6237,6 +6240,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 5:
         case 6:
         case 7:
+            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_0e1i(mtc0_watchhi, arg, sel);
             rn = "WatchHi";
             break;
@@ -6923,6 +6927,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 5:
         case 6:
         case 7:
+            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_1e0i(dmfc0_watchlo, arg, sel);
             rn = "WatchLo";
             break;
@@ -6940,6 +6945,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 5:
         case 6:
         case 7:
+            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_1e0i(mfc0_watchhi, arg, sel);
             rn = "WatchHi";
             break;
@@ -7604,6 +7610,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 5:
         case 6:
         case 7:
+            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_0e1i(mtc0_watchlo, arg, sel);
             rn = "WatchLo";
             break;
@@ -7621,6 +7628,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 5:
         case 6:
         case 7:
+            CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_0e1i(mtc0_watchhi, arg, sel);
             rn = "WatchHi";
             break;
-- 
2.7.4
