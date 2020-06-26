Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E45C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:16:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45908208C7
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hmEgE/0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45908208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joweS-0007Az-HX
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowIf-0003cr-RJ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:54:21 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowId-0002ze-61
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208459; x=1624744459;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cttxp14qlu91Siey662iMEwUQUnm2NNd/NtAS4WFcB0=;
 b=hmEgE/0oYsr3+R5q9IlzPIXaad/lqyCbtG9Ykrv4/MZpHCVVDsQLp8Uj
 4J33hE7orIw4wOVGdezjatYyKu6ZxoP6n3tSnRbE6B/nJx9Oh9rruRXVg
 FTileffMAb3h1ZHi6hgGbQu+gsF6Drx51sye6TSnq/nZKxJfgOi1hp2Hi
 8l1VU7UQTAT5Lse+/dyqq1IR4K/0xOeExjRWhKOoz/JANeFo7ZadSqLgy
 QgCPpzsqIXgLNlxprNNTc3H3qyT8U82gsxO5QmSCOIg8Jq9fZfBT+mjAQ
 jqQNHMUYNeuU5IwMbUOxZzRfzfcZqDKWTt23sPQHKaGcSxmp0+urc3BEl g==;
IronPort-SDR: Ndu4sRd+CyO8HwtLzL90Zdh149i2ndX5luPXtXKXc4LnTqaltgD1XCzYE7gdXEI16dEK/HOyh8
 uc0f0gZ7+hpufUR9WxDZlu1iY485J7XQK6IG/rGszkkcHgkm4Kyyi41iTcUNtD3N5EN/+f8cQZ
 FhwLgmhdnwvyXX5XFavtvikj5xyJtd/Bg6q/rDtfnjk2V5JUfc0S61rI35HMKQw6H9dfZZATth
 VjegeImpv2IcQPLNqsGOOLnSS7c62xBAOG+hgq81UbCfhyNeQFsMt/U+uBgsMHG2XK2Rzebj+I
 5YU=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="250261265"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:41 +0800
IronPort-SDR: HSclzmyymCXbKnZ0dnEoogiqM4B7HCdCKWnTILZEZ5CFHM0Yg5cucZmI/hDGBvAIJ/8wHODn7k
 QpjfGxOWmKlN3NyPDngHdvqt7e17WDu4w=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:39 -0700
IronPort-SDR: 4ace/MNYNGy8VT2RoptgaBDg9VzQhCVXQ4DlIl5yVAFA50SFCtUXhHEw0Y9AY4iCU8xBwWrtg2
 gKz5Ly3l/trg==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:41 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 25/63] target/riscv: vector integer merge and move instructions
Date: Fri, 26 Jun 2020 14:43:32 -0700
Message-Id: <20200626214410.3613258-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200626214410.3613258-1-alistair.francis@wdc.com>
References: <20200626214410.3613258-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=439617756=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 17:53:37
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: alistair23@gmail.com, Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200623215920.2594-24-zhiwei_liu@c-sky.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  17 ++++
 target/riscv/insn32.decode              |   7 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 113 ++++++++++++++++++++++++
 target/riscv/vector_helper.c            |  88 ++++++++++++++++++
 4 files changed, 225 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 1249ee274d..9851086730 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -675,3 +675,20 @@ DEF_HELPER_6(vwmaccsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vwmaccus_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vwmaccus_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vwmaccus_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vmerge_vvm_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmerge_vvm_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmerge_vvm_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmerge_vvm_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmerge_vxm_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmerge_vxm_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmerge_vxm_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vmerge_vxm_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_4(vmv_v_v_b, void, ptr, ptr, env, i32)
+DEF_HELPER_4(vmv_v_v_h, void, ptr, ptr, env, i32)
+DEF_HELPER_4(vmv_v_v_w, void, ptr, ptr, env, i32)
+DEF_HELPER_4(vmv_v_v_d, void, ptr, ptr, env, i32)
+DEF_HELPER_4(vmv_v_x_b, void, ptr, i64, env, i32)
+DEF_HELPER_4(vmv_v_x_h, void, ptr, i64, env, i32)
+DEF_HELPER_4(vmv_v_x_w, void, ptr, i64, env, i32)
+DEF_HELPER_4(vmv_v_x_d, void, ptr, i64, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 843c15f8fa..238aa014d1 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -71,6 +71,7 @@
 @r_nfvm  ... ... vm:1 ..... ..... ... ..... ....... &rnfvm %nf %rs2 %rs1 %rd
 @r_vm    ...... vm:1 ..... ..... ... ..... ....... &rmrr %rs2 %rs1 %rd
 @r_vm_1  ...... . ..... ..... ... ..... .......    &rmrr vm=1 %rs2 %rs1 %rd
+@r_vm_0  ...... . ..... ..... ... ..... .......    &rmrr vm=0 %rs2 %rs1 %rd
 @r_wdvm  ..... wd:1 vm:1 ..... ..... ... ..... ....... &rwdvm %rs2 %rs1 %rd
 @r2_zimm . zimm:11  ..... ... ..... ....... %rs1 %rd
 
@@ -402,6 +403,12 @@ vwmacc_vx       111101 . ..... ..... 110 ..... 1010111 @r_vm
 vwmaccsu_vv     111110 . ..... ..... 010 ..... 1010111 @r_vm
 vwmaccsu_vx     111110 . ..... ..... 110 ..... 1010111 @r_vm
 vwmaccus_vx     111111 . ..... ..... 110 ..... 1010111 @r_vm
+vmv_v_v         010111 1 00000 ..... 000 ..... 1010111 @r2
+vmv_v_x         010111 1 00000 ..... 100 ..... 1010111 @r2
+vmv_v_i         010111 1 00000 ..... 011 ..... 1010111 @r2
+vmerge_vvm      010111 0 ..... ..... 000 ..... 1010111 @r_vm_0
+vmerge_vxm      010111 0 ..... ..... 100 ..... 1010111 @r_vm_0
+vmerge_vim      010111 0 ..... ..... 011 ..... 1010111 @r_vm_0
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 24e43c615c..f9532ebc71 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1618,3 +1618,116 @@ GEN_OPIVX_WIDEN_TRANS(vwmaccu_vx)
 GEN_OPIVX_WIDEN_TRANS(vwmacc_vx)
 GEN_OPIVX_WIDEN_TRANS(vwmaccsu_vx)
 GEN_OPIVX_WIDEN_TRANS(vwmaccus_vx)
+
+/* Vector Integer Merge and Move Instructions */
+static bool trans_vmv_v_v(DisasContext *s, arg_vmv_v_v *a)
+{
+    if (vext_check_isa_ill(s) &&
+        vext_check_reg(s, a->rd, false) &&
+        vext_check_reg(s, a->rs1, false)) {
+
+        if (s->vl_eq_vlmax) {
+            tcg_gen_gvec_mov(s->sew, vreg_ofs(s, a->rd),
+                             vreg_ofs(s, a->rs1),
+                             MAXSZ(s), MAXSZ(s));
+        } else {
+            uint32_t data = FIELD_DP32(0, VDATA, LMUL, s->lmul);
+            static gen_helper_gvec_2_ptr * const fns[4] = {
+                gen_helper_vmv_v_v_b, gen_helper_vmv_v_v_h,
+                gen_helper_vmv_v_v_w, gen_helper_vmv_v_v_d,
+            };
+            TCGLabel *over = gen_new_label();
+            tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+
+            tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs1),
+                               cpu_env, 0, s->vlen / 8, data, fns[s->sew]);
+            gen_set_label(over);
+        }
+        return true;
+    }
+    return false;
+}
+
+typedef void gen_helper_vmv_vx(TCGv_ptr, TCGv_i64, TCGv_env, TCGv_i32);
+static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
+{
+    if (vext_check_isa_ill(s) &&
+        vext_check_reg(s, a->rd, false)) {
+
+        TCGv s1;
+        TCGLabel *over = gen_new_label();
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+
+        s1 = tcg_temp_new();
+        gen_get_gpr(s1, a->rs1);
+
+        if (s->vl_eq_vlmax) {
+            tcg_gen_gvec_dup_tl(s->sew, vreg_ofs(s, a->rd),
+                                MAXSZ(s), MAXSZ(s), s1);
+        } else {
+            TCGv_i32 desc ;
+            TCGv_i64 s1_i64 = tcg_temp_new_i64();
+            TCGv_ptr dest = tcg_temp_new_ptr();
+            uint32_t data = FIELD_DP32(0, VDATA, LMUL, s->lmul);
+            static gen_helper_vmv_vx * const fns[4] = {
+                gen_helper_vmv_v_x_b, gen_helper_vmv_v_x_h,
+                gen_helper_vmv_v_x_w, gen_helper_vmv_v_x_d,
+            };
+
+            tcg_gen_ext_tl_i64(s1_i64, s1);
+            desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
+            tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, a->rd));
+            fns[s->sew](dest, s1_i64, cpu_env, desc);
+
+            tcg_temp_free_ptr(dest);
+            tcg_temp_free_i32(desc);
+            tcg_temp_free_i64(s1_i64);
+        }
+
+        tcg_temp_free(s1);
+        gen_set_label(over);
+        return true;
+    }
+    return false;
+}
+
+static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
+{
+    if (vext_check_isa_ill(s) &&
+        vext_check_reg(s, a->rd, false)) {
+
+        int64_t simm = sextract64(a->rs1, 0, 5);
+        if (s->vl_eq_vlmax) {
+            tcg_gen_gvec_dup_imm(s->sew, vreg_ofs(s, a->rd),
+                                 MAXSZ(s), MAXSZ(s), simm);
+        } else {
+            TCGv_i32 desc;
+            TCGv_i64 s1;
+            TCGv_ptr dest;
+            uint32_t data = FIELD_DP32(0, VDATA, LMUL, s->lmul);
+            static gen_helper_vmv_vx * const fns[4] = {
+                gen_helper_vmv_v_x_b, gen_helper_vmv_v_x_h,
+                gen_helper_vmv_v_x_w, gen_helper_vmv_v_x_d,
+            };
+            TCGLabel *over = gen_new_label();
+            tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+
+            s1 = tcg_const_i64(simm);
+            dest = tcg_temp_new_ptr();
+            desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
+            tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, a->rd));
+            fns[s->sew](dest, s1, cpu_env, desc);
+
+            tcg_temp_free_ptr(dest);
+            tcg_temp_free_i32(desc);
+            tcg_temp_free_i64(s1);
+            gen_set_label(over);
+        }
+        return true;
+    }
+    return false;
+}
+
+GEN_OPIVV_TRANS(vmerge_vvm, opivv_vadc_check)
+GEN_OPIVX_TRANS(vmerge_vxm, opivx_vadc_check)
+GEN_OPIVI_TRANS(vmerge_vim, 0, vmerge_vxm, opivx_vadc_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index f53a530377..6e67f1d62d 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -2024,3 +2024,91 @@ GEN_VEXT_VX(vwmaccsu_vx_w, 4, 8, clearq)
 GEN_VEXT_VX(vwmaccus_vx_b, 1, 2, clearh)
 GEN_VEXT_VX(vwmaccus_vx_h, 2, 4, clearl)
 GEN_VEXT_VX(vwmaccus_vx_w, 4, 8, clearq)
+
+/* Vector Integer Merge and Move Instructions */
+#define GEN_VEXT_VMV_VV(NAME, ETYPE, H, CLEAR_FN)                    \
+void HELPER(NAME)(void *vd, void *vs1, CPURISCVState *env,           \
+                  uint32_t desc)                                     \
+{                                                                    \
+    uint32_t vl = env->vl;                                           \
+    uint32_t esz = sizeof(ETYPE);                                    \
+    uint32_t vlmax = vext_maxsz(desc) / esz;                         \
+    uint32_t i;                                                      \
+                                                                     \
+    for (i = 0; i < vl; i++) {                                       \
+        ETYPE s1 = *((ETYPE *)vs1 + H(i));                           \
+        *((ETYPE *)vd + H(i)) = s1;                                  \
+    }                                                                \
+    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                         \
+}
+
+GEN_VEXT_VMV_VV(vmv_v_v_b, int8_t,  H1, clearb)
+GEN_VEXT_VMV_VV(vmv_v_v_h, int16_t, H2, clearh)
+GEN_VEXT_VMV_VV(vmv_v_v_w, int32_t, H4, clearl)
+GEN_VEXT_VMV_VV(vmv_v_v_d, int64_t, H8, clearq)
+
+#define GEN_VEXT_VMV_VX(NAME, ETYPE, H, CLEAR_FN)                    \
+void HELPER(NAME)(void *vd, uint64_t s1, CPURISCVState *env,         \
+                  uint32_t desc)                                     \
+{                                                                    \
+    uint32_t vl = env->vl;                                           \
+    uint32_t esz = sizeof(ETYPE);                                    \
+    uint32_t vlmax = vext_maxsz(desc) / esz;                         \
+    uint32_t i;                                                      \
+                                                                     \
+    for (i = 0; i < vl; i++) {                                       \
+        *((ETYPE *)vd + H(i)) = (ETYPE)s1;                           \
+    }                                                                \
+    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                         \
+}
+
+GEN_VEXT_VMV_VX(vmv_v_x_b, int8_t,  H1, clearb)
+GEN_VEXT_VMV_VX(vmv_v_x_h, int16_t, H2, clearh)
+GEN_VEXT_VMV_VX(vmv_v_x_w, int32_t, H4, clearl)
+GEN_VEXT_VMV_VX(vmv_v_x_d, int64_t, H8, clearq)
+
+#define GEN_VEXT_VMERGE_VV(NAME, ETYPE, H, CLEAR_FN)                 \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,          \
+                  CPURISCVState *env, uint32_t desc)                 \
+{                                                                    \
+    uint32_t mlen = vext_mlen(desc);                                 \
+    uint32_t vl = env->vl;                                           \
+    uint32_t esz = sizeof(ETYPE);                                    \
+    uint32_t vlmax = vext_maxsz(desc) / esz;                         \
+    uint32_t i;                                                      \
+                                                                     \
+    for (i = 0; i < vl; i++) {                                       \
+        ETYPE *vt = (!vext_elem_mask(v0, mlen, i) ? vs2 : vs1);      \
+        *((ETYPE *)vd + H(i)) = *(vt + H(i));                        \
+    }                                                                \
+    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                         \
+}
+
+GEN_VEXT_VMERGE_VV(vmerge_vvm_b, int8_t,  H1, clearb)
+GEN_VEXT_VMERGE_VV(vmerge_vvm_h, int16_t, H2, clearh)
+GEN_VEXT_VMERGE_VV(vmerge_vvm_w, int32_t, H4, clearl)
+GEN_VEXT_VMERGE_VV(vmerge_vvm_d, int64_t, H8, clearq)
+
+#define GEN_VEXT_VMERGE_VX(NAME, ETYPE, H, CLEAR_FN)                 \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
+                  void *vs2, CPURISCVState *env, uint32_t desc)      \
+{                                                                    \
+    uint32_t mlen = vext_mlen(desc);                                 \
+    uint32_t vl = env->vl;                                           \
+    uint32_t esz = sizeof(ETYPE);                                    \
+    uint32_t vlmax = vext_maxsz(desc) / esz;                         \
+    uint32_t i;                                                      \
+                                                                     \
+    for (i = 0; i < vl; i++) {                                       \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                           \
+        ETYPE d = (!vext_elem_mask(v0, mlen, i) ? s2 :               \
+                   (ETYPE)(target_long)s1);                          \
+        *((ETYPE *)vd + H(i)) = d;                                   \
+    }                                                                \
+    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                         \
+}
+
+GEN_VEXT_VMERGE_VX(vmerge_vxm_b, int8_t,  H1, clearb)
+GEN_VEXT_VMERGE_VX(vmerge_vxm_h, int16_t, H2, clearh)
+GEN_VEXT_VMERGE_VX(vmerge_vxm_w, int32_t, H4, clearl)
+GEN_VEXT_VMERGE_VX(vmerge_vxm_d, int64_t, H8, clearq)
-- 
2.27.0


