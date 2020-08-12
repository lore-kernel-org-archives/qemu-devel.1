Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47CBC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:46:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B79E20771
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Iw3MkyTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B79E20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5zVX-0002JZ-IE
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 18:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQW-0002Im-5P
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:40:56 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQU-0005nU-6C
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597272053; x=1628808053;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+7HheV/vsUAjq9/L+MI1eALkSfh8Qj8GNhvxVKV1NM4=;
 b=Iw3MkyTWMPy5Ms/RM1ZY3dVG0zqjhwN2EGWTwe38CIHLk3v7KMtOnCug
 uhbF6wik2gSsUBQbMSG2791Z8A4yhRHbOnOHyFPQkvFEg4X0Bs5df6AHL
 J1ylJW0FErra7iYKEmeAVSbYOfGBWe6CyrWwLtAdgGyXC7qzQSBcWpaTj
 O4J4FFYGpha2h7qdFFKLF1P37rhA9xaLE/1ARzoZvYoo9Oqx/oYLP+THi
 +xR3gjXxUlzuWY1Hp6TZKWEWPoyNMIVrQ41Ws0Eq1XgcXRyr3WRPaMPe6
 YI943oRO6I2XPZm7YyxSW9Wj0W+yw04fYJd7K+bh1IG52BC/iIHTmRgKt g==;
IronPort-SDR: CR6yVkWh6Q9PIhaHWiA6SP6/oO7WPnmEPCbiFYKki7Q8SY7qUad5aIjg3C4ZScTKxGfqXHZ8+S
 +4xCITNt+ZDsBkcXvFyFWif3wDCRRZPj9LhrsFdgL9Ujp0f+h8hum2iMXD95Tdb6spaY7yJWeJ
 Egz5TFtY8L4WuUMoAiyh8stt6DHgOjlBTMR0s+9GB0D8NqY0PmUJekRUiIeWo+JQVFqLvDf/GA
 zUNyXWHAraD0NyKu0d5WgBNZpFFRUr+R4zBmuSctE7visN+IHZXcwOQUyVCYAfQYho6AidNAvK
 +/8=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="254208929"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 06:40:48 +0800
IronPort-SDR: 5sj783Nw9vaWbN8/jWjzhRXzKxyTkSNgeXB8LaopAJn1SNKszTgr2X7e5zTYBlEFVhsIinSnaq
 jTiL4vmDXjug==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 15:27:57 -0700
IronPort-SDR: t/Xqrr41H+n8R8KOPZu7l41UdYcKV2tGyhIsdMklZadd4fbL9uSMlxljMqG2pld64T2frWxIvx
 dqkk4kTmPHow==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Aug 2020 15:40:46 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/20] target/riscv: check before allocating TCG temps
Date: Wed, 12 Aug 2020 15:30:32 -0700
Message-Id: <20200812223045.96803-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200812223045.96803-1-alistair.francis@wdc.com>
References: <20200812223045.96803-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=486123ee4=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 18:40:48
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
index 0d04677a02..16df9c5ee2 100644
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


