Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84D1C54FCB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:34:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 875B920700
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ERk39boO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875B920700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSkEH-0007q2-Dc
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 12:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk81-0004d2-NT
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 12:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk80-0004Rm-Um
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 12:27:37 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk80-0004Lu-Bv; Sun, 26 Apr 2020 12:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587918457; x=1619454457;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dQeeIMGAZlib2Uc13aenLwtbzbd6jRXzSxN4B2l5zLw=;
 b=ERk39boOJUlwHlE6/ALpnOrONBzWy4X3UE5k3g1RrfGIjDZH+abthQeF
 9D2dmuWIf+Dk8zBez9QNEqR+Au20nqnYHfrf032y9yMVyjSp2aFcwR1ng
 kggHf0QXUrzCV2OlTAgkfmOCjbabp8bCaWqXjvtjDuzLbbf2nbQ8yjIrL
 d4W4BkBBYf23gq8ZiN5Q4LMJxrJ3oaO03TPfuZy+SQmDkJPbhjc9fI4EL
 7OHuAUWxvAfu36rG9HsctWdHMhDbXHjuWTiI7zErn35anmH0XPsgPG0tI
 5DGLt4WSSPE/vqMcogkw+wP0l7LO70Ra2Cc+6+KAMpDZIvZg3HQkECh9b A==;
IronPort-SDR: ELT0y5bW3gDIFvIUECesRt47fa7YwReWCBg0QviDN/BFwznMVpAJ+O+Ga5N9xMCN5MXqR4IbNS
 pWdlUMD+GzGxmHVaFAywxQePIbtuU7rlHFWB7qXCI2qk9A220M8XvGXDM3pXGdCGPMcpj0qYVg
 +ky9bNRvREy8ttfXBsnUZcLc30Zbi09Wln9QWAAeeg03Tjo5kWqfZ8qTGV/bdLjZRENP19yH6+
 xJ12ursUiFlYwklfxTJwnSUWMyiCD1Olo8WFs7r+E+UBkYH8jFbqdtcBPK7+ztUdBcCAb/KAtA
 OIM=
X-IronPort-AV: E=Sophos;i="5.73,320,1583164800"; d="scan'208";a="137626673"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 00:27:34 +0800
IronPort-SDR: pzqPu2ytwLtSMYdEICat4gGWkbodTRb4T4yFJ6eO7Fqh0Xs4HNuN+6vaBNZa7ERx/MdPxW7+bi
 +mxxgUdgd6tF+5pmbuDRmEeUUR1mVZQWM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2020 09:18:16 -0700
IronPort-SDR: PevcmigpQuhrgo6v5/Z0rvAWuFBAVPP48f03m6yaC5QPb96BD5Elp4bKAEcV2mJ/naJdqfpHtm
 4rISbmlqRawQ==
WDCIronportException: Internal
Received: from wdthnc17-0189.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.56.50])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Apr 2020 09:27:33 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 04/15] target/riscv: Implement checks for hfence
Date: Sun, 26 Apr 2020 09:19:23 -0700
Message-Id: <00639bbec729905cd9ac785447b78b8e2e05b275.1587917657.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1587917657.git.alistair.francis@wdc.com>
References: <cover.1587917657.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=378a396a1=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 12:27:33
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 216.71.154.45
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
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
index 2e91d6ae57..60978f2fa5 100644
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
 
 static bool trans_hfence_bvma(DisasContext *ctx, arg_sfence_vma *a)
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
index c6412f680c..53dca7128d 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -201,4 +201,17 @@ void helper_tlb_flush(CPURISCVState *env)
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


