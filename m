Received: from eggs.gnu.org ([2001:4830:134:3::10]:58046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckEru-0006kl-8c
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:57:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckErt-0008BN-Dk
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:57:26 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckErt-0008BA-7u
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:57:25 -0500
Received: by mail-qk0-x242.google.com with SMTP id g129so6729831qkd.1
	for <qemu-devel@nongnu.org>; Sat, 04 Mar 2017 10:57:25 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat,  4 Mar 2017 15:56:49 -0300
Message-Id: <20170304185652.10675-3-f4bug@amsat.org>
In-Reply-To: <20170304185652.10675-1-f4bug@amsat.org>
References: <20170304185652.10675-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/5] target-mips: remove old & unuseful comments
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
 target/mips/translate.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 8b4a072ecb..1fe0ff39f2 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5137,7 +5137,6 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
 //            gen_helper_mfc0_contextconfig(arg); /* SmartMIPS ASE */
             rn = "ContextConfig";
             goto cp0_unimplemented;
-//            break;
         case 2:
             CP0_CHECK(ctx->ulri);
             tcg_gen_ld32s_tl(arg, cpu_env,
@@ -5791,7 +5790,6 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
 //            gen_helper_mtc0_contextconfig(cpu_env, arg); /* SmartMIPS ASE */
             rn = "ContextConfig";
             goto cp0_unimplemented;
-//            break;
         case 2:
             CP0_CHECK(ctx->ulri);
             tcg_gen_st_tl(arg, cpu_env,
@@ -6454,7 +6452,6 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
 //            gen_helper_dmfc0_contextconfig(arg); /* SmartMIPS ASE */
             rn = "ContextConfig";
             goto cp0_unimplemented;
-//            break;
         case 2:
             CP0_CHECK(ctx->ulri);
             tcg_gen_ld_tl(arg, cpu_env,
@@ -7092,7 +7089,6 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
 //           gen_helper_mtc0_contextconfig(cpu_env, arg); /* SmartMIPS ASE */
             rn = "ContextConfig";
             goto cp0_unimplemented;
-//           break;
         case 2:
             CP0_CHECK(ctx->ulri);
             tcg_gen_st_tl(arg, cpu_env,
-- 
2.11.0
