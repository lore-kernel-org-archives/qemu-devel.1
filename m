Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E035C433E3
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 05:52:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9192072D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 05:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AZcyokCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9192072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9MSH-0003Uo-FH
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 01:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49637c5a7=alistair.francis@wdc.com>)
 id 1k9MR1-0001jW-LJ
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 01:51:23 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:23559)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49637c5a7=alistair.francis@wdc.com>)
 id 1k9MQz-0000DF-En
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 01:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598075481; x=1629611481;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=s+Qui1yOY/DT0/NEtJwMy6JHTS2A8SdJ6rIojxXUwmA=;
 b=AZcyokCCpiilTAV2BdVyGQ2xaGieuNto19xdDknWHmElxxLbHslLu5nm
 BRvIuX2YdViyKgtTF/fVGWx260ER4prxC7JEgxIjIFBnHJjQBIBOVZEfC
 kPORqUn3/MobdH4hohmX7ya+kg+Ql1qBH+UoQGH95N6fiFpic4oXnrsCw
 DV/PLuv9XTDz88Y8TxIEbKFHWuajqjR13RS/uMs9X4FfGNkUSuyVdVrUW
 R7CN4tXsvqxlrpJN+LqsfYxtkejl9r3cVfdMNOwk3RZw8oJQ7aVqyLufu
 xcE59Oi6xwU39UmLjqOTZIKIE+n1Q4v63qh+VbQqUbXpKuxVcmgZ64j4p A==;
IronPort-SDR: 2U7UhLOu6S2hS/Gj215hYTrdFY/VIOSbN/SjATPyVBwAcI2OJq8BbmMc2YrfUdWPWtuohFwNFV
 ow3ogFD0S77PsrywzgcVfMeKPM1tXyLdc9xlHAr2T54dccJrkKm+y0+pvGY3tCJhWILTkDrJqL
 uK5yDCboNsrlAOE2+gLfxuSwFMMmRJrIMLTntKHtWVvLtsnJ3loACuLHE3DVg+dmK6NMp+3pgf
 niDG3VTcbyoqqj84aPNDvGRCj2Y2/k+gbqSngfEQfnWGxWKX0AC1qnmow9Q7nkUbnd5hU2F0b9
 dWo=
X-IronPort-AV: E=Sophos;i="5.76,339,1592841600"; d="scan'208";a="255030529"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2020 13:51:16 +0800
IronPort-SDR: VNipglq2fUV82pVKZL0QSXA1Dv0wXIUYFTg1p9DyO1QGLL9L5tYChBkF3kuTR0AghkCbWlOE2o
 FstzthWqNkng==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2020 22:38:56 -0700
IronPort-SDR: weEKyVdaZIleEyCJLwMABkCmcTHNAWpBusvqDu9RD1aLrA8oRIgL+iDOsDmewU/8bVuBgaB7BR
 2TRNbKcA5vsQ==
WDCIronportException: Internal
Received: from 5zn13g2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.90])
 by uls-op-cesaip02.wdc.com with ESMTP; 21 Aug 2020 22:51:17 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 02/20] target/riscv: Generalize gen_nanbox_fpr to
 gen_nanbox_s
Date: Fri, 21 Aug 2020 22:40:43 -0700
Message-Id: <20200822054101.1202175-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200822054101.1202175-1-alistair.francis@wdc.com>
References: <20200822054101.1202175-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=49637c5a7=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 01:51:16
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: alistair23@gmail.com, Richard Henderson <richard.henderson@linaro.org>,
 alistair.francis@wdc.com, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Do not depend on the RVD extension, take input and output via
TCGv_i64 instead of fpu regno.  Move the function to translate.c
so that it can be used in multiple trans_*.inc.c files.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-Id: <20200724002807.441147-3-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c                | 11 +++++++++++
 target/riscv/insn_trans/trans_rvf.c.inc | 16 +---------------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index d0485c0750..1290faddda 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -90,6 +90,17 @@ static inline bool has_ext(DisasContext *ctx, uint32_t ext)
     return ctx->misa & ext;
 }
 
+/*
+ * RISC-V requires NaN-boxing of narrower width floating point values.
+ * This applies when a 32-bit value is assigned to a 64-bit FP register.
+ * For consistency and simplicity, we nanbox results even when the RVD
+ * extension is not present.
+ */
+static void gen_nanbox_s(TCGv_i64 out, TCGv_i64 in)
+{
+    tcg_gen_ori_i64(out, in, MAKE_64BIT_MASK(32, 32));
+}
+
 static void generate_exception(DisasContext *ctx, int excp)
 {
     tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_trans/trans_rvf.c.inc
index 3bfd8881e7..c7057482e8 100644
--- a/target/riscv/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/insn_trans/trans_rvf.c.inc
@@ -23,20 +23,6 @@
         return false;                       \
 } while (0)
 
-/*
- * RISC-V requires NaN-boxing of narrower width floating
- * point values.  This applies when a 32-bit value is
- * assigned to a 64-bit FP register.  Thus this does not
- * apply when the RVD extension is not present.
- */
-static void gen_nanbox_fpr(DisasContext *ctx, int regno)
-{
-    if (has_ext(ctx, RVD)) {
-        tcg_gen_ori_i64(cpu_fpr[regno], cpu_fpr[regno],
-                        MAKE_64BIT_MASK(32, 32));
-    }
-}
-
 static bool trans_flw(DisasContext *ctx, arg_flw *a)
 {
     TCGv t0 = tcg_temp_new();
@@ -46,7 +32,7 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
     tcg_gen_addi_tl(t0, t0, a->imm);
 
     tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], t0, ctx->mem_idx, MO_TEUL);
-    gen_nanbox_fpr(ctx, a->rd);
+    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
 
     tcg_temp_free(t0);
     mark_fs_dirty(ctx);
-- 
2.28.0


