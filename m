Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E131C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:39:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9224208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9224208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Hpo-0001m7-Hp
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 06:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3HcU-0005LD-Da
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3HcQ-0005OY-Pu
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:34 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45344 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i3HcQ-0005KP-60
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:30 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id B0ACA1A21B8;
 Thu, 29 Aug 2019 12:25:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 85BC11A2195;
 Thu, 29 Aug 2019 12:25:24 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 12:24:47 +0200
Message-Id: <1567074313-22998-6-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 05/31] target/mips: Clean up handling of CP0
 register 4
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Clean up handling of CP0 register 4.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1567009614-12438-6-git-send-email-aleksandar.markovic@rt-rk.com>
---
 target/mips/cpu.h       |  2 ++
 target/mips/translate.c | 36 ++++++++++++++++++++----------------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index d5b7103..496872e 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -305,7 +305,9 @@ typedef struct mips_def_t mips_def_t;
 #define CP0_REG03__TCOPT           7
 /* CP0 Register 04 */
 #define CP0_REG04__CONTEXT         0
+#define CP0_REG04__CONTEXTCONFIG   1
 #define CP0_REG04__USERLOCAL       2
+#define CP0_REG04__XCONTEXTCONFIG  3
 #define CP0_REG04__DBGCONTEXTID    4
 #define CP0_REG00__MMID            5
 /* CP0 Register 05 */
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 059f53e..9df59f1 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -6975,16 +6975,17 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_04:
         switch (sel) {
-        case 0:
+        case CP0_REG04__CONTEXT:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_Context));
             tcg_gen_ext32s_tl(arg, arg);
             register_name = "Context";
             break;
-        case 1:
-            /* gen_helper_mfc0_contextconfig(arg); - SmartMIPS ASE */
+        case CP0_REG04__CONTEXTCONFIG:
+            /* SmartMIPS ASE */
+            /* gen_helper_mfc0_contextconfig(arg); */
             register_name = "ContextConfig";
             goto cp0_unimplemented;
-        case 2:
+        case CP0_REG04__USERLOCAL:
             CP0_CHECK(ctx->ulri);
             tcg_gen_ld_tl(arg, cpu_env,
                           offsetof(CPUMIPSState, active_tc.CP0_UserLocal));
@@ -7710,15 +7711,16 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_04:
         switch (sel) {
-        case 0:
+        case CP0_REG04__CONTEXT:
             gen_helper_mtc0_context(cpu_env, arg);
             register_name = "Context";
             break;
-        case 1:
-//            gen_helper_mtc0_contextconfig(cpu_env, arg); /* SmartMIPS ASE */
+        case CP0_REG04__CONTEXTCONFIG:
+            /* SmartMIPS ASE */
+            /* gen_helper_mtc0_contextconfig(arg); */
             register_name = "ContextConfig";
             goto cp0_unimplemented;
-        case 2:
+        case CP0_REG04__USERLOCAL:
             CP0_CHECK(ctx->ulri);
             tcg_gen_st_tl(arg, cpu_env,
                           offsetof(CPUMIPSState, active_tc.CP0_UserLocal));
@@ -8455,15 +8457,16 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_04:
         switch (sel) {
-        case 0:
+        case CP0_REG04__CONTEXT:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_Context));
             register_name = "Context";
             break;
-        case 1:
-//            gen_helper_dmfc0_contextconfig(arg); /* SmartMIPS ASE */
+        case CP0_REG04__CONTEXTCONFIG:
+            /* SmartMIPS ASE */
+            /* gen_helper_dmfc0_contextconfig(arg); */
             register_name = "ContextConfig";
             goto cp0_unimplemented;
-        case 2:
+        case CP0_REG04__USERLOCAL:
             CP0_CHECK(ctx->ulri);
             tcg_gen_ld_tl(arg, cpu_env,
                           offsetof(CPUMIPSState, active_tc.CP0_UserLocal));
@@ -9168,15 +9171,16 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_04:
         switch (sel) {
-        case 0:
+        case CP0_REG04__CONTEXT:
             gen_helper_mtc0_context(cpu_env, arg);
             register_name = "Context";
             break;
-        case 1:
-//           gen_helper_mtc0_contextconfig(cpu_env, arg); /* SmartMIPS ASE */
+        case CP0_REG04__CONTEXTCONFIG:
+            /* SmartMIPS ASE */
+            /* gen_helper_dmtc0_contextconfig(arg); */
             register_name = "ContextConfig";
             goto cp0_unimplemented;
-        case 2:
+        case CP0_REG04__USERLOCAL:
             CP0_CHECK(ctx->ulri);
             tcg_gen_st_tl(arg, cpu_env,
                           offsetof(CPUMIPSState, active_tc.CP0_UserLocal));
-- 
2.7.4


