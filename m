Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D617C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22CE6208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22CE6208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Hpw-0001yU-9L
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 06:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3Hcd-0005RI-NH
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3Hcb-0005kf-NM
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:43 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45362 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i3Hca-0005Lb-JT
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:41 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 1505D1A21BE;
 Thu, 29 Aug 2019 12:25:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id DC4B71A21E3;
 Thu, 29 Aug 2019 12:25:24 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 12:24:55 +0200
Message-Id: <1567074313-22998-14-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 13/31] target/mips: Clean up handling of CP0
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Clean up handling of CP0 register 12.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1567009614-12438-14-git-send-email-aleksandar.markovic@rt-rk.com>
---
 target/mips/cpu.h       |  3 +++
 target/mips/translate.c | 32 ++++++++++++++++----------------
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 3797bdc..061effb 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -350,6 +350,9 @@ typedef struct mips_def_t mips_def_t;
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
index b5d5994..fb9c719 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -7177,21 +7177,21 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -7893,7 +7893,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_12:
         switch (sel) {
-        case 0:
+        case CP0_REG12__STATUS:
             save_cpu_state(ctx, 1);
             gen_helper_mtc0_status(cpu_env, arg);
             /* DISAS_STOP isn't good enough here, hflags may have changed. */
@@ -7901,21 +7901,21 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -8652,21 +8652,21 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -9356,7 +9356,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_12:
         switch (sel) {
-        case 0:
+        case CP0_REG12__STATUS:
             save_cpu_state(ctx, 1);
             gen_helper_mtc0_status(cpu_env, arg);
             /* DISAS_STOP isn't good enough here, hflags may have changed. */
@@ -9364,21 +9364,21 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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


