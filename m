Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB3DC3A5A4
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 16:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4707C20679
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 16:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4707C20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i30tK-00047f-TP
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 12:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i30mn-0006ti-2I
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:27:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i30ml-0007lW-F7
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:27:04 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55127 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i30ml-0007kY-2l
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:27:03 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 03FA21A22BA;
 Wed, 28 Aug 2019 18:27:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id BF0A61A2285;
 Wed, 28 Aug 2019 18:26:59 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 18:26:28 +0200
Message-Id: <1567009614-12438-5-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567009614-12438-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1567009614-12438-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v2 04/30] target/mips: Clean up handling of CP0
 register 3
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

Clean up handling of CP0 register 3.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       |  1 +
 target/mips/translate.c | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index eebdc9f..c2ef942 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -304,6 +304,7 @@ typedef struct mips_def_t mips_def_t;
 /* CP0 Register 03 */
 #define CP0_REG03__ENTRYLO1        0
 #define CP0_REG03__GLOBALNUM       1
+#define CP0_REG03__TCOPT           7
 /* CP0 Register 04 */
 #define CP0_REG04__CONTEXT         0
 #define CP0_REG04__USERLOCAL       2
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 6e65312..013dd53 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -6649,7 +6649,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_03:
         switch (sel) {
-        case 0:
+        case CP0_REG03__ENTRYLO1:
             CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
             gen_mfhc0_entrylo(arg, offsetof(CPUMIPSState, CP0_EntryLo1));
             register_name = "EntryLo1";
@@ -6749,7 +6749,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_03:
         switch (sel) {
-        case 0:
+        case CP0_REG03__ENTRYLO1:
             CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
             tcg_gen_andi_tl(arg, arg, mask);
             gen_mthc0_entrylo(arg, offsetof(CPUMIPSState, CP0_EntryLo1));
@@ -6987,7 +6987,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_03:
         switch (sel) {
-        case 0:
+        case CP0_REG03__ENTRYLO1:
             {
                 TCGv_i64 tmp = tcg_temp_new_i64();
                 tcg_gen_ld_i64(tmp, cpu_env,
@@ -7004,7 +7004,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             }
             register_name = "EntryLo1";
             break;
-        case 1:
+        case CP0_REG03__GLOBALNUM:
             CP0_CHECK(ctx->vp);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_GlobalNumber));
             register_name = "GlobalNumber";
@@ -7743,11 +7743,11 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_03:
         switch (sel) {
-        case 0:
+        case CP0_REG03__ENTRYLO1:
             gen_helper_mtc0_entrylo1(cpu_env, arg);
             register_name = "EntryLo1";
             break;
-        case 1:
+        case CP0_REG03__GLOBALNUM:
             CP0_CHECK(ctx->vp);
             /* ignored */
             register_name = "GlobalNumber";
@@ -8494,11 +8494,11 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_03:
         switch (sel) {
-        case 0:
+        case CP0_REG03__ENTRYLO1:
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EntryLo1));
             register_name = "EntryLo1";
             break;
-        case 1:
+        case CP0_REG03__GLOBALNUM:
             CP0_CHECK(ctx->vp);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_GlobalNumber));
             register_name = "GlobalNumber";
@@ -9215,11 +9215,11 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_03:
         switch (sel) {
-        case 0:
+        case CP0_REG03__ENTRYLO1:
             gen_helper_dmtc0_entrylo1(cpu_env, arg);
             register_name = "EntryLo1";
             break;
-        case 1:
+        case CP0_REG03__GLOBALNUM:
             CP0_CHECK(ctx->vp);
             /* ignored */
             register_name = "GlobalNumber";
-- 
2.7.4


