Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25760C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:59:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F006220828
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F006220828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3I93-0008T6-1f
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 06:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3Hcp-0005Zd-9E
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3Hcn-00066J-Ce
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:55 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45746 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i3Hcm-0005ja-RT
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:53 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id C54DC1A21FF;
 Thu, 29 Aug 2019 12:25:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 9868E1A224E;
 Thu, 29 Aug 2019 12:25:25 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 12:25:12 +0200
Message-Id: <1567074313-22998-31-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 30/31] target/mips: Clean up handling of CP0
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Clean up handling of CP0 register 31.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1567009614-12438-31-git-send-email-aleksandar.markovic@rt-rk.com>
---
 target/mips/cpu.h       |  2 +-
 target/mips/translate.c | 56 ++++++++++++++++++++++++-------------------------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 6defbea..ca00f41 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -613,7 +613,6 @@ struct CPUMIPSState {
  * CP0 Register 4
  */
     target_ulong CP0_Context;
-    target_ulong CP0_KScratch[MIPS_KSCRATCH_NUM];
     int32_t CP0_MemoryMapID;
 /*
  * CP0 Register 5
@@ -1024,6 +1023,7 @@ struct CPUMIPSState {
  * CP0 Register 31
  */
     int32_t CP0_DESAVE;
+    target_ulong CP0_KScratch[MIPS_KSCRATCH_NUM];
 
     /* We waste some space so we can handle shadow registers like TCs. */
     TCState tcs[MIPS_SHADOW_SET_MAX];
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 93f7a20..f6d1424 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -7532,17 +7532,17 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -8282,17 +8282,17 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -9009,17 +9009,17 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -9746,17 +9746,17 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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


