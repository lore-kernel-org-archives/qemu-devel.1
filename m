Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFEEC388F9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4699206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XjQSZ2J2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4699206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka2Zm-0001cG-Jv
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 15:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1ka2Vq-00053x-O9; Tue, 03 Nov 2020 15:02:38 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1ka2Vo-0002nd-CM; Tue, 03 Nov 2020 15:02:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604433756; x=1635969756;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9rA9n4f4nUibZKw+l7MKNeBuzVCCkbKZGwJg6NPpfY0=;
 b=XjQSZ2J2PcCv0P4jjnpKxsfQFsLORYafMiCss9sgphNyNQWGd2N/xSrP
 OA63Xo2C2LIf7aoW8g54NMmx8kPTr1jvkIAI2gN7w0gz6S7UV/P9OrUOG
 ifI0l6Eo76octK1XO5qg6EdvwZk6pQltXtKAeotEAqqf6rfH5JC3G2Q8a
 QE0IuebSdjDcvvmWRKYbqfIjbB/dOKUPOV4I05zzoJxIzlzo5K2nUHB0g
 kWdBxkV7iyAtNLx0smKI6OhmEQcHt35wFqXJbIcahguMHFU+rSEMu3yrx
 wGWhOTjACXl5GqOC1o2PW4geC9AB1Fz+2+wykEKfOfmqXoope1lIdWEcY w==;
IronPort-SDR: ss/RoGQ0IksMXT9BrYQse30sG8qwMCMyolgJrs12+94naT5BXR6VhjQEyM2a4Ww93EGSrbunDQ
 vVXiLJZbFCInVsuhEY2mN6V3dW0m47h/3ag3h0Tr7efO9S5FaeALQZK2c0d0g88UbIYGZnQ3Cj
 VB7pXTg+zvVQWdKO3HEmLBuvpaI0UwMk8x8MQXAV8JyT+/ukfJXKepIDsGwdl6jkEgSO9E2ms/
 3TxvenGjpKUH4hDhmT6dtbe83agGWLA986t6nYvjHil0u4jO01WiEt3zd3nUmBeketPSl/za/S
 KHg=
X-IronPort-AV: E=Sophos;i="5.77,448,1596470400"; d="scan'208";a="151793192"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2020 04:02:34 +0800
IronPort-SDR: c8jcz1KkRZYsHSuLDhJf+v2F09+/Mx1cGmZGdy9iiwf5AvQEGeOujeMEBeKrX/GuUecQ+hAIJc
 hhndHKVbcdUF4OVOlKCfzSMHG4WAes05HCqwywPNMGlZCBI528e4mYyeffuGq04ur6P+egy2Ed
 YYXMqMQ1LgZKHiNal+quTm9rixQWK2kQvUnANprVBwgu3yQmN0vJjZ8VlQPpsPL/xhNic4JuNb
 ciU0+yonRxmxqvkEi9EMmk7kk3QRxFSvcG64gDZRFhN0dT3XcbuH5YgWdLc7hrNQDvF3VoDKhl
 M3wHIfrapek9TCZAKzjyInEj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 11:47:32 -0800
IronPort-SDR: AmIoc+3ASJZQKwtRCAbKE5vvULFnd7vow3E3nprgY3UeJnJdb6zbMSl5tt9tPrydUOxwdoHNx+
 eSCJU7GKLYiqWjX2fBFQvcNkn3uEduyRegCcIioipLFWSAieGVcwtYM4xPN8Lc+eMzEbe0ATNU
 79Lojt0PqkwV2HREEvrDOQh0Z4iAfjmy2OXRawPYF0/T2R5OM9ExqxnkpMKb1tS5hbA76gKAHQ
 hIHLhrH+3EnckXec2iZEeoaqAtoaEMR5mi0t8i3Z+hI3brapAmauJ7zObZ9tEBp++7rpBIHtJS
 Xy4=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2020 12:02:34 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 4/7] target/riscv: Remove the HS_TWO_STAGE flag
Date: Tue,  3 Nov 2020 11:51:03 -0800
Message-Id: <0f672ebbc70670711ef0d8dcf8fe51d39cbf2095.1604432950.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604432950.git.alistair.francis@wdc.com>
References: <cover.1604432950.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=569a91e0c=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 14:48:57
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
Cc: richard.henderson@linaro.org, alistair.francis@wdc.com, bmeng.cn@gmail.com,
 palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The HS_TWO_STAGE flag is no longer required as the MMU index contains
the information if we are performing a two stage access.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.h        |  3 +-
 target/riscv/cpu_bits.h   |  1 -
 target/riscv/cpu_helper.c | 60 ++++++++++++++++-----------------------
 target/riscv/op_helper.c  | 12 --------
 4 files changed, 25 insertions(+), 51 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5d8e54c426..0cf48a1521 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -323,8 +323,7 @@ bool riscv_cpu_virt_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env);
 void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable);
-bool riscv_cpu_two_stage_lookup(CPURISCVState *env);
-void riscv_cpu_set_two_stage_lookup(CPURISCVState *env, bool enable);
+bool riscv_cpu_two_stage_lookup(int mmu_idx);
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
 hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index daedad8691..24b24c69c5 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -469,7 +469,6 @@
  * page table fault.
  */
 #define FORCE_HS_EXCEP      2
-#define HS_TWO_STAGE        4
 
 /* RV32 satp CSR field masks */
 #define SATP32_MODE         0x80000000
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 453e4c6d8a..dd891264c2 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -211,22 +211,9 @@ void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable)
     env->virt = set_field(env->virt, FORCE_HS_EXCEP, enable);
 }
 
-bool riscv_cpu_two_stage_lookup(CPURISCVState *env)
+bool riscv_cpu_two_stage_lookup(int mmu_idx)
 {
-    if (!riscv_has_ext(env, RVH)) {
-        return false;
-    }
-
-    return get_field(env->virt, HS_TWO_STAGE);
-}
-
-void riscv_cpu_set_two_stage_lookup(CPURISCVState *env, bool enable)
-{
-    if (!riscv_has_ext(env, RVH)) {
-        return;
-    }
-
-    env->virt = set_field(env->virt, HS_TWO_STAGE, enable);
+    return mmu_idx & TB_FLAGS_PRIV_HYP_ACCESS_MASK;
 }
 
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
@@ -337,7 +324,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
      * was called. Background registers will be used if the guest has
      * forced a two stage translation to be on (in HS or M mode).
      */
-    if (riscv_cpu_two_stage_lookup(env) && access_type != MMU_INST_FETCH) {
+    if (!riscv_cpu_virt_enabled(env) && riscv_cpu_two_stage_lookup(mmu_idx)) {
         use_background = true;
     }
 
@@ -576,7 +563,7 @@ restart:
 
 static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
                                 MMUAccessType access_type, bool pmp_violation,
-                                bool first_stage)
+                                bool first_stage, bool two_stage)
 {
     CPUState *cs = env_cpu(env);
     int page_fault_exceptions;
@@ -599,8 +586,7 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
         }
         break;
     case MMU_DATA_LOAD:
-        if ((riscv_cpu_virt_enabled(env) || riscv_cpu_two_stage_lookup(env)) &&
-            !first_stage) {
+        if (two_stage && !first_stage) {
             cs->exception_index = RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT;
         } else {
             cs->exception_index = page_fault_exceptions ?
@@ -608,8 +594,7 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
         }
         break;
     case MMU_DATA_STORE:
-        if ((riscv_cpu_virt_enabled(env) || riscv_cpu_two_stage_lookup(env)) &&
-            !first_stage) {
+        if (two_stage && !first_stage) {
             cs->exception_index = RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
         } else {
             cs->exception_index = page_fault_exceptions ?
@@ -700,6 +685,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     int prot, prot2;
     bool pmp_violation = false;
     bool first_stage_error = true;
+    bool two_stage_lookup = false;
     int ret = TRANSLATE_FAIL;
     int mode = mmu_idx;
     target_ulong tlb_size = 0;
@@ -719,11 +705,12 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         access_type != MMU_INST_FETCH &&
         get_field(env->mstatus, MSTATUS_MPRV) &&
         get_field(env->mstatus, MSTATUS_MPV)) {
-        riscv_cpu_set_two_stage_lookup(env, true);
+        two_stage_lookup = true;
     }
 
     if (riscv_cpu_virt_enabled(env) ||
-        (riscv_cpu_two_stage_lookup(env) && access_type != MMU_INST_FETCH)) {
+        ((riscv_cpu_two_stage_lookup(mmu_idx) || two_stage_lookup) &&
+         access_type != MMU_INST_FETCH)) {
         /* Two stage lookup */
         ret = get_physical_address(env, &pa, &prot, address,
                                    &env->guest_phys_fault_addr, access_type,
@@ -786,14 +773,6 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                       __func__, address, ret, pa, prot);
     }
 
-    /* We did the two stage lookup based on MPRV, unset the lookup */
-    if (riscv_has_ext(env, RVH) && env->priv == PRV_M &&
-        access_type != MMU_INST_FETCH &&
-        get_field(env->mstatus, MSTATUS_MPRV) &&
-        get_field(env->mstatus, MSTATUS_MPV)) {
-        riscv_cpu_set_two_stage_lookup(env, false);
-    }
-
     if (riscv_feature(env, RISCV_FEATURE_PMP) &&
         (ret == TRANSLATE_SUCCESS) &&
         !pmp_hart_has_privs(env, pa, size, 1 << access_type, mode)) {
@@ -815,7 +794,10 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     } else if (probe) {
         return false;
     } else {
-        raise_mmu_exception(env, address, access_type, pmp_violation, first_stage_error);
+        raise_mmu_exception(env, address, access_type, pmp_violation,
+                            first_stage_error,
+                            riscv_cpu_virt_enabled(env) ||
+                                riscv_cpu_two_stage_lookup(mmu_idx));
         riscv_raise_exception(env, cs->exception_index, retaddr);
     }
 
@@ -919,9 +901,16 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         /* handle the trap in S-mode */
         if (riscv_has_ext(env, RVH)) {
             target_ulong hdeleg = async ? env->hideleg : env->hedeleg;
+            bool two_stage_lookup = false;
+
+            if (env->priv == PRV_M ||
+                (env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
+                (env->priv == PRV_U && !riscv_cpu_virt_enabled(env) &&
+                    get_field(env->hstatus, HSTATUS_HU))) {
+                    two_stage_lookup = true;
+            }
 
-            if ((riscv_cpu_virt_enabled(env) ||
-                 riscv_cpu_two_stage_lookup(env)) && write_tval) {
+            if ((riscv_cpu_virt_enabled(env) || two_stage_lookup) && write_tval) {
                 /*
                  * If we are writing a guest virtual address to stval, set
                  * this to 1. If we are trapping to VS we will set this to 0
@@ -959,11 +948,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                 riscv_cpu_set_force_hs_excep(env, 0);
             } else {
                 /* Trap into HS mode */
-                if (!riscv_cpu_two_stage_lookup(env)) {
+                if (!two_stage_lookup) {
                     env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
                                              riscv_cpu_virt_enabled(env));
                 }
-                riscv_cpu_set_two_stage_lookup(env, false);
                 htval = env->guest_phys_fault_addr;
             }
         }
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 548c5851ec..5759850e69 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -237,8 +237,6 @@ target_ulong helper_hyp_load(CPURISCVState *env, target_ulong address,
         target_ulong pte;
         int mmu_idx = cpu_mmu_index(env, false) | TB_FLAGS_PRIV_HYP_ACCESS_MASK;
 
-        riscv_cpu_set_two_stage_lookup(env, true);
-
         switch (memop) {
         case MO_SB:
             pte = cpu_ldsb_mmuidx_ra(env, address, mmu_idx, GETPC());
@@ -265,8 +263,6 @@ target_ulong helper_hyp_load(CPURISCVState *env, target_ulong address,
             g_assert_not_reached();
         }
 
-        riscv_cpu_set_two_stage_lookup(env, false);
-
         return pte;
     }
 
@@ -287,8 +283,6 @@ void helper_hyp_store(CPURISCVState *env, target_ulong address,
             get_field(env->hstatus, HSTATUS_HU))) {
         int mmu_idx = cpu_mmu_index(env, false) | TB_FLAGS_PRIV_HYP_ACCESS_MASK;
 
-        riscv_cpu_set_two_stage_lookup(env, true);
-
         switch (memop) {
         case MO_SB:
         case MO_UB:
@@ -309,8 +303,6 @@ void helper_hyp_store(CPURISCVState *env, target_ulong address,
             g_assert_not_reached();
         }
 
-        riscv_cpu_set_two_stage_lookup(env, false);
-
         return;
     }
 
@@ -331,8 +323,6 @@ target_ulong helper_hyp_x_load(CPURISCVState *env, target_ulong address,
         target_ulong pte;
         int mmu_idx = cpu_mmu_index(env, false) | TB_FLAGS_PRIV_HYP_ACCESS_MASK;
 
-        riscv_cpu_set_two_stage_lookup(env, true);
-
         switch (memop) {
         case MO_TEUW:
             pte = cpu_lduw_mmuidx_ra(env, address, mmu_idx, GETPC());
@@ -344,8 +334,6 @@ target_ulong helper_hyp_x_load(CPURISCVState *env, target_ulong address,
             g_assert_not_reached();
         }
 
-        riscv_cpu_set_two_stage_lookup(env, false);
-
         return pte;
     }
 
-- 
2.28.0


