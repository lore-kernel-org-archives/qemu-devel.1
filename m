Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0B9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:41:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B602074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XGJjMF/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B602074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh1MO-0002Zo-8V
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 21:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1Bc-0002eJ-GF; Thu, 04 Jun 2020 21:30:20 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22008)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1Ba-00009e-Sw; Thu, 04 Jun 2020 21:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591320620; x=1622856620;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XtFXVwCUFAT+vA4t+gi7sUhQmPPR6tChBZbYsaiL+2s=;
 b=XGJjMF/ATjCidfJn0DRPQ/F4fqdmpx3th38iXXTNC7+4AAJZ9Y2hvEvh
 a0FA2gqshWviD6lrGm708Gh3TI/Oz6isna0kxYeJwqcvs/zTs7Zqte9uM
 zKXId5TBIvKwXI8sJsU6ja3HlIuDZnqFPOXSK0LddOukugRR7WRcT9qGH
 EuW9D9UyUQsnuyMWUa9rWkgW4OzdEmc1fzxDwUSUmx1GtRmj9azdBXkJO
 u6LFkAZjMEOUW6JGgc1buDxfvbgSAkEuI2OMGfx0RUsDkgC+Ug7NU6ggo
 lbhvzQIAXMrn/NVj/oJ1pTmMemDb0u6CSIauDYyWDLewrwhQsN5IIEKu+ g==;
IronPort-SDR: OKfpnROFraPGghyvTwRQh2NJtdkJRh8E7S2BTVyE6M6DOgTOqKcWpHnXzAxZ0PxGM5GNs2CYvo
 1xaNjYLTY+fteVn5TsBLieuSsRBbs4M/8Wc7wKLfOBZ+NLTzKFoU8QM8Pz10YoPKrNjhCu1eAa
 49gdhxxI2wLtq/WoC3GQL1NeVhAEOpZwnJYEjQNGMgZPaKpZBT4zHORu/okMXKM/VG1NzbVQ29
 zDWmgU8pOUGS89Pjd6/rKhktOJVxnAbjWxmFgbizfM3lAUQOXCpqwK+jG6qmZilPboIJ3rDNZ6
 ++4=
X-IronPort-AV: E=Sophos;i="5.73,474,1583164800"; d="scan'208";a="242127074"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2020 09:30:20 +0800
IronPort-SDR: xaN3f4KkLXVuUwQ4AdZpIQJdbCONtPaUayN461UsL7RrA5zChhmypZKTpqGO0k4vUoIJe1ANJ5
 PYQOAxnf/9wzlGpRF0VaWYMhnDIuNpYtk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 18:19:53 -0700
IronPort-SDR: nW3FLPfTD5ZoXt9O4yRPaRVX+6W18ka6PcMRLSWbmisOQTJIrRsc0i92pv/U1ARVpbaQa6r9Fx
 b8KQuRKn2HYA==
WDCIronportException: Internal
Received: from cnf006056.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.233])
 by uls-op-cesaip01.wdc.com with ESMTP; 04 Jun 2020 18:30:18 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 17/17] target/riscv: Support the Virtual Instruction fault
Date: Thu,  4 Jun 2020 18:21:29 -0700
Message-Id: <399681975d78747509166baccabc870a7646048a.1591319882.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591319882.git.alistair@alistair23.me>
References: <cover.1591319882.git.alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=4185f83b6=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 21:30:00
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h                 |  6 +++
 target/riscv/helper.h                   |  1 +
 target/riscv/csr.c                      | 64 ++++++++++++++++++++++++-
 target/riscv/insn_trans/trans_rvh.inc.c |  2 +-
 target/riscv/op_helper.c                | 42 ++++++++++++++--
 5 files changed, 109 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 690f327828..30fa746d10 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -446,6 +446,11 @@
 #define HSTATUS_WPRI HSTATUS64_WPRI
 #endif
 
+#define HCOUNTEREN_CY        (1 << 0)
+#define HCOUNTEREN_TM        (1 << 1)
+#define HCOUNTEREN_IR        (1 << 2)
+#define HCOUNTEREN_HPM3      (1 << 3)
+
 /* Privilege modes */
 #define PRV_U 0
 #define PRV_S 1
@@ -538,6 +543,7 @@
 #define RISCV_EXCP_STORE_PAGE_FAULT              0xf /* since: priv-1.10.0 */
 #define RISCV_EXCP_INST_GUEST_PAGE_FAULT         0x14
 #define RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT       0x15
+#define RISCV_EXCP_VIRT_INSTRUCTION_FAULT        0x16
 #define RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT  0x17
 
 #define RISCV_EXCP_INT_FLAG                0x80000000
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index d020d1459c..2df7e09766 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -80,6 +80,7 @@ DEF_HELPER_1(tlb_flush, void, env)
 /* Hypervisor functions */
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(hyp_tlb_flush, void, env)
+DEF_HELPER_1(hyp_gvma_tlb_flush, void, env)
 DEF_HELPER_4(hyp_load, tl, env, tl, tl, tl)
 DEF_HELPER_5(hyp_store, void, env, tl, tl, tl, tl)
 DEF_HELPER_4(hyp_x_load, tl, env, tl, tl, tl)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 0c53438605..4909059baf 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -63,6 +63,61 @@ static int ctr(CPURISCVState *env, int csrno)
         /* The Counters extensions is not enabled */
         return -RISCV_EXCP_ILLEGAL_INST;
     }
+
+    if (riscv_cpu_virt_enabled(env)) {
+        switch (csrno) {
+        case CSR_CYCLE:
+            if (!get_field(env->hcounteren, HCOUNTEREN_CY) &&
+                get_field(env->mcounteren, HCOUNTEREN_CY)) {
+                return -RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
+            }
+            break;
+        case CSR_TIME:
+            if (!get_field(env->hcounteren, HCOUNTEREN_TM) &&
+                get_field(env->mcounteren, HCOUNTEREN_TM)) {
+                return -RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
+            }
+            break;
+        case CSR_INSTRET:
+            if (!get_field(env->hcounteren, HCOUNTEREN_IR) &&
+                get_field(env->mcounteren, HCOUNTEREN_IR)) {
+                return -RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
+            }
+            break;
+        case CSR_HPMCOUNTER3...CSR_HPMCOUNTER31:
+            if (!get_field(env->hcounteren, 1 << (csrno - CSR_HPMCOUNTER3)) &&
+                get_field(env->mcounteren, 1 << (csrno - CSR_HPMCOUNTER3))) {
+                return -RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
+            }
+            break;
+#if defined(TARGET_RISCV32)
+        case CSR_CYCLEH:
+            if (!get_field(env->hcounteren, HCOUNTEREN_CY) &&
+                get_field(env->mcounteren, HCOUNTEREN_CY)) {
+                return -RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
+            }
+            break;
+        case CSR_TIMEH:
+            if (!get_field(env->hcounteren, HCOUNTEREN_TM) &&
+                get_field(env->mcounteren, HCOUNTEREN_TM)) {
+                return -RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
+            }
+            break;
+        case CSR_INSTRETH:
+            if (!get_field(env->hcounteren, HCOUNTEREN_IR) &&
+                get_field(env->mcounteren, HCOUNTEREN_IR)) {
+                return -RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
+            }
+            break;
+        case CSR_HPMCOUNTER3H...CSR_HPMCOUNTER31H:
+            if (!get_field(env->hcounteren, 1 << (csrno - CSR_HPMCOUNTER3H)) &&
+                get_field(env->mcounteren, 1 << (csrno - CSR_HPMCOUNTER3H))) {
+                return -RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
+            }
+            break;
+#endif
+        }
+    }
 #endif
     return 0;
 }
@@ -86,6 +141,8 @@ static int hmode(CPURISCVState *env, int csrno)
         if ((env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
             env->priv == PRV_M) {
             return 0;
+        } else {
+            return -RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
         }
     }
 
@@ -272,6 +329,7 @@ static const target_ulong delegable_excps =
     (1ULL << (RISCV_EXCP_STORE_PAGE_FAULT)) |
     (1ULL << (RISCV_EXCP_INST_GUEST_PAGE_FAULT)) |
     (1ULL << (RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT)) |
+    (1ULL << (RISCV_EXCP_VIRT_INSTRUCTION_FAULT)) |
     (1ULL << (RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT));
 static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
     SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
@@ -1170,9 +1228,13 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
     }
 
     /* check predicate */
-    if (!csr_ops[csrno].predicate || csr_ops[csrno].predicate(env, csrno) < 0) {
+    if (!csr_ops[csrno].predicate) {
         return -RISCV_EXCP_ILLEGAL_INST;
     }
+    ret = csr_ops[csrno].predicate(env, csrno);
+    if (ret < 0) {
+        return ret;
+    }
 
     /* execute combined read/write operation if it exists */
     if (csr_ops[csrno].op) {
diff --git a/target/riscv/insn_trans/trans_rvh.inc.c b/target/riscv/insn_trans/trans_rvh.inc.c
index db650ae62a..881c9ef4d2 100644
--- a/target/riscv/insn_trans/trans_rvh.inc.c
+++ b/target/riscv/insn_trans/trans_rvh.inc.c
@@ -360,7 +360,7 @@ static bool trans_hfence_gvma(DisasContext *ctx, arg_sfence_vma *a)
 {
     REQUIRE_EXT(ctx, RVH);
 #ifndef CONFIG_USER_ONLY
-    gen_helper_hyp_tlb_flush(cpu_env);
+    gen_helper_hyp_gvma_tlb_flush(cpu_env);
     return true;
 #endif
     return false;
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 80d632777b..d1f1a46335 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -94,6 +94,11 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
 
+    if (riscv_has_ext(env, RVH) && riscv_cpu_virt_enabled(env) &&
+        get_field(env->hstatus, HSTATUS_VTSR)) {
+        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
+    }
+
     mstatus = env->mstatus;
 
     if (riscv_has_ext(env, RVH) && !riscv_cpu_virt_enabled(env)) {
@@ -176,7 +181,7 @@ void helper_wfi(CPURISCVState *env)
     if ((env->priv == PRV_S &&
         get_field(env->mstatus, MSTATUS_TW)) ||
         riscv_cpu_virt_enabled(env)) {
-        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
     } else {
         cs->halted = 1;
         cs->exception_index = EXCP_HLT;
@@ -191,6 +196,9 @@ void helper_tlb_flush(CPURISCVState *env)
         (env->priv == PRV_S &&
          get_field(env->mstatus, MSTATUS_TVM))) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    } else if (riscv_has_ext(env, RVH) && riscv_cpu_virt_enabled(env) &&
+               get_field(env->hstatus, HSTATUS_VTVM)) {
+        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
     } else {
         tlb_flush(cs);
     }
@@ -200,6 +208,10 @@ void helper_hyp_tlb_flush(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);
 
+    if (env->priv == PRV_S && riscv_cpu_virt_enabled(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
+    }
+
     if (env->priv == PRV_M ||
         (env->priv == PRV_S && !riscv_cpu_virt_enabled(env))) {
         tlb_flush(cs);
@@ -209,6 +221,16 @@ void helper_hyp_tlb_flush(CPURISCVState *env)
     riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
 }
 
+void helper_hyp_gvma_tlb_flush(CPURISCVState *env)
+{
+    if (env->priv == PRV_S && !riscv_cpu_virt_enabled(env) &&
+        get_field(env->mstatus, MSTATUS_TVM)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    }
+
+    helper_hyp_tlb_flush(env);
+}
+
 target_ulong helper_hyp_load(CPURISCVState *env, target_ulong address,
                              target_ulong attrs, target_ulong memop)
 {
@@ -251,7 +273,11 @@ target_ulong helper_hyp_load(CPURISCVState *env, target_ulong address,
         return pte;
     }
 
-    riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    if (riscv_cpu_virt_enabled(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
+    } else {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    }
     return 0;
 }
 
@@ -289,7 +315,11 @@ void helper_hyp_store(CPURISCVState *env, target_ulong address,
         return;
     }
 
-    riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    if (riscv_cpu_virt_enabled(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
+    } else {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    }
 }
 
 target_ulong helper_hyp_x_load(CPURISCVState *env, target_ulong address,
@@ -319,7 +349,11 @@ target_ulong helper_hyp_x_load(CPURISCVState *env, target_ulong address,
         return pte;
     }
 
-    riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    if (riscv_cpu_virt_enabled(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
+    } else {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    }
     return 0;
 }
 
-- 
2.26.2


