Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9295C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:09:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B446F20771
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Mxw6YUox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B446F20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKWc-0005Mi-VW
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUC-0000dI-2h
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:28 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKU9-0004PZ-3V
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592586445; x=1624122445;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XRlfmAxnNO+uf1echkK6NudzAPtFUGkmvCQ9SmWv+Zg=;
 b=Mxw6YUoxCzsUT30KqqdLF8NFP282/TfyNpzmldDIjzc71FbdE/l+AGfu
 /OGjSzOO99ZX4HOY1jwe7XMSUiGxMki89Psg7uBj4MwtiatCPj9Va5H0Z
 IqZB8sVPz5KpJkHap0/c+IjVskviBa64GgEFuBfTld8TDLIorpOaCkJsn
 HknK8kT/NZ8qrzfzOZNbggER41i/RpNCxjfAh0N9rX+2PfyfseCTKtWq+
 47cIrhHr/f6ldmuPwS6A1W8VEZSXGUV4Ky1eFipPDAW6veFU2XDkd17pw
 FTIqDS45RGInFBKhQ9acmcr1JD+/qR6Iu5LtN7tF/9roIf+R/R+xpdJRm g==;
IronPort-SDR: zvPQ5lQqkE9Jp5JINanqI+xo/HUFMIs7K+tY9o3GT72OtI3b191iMRKxYOKJzIBB4uPIEjCLNB
 J6jNTT2LRTwzx29wCVG6rTtLCgCt0mVtjc3Rm1vwq6a8LaoWKpaJzL1RNQWB08YJhPyGC4JvHT
 ZHi8nC1APm9q04sT4lfKiEPg08/qL7+djzZI4J3ZGbkHR676BHSeIzWqNPLA0rzHNsybGYLeml
 LzIx2kZVhkN9tFp1w+3jJ10SDMvVYsNSutuSM7lJIoeWiQ2W14Sgvob8s90YBE/8rk8F6Gf1ZO
 VQc=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; d="scan'208";a="144763295"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 01:07:21 +0800
IronPort-SDR: 36Yx6u1MFk392HGrnJdJUt2DMR7n5TejB6KVLeXb8DUjBZxqSLYqtzACjkBFC3wrLJn0IyRVNU
 2m+Qo3olGxu68tbDHiNmjRqvGpdtzZzPo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 09:55:58 -0700
IronPort-SDR: 2KntkliM+aXblpaEUylXwA5cqhqlUeCI/qc8K2/Ppi2FYGxsdHtQqY5ejIcwm/pdeSxseFsUiE
 RaRzKM37+5AA==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jun 2020 10:07:21 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 01/32] riscv: Add helper to make NaN-boxing for FP register
Date: Fri, 19 Jun 2020 09:57:46 -0700
Message-Id: <20200619165817.4144200-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619165817.4144200-1-alistair.francis@wdc.com>
References: <20200619165817.4144200-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 13:07:21
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Alistair Francis <alistair.francis@wdc.com>,
 Ian Jiang <ianjiang.ict@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ian Jiang <ianjiang.ict@gmail.com>

The function that makes NaN-boxing when a 32-bit value is assigned
to a 64-bit FP register is split out to a helper gen_nanbox_fpr().
Then it is applied in translating of the FLW instruction.

Signed-off-by: Ian Jiang <ianjiang.ict@gmail.com>
Message-Id: <20200128003707.17028-1-ianjiang.ict@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvf.inc.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
index e23cd639a6..3bfd8881e7 100644
--- a/target/riscv/insn_trans/trans_rvf.inc.c
+++ b/target/riscv/insn_trans/trans_rvf.inc.c
@@ -23,6 +23,20 @@
         return false;                       \
 } while (0)
 
+/*
+ * RISC-V requires NaN-boxing of narrower width floating
+ * point values.  This applies when a 32-bit value is
+ * assigned to a 64-bit FP register.  Thus this does not
+ * apply when the RVD extension is not present.
+ */
+static void gen_nanbox_fpr(DisasContext *ctx, int regno)
+{
+    if (has_ext(ctx, RVD)) {
+        tcg_gen_ori_i64(cpu_fpr[regno], cpu_fpr[regno],
+                        MAKE_64BIT_MASK(32, 32));
+    }
+}
+
 static bool trans_flw(DisasContext *ctx, arg_flw *a)
 {
     TCGv t0 = tcg_temp_new();
@@ -32,8 +46,7 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
     tcg_gen_addi_tl(t0, t0, a->imm);
 
     tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], t0, ctx->mem_idx, MO_TEUL);
-    /* RISC-V requires NaN-boxing of narrower width floating point values */
-    tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd], 0xffffffff00000000ULL);
+    gen_nanbox_fpr(ctx, a->rd);
 
     tcg_temp_free(t0);
     mark_fs_dirty(ctx);
-- 
2.27.0


