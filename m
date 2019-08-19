Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36C9C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB33B20843
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB33B20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzgmM-0005rX-UB
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 08:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hzgTo-00028n-2b
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hzgTm-0002kN-Dc
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:09:43 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:58028 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hzgTl-0002bO-W0
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:09:42 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 5E77A1A2088;
 Mon, 19 Aug 2019 14:08:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id C02B61A2128;
 Mon, 19 Aug 2019 14:08:24 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:08:02 +0200
Message-Id: <1566216496-17375-24-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v8 23/37] target/mips: Clean up handling of CP0
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
Cc: arikalo@wavecomp.com, philmd@redhat.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Clean up handling of CP0 register 8.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       |  1 +
 target/mips/translate.c | 32 ++++++++++++++++----------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index c865b51..c7fdf1d 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -332,6 +332,7 @@ typedef struct mips_def_t mips_def_t;
 #define CP0_REG08__BADVADDR        0
 #define CP0_REG08__BADINSTR        1
 #define CP0_REG08__BADINSTRP       2
+#define CP0_REG08__BADINSTRX       3
 /* CP0 Register 09 */
 #define CP0_REG09__COUNT           0
 #define CP0_REG09__SAARI           6
diff --git a/target/mips/translate.c b/target/mips/translate.c
index abbb924..c046a10 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -7141,22 +7141,22 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -7881,19 +7881,19 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -8630,21 +8630,21 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -9352,19 +9352,19 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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


