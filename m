Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A68C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5CE020838
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PY1sqiCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5CE020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5wQ6-0004pH-7E
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 15:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5wLO-0004hv-Ss; Wed, 12 Aug 2020 15:23:26 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4814)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5wLN-0000RC-4x; Wed, 12 Aug 2020 15:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597260205; x=1628796205;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mBVne42E+z7WjzcmTmyYMYMA7SNAuVmXUkFCmKBKgCA=;
 b=PY1sqiCVVBzcsmKezZJywSMjKmiQqpHb6C3YYsXLcHm2amM1l/J5qn+E
 CdkjNQFdSrTMB88hEezYD1fcERmDDHYJmfXAUXFSyxq9ZXZS0+AcSBZ2e
 nlX05cGF9vfde2CTKskK6H7Xj2MOxYM/RkSfZOlUGQEJhgZCdTR+sX+OP
 nwL/ltyFHjT3q38dTVQSwdg9OKuvSST/luel0mn5dLyc2Y7hefnbcV7mg
 2ubt5KS1QE4qDNqwHvJMTZJU/sBurqdEXOZNzpZ32CLUZOn564Da3CVW7
 s5cHyKSd1Yb4Qs+9lpfKzpQZyAijetPYSL6kIUTiGXmvXI5Qo+N/2XcoH w==;
IronPort-SDR: ykHOFWJ5zgPSOcnQgqMNe7Au01LkhD6Wxt2jkcAjCEi50HnDN/RiA0O1++8WcLx5PhKK4m1r7Z
 K0hG6seNzYFuW6eT3iPJS6n8c9aiLZSnjXD56piHIqGY65jJqUxju8afgplya3ZiWSIoo5D3j/
 M0XPxdhEqJ49RAHRc2NNNL8jzAJN+nvlKG7h/ncyXwDzTxtpKX2w1oCyyoDYA2fHuroH8uNF54
 GFQ5J3jkhO60woyElfGAy/A9CTA42jo8VT/LT3HKSH7FQLY1cUJCSZ1pi1vGq3Bc9LfIias5do
 VDM=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="146029196"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 03:23:23 +0800
IronPort-SDR: ZFlXZx/5V0I7SSOfmELKhpgu5SghfTLyYcpVTEDmpW2esLK9ISLuS2AbGawhsDsHhAhMkXcoKb
 xRzf/GLofC6Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 12:10:30 -0700
IronPort-SDR: lRBo3PVA30BiJAYMpqkkFc1H1Crb7vhCRJj3qEf1q856c7yHy70PhTqNvB7Cq3FJW8HMK9HP8p
 cclYjraY5j/A==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip02.wdc.com with ESMTP; 12 Aug 2020 12:23:23 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 03/13] target/riscv: Do two-stage lookups on hlv/hlvx/hsv
 instructions
Date: Wed, 12 Aug 2020 12:13:22 -0700
Message-Id: <024ad8a594fb2feaf0950fbfad1508cfa82ce7f0.1597259519.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597259519.git.alistair.francis@wdc.com>
References: <cover.1597259519.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=486123ee4=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 15:23:20
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
Cc: alistair.francis@wdc.com, anup.patel@wdc.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 60 ++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 35 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 68abccc993..10c9f8b63b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -340,22 +340,13 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
      * was called. Background registers will be used if the guest has
      * forced a two stage translation to be on (in HS or M mode).
      */
+    if (riscv_cpu_two_stage_lookup(env) && access_type != MMU_INST_FETCH) {
+        use_background = true;
+    }
+
     if (mode == PRV_M && access_type != MMU_INST_FETCH) {
         if (get_field(env->mstatus, MSTATUS_MPRV)) {
             mode = get_field(env->mstatus, MSTATUS_MPP);
-
-            if (riscv_has_ext(env, RVH) &&
-                MSTATUS_MPV_ISSET(env)) {
-                use_background = true;
-            }
-        }
-    }
-
-    if (mode == PRV_S && access_type != MMU_INST_FETCH &&
-        riscv_has_ext(env, RVH) && !riscv_cpu_virt_enabled(env)) {
-        if (get_field(env->hstatus, HSTATUS_SPRV)) {
-            mode = get_field(env->mstatus, SSTATUS_SPP);
-            use_background = true;
         }
     }
 
@@ -607,7 +598,8 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
         }
         break;
     case MMU_DATA_LOAD:
-        if (riscv_cpu_virt_enabled(env) && !first_stage) {
+        if ((riscv_cpu_virt_enabled(env) || riscv_cpu_two_stage_lookup(env)) &&
+            !first_stage) {
             cs->exception_index = RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT;
         } else {
             cs->exception_index = page_fault_exceptions ?
@@ -615,7 +607,8 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
         }
         break;
     case MMU_DATA_STORE:
-        if (riscv_cpu_virt_enabled(env) && !first_stage) {
+        if ((riscv_cpu_virt_enabled(env) || riscv_cpu_two_stage_lookup(env)) &&
+            !first_stage) {
             cs->exception_index = RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
         } else {
             cs->exception_index = page_fault_exceptions ?
@@ -705,8 +698,6 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     hwaddr pa = 0;
     int prot, prot2;
     bool pmp_violation = false;
-    bool m_mode_two_stage = false;
-    bool hs_mode_two_stage = false;
     bool first_stage_error = true;
     int ret = TRANSLATE_FAIL;
     int mode = mmu_idx;
@@ -716,30 +707,21 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
                   __func__, address, access_type, mmu_idx);
 
-    /*
-     * Determine if we are in M mode and MPRV is set or in HS mode and SPRV is
-     * set and we want to access a virtulisation address.
-     */
-    if (riscv_has_ext(env, RVH)) {
-        m_mode_two_stage = env->priv == PRV_M &&
-                           access_type != MMU_INST_FETCH &&
-                           get_field(env->mstatus, MSTATUS_MPRV) &&
-                           MSTATUS_MPV_ISSET(env);
-
-        hs_mode_two_stage = env->priv == PRV_S &&
-                            !riscv_cpu_virt_enabled(env) &&
-                            access_type != MMU_INST_FETCH &&
-                            get_field(env->hstatus, HSTATUS_SPRV) &&
-                            get_field(env->hstatus, HSTATUS_SPV);
-    }
-
     if (mode == PRV_M && access_type != MMU_INST_FETCH) {
         if (get_field(env->mstatus, MSTATUS_MPRV)) {
             mode = get_field(env->mstatus, MSTATUS_MPP);
         }
     }
 
-    if (riscv_cpu_virt_enabled(env) || m_mode_two_stage || hs_mode_two_stage) {
+    if (riscv_has_ext(env, RVH) && env->priv == PRV_M &&
+        access_type != MMU_INST_FETCH &&
+        get_field(env->mstatus, MSTATUS_MPRV) &&
+        MSTATUS_MPV_ISSET(env)) {
+        riscv_cpu_set_two_stage_lookup(env, true);
+    }
+
+    if (riscv_cpu_virt_enabled(env) ||
+        (riscv_cpu_two_stage_lookup(env) && access_type != MMU_INST_FETCH)) {
         /* Two stage lookup */
         ret = get_physical_address(env, &pa, &prot, address, access_type,
                                    mmu_idx, true, true);
@@ -791,6 +773,14 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                       __func__, address, ret, pa, prot);
     }
 
+    /* We did the two stage lookup based on MPRV, unset the lookup */
+    if (riscv_has_ext(env, RVH) && env->priv == PRV_M &&
+        access_type != MMU_INST_FETCH &&
+        get_field(env->mstatus, MSTATUS_MPRV) &&
+        MSTATUS_MPV_ISSET(env)) {
+        riscv_cpu_set_two_stage_lookup(env, false);
+    }
+
     if (riscv_feature(env, RISCV_FEATURE_PMP) &&
         (ret == TRANSLATE_SUCCESS) &&
         !pmp_hart_has_privs(env, pa, size, 1 << access_type, mode)) {
-- 
2.27.0


