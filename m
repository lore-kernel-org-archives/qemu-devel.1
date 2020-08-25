Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23D6C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 682DF2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KT42SiqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682DF2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeMC-000788-O7
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAeAd-0004rR-Oo
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:47 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58813)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAeAb-0002w2-FA
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598381986; x=1629917986;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=E60vsFyguXLMuMZShHaQ2aDvgZwltzRDstE68nCJACo=;
 b=KT42SiqYR6bwT3Oy4p6HdY7X21SQIoxp29O7LtuxJViUvGhiU1MYXEvo
 4+N4YlZGAmbq90DXRgVKmlMJ5DiKQo4D2N948xDUCBt3eFVpfbh6q+m68
 SNDJw1oZbLjIuaEpbgCSiXmHU6mnDtGkcO4w4FCjuum8Fq95Q2v7btGoC
 9fMyriWpHX/GVfeWhpa4rHZ4HRKj04jTmrZJA04cRGAHNzQ015CUOg2y3
 7YSVJ7eAjTgU1KU1qA08MJkIxEMNsTf0zlBnsvHDO5wRNFTGgX0OLA1NU
 zvpPrzTJY1wqq/SA3nyxIdfRCPrk7WmD2Z3gwlRiF9p3p21Q+gCUG1TIw g==;
IronPort-SDR: /swqzEIu4YwlljbsHXcr8QHTfRDA6uypUoxDQ65Z+RBQ3qqMl6KqZOsJT5Dy3vCeh7cKBqmzWJ
 2E/usR/rPAoanfjtl7xnIGF6UzdnqndD3z7Zq0GrvBSYT59aKqkePGsWRXcWp/1QBK1ChA8DW7
 EYKn7j5+cgmst6T7AakNDCJNst0xOGUQ789APtRq0nTbvwQxeYeEcZgrjKygsyAtELsC5xssb2
 tLaISuLFBaEl+Z9G8sn83zrvO4rVjMEuUSepVrF1cWesUQcc8f/ZApXZuvzPnc2oGxlk2U/+2K
 9hE=
X-IronPort-AV: E=Sophos;i="5.76,353,1592841600"; d="scan'208";a="150145302"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2020 02:58:58 +0800
IronPort-SDR: azwFqZs0muVbu70CBjaeu+7P8D16+dq+gl8cPXQyO/XKS0Rt8UDYNvJcaxqwvcocZ0Xh0swQ+Y
 8HZ/wjwq4F/A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 11:46:33 -0700
IronPort-SDR: mz8wm1xBSwv2mAWLNOrSM4jX1Jho20gyKZAPbxdMnoH979u8iv5E5n4E2j/mxsJGLPBgrmh3PA
 rCVaoumJCMaA==
WDCIronportException: Internal
Received: from ind003389.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.125])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Aug 2020 11:58:57 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/18] target/riscv: Support the Virtual Instruction fault
Date: Tue, 25 Aug 2020 11:48:36 -0700
Message-Id: <20200825184836.1282371-19-alistair.francis@wdc.com>
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
Message-id: 4c744dce9b0b057cbb5cc0f4d4ac75cda682a8af.1597259519.git.alistair.francis@wdc.com
Message-Id: <4c744dce9b0b057cbb5cc0f4d4ac75cda682a8af.1597259519.git.alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h                 |  6 +++
 target/riscv/helper.h                   |  1 +
 target/riscv/csr.c                      | 64 ++++++++++++++++++++++++-
 target/riscv/op_helper.c                | 42 ++++++++++++++--
 target/riscv/insn_trans/trans_rvh.c.inc |  2 +-
 5 files changed, 109 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index d88e2ea30d..bd36062877 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -461,6 +461,11 @@
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
@@ -553,6 +558,7 @@
 #define RISCV_EXCP_STORE_PAGE_FAULT              0xf /* since: priv-1.10.0 */
 #define RISCV_EXCP_INST_GUEST_PAGE_FAULT         0x14
 #define RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT       0x15
+#define RISCV_EXCP_VIRT_INSTRUCTION_FAULT        0x16
 #define RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT  0x17
 
 #define RISCV_EXCP_INT_FLAG                0x80000000
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index c8029d83f9..4b690147fb 100644
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
index 197ce97e95..200001de74 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -75,6 +75,61 @@ static int ctr(CPURISCVState *env, int csrno)
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
@@ -98,6 +153,8 @@ static int hmode(CPURISCVState *env, int csrno)
         if ((env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
             env->priv == PRV_M) {
             return 0;
+        } else {
+            return -RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
         }
     }
 
@@ -340,6 +397,7 @@ static const target_ulong delegable_excps =
     (1ULL << (RISCV_EXCP_STORE_PAGE_FAULT)) |
     (1ULL << (RISCV_EXCP_INST_GUEST_PAGE_FAULT)) |
     (1ULL << (RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT)) |
+    (1ULL << (RISCV_EXCP_VIRT_INSTRUCTION_FAULT)) |
     (1ULL << (RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT));
 static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
     SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
@@ -1238,9 +1296,13 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
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
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 948d204793..9b9ada45a9 100644
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
 
diff --git a/target/riscv/insn_trans/trans_rvh.c.inc b/target/riscv/insn_trans/trans_rvh.c.inc
index db650ae62a..881c9ef4d2 100644
--- a/target/riscv/insn_trans/trans_rvh.c.inc
+++ b/target/riscv/insn_trans/trans_rvh.c.inc
@@ -360,7 +360,7 @@ static bool trans_hfence_gvma(DisasContext *ctx, arg_sfence_vma *a)
 {
     REQUIRE_EXT(ctx, RVH);
 #ifndef CONFIG_USER_ONLY
-    gen_helper_hyp_tlb_flush(cpu_env);
+    gen_helper_hyp_gvma_tlb_flush(cpu_env);
     return true;
 #endif
     return false;
-- 
2.28.0


