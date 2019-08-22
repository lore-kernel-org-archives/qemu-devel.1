Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67266C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE6F233A0
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE6F233A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0lkV-0006uc-So
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 07:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i0lPN-0005Dg-Oi
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i0lPK-00088G-15
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:37:37 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:49985 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i0lPJ-0007sR-93
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:37:33 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 663581A20D6;
 Thu, 22 Aug 2019 13:35:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 39A0C1A20C8;
 Thu, 22 Aug 2019 13:35:59 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 13:35:50 +0200
Message-Id: <1566473750-17743-27-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566473750-17743-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1566473750-17743-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 26/26] target/mips: Clean up handling of CP0
 register 31
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
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Clean up handling of CP0 register 31.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       |  2 +-
 target/mips/translate.c | 56 ++++++++++++++++++++++++-------------------------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 90d1373..070f5ea 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -610,7 +610,6 @@ struct CPUMIPSState {
  * CP0 Register 4
  */
     target_ulong CP0_Context;
-    target_ulong CP0_KScratch[MIPS_KSCRATCH_NUM];
     int32_t CP0_MemoryMapID;
 /*
  * CP0 Register 5
@@ -1021,6 +1020,7 @@ struct CPUMIPSState {
  * CP0 Register 31
  */
     int32_t CP0_DESAVE;
+    target_ulong CP0_KScratch[MIPS_KSCRATCH_NUM];
 
     /* We waste some space so we can handle shadow registers like TCs. */
     TCState tcs[MIPS_SHADOW_SET_MAX];
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 808d046..ba4e28e 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -7579,17 +7579,17 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_31:
         switch (sel) {
-        case 0:
+        case CP0_REG31__DESAVE:
             /* EJTAG support */
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_DESAVE));
             register_name = "DESAVE";
             break;
-        case 2:
-        case 3:
-        case 4:
-        case 5:
-        case 6:
-        case 7:
+        case CP0_REG31__KSCRATCH1:
+        case CP0_REG31__KSCRATCH2:
+        case CP0_REG31__KSCRATCH3:
+        case CP0_REG31__KSCRATCH4:
+        case CP0_REG31__KSCRATCH5:
+        case CP0_REG31__KSCRATCH6:
             CP0_CHECK(ctx->kscrexist & (1 << sel));
             tcg_gen_ld_tl(arg, cpu_env,
                           offsetof(CPUMIPSState, CP0_KScratch[sel-2]));
@@ -8333,17 +8333,17 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_31:
         switch (sel) {
-        case 0:
+        case CP0_REG31__DESAVE:
             /* EJTAG support */
             gen_mtc0_store32(arg, offsetof(CPUMIPSState, CP0_DESAVE));
             register_name = "DESAVE";
             break;
-        case 2:
-        case 3:
-        case 4:
-        case 5:
-        case 6:
-        case 7:
+        case CP0_REG31__KSCRATCH1:
+        case CP0_REG31__KSCRATCH2:
+        case CP0_REG31__KSCRATCH3:
+        case CP0_REG31__KSCRATCH4:
+        case CP0_REG31__KSCRATCH5:
+        case CP0_REG31__KSCRATCH6:
             CP0_CHECK(ctx->kscrexist & (1 << sel));
             tcg_gen_st_tl(arg, cpu_env,
                           offsetof(CPUMIPSState, CP0_KScratch[sel-2]));
@@ -9068,17 +9068,17 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_31:
         switch (sel) {
-        case 0:
+        case CP0_REG31__DESAVE:
             /* EJTAG support */
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_DESAVE));
             register_name = "DESAVE";
             break;
-        case 2:
-        case 3:
-        case 4:
-        case 5:
-        case 6:
-        case 7:
+        case CP0_REG31__KSCRATCH1:
+        case CP0_REG31__KSCRATCH2:
+        case CP0_REG31__KSCRATCH3:
+        case CP0_REG31__KSCRATCH4:
+        case CP0_REG31__KSCRATCH5:
+        case CP0_REG31__KSCRATCH6:
             CP0_CHECK(ctx->kscrexist & (1 << sel));
             tcg_gen_ld_tl(arg, cpu_env,
                           offsetof(CPUMIPSState, CP0_KScratch[sel-2]));
@@ -9809,17 +9809,17 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_31:
         switch (sel) {
-        case 0:
+        case CP0_REG31__DESAVE:
             /* EJTAG support */
             gen_mtc0_store32(arg, offsetof(CPUMIPSState, CP0_DESAVE));
             register_name = "DESAVE";
             break;
-        case 2:
-        case 3:
-        case 4:
-        case 5:
-        case 6:
-        case 7:
+        case CP0_REG31__KSCRATCH1:
+        case CP0_REG31__KSCRATCH2:
+        case CP0_REG31__KSCRATCH3:
+        case CP0_REG31__KSCRATCH4:
+        case CP0_REG31__KSCRATCH5:
+        case CP0_REG31__KSCRATCH6:
             CP0_CHECK(ctx->kscrexist & (1 << sel));
             tcg_gen_st_tl(arg, cpu_env,
                           offsetof(CPUMIPSState, CP0_KScratch[sel - 2]));
-- 
2.7.4


