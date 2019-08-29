Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BE9C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:32:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE71D2073F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE71D2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Hj9-0002df-6K
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 06:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3HcU-0005Le-P0
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3HcQ-0005Or-RM
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:34 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45349 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i3HcQ-0005Kh-7G
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:30 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id D16A31A2195;
 Thu, 29 Aug 2019 12:25:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 9BF771A2191;
 Thu, 29 Aug 2019 12:25:24 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 12:24:49 +0200
Message-Id: <1567074313-22998-8-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 07/31] target/mips: Clean up handling of CP0
 register 6
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

Clean up handling of CP0 register 6.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1567009614-12438-8-git-send-email-aleksandar.markovic@rt-rk.com>
---
 target/mips/cpu.h       |  6 ++++++
 target/mips/translate.c | 56 ++++++++++++++++++++++++-------------------------
 2 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index ed1a974..a0c6a6f 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -321,6 +321,12 @@ typedef struct mips_def_t mips_def_t;
 #define CP0_REG05__PWSIZE          7
 /* CP0 Register 06 */
 #define CP0_REG06__WIRED           0
+#define CP0_REG06__SRSCONF0        1
+#define CP0_REG06__SRSCONF1        2
+#define CP0_REG06__SRSCONF2        3
+#define CP0_REG06__SRSCONF3        4
+#define CP0_REG06__SRSCONF4        5
+#define CP0_REG06__PWCTL           6
 /* CP0 Register 07 */
 #define CP0_REG07__HWRENA          0
 /* CP0 Register 08 */
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 19f86f2..a914fe4 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -7046,36 +7046,36 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_06:
         switch (sel) {
-        case 0:
+        case CP0_REG06__WIRED:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Wired));
             register_name = "Wired";
             break;
-        case 1:
+        case CP0_REG06__SRSCONF0:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSConf0));
             register_name = "SRSConf0";
             break;
-        case 2:
+        case CP0_REG06__SRSCONF1:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSConf1));
             register_name = "SRSConf1";
             break;
-        case 3:
+        case CP0_REG06__SRSCONF2:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSConf2));
             register_name = "SRSConf2";
             break;
-        case 4:
+        case CP0_REG06__SRSCONF3:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSConf3));
             register_name = "SRSConf3";
             break;
-        case 5:
+        case CP0_REG06__SRSCONF4:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSConf4));
             register_name = "SRSConf4";
             break;
-        case 6:
+        case CP0_REG06__PWCTL:
             check_pw(ctx);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PWCtl));
             register_name = "PWCtl";
@@ -7778,36 +7778,36 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_06:
         switch (sel) {
-        case 0:
+        case CP0_REG06__WIRED:
             gen_helper_mtc0_wired(cpu_env, arg);
             register_name = "Wired";
             break;
-        case 1:
+        case CP0_REG06__SRSCONF0:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_srsconf0(cpu_env, arg);
             register_name = "SRSConf0";
             break;
-        case 2:
+        case CP0_REG06__SRSCONF1:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_srsconf1(cpu_env, arg);
             register_name = "SRSConf1";
             break;
-        case 3:
+        case CP0_REG06__SRSCONF2:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_srsconf2(cpu_env, arg);
             register_name = "SRSConf2";
             break;
-        case 4:
+        case CP0_REG06__SRSCONF3:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_srsconf3(cpu_env, arg);
             register_name = "SRSConf3";
             break;
-        case 5:
+        case CP0_REG06__SRSCONF4:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_srsconf4(cpu_env, arg);
             register_name = "SRSConf4";
             break;
-        case 6:
+        case CP0_REG06__PWCTL:
             check_pw(ctx);
             gen_helper_mtc0_pwctl(cpu_env, arg);
             register_name = "PWCtl";
@@ -8523,36 +8523,36 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_06:
         switch (sel) {
-        case 0:
+        case CP0_REG06__WIRED:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Wired));
             register_name = "Wired";
             break;
-        case 1:
+        case CP0_REG06__SRSCONF0:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSConf0));
             register_name = "SRSConf0";
             break;
-        case 2:
+        case CP0_REG06__SRSCONF1:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSConf1));
             register_name = "SRSConf1";
             break;
-        case 3:
+        case CP0_REG06__SRSCONF2:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSConf2));
             register_name = "SRSConf2";
             break;
-        case 4:
+        case CP0_REG06__SRSCONF3:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSConf3));
             register_name = "SRSConf3";
             break;
-        case 5:
+        case CP0_REG06__SRSCONF4:
             check_insn(ctx, ISA_MIPS32R2);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SRSConf4));
             register_name = "SRSConf4";
             break;
-        case 6:
+        case CP0_REG06__PWCTL:
             check_pw(ctx);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PWCtl));
             register_name = "PWCtl";
@@ -9237,36 +9237,36 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_06:
         switch (sel) {
-        case 0:
+        case CP0_REG06__WIRED:
             gen_helper_mtc0_wired(cpu_env, arg);
             register_name = "Wired";
             break;
-        case 1:
+        case CP0_REG06__SRSCONF0:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_srsconf0(cpu_env, arg);
             register_name = "SRSConf0";
             break;
-        case 2:
+        case CP0_REG06__SRSCONF1:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_srsconf1(cpu_env, arg);
             register_name = "SRSConf1";
             break;
-        case 3:
+        case CP0_REG06__SRSCONF2:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_srsconf2(cpu_env, arg);
             register_name = "SRSConf2";
             break;
-        case 4:
+        case CP0_REG06__SRSCONF3:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_srsconf3(cpu_env, arg);
             register_name = "SRSConf3";
             break;
-        case 5:
+        case CP0_REG06__SRSCONF4:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_srsconf4(cpu_env, arg);
             register_name = "SRSConf4";
             break;
-        case 6:
+        case CP0_REG06__PWCTL:
             check_pw(ctx);
             gen_helper_mtc0_pwctl(cpu_env, arg);
             register_name = "PWCtl";
-- 
2.7.4


