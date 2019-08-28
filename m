Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D444C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 16:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65576208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 16:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65576208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i315n-0000L5-8w
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 12:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i30mz-00076w-1D
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i30mx-00080B-60
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:27:16 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55328 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i30mw-0007mV-PA
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:27:15 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 6A7BC1A22BC;
 Wed, 28 Aug 2019 18:27:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 14A761A22A0;
 Wed, 28 Aug 2019 18:27:00 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 18:26:37 +0200
Message-Id: <1567009614-12438-14-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567009614-12438-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1567009614-12438-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v2 13/30] target/mips: Clean up handling of CP0
 register 12
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
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Clean up handling of CP0 register 12.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       |  3 +++
 target/mips/translate.c | 32 ++++++++++++++++----------------
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 42f3c77..ec7285d 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -352,6 +352,9 @@ typedef struct mips_def_t mips_def_t;
 #define CP0_REG12__STATUS          0
 #define CP0_REG12__INTCTL          1
 #define CP0_REG12__SRSCTL          2
+#define CP0_REG12__SRSMAP          3
+#define CP0_REG12__VIEW_IPL        4
+#define CP0_REG12__SRSMAP2         5
 #define CP0_REG12__GUESTCTL0       6
 #define CP0_REG12__GTOFFSET        7
 /* CP0 Register 13 */
diff --git a/target/mips/translate.c b/target/mips/translate.c
index d92bb07..3240d25 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -7225,21 +7225,21 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_12:
         switch (sel) {
-        case 0:
+        case CP0_REG12__STATUS:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Status));
             register_name = "Status";
             break;
-        case 1:
+        case CP0_REG12__INTCTL:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_IntCtl));
             register_name = "IntCtl";
             break;
-        case 2:
+        case CP0_REG12__SRSCTL:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSCtl));
             register_name = "SRSCtl";
             break;
-        case 3:
+        case CP0_REG12__SRSMAP:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSMap));
             register_name = "SRSMap";
@@ -7946,7 +7946,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_12:
         switch (sel) {
-        case 0:
+        case CP0_REG12__STATUS:
             save_cpu_state(ctx, 1);
             gen_helper_mtc0_status(cpu_env, arg);
             /* DISAS_STOP isn't good enough here, hflags may have changed. */
@@ -7954,21 +7954,21 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             ctx->base.is_jmp = DISAS_EXIT;
             register_name = "Status";
             break;
-        case 1:
+        case CP0_REG12__INTCTL:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_intctl(cpu_env, arg);
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             register_name = "IntCtl";
             break;
-        case 2:
+        case CP0_REG12__SRSCTL:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_srsctl(cpu_env, arg);
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             register_name = "SRSCtl";
             break;
-        case 3:
+        case CP0_REG12__SRSMAP:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mtc0_store32(arg, offsetof(CPUMIPSState, CP0_SRSMap));
             /* Stop translation as we may have switched the execution mode */
@@ -8714,21 +8714,21 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_12:
         switch (sel) {
-        case 0:
+        case CP0_REG12__STATUS:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Status));
             register_name = "Status";
             break;
-        case 1:
+        case CP0_REG12__INTCTL:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_IntCtl));
             register_name = "IntCtl";
             break;
-        case 2:
+        case CP0_REG12__SRSCTL:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSCtl));
             register_name = "SRSCtl";
             break;
-        case 3:
+        case CP0_REG12__SRSMAP:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSMap));
             register_name = "SRSMap";
@@ -9423,7 +9423,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_12:
         switch (sel) {
-        case 0:
+        case CP0_REG12__STATUS:
             save_cpu_state(ctx, 1);
             gen_helper_mtc0_status(cpu_env, arg);
             /* DISAS_STOP isn't good enough here, hflags may have changed. */
@@ -9431,21 +9431,21 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             ctx->base.is_jmp = DISAS_EXIT;
             register_name = "Status";
             break;
-        case 1:
+        case CP0_REG12__INTCTL:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_intctl(cpu_env, arg);
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             register_name = "IntCtl";
             break;
-        case 2:
+        case CP0_REG12__SRSCTL:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_srsctl(cpu_env, arg);
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             register_name = "SRSCtl";
             break;
-        case 3:
+        case CP0_REG12__SRSMAP:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mtc0_store32(arg, offsetof(CPUMIPSState, CP0_SRSMap));
             /* Stop translation as we may have switched the execution mode */
-- 
2.7.4


