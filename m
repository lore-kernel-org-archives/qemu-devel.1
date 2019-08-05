Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F773C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 10:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374782087B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 10:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374782087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hua5c-0005u3-Fy
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 06:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39328)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1huZx8-0005xH-UI
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 06:10:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1huZx7-0002tY-M3
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 06:10:54 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:44925 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1huZx7-0002jA-C6
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 06:10:53 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id BA6811A211A;
 Mon,  5 Aug 2019 12:09:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 531001A216C;
 Mon,  5 Aug 2019 12:09:36 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Mon,  5 Aug 2019 12:09:18 +0200
Message-Id: <1564999760-27438-21-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564999760-27438-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1564999760-27438-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH for 4.2 v6 20/22] target/mips: Clean up
 handling of CP0 register 31
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

Clean up handling of CP0 register 31.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       |  2 +-
 target/mips/translate.c | 56 ++++++++++++++++++++++++-------------------------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index e2f6844..0c79a0e 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -552,7 +552,6 @@ struct CPUMIPSState {
  * CP0 Register 4
  */
     target_ulong CP0_Context;
-    target_ulong CP0_KScratch[MIPS_KSCRATCH_NUM];
     int32_t CP0_MemoryMapID;
 /*
  * CP0 Register 5
@@ -963,6 +962,7 @@ struct CPUMIPSState {
  * CP0 Register 31
  */
     int32_t CP0_DESAVE;
+    target_ulong CP0_KScratch[MIPS_KSCRATCH_NUM];
 
     /* We waste some space so we can handle shadow registers like TCs. */
     TCState tcs[MIPS_SHADOW_SET_MAX];
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 90e9636..9ad0519 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -7573,17 +7573,17 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -8319,17 +8319,17 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -9048,17 +9048,17 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -9781,17 +9781,17 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
-- 
2.7.4


