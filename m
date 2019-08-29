Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B3DC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:50:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AB81233A1
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB81233A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3I0H-0004l9-3B
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 06:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3Hcf-0005S3-OX
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3Hcd-0005nG-11
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:45 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45430 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i3Hcc-0005Pt-E3
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:42 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 5C3081A21B1;
 Thu, 29 Aug 2019 12:25:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 281921A222E;
 Thu, 29 Aug 2019 12:25:25 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 12:25:02 +0200
Message-Id: <1567074313-22998-21-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 20/31] target/mips: Clean up handling of CP0
 register 19
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

Clean up handling of CP0 register 19.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1567009614-12438-21-git-send-email-aleksandar.markovic@rt-rk.com>
---
 target/mips/cpu.h       |  4 ++++
 target/mips/translate.c | 64 ++++++++++++++++++++++++-------------------------
 2 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index d6ea111..b4866a5 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -395,6 +395,10 @@ typedef struct mips_def_t mips_def_t;
 #define CP0_REG19__WATCHHI1        1
 #define CP0_REG19__WATCHHI2        2
 #define CP0_REG19__WATCHHI3        3
+#define CP0_REG19__WATCHHI4        4
+#define CP0_REG19__WATCHHI5        5
+#define CP0_REG19__WATCHHI6        6
+#define CP0_REG19__WATCHHI7        7
 /* CP0 Register 20 */
 #define CP0_REG20__XCONTEXT        0
 /* CP0 Register 21 */
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 6a11e8d..6d617f4 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -7323,14 +7323,14 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_19:
         switch (sel) {
-        case 0:
-        case 1:
-        case 2:
-        case 3:
-        case 4:
-        case 5:
-        case 6:
-        case 7:
+        case CP0_REG19__WATCHHI0:
+        case CP0_REG19__WATCHHI1:
+        case CP0_REG19__WATCHHI2:
+        case CP0_REG19__WATCHHI3:
+        case CP0_REG19__WATCHHI4:
+        case CP0_REG19__WATCHHI5:
+        case CP0_REG19__WATCHHI6:
+        case CP0_REG19__WATCHHI7:
             CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_1e0i(mfc0_watchhi, arg, sel);
             register_name = "WatchHi";
@@ -8058,14 +8058,14 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_19:
         switch (sel) {
-        case 0:
-        case 1:
-        case 2:
-        case 3:
-        case 4:
-        case 5:
-        case 6:
-        case 7:
+        case CP0_REG19__WATCHHI0:
+        case CP0_REG19__WATCHHI1:
+        case CP0_REG19__WATCHHI2:
+        case CP0_REG19__WATCHHI3:
+        case CP0_REG19__WATCHHI4:
+        case CP0_REG19__WATCHHI5:
+        case CP0_REG19__WATCHHI6:
+        case CP0_REG19__WATCHHI7:
             CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_0e1i(mtc0_watchhi, arg, sel);
             register_name = "WatchHi";
@@ -8795,14 +8795,14 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_19:
         switch (sel) {
-        case 0:
-        case 1:
-        case 2:
-        case 3:
-        case 4:
-        case 5:
-        case 6:
-        case 7:
+        case CP0_REG19__WATCHHI0:
+        case CP0_REG19__WATCHHI1:
+        case CP0_REG19__WATCHHI2:
+        case CP0_REG19__WATCHHI3:
+        case CP0_REG19__WATCHHI4:
+        case CP0_REG19__WATCHHI5:
+        case CP0_REG19__WATCHHI6:
+        case CP0_REG19__WATCHHI7:
             CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_1e0i(mfc0_watchhi, arg, sel);
             register_name = "WatchHi";
@@ -9512,14 +9512,14 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_19:
         switch (sel) {
-        case 0:
-        case 1:
-        case 2:
-        case 3:
-        case 4:
-        case 5:
-        case 6:
-        case 7:
+        case CP0_REG19__WATCHHI0:
+        case CP0_REG19__WATCHHI1:
+        case CP0_REG19__WATCHHI2:
+        case CP0_REG19__WATCHHI3:
+        case CP0_REG19__WATCHHI4:
+        case CP0_REG19__WATCHHI5:
+        case CP0_REG19__WATCHHI6:
+        case CP0_REG19__WATCHHI7:
             CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
             gen_helper_0e1i(mtc0_watchhi, arg, sel);
             register_name = "WatchHi";
-- 
2.7.4


