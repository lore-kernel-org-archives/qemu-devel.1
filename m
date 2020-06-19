Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46F3C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:19:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7D3214DB
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WDJrDpta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7D3214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKfO-0001pa-KU
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUL-0000pi-Mp
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:38 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUG-0004PR-3M
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592586452; x=1624122452;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=melHyBNyq+GBsmbi68L0crjn+k4ZDNG0okkKwoQJd1E=;
 b=WDJrDptaXabXE60fGKqvHWkSaLIZVwVAF09vb/6YHOf4Vox6xnMsdqh+
 06deDkso/fcM53Y+W3JKiuY0FfRoHTuAhh2sHFyjfn0fW42wgGnOpOTnf
 aIYeGF+0U3JD03ShxNbbcxRXvOzeCFrXi0GZfr4zXwprVriic7elo4NoN
 mZPTgwJ+LnU6CCdDvzVJXfxZCZ8rztXD0Ve6saYTNI9DYfJAOg6QeTa1K
 C4H/Ci1B+PUYUMsJS+n29S3Y05dIA7Mey9+trQVWJH0xk2oPz8tac3BFx
 uxWQqw4Kg3mfIhHlpNwR8QrEdFyFL4oTk5TbpVAzn5znAkNgzagYPIkOO w==;
IronPort-SDR: 2f2e9DrkxKt0TvInIYK+8XLU55FlPFCIZOc6LBxBCnQJ4b7JGuHa7eLBEZjdJsGBZmRnABU/lx
 pt30hgmTL37pX6q7s+T/8sg3RB1669HaeYmSxyPiX0SzneDKz3C9ICSlYFJsvVl6WZnQ9d60xV
 9jFLSuTSjlp0uTdiDVLp43nTcPQiN9puWaHIQHyCJ9++g85tRbUDuEgF3NJ/zAqUEz7r2ZCTeH
 laSpWvOv8iXCj4+8hXCAcMt7loAZg2O1vvVNQbdqSDGl6OMjsE+QqtwoDTp5scpzHzx1stRxzm
 as0=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; d="scan'208";a="144763327"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 01:07:23 +0800
IronPort-SDR: 6xwowBLhNMZu9tJKEt1fWW8OFsgB067nmoS/k2xZG4Aw5tg0Ywwag3KORIpLbnyot5hUwf8qaK
 +HpGonOZzaiDx5ze78x+nEE9K8MhaYuAk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 09:56:33 -0700
IronPort-SDR: tX4WVnppWyeEaM/LdRYn1c9CUUefhDT+KGF6VXtu4JxYNd/6Fe68k+lerR/HdZmM1XNMQ1441N
 Kgjpd5r4rLPw==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jun 2020 10:07:24 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 10/32] target/riscv: Implement checks for hfence
Date: Fri, 19 Jun 2020 09:57:55 -0700
Message-Id: <20200619165817.4144200-11-alistair.francis@wdc.com>
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
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Call the helper_hyp_tlb_flush() function on hfence instructions which
will generate an illegal insruction execption if we don't have
permission to flush the Hypervisor level TLBs.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/helper.h                   |  5 ++++
 target/riscv/insn_trans/trans_rvh.inc.c | 32 +++++--------------------
 target/riscv/op_helper.c                | 13 ++++++++++
 3 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index debb22a480..b36be978d5 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -76,3 +76,8 @@ DEF_HELPER_2(mret, tl, env, tl)
 DEF_HELPER_1(wfi, void, env)
 DEF_HELPER_1(tlb_flush, void, env)
 #endif
+
+/* Hypervisor functions */
+#ifndef CONFIG_USER_ONLY
+DEF_HELPER_1(hyp_tlb_flush, void, env)
+#endif
diff --git a/target/riscv/insn_trans/trans_rvh.inc.c b/target/riscv/insn_trans/trans_rvh.inc.c
index 2c0359819d..263b652d90 100644
--- a/target/riscv/insn_trans/trans_rvh.inc.c
+++ b/target/riscv/insn_trans/trans_rvh.inc.c
@@ -18,40 +18,20 @@
 
 static bool trans_hfence_gvma(DisasContext *ctx, arg_sfence_vma *a)
 {
+    REQUIRE_EXT(ctx, RVH);
 #ifndef CONFIG_USER_ONLY
-    if (ctx->priv_ver >= PRIV_VERSION_1_10_0 &&
-        has_ext(ctx, RVH)) {
-        /* Hpervisor extensions exist */
-        /*
-         * if (env->priv == PRV_M ||
-         *   (env->priv == PRV_S &&
-         *    !riscv_cpu_virt_enabled(env) &&
-         *    get_field(ctx->mstatus_fs, MSTATUS_TVM))) {
-         */
-            gen_helper_tlb_flush(cpu_env);
-            return true;
-        /* } */
-    }
+    gen_helper_hyp_tlb_flush(cpu_env);
+    return true;
 #endif
     return false;
 }
 
 static bool trans_hfence_vvma(DisasContext *ctx, arg_sfence_vma *a)
 {
+    REQUIRE_EXT(ctx, RVH);
 #ifndef CONFIG_USER_ONLY
-    if (ctx->priv_ver >= PRIV_VERSION_1_10_0 &&
-        has_ext(ctx, RVH)) {
-        /* Hpervisor extensions exist */
-        /*
-         * if (env->priv == PRV_M ||
-         *   (env->priv == PRV_S &&
-         *    !riscv_cpu_virt_enabled(env) &&
-         *    get_field(ctx->mstatus_fs, MSTATUS_TVM))) {
-         */
-            gen_helper_tlb_flush(cpu_env);
-            return true;
-        /* } */
-    }
+    gen_helper_hyp_tlb_flush(cpu_env);
+    return true;
 #endif
     return false;
 }
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index b0c49efc4a..7cccd42a1e 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -194,4 +194,17 @@ void helper_tlb_flush(CPURISCVState *env)
     }
 }
 
+void helper_hyp_tlb_flush(CPURISCVState *env)
+{
+    CPUState *cs = env_cpu(env);
+
+    if (env->priv == PRV_M ||
+        (env->priv == PRV_S && !riscv_cpu_virt_enabled(env))) {
+        tlb_flush(cs);
+        return;
+    }
+
+    riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+}
+
 #endif /* !CONFIG_USER_ONLY */
-- 
2.27.0


