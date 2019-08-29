Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3634DC3A5A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A1EE233A1
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1EE233A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3I0J-0004sg-Lv
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 06:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3Hco-0005YB-Am
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3Hcm-00064Q-4k
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:54 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45739 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i3Hcl-0005jH-Of
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:52 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id A8B2E1A222E;
 Thu, 29 Aug 2019 12:25:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 772621A21E3;
 Thu, 29 Aug 2019 12:25:25 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 12:25:10 +0200
Message-Id: <1567074313-22998-29-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 28/31] target/mips: Clean up handling of CP0
 register 29
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

Clean up handling of CP0 register 29.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1567009614-12438-29-git-send-email-aleksandar.markovic@rt-rk.com>
---
 target/mips/cpu.h       | 22 ++++++++++-------
 target/mips/translate.c | 64 ++++++++++++++++++++++++-------------------------
 2 files changed, 46 insertions(+), 40 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index de9e850..6defbea 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -233,12 +233,12 @@ typedef struct mips_def_t mips_def_t;
  *
  * 0   DataLo            DataHi            ErrorEPC          DESAVE
  * 1   TagLo             TagHi
- * 2   DataLo1           DataHi                              KScratch<n>
- * 3   TagLo1            TagHi                               KScratch<n>
- * 4   DataLo2           DataHi                              KScratch<n>
- * 5   TagLo2            TagHi                               KScratch<n>
- * 6   DataLo3           DataHi                              KScratch<n>
- * 7   TagLo3            TagHi                               KScratch<n>
+ * 2   DataLo1           DataHi1                             KScratch<n>
+ * 3   TagLo1            TagHi1                              KScratch<n>
+ * 4   DataLo2           DataHi2                             KScratch<n>
+ * 5   TagLo2            TagHi2                              KScratch<n>
+ * 6   DataLo3           DataHi3                             KScratch<n>
+ * 7   TagLo3            TagHi3                              KScratch<n>
  *
  */
 #define CP0_REGISTER_00     0
@@ -436,8 +436,14 @@ typedef struct mips_def_t mips_def_t;
 #define CP0_REG28__TAGLO3          6
 #define CP0_REG28__DATALO3         7
 /* CP0 Register 29 */
-#define CP0_REG29__IDATAHI         1
-#define CP0_REG29__DDATAHI         3
+#define CP0_REG29__TAGHI           0
+#define CP0_REG29__DATAHI          1
+#define CP0_REG29__TAGHI1          2
+#define CP0_REG29__DATAHI1         3
+#define CP0_REG29__TAGHI2          4
+#define CP0_REG29__DATAHI2         5
+#define CP0_REG29__TAGHI3          6
+#define CP0_REG29__DATAHI3         7
 /* CP0 Register 30 */
 #define CP0_REG30__ERROREPC        0
 /* CP0 Register 31 */
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 032e3b0..6d6fda6 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -7501,17 +7501,17 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_29:
         switch (sel) {
-        case 0:
-        case 2:
-        case 4:
-        case 6:
+        case CP0_REG29__TAGHI:
+        case CP0_REG29__TAGHI1:
+        case CP0_REG29__TAGHI2:
+        case CP0_REG29__TAGHI3:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_TagHi));
             register_name = "TagHi";
             break;
-        case 1:
-        case 3:
-        case 5:
-        case 7:
+        case CP0_REG29__DATAHI:
+        case CP0_REG29__DATAHI1:
+        case CP0_REG29__DATAHI2:
+        case CP0_REG29__DATAHI3:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_DataHi));
             register_name = "DataHi";
             break;
@@ -8251,17 +8251,17 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_29:
         switch (sel) {
-        case 0:
-        case 2:
-        case 4:
-        case 6:
+        case CP0_REG29__TAGHI:
+        case CP0_REG29__TAGHI1:
+        case CP0_REG29__TAGHI2:
+        case CP0_REG29__TAGHI3:
             gen_helper_mtc0_taghi(cpu_env, arg);
             register_name = "TagHi";
             break;
-        case 1:
-        case 3:
-        case 5:
-        case 7:
+        case CP0_REG29__DATAHI:
+        case CP0_REG29__DATAHI1:
+        case CP0_REG29__DATAHI2:
+        case CP0_REG29__DATAHI3:
             gen_helper_mtc0_datahi(cpu_env, arg);
             register_name = "DataHi";
             break;
@@ -8979,17 +8979,17 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_29:
         switch (sel) {
-        case 0:
-        case 2:
-        case 4:
-        case 6:
+        case CP0_REG29__TAGHI:
+        case CP0_REG29__TAGHI1:
+        case CP0_REG29__TAGHI2:
+        case CP0_REG29__TAGHI3:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_TagHi));
             register_name = "TagHi";
             break;
-        case 1:
-        case 3:
-        case 5:
-        case 7:
+        case CP0_REG29__DATAHI:
+        case CP0_REG29__DATAHI1:
+        case CP0_REG29__DATAHI2:
+        case CP0_REG29__DATAHI3:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_DataHi));
             register_name = "DataHi";
             break;
@@ -9715,17 +9715,17 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_29:
         switch (sel) {
-        case 0:
-        case 2:
-        case 4:
-        case 6:
+        case CP0_REG29__TAGHI:
+        case CP0_REG29__TAGHI1:
+        case CP0_REG29__TAGHI2:
+        case CP0_REG29__TAGHI3:
             gen_helper_mtc0_taghi(cpu_env, arg);
             register_name = "TagHi";
             break;
-        case 1:
-        case 3:
-        case 5:
-        case 7:
+        case CP0_REG29__DATAHI:
+        case CP0_REG29__DATAHI1:
+        case CP0_REG29__DATAHI2:
+        case CP0_REG29__DATAHI3:
             gen_helper_mtc0_datahi(cpu_env, arg);
             register_name = "DataHi";
             break;
-- 
2.7.4


