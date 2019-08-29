Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1B8C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C55F423405
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55F423405
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Hn8-0006Ld-Gb
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 06:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3Hcd-0005RJ-N5
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3Hcb-0005kl-Nh
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:42 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45360 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i3Hca-0005LT-K0
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:41 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id E7C0B1A2191;
 Thu, 29 Aug 2019 12:25:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id ACCB51A21B1;
 Thu, 29 Aug 2019 12:25:24 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 12:24:51 +0200
Message-Id: <1567074313-22998-10-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 09/31] target/mips: Clean up handling of CP0
 register 8
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

Clean up handling of CP0 register 8.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1567009614-12438-10-git-send-email-aleksandar.markovic@rt-rk.com>
---
 target/mips/cpu.h       |  1 +
 target/mips/translate.c | 32 ++++++++++++++++----------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index a0c6a6f..50a7205 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -333,6 +333,7 @@ typedef struct mips_def_t mips_def_t;
 #define CP0_REG08__BADVADDR        0
 #define CP0_REG08__BADINSTR        1
 #define CP0_REG08__BADINSTRP       2
+#define CP0_REG08__BADINSTRX       3
 /* CP0 Register 09 */
 #define CP0_REG09__COUNT           0
 #define CP0_REG09__SAARI           6
diff --git a/target/mips/translate.c b/target/mips/translate.c
index cf2ba5a..d4faa75 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -7097,22 +7097,22 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_08:
         switch (sel) {
-        case 0:
+        case CP0_REG08__BADVADDR:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_BadVAddr));
             tcg_gen_ext32s_tl(arg, arg);
             register_name = "BadVAddr";
             break;
-        case 1:
+        case CP0_REG08__BADINSTR:
             CP0_CHECK(ctx->bi);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstr));
             register_name = "BadInstr";
             break;
-        case 2:
+        case CP0_REG08__BADINSTRP:
             CP0_CHECK(ctx->bp);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrP));
             register_name = "BadInstrP";
             break;
-        case 3:
+        case CP0_REG08__BADINSTRX:
             CP0_CHECK(ctx->bi);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrX));
             tcg_gen_andi_tl(arg, arg, ~0xffff);
@@ -7830,19 +7830,19 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_08:
         switch (sel) {
-        case 0:
+        case CP0_REG08__BADVADDR:
             /* ignored */
             register_name = "BadVAddr";
             break;
-        case 1:
+        case CP0_REG08__BADINSTR:
             /* ignored */
             register_name = "BadInstr";
             break;
-        case 2:
+        case CP0_REG08__BADINSTRP:
             /* ignored */
             register_name = "BadInstrP";
             break;
-        case 3:
+        case CP0_REG08__BADINSTRX:
             /* ignored */
             register_name = "BadInstrX";
             break;
@@ -8574,21 +8574,21 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_08:
         switch (sel) {
-        case 0:
+        case CP0_REG08__BADVADDR:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_BadVAddr));
             register_name = "BadVAddr";
             break;
-        case 1:
+        case CP0_REG08__BADINSTR:
             CP0_CHECK(ctx->bi);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstr));
             register_name = "BadInstr";
             break;
-        case 2:
+        case CP0_REG08__BADINSTRP:
             CP0_CHECK(ctx->bp);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrP));
             register_name = "BadInstrP";
             break;
-        case 3:
+        case CP0_REG08__BADINSTRX:
             CP0_CHECK(ctx->bi);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrX));
             tcg_gen_andi_tl(arg, arg, ~0xffff);
@@ -9289,19 +9289,19 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_08:
         switch (sel) {
-        case 0:
+        case CP0_REG08__BADVADDR:
             /* ignored */
             register_name = "BadVAddr";
             break;
-        case 1:
+        case CP0_REG08__BADINSTR:
             /* ignored */
             register_name = "BadInstr";
             break;
-        case 2:
+        case CP0_REG08__BADINSTRP:
             /* ignored */
             register_name = "BadInstrP";
             break;
-        case 3:
+        case CP0_REG08__BADINSTRX:
             /* ignored */
             register_name = "BadInstrX";
             break;
-- 
2.7.4


