Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CA5C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:18:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33243207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DbfTvGpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33243207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6bTc-0000S4-Cb
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 11:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4887bfbec=alistair.francis@wdc.com>)
 id 1k6bQP-0003UR-C6
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 11:15:21 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:55679)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4887bfbec=alistair.francis@wdc.com>)
 id 1k6bQL-0007fN-TC
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 11:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597418118; x=1628954118;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jL8la5SaUZPFPaXp7NmU6atCG+J2ay2cXyu6f42UdYk=;
 b=DbfTvGpcSybW/thbdF0wOIXQhvp9hWmzOe9cuMVEqkWGO57Z2MPbFWYq
 SSfTmOHmt170SMFg+y5EOV+jpplB5YAtb2zUWoyIe1ksFq3wrEKUBQHi4
 4pq1B+JnXeeDInXWgs8yV6oGUGprgefXHDF1NB2kmvUXxTQqPIE5Nzwn6
 CgCexD0Z85ww/vpMVXKsQzato+DECkCXX6da4hThj7UWJxsGJfDdtAG9T
 TQ4p9UrM1dq2Tjiq1CW38SipQIM4tio55kZ4NzkkfYZkjtZxet++RHX6e
 exoh/SmQms5QaBimWvmCooRGSKnbd4lxBJE3FWEjd/o0xgErxMFfPWY3C g==;
IronPort-SDR: l8tpDX3bYEYcAYCocmtWuyVPnw7CnTRw0o8EYCeghZ8aJAsx8AH2QW0tOAN1pCOUGZOZJr39N8
 MZustU7RisdCtbBCoeNOkMIEEgbajCgCjr97Dec6VUejfM+DiIWV/Dc0oJ7v9ATxQU5qDUDnv1
 7PuWUYe13F2pX5hXEBHg/ZEGWhSs2bhJGnU7rEwdLlz3h58lxrYiVpX/V/LwA1J0RhPTJdfTG2
 js48yheWcmedJqA9d4js19j3CBcpcxhn6L0e+9jXQY1D9HXl6w0cLqmjluAtJf6/qVNSccK5zR
 AUw=
X-IronPort-AV: E=Sophos;i="5.76,312,1592841600"; d="scan'208";a="144994807"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2020 23:15:12 +0800
IronPort-SDR: 9yexvthJUafo3pBHSUflyB4xsHJI0/UbwGcrZ196BZaxfVikv/Xy4MP9nIQ1Hgh9bQIulRdcv0
 TS64LdqA+c+Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2020 08:02:16 -0700
IronPort-SDR: vYgLCfcksVdqUKnvlMt+j0QzFuYCafOXFwlVf0z8LJd9sODwFlYbArM2xo/tJ3UYWZbOoiFYPc
 l6ilg+EL7HsA==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Aug 2020 08:15:11 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 02/20] target/riscv: Generalize gen_nanbox_fpr to
 gen_nanbox_s
Date: Fri, 14 Aug 2020 08:04:48 -0700
Message-Id: <20200814150506.2070566-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814150506.2070566-1-alistair.francis@wdc.com>
References: <20200814150506.2070566-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=4887bfbec=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 11:15:11
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


