Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2346CC3A5A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:28:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE1402073F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1402073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3HfJ-0007JU-QU
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 06:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3HcS-0005HZ-C2
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3HcP-0005L2-Ad
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:31 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45232 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i3HcO-0005Fm-LD
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:29 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 8DE3F1A2177;
 Thu, 29 Aug 2019 12:25:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 69C611A2193;
 Thu, 29 Aug 2019 12:25:24 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 12:24:45 +0200
Message-Id: <1567074313-22998-4-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 03/31] target/mips: Clean up handling of CP0
 register 2
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

Clean up handling of CP0 register 2.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1567009614-12438-4-git-send-email-aleksandar.markovic@rt-rk.com>
---
 target/mips/cpu.h       |  7 ++++++
 target/mips/translate.c | 64 ++++++++++++++++++++++++-------------------------
 2 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 36e983a..466f72a 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -292,6 +292,13 @@ typedef struct mips_def_t mips_def_t;
 #define CP0_REG01__VPEOPT          7
 /* CP0 Register 02 */
 #define CP0_REG02__ENTRYLO0        0
+#define CP0_REG02__TCSTATUS        1
+#define CP0_REG02__TCBIND          2
+#define CP0_REG02__TCRESTART       3
+#define CP0_REG02__TCHALT          4
+#define CP0_REG02__TCCONTEXT       5
+#define CP0_REG02__TCSCHEDULE      6
+#define CP0_REG02__TCSCHEFBACK     7
 /* CP0 Register 03 */
 #define CP0_REG03__ENTRYLO1        0
 #define CP0_REG03__GLOBALNUM       1
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 97e0aec..66c6207 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -6889,7 +6889,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_02:
         switch (sel) {
-        case 0:
+        case CP0_REG02__ENTRYLO0:
             {
                 TCGv_i64 tmp = tcg_temp_new_i64();
                 tcg_gen_ld_i64(tmp, cpu_env,
@@ -6906,37 +6906,37 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             }
             register_name = "EntryLo0";
             break;
-        case 1:
+        case CP0_REG02__TCSTATUS:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_tcstatus(arg, cpu_env);
             register_name = "TCStatus";
             break;
-        case 2:
+        case CP0_REG02__TCBIND:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_tcbind(arg, cpu_env);
             register_name = "TCBind";
             break;
-        case 3:
+        case CP0_REG02__TCRESTART:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_tcrestart(arg, cpu_env);
             register_name = "TCRestart";
             break;
-        case 4:
+        case CP0_REG02__TCHALT:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_tchalt(arg, cpu_env);
             register_name = "TCHalt";
             break;
-        case 5:
+        case CP0_REG02__TCCONTEXT:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_tccontext(arg, cpu_env);
             register_name = "TCContext";
             break;
-        case 6:
+        case CP0_REG02__TCSCHEDULE:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_tcschedule(arg, cpu_env);
             register_name = "TCSchedule";
             break;
-        case 7:
+        case CP0_REG02__TCSCHEFBACK:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_tcschefback(arg, cpu_env);
             register_name = "TCScheFBack";
@@ -7650,41 +7650,41 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_02:
         switch (sel) {
-        case 0:
+        case CP0_REG02__ENTRYLO0:
             gen_helper_mtc0_entrylo0(cpu_env, arg);
             register_name = "EntryLo0";
             break;
-        case 1:
+        case CP0_REG02__TCSTATUS:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tcstatus(cpu_env, arg);
             register_name = "TCStatus";
             break;
-        case 2:
+        case CP0_REG02__TCBIND:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tcbind(cpu_env, arg);
             register_name = "TCBind";
             break;
-        case 3:
+        case CP0_REG02__TCRESTART:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tcrestart(cpu_env, arg);
             register_name = "TCRestart";
             break;
-        case 4:
+        case CP0_REG02__TCHALT:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tchalt(cpu_env, arg);
             register_name = "TCHalt";
             break;
-        case 5:
+        case CP0_REG02__TCCONTEXT:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tccontext(cpu_env, arg);
             register_name = "TCContext";
             break;
-        case 6:
+        case CP0_REG02__TCSCHEDULE:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tcschedule(cpu_env, arg);
             register_name = "TCSchedule";
             break;
-        case 7:
+        case CP0_REG02__TCSCHEFBACK:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tcschefback(cpu_env, arg);
             register_name = "TCScheFBack";
@@ -8395,41 +8395,41 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_02:
         switch (sel) {
-        case 0:
+        case CP0_REG02__ENTRYLO0:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EntryLo0));
             register_name = "EntryLo0";
             break;
-        case 1:
+        case CP0_REG02__TCSTATUS:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_tcstatus(arg, cpu_env);
             register_name = "TCStatus";
             break;
-        case 2:
+        case CP0_REG02__TCBIND:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mfc0_tcbind(arg, cpu_env);
             register_name = "TCBind";
             break;
-        case 3:
+        case CP0_REG02__TCRESTART:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_dmfc0_tcrestart(arg, cpu_env);
             register_name = "TCRestart";
             break;
-        case 4:
+        case CP0_REG02__TCHALT:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_dmfc0_tchalt(arg, cpu_env);
             register_name = "TCHalt";
             break;
-        case 5:
+        case CP0_REG02__TCCONTEXT:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_dmfc0_tccontext(arg, cpu_env);
             register_name = "TCContext";
             break;
-        case 6:
+        case CP0_REG02__TCSCHEDULE:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_dmfc0_tcschedule(arg, cpu_env);
             register_name = "TCSchedule";
             break;
-        case 7:
+        case CP0_REG02__TCSCHEFBACK:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_dmfc0_tcschefback(arg, cpu_env);
             register_name = "TCScheFBack";
@@ -9108,41 +9108,41 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_02:
         switch (sel) {
-        case 0:
+        case CP0_REG02__ENTRYLO0:
             gen_helper_dmtc0_entrylo0(cpu_env, arg);
             register_name = "EntryLo0";
             break;
-        case 1:
+        case CP0_REG02__TCSTATUS:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tcstatus(cpu_env, arg);
             register_name = "TCStatus";
             break;
-        case 2:
+        case CP0_REG02__TCBIND:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tcbind(cpu_env, arg);
             register_name = "TCBind";
             break;
-        case 3:
+        case CP0_REG02__TCRESTART:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tcrestart(cpu_env, arg);
             register_name = "TCRestart";
             break;
-        case 4:
+        case CP0_REG02__TCHALT:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tchalt(cpu_env, arg);
             register_name = "TCHalt";
             break;
-        case 5:
+        case CP0_REG02__TCCONTEXT:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tccontext(cpu_env, arg);
             register_name = "TCContext";
             break;
-        case 6:
+        case CP0_REG02__TCSCHEDULE:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tcschedule(cpu_env, arg);
             register_name = "TCSchedule";
             break;
-        case 7:
+        case CP0_REG02__TCSCHEFBACK:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
             gen_helper_mtc0_tcschefback(cpu_env, arg);
             register_name = "TCScheFBack";
-- 
2.7.4


