Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BBCC2BB1D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D754206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D754206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQv7-00068c-LF
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCQuT-0004XQ-7W
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCQuR-0000bu-T5
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:42:13 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:44255)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jCQuR-0000Wq-E6; Thu, 12 Mar 2020 12:42:11 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.0811598|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.00322337-0.000962777-0.995814;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03301; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H-Q3d9P_1584031324; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H-Q3d9P_1584031324)
 by smtp.aliyun-inc.com(10.147.42.241);
 Fri, 13 Mar 2020 00:42:05 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v5 51/60] target/riscv: set-X-first mask bit
Date: Thu, 12 Mar 2020 22:58:51 +0800
Message-Id: <20200312145900.2054-52-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
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
Cc: guoren@linux.alibaba.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com, wenmeng_zhang@c-sky.com,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/helper.h                   |  4 ++
 target/riscv/insn32.decode              |  3 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 23 +++++++++
 target/riscv/vector_helper.c            | 66 +++++++++++++++++++++++++
 4 files changed, 96 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 363bc52dc4..2da967b33b 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1087,3 +1087,7 @@ DEF_HELPER_6(vmxnor_mm, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_4(vmpopc_m, tl, ptr, ptr, env, i32)
 
 DEF_HELPER_4(vmfirst_m, tl, ptr, ptr, env, i32)
+
+DEF_HELPER_5(vmsbf_m, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vmsif_m, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vmsof_m, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 328a6c75bb..b2a11441c8 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -549,6 +549,9 @@ vmornot_mm      011100 - ..... ..... 010 ..... 1010111 @r
 vmxnor_mm       011111 - ..... ..... 010 ..... 1010111 @r
 vmpopc_m        010100 . ..... ----- 010 ..... 1010111 @r2_vm
 vmfirst_m       010101 . ..... ----- 010 ..... 1010111 @r2_vm
+vmsbf_m         010110 . ..... 00001 010 ..... 1010111 @r2_vm
+vmsif_m         010110 . ..... 00011 010 ..... 1010111 @r2_vm
+vmsof_m         010110 . ..... 00010 010 ..... 1010111 @r2_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 265d94245f..c1f4e27743 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2144,3 +2144,26 @@ static bool trans_vmfirst_m(DisasContext *s, arg_rmr *a)
     }
     return false;
 }
+
+/* vmsbf.m set-before-first mask bit */
+/* vmsif.m set-includ-first mask bit */
+/* vmsof.m set-only-first mask bit */
+#define GEN_M_TRANS(NAME)                                          \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
+{                                                                  \
+    if (vext_check_isa_ill(s, RVV)) {                              \
+        uint32_t data = 0;                                         \
+        gen_helper_gvec_3_ptr * fn = gen_helper_##NAME;            \
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);             \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd),                     \
+            vreg_ofs(s, 0), vreg_ofs(s, a->rs2),                   \
+            cpu_env, 0, s->vlen / 8, data, fn);                    \
+        return true;                                               \
+    }                                                              \
+    return false;                                                  \
+}
+GEN_M_TRANS(vmsbf_m)
+GEN_M_TRANS(vmsif_m)
+GEN_M_TRANS(vmsof_m)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 8a3f8ccdec..073f5dea6a 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4317,3 +4317,69 @@ target_ulong HELPER(vmfirst_m)(void *v0, void *vs2, CPURISCVState *env,
     }
     return -1LL;
 }
+
+enum set_mask_type {
+    ONLY_FIRST = 1,
+    INCLUDE_FIRST,
+    BEFORE_FIRST,
+};
+
+static void vmsetm(void *vd, void *v0, void *vs2, CPURISCVState *env,
+        uint32_t desc, enum set_mask_type type)
+{
+    uint32_t mlen = vext_mlen(desc);
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;
+    uint32_t vm = vext_vm(desc);
+    uint32_t vl = env->vl;
+    int i;
+    bool first_mask_bit = false;
+
+    for (i = 0; i < vl; i++) {
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        /* write a zero to all following active elements */
+        if (first_mask_bit) {
+            vext_set_elem_mask(vd, mlen, i, 0);
+            continue;
+        }
+        if (vext_elem_mask(vs2, mlen, i)) {
+            first_mask_bit = true;
+            if (type == BEFORE_FIRST) {
+                vext_set_elem_mask(vd, mlen, i, 0);
+            } else {
+                vext_set_elem_mask(vd, mlen, i, 1);
+            }
+        } else {
+            if (type == ONLY_FIRST) {
+                vext_set_elem_mask(vd, mlen, i, 0);
+            } else {
+                vext_set_elem_mask(vd, mlen, i, 1);
+            }
+        }
+    }
+    if (i == 0) { /* vector register writeback is cancelled when vl == 0*/
+        return;
+    }
+    for (; i < vlmax; i++) {
+        vext_set_elem_mask(vd, mlen, i, 0);
+    }
+}
+
+void HELPER(vmsbf_m)(void *vd, void *v0, void *vs2, CPURISCVState *env,
+        uint32_t desc)
+{
+    vmsetm(vd, v0, vs2, env, desc, BEFORE_FIRST);
+}
+
+void HELPER(vmsif_m)(void *vd, void *v0, void *vs2, CPURISCVState *env,
+        uint32_t desc)
+{
+    vmsetm(vd, v0, vs2, env, desc, INCLUDE_FIRST);
+}
+
+void HELPER(vmsof_m)(void *vd, void *v0, void *vs2, CPURISCVState *env,
+        uint32_t desc)
+{
+    vmsetm(vd, v0, vs2, env, desc, ONLY_FIRST);
+}
-- 
2.23.0


