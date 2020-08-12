Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC114C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32E120774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U7Vsq2Jl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32E120774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5zSe-0005B8-Rf
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 18:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQU-0002H3-T8
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:40:54 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:56480)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQR-0005oE-G5
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597272051; x=1628808051;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jL8la5SaUZPFPaXp7NmU6atCG+J2ay2cXyu6f42UdYk=;
 b=U7Vsq2JlUdP2GEvpWk4Ll1GNZHvN8mhXt6YyZUhVF5yHenJOzKLP567V
 GfaN4wg2e6r620d8zYwR7xVtsM5nojcFWQQl/Ai16TqM3ybnMsnpk44xY
 F7hZVfbf01skr0kTCVva2+cXbwKKdfZrErZkZK1Uk+71VlKzyOzGqvC1U
 ypiesdaxgjd0il2JjjZ6yLR6znsbdFIDFvusHz53PrTNKIClHqyUEjg/A
 JFPsMEjxD+oyJy4d0vZ/585NNYvKi8+MBaE5mlFYxBJPlynIiHNiScpKL
 QTSnUqGhRdgI5dNDJDyQSlL5CyAGo8a/0+iu7Q8f7MeJHdtBq7vxGDvKc g==;
IronPort-SDR: IHjIddzMoa+1SJF0yKhZ8CqUSecXAy9SuMGtHEobRFtPeUoakoLGPagvK/84GeeCvAXqa7hQ/4
 ZpCSXyPfc60I1yLluLRW2te5ecvfzh3ocfzs7Pl/TeOoJwMHeXRmWp8pf1MeNqCcXBuqjcvqFv
 MQOAOavjboeKUDIU/XtYZArzc8PA5yRaD3nUkPelcQ/yX0ypTe2a0Dk47T+2rUKneTIPa7mt3/
 tT1LhQZSCGTNWO34pSF3zdl4uI9Q5/p+TuSmQTp5LdfbK18Trv7v1mP8pZTf8yeQSWFzP7meLI
 ekY=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="144853391"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 06:40:48 +0800
IronPort-SDR: jOg/EHds++OtJwZ3ex23mJ1GzL2XtWPiJZllGk6pqqT4H+Q4OpBNXRPGgxgAX/ld2g7BL6aMPn
 AynOnvZbmK6w==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 15:28:38 -0700
IronPort-SDR: rue34bdCbrZGzJ8YLTkWsavkovnKh618O2lgNGaANsLHkNaGB2KByteYN1EudBhmhY7nE8lmAB
 JRj1CYNO6dHA==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Aug 2020 15:40:44 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/20] target/riscv: Generalize gen_nanbox_fpr to gen_nanbox_s
Date: Wed, 12 Aug 2020 15:30:27 -0700
Message-Id: <20200812223045.96803-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200812223045.96803-1-alistair.francis@wdc.com>
References: <20200812223045.96803-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=486123ee4=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 18:40:47
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
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
 target/riscv/insn_trans/trans_rvf.inc.c | 16 +---------------
 target/riscv/translate.c                | 11 +++++++++++
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
index 3bfd8881e7..c7057482e8 100644
--- a/target/riscv/insn_trans/trans_rvf.inc.c
+++ b/target/riscv/insn_trans/trans_rvf.inc.c
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
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9632e79cf3..12a746da97 100644
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
-- 
2.27.0


