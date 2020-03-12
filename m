Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85214C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:44:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A049206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A049206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQwz-0007nt-JG
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCQwR-0007LA-JQ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:44:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCQwQ-00043t-9J
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:44:15 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:58151)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jCQwP-00042A-Pn; Thu, 12 Mar 2020 12:44:14 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08002406|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.698862-0.000305943-0.300832;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03302; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H-QARbu_1584031445; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H-QARbu_1584031445)
 by smtp.aliyun-inc.com(10.147.44.118);
 Fri, 13 Mar 2020 00:44:05 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v5 52/60] target/riscv: vector iota instruction
Date: Thu, 12 Mar 2020 22:58:52 +0800
Message-Id: <20200312145900.2054-53-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   |  5 ++++
 target/riscv/insn32.decode              |  1 +
 target/riscv/insn_trans/trans_rvv.inc.c | 22 ++++++++++++++++++
 target/riscv/vector_helper.c            | 31 +++++++++++++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 2da967b33b..1a7653a431 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1091,3 +1091,8 @@ DEF_HELPER_4(vmfirst_m, tl, ptr, ptr, env, i32)
 DEF_HELPER_5(vmsbf_m, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vmsif_m, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vmsof_m, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_5(viota_m_b, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(viota_m_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(viota_m_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(viota_m_d, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index b2a11441c8..00b8d2df9d 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -552,6 +552,7 @@ vmfirst_m       010101 . ..... ----- 010 ..... 1010111 @r2_vm
 vmsbf_m         010110 . ..... 00001 010 ..... 1010111 @r2_vm
 vmsif_m         010110 . ..... 00011 010 ..... 1010111 @r2_vm
 vmsof_m         010110 . ..... 00010 010 ..... 1010111 @r2_vm
+viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index c1f4e27743..c7be689553 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2167,3 +2167,25 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
 GEN_M_TRANS(vmsbf_m)
 GEN_M_TRANS(vmsif_m)
 GEN_M_TRANS(vmsof_m)
+
+/* Vector Iota Instruction */
+static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
+{
+    if (vext_check_isa_ill(s, RVV) &&
+        vext_check_reg(s, a->rd, false) &&
+        vext_check_overlap_group(a->rd, 1 << s->lmul, a->rs2, 1) &&
+        (a->vm != 0 || a->rd != 0)) {
+        uint32_t data = 0;
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
+        data = FIELD_DP32(data, VDATA, VM, a->vm);
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        static gen_helper_gvec_3_ptr * const fns[4] = {
+            gen_helper_viota_m_b, gen_helper_viota_m_h,
+            gen_helper_viota_m_w, gen_helper_viota_m_d,
+        };
+        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
+            vreg_ofs(s, a->rs2), cpu_env, 0, s->vlen / 8, data, fns[s->sew]);
+        return true;
+    }
+    return false;
+}
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 073f5dea6a..6089be92fa 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4383,3 +4383,34 @@ void HELPER(vmsof_m)(void *vd, void *v0, void *vs2, CPURISCVState *env,
 {
     vmsetm(vd, v0, vs2, env, desc, ONLY_FIRST);
 }
+
+/* Vector Iota Instruction */
+#define GEN_VEXT_VIOTA_M(NAME, ETYPE, H, CLEAR_FN)                        \
+void HELPER(NAME)(void *vd, void *v0, void *vs2, CPURISCVState *env,      \
+        uint32_t desc)                                                    \
+{                                                                         \
+    uint32_t mlen = vext_mlen(desc);                                      \
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
+    uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vl = env->vl;                                                \
+    uint32_t sum = 0;                                                     \
+    int i;                                                                \
+                                                                          \
+    for (i = 0; i < vl; i++) {                                            \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
+            continue;                                                     \
+        }                                                                 \
+        *((ETYPE *)vd + H(i)) = sum;                                      \
+        if (vext_elem_mask(vs2, mlen, i)) {                               \
+            sum++;                                                        \
+        }                                                                 \
+    }                                                                     \
+    if (i == 0) {                                                         \
+        return;                                                           \
+    }                                                                     \
+    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+}
+GEN_VEXT_VIOTA_M(viota_m_b, uint8_t, H1, clearb)
+GEN_VEXT_VIOTA_M(viota_m_h, uint16_t, H2, clearh)
+GEN_VEXT_VIOTA_M(viota_m_w, uint32_t, H4, clearl)
+GEN_VEXT_VIOTA_M(viota_m_d, uint64_t, H8, clearq)
-- 
2.23.0


