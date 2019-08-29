Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8907FC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EFFC2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFFC2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3I0E-0004iG-BO
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 06:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3Hcg-0005SD-Po
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3Hcd-0005p4-NM
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:45 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45424 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i3Hcc-0005Pf-Hg
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:43 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 3FE721A2200;
 Thu, 29 Aug 2019 12:25:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 0BF8A1A21B1;
 Thu, 29 Aug 2019 12:25:25 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 12:24:59 +0200
Message-Id: <1567074313-22998-18-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 17/31] target/mips: Clean up handling of CP0
 register 16
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

Clean up handling of CP0 register 16.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1567009614-12438-18-git-send-email-aleksandar.markovic@rt-rk.com>
---
 target/mips/cpu.h       |  3 ++-
 target/mips/translate.c | 60 ++++++++++++++++++++++++-------------------------
 2 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 8ecfdb3..d6405ad 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -375,7 +375,8 @@ typedef struct mips_def_t mips_def_t;
 #define CP0_REG16__CONFIG3         3
 #define CP0_REG16__CONFIG4         4
 #define CP0_REG16__CONFIG5         5
-#define CP0_REG00__CONFIG7         7
+#define CP0_REG16__CONFIG6         6
+#define CP0_REG16__CONFIG7         7
 /* CP0 Register 17 */
 #define CP0_REG17__LLADDR          0
 #define CP0_REG17__MAAR            1
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 238066f..4808640 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -7246,36 +7246,36 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_16:
         switch (sel) {
-        case 0:
+        case CP0_REG16__CONFIG:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config0));
             register_name = "Config";
             break;
-        case 1:
+        case CP0_REG16__CONFIG1:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config1));
             register_name = "Config1";
             break;
-        case 2:
+        case CP0_REG16__CONFIG2:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config2));
             register_name = "Config2";
             break;
-        case 3:
+        case CP0_REG16__CONFIG3:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config3));
             register_name = "Config3";
             break;
-        case 4:
+        case CP0_REG16__CONFIG4:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config4));
             register_name = "Config4";
             break;
-        case 5:
+        case CP0_REG16__CONFIG5:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config5));
             register_name = "Config5";
             break;
         /* 6,7 are implementation dependent */
-        case 6:
+        case CP0_REG16__CONFIG6:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config6));
             register_name = "Config6";
             break;
-        case 7:
+        case CP0_REG16__CONFIG7:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config7));
             register_name = "Config7";
             break;
@@ -7971,45 +7971,45 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_16:
         switch (sel) {
-        case 0:
+        case CP0_REG16__CONFIG:
             gen_helper_mtc0_config0(cpu_env, arg);
             register_name = "Config";
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             break;
-        case 1:
+        case CP0_REG16__CONFIG1:
             /* ignored, read only */
             register_name = "Config1";
             break;
-        case 2:
+        case CP0_REG16__CONFIG2:
             gen_helper_mtc0_config2(cpu_env, arg);
             register_name = "Config2";
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             break;
-        case 3:
+        case CP0_REG16__CONFIG3:
             gen_helper_mtc0_config3(cpu_env, arg);
             register_name = "Config3";
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             break;
-        case 4:
+        case CP0_REG16__CONFIG4:
             gen_helper_mtc0_config4(cpu_env, arg);
             register_name = "Config4";
             ctx->base.is_jmp = DISAS_STOP;
             break;
-        case 5:
+        case CP0_REG16__CONFIG5:
             gen_helper_mtc0_config5(cpu_env, arg);
             register_name = "Config5";
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             break;
         /* 6,7 are implementation dependent */
-        case 6:
+        case CP0_REG16__CONFIG6:
             /* ignored */
             register_name = "Config6";
             break;
-        case 7:
+        case CP0_REG16__CONFIG7:
             /* ignored */
             register_name = "Config7";
             break;
@@ -8718,36 +8718,36 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_16:
         switch (sel) {
-        case 0:
+        case CP0_REG16__CONFIG:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config0));
             register_name = "Config";
             break;
-        case 1:
+        case CP0_REG16__CONFIG1:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config1));
             register_name = "Config1";
             break;
-        case 2:
+        case CP0_REG16__CONFIG2:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config2));
             register_name = "Config2";
             break;
-        case 3:
+        case CP0_REG16__CONFIG3:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config3));
             register_name = "Config3";
             break;
-        case 4:
+        case CP0_REG16__CONFIG4:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config4));
             register_name = "Config4";
             break;
-        case 5:
+        case CP0_REG16__CONFIG5:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config5));
             register_name = "Config5";
             break;
        /* 6,7 are implementation dependent */
-        case 6:
+        case CP0_REG16__CONFIG6:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config6));
             register_name = "Config6";
             break;
-        case 7:
+        case CP0_REG16__CONFIG7:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config7));
             register_name = "Config7";
             break;
@@ -9434,33 +9434,33 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_16:
         switch (sel) {
-        case 0:
+        case CP0_REG16__CONFIG:
             gen_helper_mtc0_config0(cpu_env, arg);
             register_name = "Config";
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             break;
-        case 1:
+        case CP0_REG16__CONFIG1:
             /* ignored, read only */
             register_name = "Config1";
             break;
-        case 2:
+        case CP0_REG16__CONFIG2:
             gen_helper_mtc0_config2(cpu_env, arg);
             register_name = "Config2";
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             break;
-        case 3:
+        case CP0_REG16__CONFIG3:
             gen_helper_mtc0_config3(cpu_env, arg);
             register_name = "Config3";
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             break;
-        case 4:
+        case CP0_REG16__CONFIG4:
             /* currently ignored */
             register_name = "Config4";
             break;
-        case 5:
+        case CP0_REG16__CONFIG5:
             gen_helper_mtc0_config5(cpu_env, arg);
             register_name = "Config5";
             /* Stop translation as we may have switched the execution mode */
-- 
2.7.4


