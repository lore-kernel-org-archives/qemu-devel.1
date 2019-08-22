Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43949C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 12:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145AD233FC
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 12:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145AD233FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0lqI-0004av-3f
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 08:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i0lPO-0005EI-4q
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i0lPJ-00087Y-RH
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:37:37 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:48307 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i0lPI-0007lQ-PF
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:37:33 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 40B6D1A2107;
 Thu, 22 Aug 2019 13:35:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id EC5311A205C;
 Thu, 22 Aug 2019 13:35:58 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 13:35:44 +0200
Message-Id: <1566473750-17743-21-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566473750-17743-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1566473750-17743-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 20/26] target/mips: Clean up handling of CP0
 register 25
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

Clean up handling of CP0 register 25.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 64 ++++++++++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 41392ab..55d1d95 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -7465,35 +7465,35 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_25:
         switch (sel) {
-        case 0:
+        case CP0_REG25__PERFCTL0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Performance0));
             register_name = "Performance0";
             break;
-        case 1:
+        case CP0_REG25__PERFCNT0:
             /* gen_helper_mfc0_performance1(arg); */
             register_name = "Performance1";
             goto cp0_unimplemented;
-        case 2:
+        case CP0_REG25__PERFCTL1:
             /* gen_helper_mfc0_performance2(arg); */
             register_name = "Performance2";
             goto cp0_unimplemented;
-        case 3:
+        case CP0_REG25__PERFCNT1:
             /* gen_helper_mfc0_performance3(arg); */
             register_name = "Performance3";
             goto cp0_unimplemented;
-        case 4:
+        case CP0_REG25__PERFCTL2:
             /* gen_helper_mfc0_performance4(arg); */
             register_name = "Performance4";
             goto cp0_unimplemented;
-        case 5:
+        case CP0_REG25__PERFCNT2:
             /* gen_helper_mfc0_performance5(arg); */
             register_name = "Performance5";
             goto cp0_unimplemented;
-        case 6:
+        case CP0_REG25__PERFCTL3:
             /* gen_helper_mfc0_performance6(arg); */
             register_name = "Performance6";
             goto cp0_unimplemented;
-        case 7:
+        case CP0_REG25__PERFCNT3:
             /* gen_helper_mfc0_performance7(arg); */
             register_name = "Performance7";
             goto cp0_unimplemented;
@@ -8226,35 +8226,35 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_25:
         switch (sel) {
-        case 0:
+        case CP0_REG25__PERFCTL0:
             gen_helper_mtc0_performance0(cpu_env, arg);
             register_name = "Performance0";
             break;
-        case 1:
+        case CP0_REG25__PERFCNT0:
             /* gen_helper_mtc0_performance1(arg); */
             register_name = "Performance1";
             goto cp0_unimplemented;
-        case 2:
+        case CP0_REG25__PERFCTL1:
             /* gen_helper_mtc0_performance2(arg); */
             register_name = "Performance2";
             goto cp0_unimplemented;
-        case 3:
+        case CP0_REG25__PERFCNT1:
             /* gen_helper_mtc0_performance3(arg); */
             register_name = "Performance3";
             goto cp0_unimplemented;
-        case 4:
+        case CP0_REG25__PERFCTL2:
             /* gen_helper_mtc0_performance4(arg); */
             register_name = "Performance4";
             goto cp0_unimplemented;
-        case 5:
+        case CP0_REG25__PERFCNT2:
             /* gen_helper_mtc0_performance5(arg); */
             register_name = "Performance5";
             goto cp0_unimplemented;
-        case 6:
+        case CP0_REG25__PERFCTL3:
             /* gen_helper_mtc0_performance6(arg); */
             register_name = "Performance6";
             goto cp0_unimplemented;
-        case 7:
+        case CP0_REG25__PERFCNT3:
             /* gen_helper_mtc0_performance7(arg); */
             register_name = "Performance7";
             goto cp0_unimplemented;
@@ -8965,35 +8965,35 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_25:
         switch (sel) {
-        case 0:
+        case CP0_REG25__PERFCTL0:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Performance0));
             register_name = "Performance0";
             break;
-        case 1:
+        case CP0_REG25__PERFCNT0:
             /* gen_helper_dmfc0_performance1(arg); */
             register_name = "Performance1";
             goto cp0_unimplemented;
-        case 2:
+        case CP0_REG25__PERFCTL1:
             /* gen_helper_dmfc0_performance2(arg); */
             register_name = "Performance2";
             goto cp0_unimplemented;
-        case 3:
+        case CP0_REG25__PERFCNT1:
             /* gen_helper_dmfc0_performance3(arg); */
             register_name = "Performance3";
             goto cp0_unimplemented;
-        case 4:
+        case CP0_REG25__PERFCTL2:
             /* gen_helper_dmfc0_performance4(arg); */
             register_name = "Performance4";
             goto cp0_unimplemented;
-        case 5:
+        case CP0_REG25__PERFCNT2:
             /* gen_helper_dmfc0_performance5(arg); */
             register_name = "Performance5";
             goto cp0_unimplemented;
-        case 6:
+        case CP0_REG25__PERFCTL3:
             /* gen_helper_dmfc0_performance6(arg); */
             register_name = "Performance6";
             goto cp0_unimplemented;
-        case 7:
+        case CP0_REG25__PERFCNT3:
             /* gen_helper_dmfc0_performance7(arg); */
             register_name = "Performance7";
             goto cp0_unimplemented;
@@ -9708,35 +9708,35 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_25:
         switch (sel) {
-        case 0:
+        case CP0_REG25__PERFCTL0:
             gen_helper_mtc0_performance0(cpu_env, arg);
             register_name = "Performance0";
             break;
-        case 1:
+        case CP0_REG25__PERFCNT0:
             /* gen_helper_mtc0_performance1(cpu_env, arg); */
             register_name = "Performance1";
             goto cp0_unimplemented;
-        case 2:
+        case CP0_REG25__PERFCTL1:
             /* gen_helper_mtc0_performance2(cpu_env, arg); */
             register_name = "Performance2";
             goto cp0_unimplemented;
-        case 3:
+        case CP0_REG25__PERFCNT1:
             /* gen_helper_mtc0_performance3(cpu_env, arg); */
             register_name = "Performance3";
             goto cp0_unimplemented;
-        case 4:
+        case CP0_REG25__PERFCTL2:
             /* gen_helper_mtc0_performance4(cpu_env, arg); */
             register_name = "Performance4";
             goto cp0_unimplemented;
-        case 5:
+        case CP0_REG25__PERFCNT2:
             /* gen_helper_mtc0_performance5(cpu_env, arg); */
             register_name = "Performance5";
             goto cp0_unimplemented;
-        case 6:
+        case CP0_REG25__PERFCTL3:
             /* gen_helper_mtc0_performance6(cpu_env, arg); */
             register_name = "Performance6";
             goto cp0_unimplemented;
-        case 7:
+        case CP0_REG25__PERFCNT3:
             /* gen_helper_mtc0_performance7(cpu_env, arg); */
             register_name = "Performance7";
             goto cp0_unimplemented;
-- 
2.7.4


