Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AC6C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:20:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC0262192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WEHqscrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0262192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVznS-0008Tq-Jx
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVz8I-0000Dt-9X; Fri, 23 Oct 2020 11:37:34 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:38922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVz8D-0002ph-Jf; Fri, 23 Oct 2020 11:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603467449; x=1635003449;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4Z/7dayRDSa2KKP8y8Jqwgf1XxejSmUnh8RAME+YzaE=;
 b=WEHqscrIrGwmnbS5lgc26uEWNo7vJaA7E1oHR8wbVvpE7xO+rsF4xBvC
 fqh1LglRkLH7aoseD0ouodQqsllTKgxkCgLkKljRu6hXws4bPCzHo7Y/u
 MhRhUrwjpgiZe3dqOqHtq7S7NIaNam9HK4zogQROeqmFW8m8kbrgjqtPR
 8PPaiJ4c048ldbE0SNkB79co1e9RxPiKZipRHeKRbrM7Hypmwk9s/Pt9n
 trsunqMKq2qrRD2k6eSeIOpdUoh2zu0Mc3qyTYCOp8Yc2YlagchcQqUK+
 yzanhOT5FgnCXB/tZrhb1/UV96toiMZGQsKd6BwlOp7NqIx71JtRuVdpz Q==;
IronPort-SDR: bPoVdAJ6Ficw2ABBlbYj80HXHSYgOT/ZahxKEAnZFBueoUIb1VsCxF6ZKFHYZD+Z3cVh+XpRb9
 3NouTmH8u8yo+w+eC2mUrBar7IHB3wd79V4puM6ymcSAfl7L3LazgxRqkMU07zcfYIc3JTPZse
 CVdl5WlkybrFUoOEMLfuTcZBjUSNlZqSnYjmJFWiaPKKorrZGCACB1IjEEWQrvBT2japvspIrI
 fOm0F8GXPDdq9iZ5RkbPxlzCOLOcSL7qA5RBqptFUaMhx1TcFZ/RqsQzbFi1N2XlpzVKRhVqjg
 CSg=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="260636274"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:37:28 +0800
IronPort-SDR: 0LZ1nLrgc2gWUJZNE/uSRtRyczwY8YC7u4lc+1Fol2hWqfRq4VB6KdlYegujD+FBSK98HuzHku
 JpoSAyznQYDTPaNdzE2FUEAsLfu/ZrIACBXGiIOT3B4WNSgyEsffGq9RWCalRBQ4bCbt9PisfH
 IhMzZIGF8G/r0izgAyDlTyaCREV4wwsOHjSXSXwiOXsEQD+gyqcOf7BckwuTIgf2Ojx2vjVlJq
 G0YkV+eonj3CjP9r0MC5MsRtGVLoarCRWzLy/Eku7YaJmHf1CsnOOop/lCpNiQfSyAKx93oyZr
 uHikAC2wfKT/PXqJKCa3ZhXF
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:23:50 -0700
IronPort-SDR: IJb84/xbLn02tNeuAD0U1/fpjcVLzHLu7lHQxDQW2vI9NauOfedxxvABXbSnS6duhCeYWaNlrB
 8D6Ax7SK/BqHJycTfV11PRv/F/PliPIQV1QMkxeXB6pKX/cJ6ebqkFh0B8B6H4tPrk60cSWC4g
 3S1XVkf8DGas61rUotD/MfelX6BamLQ/3ZTAcoAHPTi/Aw7UbmWe4zohuNToO411CO5tLGJegy
 OtzPYCWTHMwjoLy31v9kA/6gJIhjAysegzNd89tHKIS0q3eauKbCcpdOPl93yHxajtVKHBGaTr
 DGo=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2020 08:37:27 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 3/5] target/riscv: Remove the HS_TWO_STAGE flag
Date: Fri, 23 Oct 2020 08:26:07 -0700
Message-Id: <48ac80cb949569fa0de6379cb8229f588817eb30.1603466725.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603466725.git.alistair.francis@wdc.com>
References: <cover.1603466725.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:37:20
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
Cc: alistair.francis@wdc.com, richard.henderson@linaro.org, bmeng.cn@gmail.com,
 palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The HS_TWO_STAGE flag is no longer required as the MMU index contains
the information if we are performing a two stage access.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  3 +-
 target/riscv/cpu_bits.h   |  1 -
 target/riscv/cpu_helper.c | 61 ++++++++++++++++-----------------------
 target/riscv/op_helper.c  | 12 --------
 4 files changed, 26 insertions(+), 51 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8ac01f3a64..694f51ebd4 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -325,8 +325,7 @@ bool riscv_cpu_virt_enabled(CPURISCVState *env);
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
index bd36062877..20b6ec4ec5 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -480,7 +480,6 @@
  * page table fault.
  */
 #define FORCE_HS_EXCEP      2
-#define HS_TWO_STAGE        4
 
 /* RV32 satp CSR field masks */
 #define SATP32_MODE         0x80000000
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 46b62a0f37..a1f94ea518 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -224,22 +224,9 @@ void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable)
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
@@ -350,7 +337,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
      * was called. Background registers will be used if the guest has
      * forced a two stage translation to be on (in HS or M mode).
      */
-    if (riscv_cpu_two_stage_lookup(env) && access_type != MMU_INST_FETCH) {
+    if ((!riscv_cpu_virt_enabled(env) && riscv_cpu_two_stage_lookup(mmu_idx))
+        && access_type != MMU_INST_FETCH) {
         use_background = true;
     }
 
@@ -589,7 +577,7 @@ restart:
 
 static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
                                 MMUAccessType access_type, bool pmp_violation,
-                                bool first_stage)
+                                bool first_stage, bool two_stage)
 {
     CPUState *cs = env_cpu(env);
     int page_fault_exceptions;
@@ -612,8 +600,7 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
         }
         break;
     case MMU_DATA_LOAD:
-        if ((riscv_cpu_virt_enabled(env) || riscv_cpu_two_stage_lookup(env)) &&
-            !first_stage) {
+        if (two_stage && !first_stage) {
             cs->exception_index = RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT;
         } else {
             cs->exception_index = page_fault_exceptions ?
@@ -621,8 +608,7 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
         }
         break;
     case MMU_DATA_STORE:
-        if ((riscv_cpu_virt_enabled(env) || riscv_cpu_two_stage_lookup(env)) &&
-            !first_stage) {
+        if (two_stage && !first_stage) {
             cs->exception_index = RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
         } else {
             cs->exception_index = page_fault_exceptions ?
@@ -713,6 +699,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     int prot, prot2;
     bool pmp_violation = false;
     bool first_stage_error = true;
+    bool two_stage_lookup = false;
     int ret = TRANSLATE_FAIL;
     int mode = mmu_idx;
     target_ulong tlb_size = 0;
@@ -732,11 +719,12 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         access_type != MMU_INST_FETCH &&
         get_field(env->mstatus, MSTATUS_MPRV) &&
         MSTATUS_MPV_ISSET(env)) {
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
@@ -799,14 +787,6 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                       __func__, address, ret, pa, prot);
     }
 
-    /* We did the two stage lookup based on MPRV, unset the lookup */
-    if (riscv_has_ext(env, RVH) && env->priv == PRV_M &&
-        access_type != MMU_INST_FETCH &&
-        get_field(env->mstatus, MSTATUS_MPRV) &&
-        MSTATUS_MPV_ISSET(env)) {
-        riscv_cpu_set_two_stage_lookup(env, false);
-    }
-
     if (riscv_feature(env, RISCV_FEATURE_PMP) &&
         (ret == TRANSLATE_SUCCESS) &&
         !pmp_hart_has_privs(env, pa, size, 1 << access_type, mode)) {
@@ -828,7 +808,10 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
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
 
@@ -932,9 +915,16 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
@@ -972,11 +962,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
index bc6df6c8c9..556a23f031 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -240,8 +240,6 @@ target_ulong helper_hyp_load(CPURISCVState *env, target_ulong address,
         target_ulong pte;
         int mmu_idx = cpu_mmu_index(env, false) | TB_FLAGS_PRIV_HYP_ACCESS_MASK;
 
-        riscv_cpu_set_two_stage_lookup(env, true);
-
         switch (memop) {
         case MO_SB:
             pte = cpu_ldsb_mmuidx_ra(env, address, mmu_idx, GETPC());
@@ -268,8 +266,6 @@ target_ulong helper_hyp_load(CPURISCVState *env, target_ulong address,
             g_assert_not_reached();
         }
 
-        riscv_cpu_set_two_stage_lookup(env, false);
-
         return pte;
     }
 
@@ -290,8 +286,6 @@ void helper_hyp_store(CPURISCVState *env, target_ulong address,
             get_field(env->hstatus, HSTATUS_HU))) {
         int mmu_idx = cpu_mmu_index(env, false) | TB_FLAGS_PRIV_HYP_ACCESS_MASK;
 
-        riscv_cpu_set_two_stage_lookup(env, true);
-
         switch (memop) {
         case MO_SB:
         case MO_UB:
@@ -312,8 +306,6 @@ void helper_hyp_store(CPURISCVState *env, target_ulong address,
             g_assert_not_reached();
         }
 
-        riscv_cpu_set_two_stage_lookup(env, false);
-
         return;
     }
 
@@ -334,8 +326,6 @@ target_ulong helper_hyp_x_load(CPURISCVState *env, target_ulong address,
         target_ulong pte;
         int mmu_idx = cpu_mmu_index(env, false) | TB_FLAGS_PRIV_HYP_ACCESS_MASK;
 
-        riscv_cpu_set_two_stage_lookup(env, true);
-
         switch (memop) {
         case MO_TEUW:
             pte = cpu_lduw_mmuidx_ra(env, address, mmu_idx, GETPC());
@@ -347,8 +337,6 @@ target_ulong helper_hyp_x_load(CPURISCVState *env, target_ulong address,
             g_assert_not_reached();
         }
 
-        riscv_cpu_set_two_stage_lookup(env, false);
-
         return pte;
     }
 
-- 
2.28.0


