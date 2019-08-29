Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DCBC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:32:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8F212073F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F212073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Hj3-0002SH-8o
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 06:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3HcZ-0005O8-B4
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3HcR-0005PZ-0v
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:38 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45359 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i3HcQ-0005LV-Bs
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:30 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id E94F21A21C1;
 Thu, 29 Aug 2019 12:25:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id B4FCA1A1E16;
 Thu, 29 Aug 2019 12:25:24 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 12:24:52 +0200
Message-Id: <1567074313-22998-11-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 10/31] target/mips: Clean up handling of CP0
 register 9
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

Clean up handling of CP0 register 9.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1567009614-12438-11-git-send-email-aleksandar.markovic@rt-rk.com>
---
 target/mips/translate.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index d4faa75..b79c58c 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -6658,7 +6658,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_09:
         switch (sel) {
-        case 7:
+        case CP0_REG09__SAAR:
             CP0_CHECK(ctx->saar);
             gen_helper_mfhc0_saar(arg, cpu_env);
             register_name = "SAAR";
@@ -6740,7 +6740,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_09:
         switch (sel) {
-        case 7:
+        case CP0_REG09__SAAR:
             CP0_CHECK(ctx->saar);
             gen_helper_mthc0_saar(cpu_env, arg);
             register_name = "SAAR";
@@ -7124,7 +7124,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_09:
         switch (sel) {
-        case 0:
+        case CP0_REG09__COUNT:
             /* Mark as an IO operation because we read the time.  */
             if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
                 gen_io_start();
@@ -7139,12 +7139,12 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             ctx->base.is_jmp = DISAS_EXIT;
             register_name = "Count";
             break;
-        case 6:
+        case CP0_REG09__SAARI:
             CP0_CHECK(ctx->saar);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SAARI));
             register_name = "SAARI";
             break;
-        case 7:
+        case CP0_REG09__SAAR:
             CP0_CHECK(ctx->saar);
             gen_helper_mfc0_saar(arg, cpu_env);
             register_name = "SAAR";
@@ -7852,16 +7852,16 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_09:
         switch (sel) {
-        case 0:
+        case CP0_REG09__COUNT:
             gen_helper_mtc0_count(cpu_env, arg);
             register_name = "Count";
             break;
-        case 6:
+        case CP0_REG09__SAARI:
             CP0_CHECK(ctx->saar);
             gen_helper_mtc0_saari(cpu_env, arg);
             register_name = "SAARI";
             break;
-        case 7:
+        case CP0_REG09__SAAR:
             CP0_CHECK(ctx->saar);
             gen_helper_mtc0_saar(cpu_env, arg);
             register_name = "SAAR";
@@ -8600,7 +8600,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_09:
         switch (sel) {
-        case 0:
+        case CP0_REG09__COUNT:
             /* Mark as an IO operation because we read the time.  */
             if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
                 gen_io_start();
@@ -8615,12 +8615,12 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             ctx->base.is_jmp = DISAS_EXIT;
             register_name = "Count";
             break;
-        case 6:
+        case CP0_REG09__SAARI:
             CP0_CHECK(ctx->saar);
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SAARI));
             register_name = "SAARI";
             break;
-        case 7:
+        case CP0_REG09__SAAR:
             CP0_CHECK(ctx->saar);
             gen_helper_dmfc0_saar(arg, cpu_env);
             register_name = "SAAR";
@@ -9311,16 +9311,16 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_09:
         switch (sel) {
-        case 0:
+        case CP0_REG09__COUNT:
             gen_helper_mtc0_count(cpu_env, arg);
             register_name = "Count";
             break;
-        case 6:
+        case CP0_REG09__SAARI:
             CP0_CHECK(ctx->saar);
             gen_helper_mtc0_saari(cpu_env, arg);
             register_name = "SAARI";
             break;
-        case 7:
+        case CP0_REG09__SAAR:
             CP0_CHECK(ctx->saar);
             gen_helper_mtc0_saar(cpu_env, arg);
             register_name = "SAAR";
-- 
2.7.4


