Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78172C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C2820752
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C2820752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFWY-0001aC-Cx
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEFVT-0008VE-5U
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:55:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jEFVR-0003xI-PR
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:55:55 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:40747)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jEFVR-0002W1-8R; Tue, 17 Mar 2020 12:55:53 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07669276|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.606618-0.000358709-0.393023;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03305; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H1.IAzM_1584464144; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H1.IAzM_1584464144)
 by smtp.aliyun-inc.com(10.147.44.118);
 Wed, 18 Mar 2020 00:55:45 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v6 54/61] target/riscv: vector element index instruction
Date: Tue, 17 Mar 2020 23:06:46 +0800
Message-Id: <20200317150653.9008-55-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/helper.h                   |  5 +++++
 target/riscv/insn32.decode              |  2 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 21 ++++++++++++++++++++
 target/riscv/vector_helper.c            | 26 +++++++++++++++++++++++++
 4 files changed, 54 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 8e7bef8f96..3d0e2e72bd 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1104,3 +1104,8 @@ DEF_HELPER_5(viota_m_b, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(viota_m_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(viota_m_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(viota_m_d, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_4(vid_v_b, void, ptr, ptr, env, i32)
+DEF_HELPER_4(vid_v_h, void, ptr, ptr, env, i32)
+DEF_HELPER_4(vid_v_w, void, ptr, ptr, env, i32)
+DEF_HELPER_4(vid_v_d, void, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 37756fa76d..1231628cb2 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -70,6 +70,7 @@
 @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
 @r2_nfvm ... ... vm:1 ..... ..... ... ..... ....... &r2nfvm %nf %rs1 %rd
 @r2_vm   ...... vm:1 ..... ..... ... ..... ....... &rmr %rs2 %rd
+@r1_vm   ...... vm:1 ..... ..... ... ..... ....... %rd
 @r_nfvm  ... ... vm:1 ..... ..... ... ..... ....... &rnfvm %nf %rs2 %rs1 %rd
 @r_vm    ...... vm:1 ..... ..... ... ..... ....... &rmrr %rs2 %rs1 %rd
 @r_vm_1  ...... . ..... ..... ... ..... .......    &rmrr vm=1 %rs2 %rs1 %rd
@@ -559,6 +560,7 @@ vmsbf_m         010110 . ..... 00001 010 ..... 1010111 @r2_vm
 vmsif_m         010110 . ..... 00011 010 ..... 1010111 @r2_vm
 vmsof_m         010110 . ..... 00010 010 ..... 1010111 @r2_vm
 viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
+vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 798e7c7cff..fae72acaa1 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2326,3 +2326,24 @@ static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
     }
     return false;
 }
+
+/* Vector Element Index Instruction */
+static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
+{
+    if (vext_check_isa_ill(s) &&
+        vext_check_reg(s, a->rd, false) &&
+        vext_check_overlap_mask(s, a->rd, a->vm, false)) {
+        uint32_t data = 0;
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
+        data = FIELD_DP32(data, VDATA, VM, a->vm);
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        static gen_helper_gvec_2_ptr * const fns[4] = {
+            gen_helper_vid_v_b, gen_helper_vid_v_h,
+            gen_helper_vid_v_w, gen_helper_vid_v_d,
+        };
+        tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
+            cpu_env, 0, s->vlen / 8, data, fns[s->sew]);
+        return true;
+    }
+    return false;
+}
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 43bf61caca..769894c5be 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4647,3 +4647,29 @@ GEN_VEXT_VIOTA_M(viota_m_b, uint8_t, H1, clearb)
 GEN_VEXT_VIOTA_M(viota_m_h, uint16_t, H2, clearh)
 GEN_VEXT_VIOTA_M(viota_m_w, uint32_t, H4, clearl)
 GEN_VEXT_VIOTA_M(viota_m_d, uint64_t, H8, clearq)
+
+/* Vector Element Index Instruction */
+#define GEN_VEXT_VID_V(NAME, ETYPE, H, CLEAR_FN)                          \
+void HELPER(NAME)(void *vd, void *v0, CPURISCVState *env, uint32_t desc)  \
+{                                                                         \
+    uint32_t mlen = vext_mlen(desc);                                      \
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
+    uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vl = env->vl;                                                \
+    int i;                                                                \
+                                                                          \
+    if (vl == 0) {                                                        \
+        return;                                                           \
+    }                                                                     \
+    for (i = 0; i < vl; i++) {                                            \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
+            continue;                                                     \
+        }                                                                 \
+        *((ETYPE *)vd + H(i)) = i;                                        \
+    }                                                                     \
+    CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));          \
+}
+GEN_VEXT_VID_V(vid_v_b, uint8_t, H1, clearb)
+GEN_VEXT_VID_V(vid_v_h, uint16_t, H2, clearh)
+GEN_VEXT_VID_V(vid_v_w, uint32_t, H4, clearl)
+GEN_VEXT_VID_V(vid_v_d, uint64_t, H8, clearq)
-- 
2.23.0


