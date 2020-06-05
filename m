Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA7DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:30:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CC972067B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HDvQD3a3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC972067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh1CE-00030F-I2
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 21:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1B2-0001Ao-SB; Thu, 04 Jun 2020 21:29:44 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:2751)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1B1-00005E-OA; Thu, 04 Jun 2020 21:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591320584; x=1622856584;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7OG5PQ7EMlGiRWRRP8nKJze1pOtbNJ61V3syvPkO4Go=;
 b=HDvQD3a3PKxAuXGTV93KOTdEJNqV7sISUy3g67GjbyFYTngV19d3zB7o
 GNdv4p+0n8oLdZo6MrzAq33Q/cNjH1ziJ+Q+UCS08UbVXi53PEwPTVsXK
 WEdgZKg9IaOOe13MAAYZmtSF63knyaQrRAoXr/OV7mTJ32tInod0khPWk
 W9df1J6E/bJH2/NurFEG0e1Qyuf3cch0JVhZFDHg0OSllNCo/goXJ4ep0
 YHMZDvMPbtv+atov6C6IlCTnYmEpX7oYHaFAEXFmhO8Z/HyP3A2VnhxRJ
 3epAsXTqcnVneLOjlsYE5QTmYiYY/n7lNBQKl+c2YJxzlevhpM1c8tZkW g==;
IronPort-SDR: jT8YayPcgiSI27bsTQE9+yg7vWRCKDdSzCO3QddPlkvPDMkG4strU4N6CcK362H7Ftm4xfQYzT
 /nwzB1WERjBEunDtVsAl7enjRAXotndVooBJLY5ONJzMS6UGWwuG3FXJ3RMb06P7tjxzI+A+00
 cotCVjvnofPbbaBYpc1mBUzIX1AQkJ2V80r5315OS+FSi8RFkWFYhITCR0UgIv4hZ3dDjtVAKK
 EJ0RSDjEnlwbNqlw9/OGgVUEHgcuQvnDNKfwOWfyt7IONxcF55nvoRNWDvariu0pzACV67BBEh
 GO8=
X-IronPort-AV: E=Sophos;i="5.73,474,1583164800"; d="scan'208";a="143573555"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2020 09:29:41 +0800
IronPort-SDR: rBLSyOicbtdmiqXN5beUek44QVsOzgtClvBpqt2+ThmKJ9jusY+rWQ0d2Hvo/r6f2nEEsegdbw
 2P9j9Kzy5YntNLWca3Qjg009dTAxgqHZE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 18:18:44 -0700
IronPort-SDR: C8vJXJw4ijA4hUhRonxqTv1WJ+xqP0L72uqueMoTsO4V4bWWwfe41zV+vNfm/VYBXZZkVsjoXp
 /UBo0VD0MCKQ==
WDCIronportException: Internal
Received: from cnf006056.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.233])
 by uls-op-cesaip01.wdc.com with ESMTP; 04 Jun 2020 18:29:41 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 04/17] target/riscv: Implement checks for hfence
Date: Thu,  4 Jun 2020 18:20:53 -0700
Message-Id: <c78f245c8d1629f1bce1387ba623a0215767f804.1591319882.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591319882.git.alistair@alistair23.me>
References: <cover.1591319882.git.alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=4185f83b6=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 21:29:41
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Cc: alistair.francis@wdc.com, anup.pate@wdc.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Call the helper_hyp_tlb_flush() function on hfence instructions which
will generate an illegal insruction execption if we don't have
permission to flush the Hypervisor level TLBs.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.26.2


