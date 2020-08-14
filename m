Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67087C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3173320866
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GHJ695q9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3173320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6bTm-0000p7-DN
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 11:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4887bfbec=alistair.francis@wdc.com>)
 id 1k6bQU-0003iV-8w
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 11:15:26 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:55679)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4887bfbec=alistair.francis@wdc.com>)
 id 1k6bQS-0007fN-66
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 11:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597418125; x=1628954125;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pyy744F3DcYeTss9mTByW5CPEEq0NerFiagNesu+5ZY=;
 b=GHJ695q9lE7XcGbIX5ypgj1x93Fr0iW3A4EOvX/lfD7RmEVTFOu5UAjw
 tIy1B0kn1tj9g0H6aH5VhFzkAZXDaKVpH3cGcRvEN228HFUIIckuvVYLm
 GESWOjlyAEqjESnoDhkfY8/IzQTjcBGxDLiO6skqLPqOj8t5ZBzlwl5rQ
 xiVTtRRAmOzfxeSLu6oqeHnB198yyoNGLWuCc0NJT9RnSc4qGSQt5GxC5
 T9aa1Y+kXHezENuEaJ2Yu1CfSR4IvNrOaXM6GaIpJeblqHYfPEowt0jro
 cdcSbSzWi5tKOauOoHQlWKdw/dL893He0fLd135xkggdMOoHszP7hFd8y Q==;
IronPort-SDR: 4faAjNGADO+OuOE3PC0jUBDhRdC+axtPFVLV0e1NY/HFsq0wEfswPIWVcpSqDe9OcU0mFE6NBi
 3tNxuAr/AUS8ZHJFZ0zJ3xUQxJSm6oOkSLa73rE209T3rUyBdD6hYYLdtag5EOdeAwtyGyya0A
 dHZ0QRJTBSRBi71raiml25eYNOBDP0UmrSPiOMkvbbJCsG0XvBdCLInEU84OqCZU9y0XxN5GGi
 JPX3swO39aC50iCwZ+xrrvULpKqI7ik98dG3wPIQy9pWIBUgKUpPToRzdU5wyOr80AHpwX44TP
 CPE=
X-IronPort-AV: E=Sophos;i="5.76,312,1592841600"; d="scan'208";a="144994825"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2020 23:15:13 +0800
IronPort-SDR: zQxYHQNvIyoEVRyAbu/pS/y4hC+zmFgQrpfXFZj5u0ejoCE1y6TIs5mMz6rhp31eAJysoEpY9k
 u9AOYvtK20Xg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2020 08:02:17 -0700
IronPort-SDR: eeVj4A8pBahRF/3LPWNFo0dlodAciz4IVnJ9fiR1pOR+vFQdjpG/p7cC1DoRffYX+CShVaEhUx
 ntgfFbNZngFA==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Aug 2020 08:15:12 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 07/20] target/riscv: check before allocating TCG temps
Date: Fri, 14 Aug 2020 08:04:53 -0700
Message-Id: <20200814150506.2070566-8-alistair.francis@wdc.com>
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

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200626205917.4545-5-zhiwei_liu@c-sky.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200724002807.441147-8-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvd.inc.c | 8 ++++----
 target/riscv/insn_trans/trans_rvf.inc.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvd.inc.c b/target/riscv/insn_trans/trans_rvd.inc.c
index ea1044f13b..4f832637fa 100644
--- a/target/riscv/insn_trans/trans_rvd.inc.c
+++ b/target/riscv/insn_trans/trans_rvd.inc.c
@@ -20,10 +20,10 @@
 
 static bool trans_fld(DisasContext *ctx, arg_fld *a)
 {
-    TCGv t0 = tcg_temp_new();
-    gen_get_gpr(t0, a->rs1);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
+    TCGv t0 = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
     tcg_gen_addi_tl(t0, t0, a->imm);
 
     tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], t0, ctx->mem_idx, MO_TEQ);
@@ -35,10 +35,10 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
 
 static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
 {
-    TCGv t0 = tcg_temp_new();
-    gen_get_gpr(t0, a->rs1);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
+    TCGv t0 = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
     tcg_gen_addi_tl(t0, t0, a->imm);
 
     tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, MO_TEQ);
diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
index 138e317723..3dfec8211d 100644
--- a/target/riscv/insn_trans/trans_rvf.inc.c
+++ b/target/riscv/insn_trans/trans_rvf.inc.c
@@ -25,10 +25,10 @@
 
 static bool trans_flw(DisasContext *ctx, arg_flw *a)
 {
-    TCGv t0 = tcg_temp_new();
-    gen_get_gpr(t0, a->rs1);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
+    TCGv t0 = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
     tcg_gen_addi_tl(t0, t0, a->imm);
 
     tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], t0, ctx->mem_idx, MO_TEUL);
@@ -41,11 +41,11 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
 
 static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
 {
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVF);
     TCGv t0 = tcg_temp_new();
     gen_get_gpr(t0, a->rs1);
 
-    REQUIRE_FPU;
-    REQUIRE_EXT(ctx, RVF);
     tcg_gen_addi_tl(t0, t0, a->imm);
 
     tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, MO_TEUL);
-- 
2.27.0


