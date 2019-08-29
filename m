Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A433C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:55:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 508652053B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508652053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3I5R-0002sJ-Dz
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 06:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3Hcf-0005SB-Vt
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3Hcd-0005pK-OW
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:45 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45425 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i3Hcc-0005Pi-HO
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:43 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 460C91A21EC;
 Thu, 29 Aug 2019 12:25:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 15EDC1A21D6;
 Thu, 29 Aug 2019 12:25:25 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 12:25:00 +0200
Message-Id: <1567074313-22998-19-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 18/31] target/mips: Clean up handling of CP0
 register 17
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

Clean up handling of CP0 register 17.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1567009614-12438-19-git-send-email-aleksandar.markovic@rt-rk.com>
---
 target/mips/translate.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 4808640..edeaaad 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -6669,12 +6669,12 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_17:
         switch (sel) {
-        case 0:
+        case CP0_REG17__LLADDR:
             gen_mfhc0_load64(arg, offsetof(CPUMIPSState, CP0_LLAddr),
                              ctx->CP0_LLAddr_shift);
             register_name = "LLAddr";
             break;
-        case 1:
+        case CP0_REG17__MAAR:
             CP0_CHECK(ctx->mrp);
             gen_helper_mfhc0_maar(arg, cpu_env);
             register_name = "MAAR";
@@ -6751,7 +6751,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_17:
         switch (sel) {
-        case 0:
+        case CP0_REG17__LLADDR:
             /*
              * LLAddr is read-only (the only exception is bit 0 if LLB is
              * supported); the CP0_LLAddr_rw_bitmask does not seem to be
@@ -6760,7 +6760,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
              */
             register_name = "LLAddr";
             break;
-        case 1:
+        case CP0_REG17__MAAR:
             CP0_CHECK(ctx->mrp);
             gen_helper_mthc0_maar(cpu_env, arg);
             register_name = "MAAR";
@@ -7285,16 +7285,16 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_17:
         switch (sel) {
-        case 0:
+        case CP0_REG17__LLADDR:
             gen_helper_mfc0_lladdr(arg, cpu_env);
             register_name = "LLAddr";
             break;
-        case 1:
+        case CP0_REG17__MAAR:
             CP0_CHECK(ctx->mrp);
             gen_helper_mfc0_maar(arg, cpu_env);
             register_name = "MAAR";
             break;
-        case 2:
+        case CP0_REG17__MAARI:
             CP0_CHECK(ctx->mrp);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_MAARI));
             register_name = "MAARI";
@@ -8020,16 +8020,16 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_17:
         switch (sel) {
-        case 0:
+        case CP0_REG17__LLADDR:
             gen_helper_mtc0_lladdr(cpu_env, arg);
             register_name = "LLAddr";
             break;
-        case 1:
+        case CP0_REG17__MAAR:
             CP0_CHECK(ctx->mrp);
             gen_helper_mtc0_maar(cpu_env, arg);
             register_name = "MAAR";
             break;
-        case 2:
+        case CP0_REG17__MAARI:
             CP0_CHECK(ctx->mrp);
             gen_helper_mtc0_maari(cpu_env, arg);
             register_name = "MAARI";
@@ -8757,16 +8757,16 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_17:
         switch (sel) {
-        case 0:
+        case CP0_REG17__LLADDR:
             gen_helper_dmfc0_lladdr(arg, cpu_env);
             register_name = "LLAddr";
             break;
-        case 1:
+        case CP0_REG17__MAAR:
             CP0_CHECK(ctx->mrp);
             gen_helper_dmfc0_maar(arg, cpu_env);
             register_name = "MAAR";
             break;
-        case 2:
+        case CP0_REG17__MAARI:
             CP0_CHECK(ctx->mrp);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_MAARI));
             register_name = "MAARI";
@@ -9474,16 +9474,16 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_17:
         switch (sel) {
-        case 0:
+        case CP0_REG17__LLADDR:
             gen_helper_mtc0_lladdr(cpu_env, arg);
             register_name = "LLAddr";
             break;
-        case 1:
+        case CP0_REG17__MAAR:
             CP0_CHECK(ctx->mrp);
             gen_helper_mtc0_maar(cpu_env, arg);
             register_name = "MAAR";
             break;
-        case 2:
+        case CP0_REG17__MAARI:
             CP0_CHECK(ctx->mrp);
             gen_helper_mtc0_maari(cpu_env, arg);
             register_name = "MAARI";
-- 
2.7.4


