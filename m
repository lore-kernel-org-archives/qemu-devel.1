Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B76C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4346920843
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4346920843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzgiD-0002Gg-T4
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 08:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hzgTp-0002B0-E1
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:09:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hzgTm-0002lR-OR
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:09:45 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:58064 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hzgTm-0002bp-9q
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:09:42 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id D7AA91A21F1;
 Mon, 19 Aug 2019 14:08:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id E03F31A21A4;
 Mon, 19 Aug 2019 14:08:24 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:08:06 +0200
Message-Id: <1566216496-17375-28-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v8 27/37] target/mips: Clean up handling of CP0
 register 15
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

Clean up handling of CP0 register 15.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       |  1 +
 target/mips/translate.c | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index d61b8c0..3a8c560 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -363,6 +363,7 @@ typedef struct mips_def_t mips_def_t;
 #define CP0_REG15__EBASE           1
 #define CP0_REG15__CDMMBASE        2
 #define CP0_REG15__CMGCRBASE       3
+#define CP0_REG15__BEVVA           4
 /* CP0 Register 16 */
 #define CP0_REG16__CONFIG          0
 #define CP0_REG16__CONFIG1         1
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 863bd39..9d3996d 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -7270,17 +7270,17 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_15:
         switch (sel) {
-        case 0:
+        case CP0_REG15__PRID:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PRid));
             register_name = "PRid";
             break;
-        case 1:
+        case CP0_REG15__EBASE:
             check_insn(ctx, ISA_MIPS32R2);
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EBase));
             tcg_gen_ext32s_tl(arg, arg);
             register_name = "EBase";
             break;
-        case 3:
+        case CP0_REG15__CMGCRBASE:
             check_insn(ctx, ISA_MIPS32R2);
             CP0_CHECK(ctx->cmgcr);
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_CMGCRBase));
@@ -8007,11 +8007,11 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_15:
         switch (sel) {
-        case 0:
+        case CP0_REG15__PRID:
             /* ignored */
             register_name = "PRid";
             break;
-        case 1:
+        case CP0_REG15__EBASE:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_ebase(cpu_env, arg);
             register_name = "EBase";
@@ -8756,16 +8756,16 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_15:
         switch (sel) {
-        case 0:
+        case CP0_REG15__PRID:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_PRid));
             register_name = "PRid";
             break;
-        case 1:
+        case CP0_REG15__EBASE:
             check_insn(ctx, ISA_MIPS32R2);
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EBase));
             register_name = "EBase";
             break;
-        case 3:
+        case CP0_REG15__CMGCRBASE:
             check_insn(ctx, ISA_MIPS32R2);
             CP0_CHECK(ctx->cmgcr);
             tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_CMGCRBase));
@@ -9482,11 +9482,11 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_15:
         switch (sel) {
-        case 0:
+        case CP0_REG15__PRID:
             /* ignored */
             register_name = "PRid";
             break;
-        case 1:
+        case CP0_REG15__EBASE:
             check_insn(ctx, ISA_MIPS32R2);
             gen_helper_mtc0_ebase(cpu_env, arg);
             register_name = "EBase";
-- 
2.7.4


