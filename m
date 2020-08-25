Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C268C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:02:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB6CE2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Iu6UlxPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6CE2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeDN-0000LC-1a
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAe9y-0003gX-Kj
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:06 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAe9w-0002vn-N0
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598381945; x=1629917945;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TU1cCEPzubrHs64fD2uz3bj2lnpTyVMXjl8IKCqlV0U=;
 b=Iu6UlxPQPfUzrRZ4lE0wSbgIGUc0djQnek4CeNLk0LjJ1brzI5UeWOUd
 8SC7Ztnjy5QeYHL2LlDGRjds61W30ONWr2jSt1z2T23Pgm8yTwrnDipBN
 23++P2ZKMpxu5GExGd9vvYP8YparYXAHsRLFgbYSUP6c788iGKLHRko3r
 grdNBwwvCXHRR9Y0Hck4zrCDEN66weIjqYE3/CtICeFYgfoCSFDb5NleB
 iMiG/MZ4zyGOQDwG3h8IEMgm+AB4Upglds6QfNvnVnpJ+kgKWzudhdqbp
 51UPUQafw/0j7m9zcGfSHEcg1gJyoUbATOMwuxEdWVmpZnWe7nbLJX8lU g==;
IronPort-SDR: AEnBY5gEjynDspC6gqyTfTpQO60znkWp1djYzjiFWVQLnIHSKV9wcuo4czvsayYmU3+wqgmcnu
 6j0g69+BhDokbCYGKBxumvK0QEctXiLNWvGs4cp9/lLzJzbBD/V1lpccammXtXBPZExckIodbG
 r/IwZEFPHPdfapfCHX6E7zh0RTay6YDqNsFWT3nWsHqB0AMB4PG940TvlCsq7fUu9xFVfd2S4/
 T91N+IyFXkkEr0cg8XGhYK+iY1jlvPbN/zHk0kJk9IP7dgKfRMgLaQsvuXh7KZSCSw0TNbkqv3
 mQg=
X-IronPort-AV: E=Sophos;i="5.76,353,1592841600"; d="scan'208";a="150145290"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2020 02:58:56 +0800
IronPort-SDR: l0c1sa/WPbtnmgWXDTIcS9CjbyMiLkbld29f2+jVM+1vQWQMNEhSydg11EF7AulrG0n3cTPkot
 EwWYkr/G9bPQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 11:46:31 -0700
IronPort-SDR: fJcMZktbCQvH/VE5bOv58YqJcMID80OoMWz5b4Px1k4WO1HjrFglqVn3X7l7Pyav2uC8e5svC8
 QKqdNOx/S0MQ==
WDCIronportException: Internal
Received: from ind003389.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.125])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Aug 2020 11:58:55 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/18] target/riscv: Do two-stage lookups on hlv/hlvx/hsv
 instructions
Date: Tue, 25 Aug 2020 11:48:26 -0700
Message-Id: <20200825184836.1282371-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825184836.1282371-1-alistair.francis@wdc.com>
References: <20200825184836.1282371-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=49978a6e9=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 14:58:53
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alistair23@gmail.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 024ad8a594fb2feaf0950fbfad1508cfa82ce7f0.1597259519.git.alistair.francis@wdc.com
Message-Id: <024ad8a594fb2feaf0950fbfad1508cfa82ce7f0.1597259519.git.alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 60 ++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 35 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e5e0d80c32..5efb3b16e0 100644
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
 
@@ -608,7 +599,8 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
         }
         break;
     case MMU_DATA_LOAD:
-        if (riscv_cpu_virt_enabled(env) && !first_stage) {
+        if ((riscv_cpu_virt_enabled(env) || riscv_cpu_two_stage_lookup(env)) &&
+            !first_stage) {
             cs->exception_index = RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT;
         } else {
             cs->exception_index = page_fault_exceptions ?
@@ -616,7 +608,8 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
         }
         break;
     case MMU_DATA_STORE:
-        if (riscv_cpu_virt_enabled(env) && !first_stage) {
+        if ((riscv_cpu_virt_enabled(env) || riscv_cpu_two_stage_lookup(env)) &&
+            !first_stage) {
             cs->exception_index = RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
         } else {
             cs->exception_index = page_fault_exceptions ?
@@ -706,8 +699,6 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     hwaddr pa = 0;
     int prot, prot2;
     bool pmp_violation = false;
-    bool m_mode_two_stage = false;
-    bool hs_mode_two_stage = false;
     bool first_stage_error = true;
     int ret = TRANSLATE_FAIL;
     int mode = mmu_idx;
@@ -718,30 +709,21 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
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
@@ -793,6 +775,14 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
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
2.28.0


