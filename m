Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F0CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D2420720
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NH4L0hFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D2420720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2J2-0006wk-U1
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr29s-0004HG-3f
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:33:56 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr29m-00009X-Vw
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707630; x=1625243630;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9w72S+SX5OBKD8CuFilnPZI2ESlFlhU8RtVYTxnFb0A=;
 b=NH4L0hFR1J+54znP8FE+ygxaFr0aGuFAfGN9oSsNv7heg8Y3jZzDsmC6
 5gY/oaUh1NpKb0LXAPCmLFXnetFefRnluBKy1Y0wF4bpG6AONd1JmLlPC
 TLZeBMDPAH03Y2nghazawKOy4fVaRIIzrfk3C5u2/fAtZXZ7MWvQEra0v
 xU1mGDoTYUmD1NvdogNsZnUtHLVExqdYMH0cnBQVAbXfSgIZBS0oL6PwE
 b6cfAsNIU0cX3MZuuKp/sRDX9amQ2J0QcQ6upgEQ/A+JVwjdluSrylPuT
 92qmn5JPpvZOXnb+ytCG44c4wvnwnAdBalInCAl8rXx7wcZ/4G0zy4kH2 A==;
IronPort-SDR: +ah5hN8OFpNlBVzzzuqW/pC8/PwMpGPLttQs/w8rgRXW/XuVScyflj57rrNOJLCu6MiPIDFaWw
 iepXWyOlz0IJRvvoLuvYjR9AvwTEG4bvSm+YnLpQyZ5nKeFBR+7zu7xpfpyxK9qogMKzPXvAw7
 2shy1vrQ78a5oQgk52XP8ftd0KYraI066p8sCzs7T1gKxqcqfO/THQZFJHnvu7A8uMpPdouBYC
 v6Pt+OrIQb7naD9gaCXuiLcQlcElv4I9WfEfUSB3+iXHRhcChi2WLk0U1ruO3og9jutICrOSUl
 /+A=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498478"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:24 +0800
IronPort-SDR: zIB67cKpG5Spf985GUNazbSudHXnSLv6Au63fWtubjTs2WmNtQRLV/7Lr/0YBGVc/woddB7B3f
 +02fuLFJNQDDdk2q7v4BcIgoL8uI7KhiQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:39 -0700
IronPort-SDR: PKww7K8E1Sg6V+8c5K4dk1l4K/DRBOGPDpWJ9kLJiw7SzAi/xr7LKygdIwtxWL8r3pfxgJmu1T
 2Cr9tcu/n30A==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:23 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 17/64] target/riscv: vector single-width bit shift
 instructions
Date: Thu,  2 Jul 2020 09:23:07 -0700
Message-Id: <20200702162354.928528-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702162354.928528-1-alistair.francis@wdc.com>
References: <20200702162354.928528-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=4451fe355=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 12:33:30
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20200701152549.1218-15-zhiwei_liu@c-sky.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   | 25 ++++++++
 target/riscv/insn32.decode              |  9 +++
 target/riscv/insn_trans/trans_rvv.inc.c | 52 ++++++++++++++++
 target/riscv/vector_helper.c            | 79 +++++++++++++++++++++++++
 4 files changed, 165 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index f8b1c8a800..6805bf7dbd 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -407,3 +407,28 @@ DEF_HELPER_6(vxor_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vxor_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vxor_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vxor_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vsll_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsll_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsll_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsll_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsrl_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsrl_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsrl_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsrl_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsra_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsra_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsra_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsra_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vsll_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsll_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsll_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsll_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsrl_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsrl_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsrl_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsrl_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsra_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsra_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsra_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsra_vx_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 34d05a5917..e5334230df 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -322,6 +322,15 @@ vor_vi          001010 . ..... ..... 011 ..... 1010111 @r_vm
 vxor_vv         001011 . ..... ..... 000 ..... 1010111 @r_vm
 vxor_vx         001011 . ..... ..... 100 ..... 1010111 @r_vm
 vxor_vi         001011 . ..... ..... 011 ..... 1010111 @r_vm
+vsll_vv         100101 . ..... ..... 000 ..... 1010111 @r_vm
+vsll_vx         100101 . ..... ..... 100 ..... 1010111 @r_vm
+vsll_vi         100101 . ..... ..... 011 ..... 1010111 @r_vm
+vsrl_vv         101000 . ..... ..... 000 ..... 1010111 @r_vm
+vsrl_vx         101000 . ..... ..... 100 ..... 1010111 @r_vm
+vsrl_vi         101000 . ..... ..... 011 ..... 1010111 @r_vm
+vsra_vv         101001 . ..... ..... 000 ..... 1010111 @r_vm
+vsra_vx         101001 . ..... ..... 100 ..... 1010111 @r_vm
+vsra_vi         101001 . ..... ..... 011 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 1552534796..d2dbf701c8 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1373,3 +1373,55 @@ GEN_OPIVX_GVEC_TRANS(vxor_vx, xors)
 GEN_OPIVI_GVEC_TRANS(vand_vi, 0, vand_vx, andi)
 GEN_OPIVI_GVEC_TRANS(vor_vi, 0, vor_vx,  ori)
 GEN_OPIVI_GVEC_TRANS(vxor_vi, 0, vxor_vx, xori)
+
+/* Vector Single-Width Bit Shift Instructions */
+GEN_OPIVV_GVEC_TRANS(vsll_vv,  shlv)
+GEN_OPIVV_GVEC_TRANS(vsrl_vv,  shrv)
+GEN_OPIVV_GVEC_TRANS(vsra_vv,  sarv)
+
+typedef void GVecGen2sFn32(unsigned, uint32_t, uint32_t, TCGv_i32,
+                           uint32_t, uint32_t);
+
+static inline bool
+do_opivx_gvec_shift(DisasContext *s, arg_rmrr *a, GVecGen2sFn32 *gvec_fn,
+                    gen_helper_opivx *fn)
+{
+    if (!opivx_check(s, a)) {
+        return false;
+    }
+
+    if (a->vm && s->vl_eq_vlmax) {
+        TCGv_i32 src1 = tcg_temp_new_i32();
+        TCGv tmp = tcg_temp_new();
+
+        gen_get_gpr(tmp, a->rs1);
+        tcg_gen_trunc_tl_i32(src1, tmp);
+        tcg_gen_extract_i32(src1, src1, 0, s->sew + 3);
+        gvec_fn(s->sew, vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2),
+                src1, MAXSZ(s), MAXSZ(s));
+
+        tcg_temp_free_i32(src1);
+        tcg_temp_free(tmp);
+        return true;
+    }
+    return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s);
+}
+
+#define GEN_OPIVX_GVEC_SHIFT_TRANS(NAME, SUF) \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                    \
+{                                                                         \
+    static gen_helper_opivx * const fns[4] = {                            \
+        gen_helper_##NAME##_b, gen_helper_##NAME##_h,                     \
+        gen_helper_##NAME##_w, gen_helper_##NAME##_d,                     \
+    };                                                                    \
+                                                                          \
+    return do_opivx_gvec_shift(s, a, tcg_gen_gvec_##SUF, fns[s->sew]);    \
+}
+
+GEN_OPIVX_GVEC_SHIFT_TRANS(vsll_vx,  shls)
+GEN_OPIVX_GVEC_SHIFT_TRANS(vsrl_vx,  shrs)
+GEN_OPIVX_GVEC_SHIFT_TRANS(vsra_vx,  sars)
+
+GEN_OPIVI_GVEC_TRANS(vsll_vi, 1, vsll_vx,  shli)
+GEN_OPIVI_GVEC_TRANS(vsrl_vi, 1, vsrl_vx,  shri)
+GEN_OPIVI_GVEC_TRANS(vsra_vi, 1, vsra_vx,  sari)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index bd77de110e..cd81f86faf 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -1316,3 +1316,82 @@ GEN_VEXT_VX(vxor_vx_b, 1, 1, clearb)
 GEN_VEXT_VX(vxor_vx_h, 2, 2, clearh)
 GEN_VEXT_VX(vxor_vx_w, 4, 4, clearl)
 GEN_VEXT_VX(vxor_vx_d, 8, 8, clearq)
+
+/* Vector Single-Width Bit Shift Instructions */
+#define DO_SLL(N, M)  (N << (M))
+#define DO_SRL(N, M)  (N >> (M))
+
+/* generate the helpers for shift instructions with two vector operators */
+#define GEN_VEXT_SHIFT_VV(NAME, TS1, TS2, HS1, HS2, OP, MASK, CLEAR_FN)   \
+void HELPER(NAME)(void *vd, void *v0, void *vs1,                          \
+                  void *vs2, CPURISCVState *env, uint32_t desc)           \
+{                                                                         \
+    uint32_t mlen = vext_mlen(desc);                                      \
+    uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vl = env->vl;                                                \
+    uint32_t esz = sizeof(TS1);                                           \
+    uint32_t vlmax = vext_maxsz(desc) / esz;                              \
+    uint32_t i;                                                           \
+                                                                          \
+    for (i = 0; i < vl; i++) {                                            \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
+            continue;                                                     \
+        }                                                                 \
+        TS1 s1 = *((TS1 *)vs1 + HS1(i));                                  \
+        TS2 s2 = *((TS2 *)vs2 + HS2(i));                                  \
+        *((TS1 *)vd + HS1(i)) = OP(s2, s1 & MASK);                        \
+    }                                                                     \
+    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                              \
+}
+
+GEN_VEXT_SHIFT_VV(vsll_vv_b, uint8_t,  uint8_t, H1, H1, DO_SLL, 0x7, clearb)
+GEN_VEXT_SHIFT_VV(vsll_vv_h, uint16_t, uint16_t, H2, H2, DO_SLL, 0xf, clearh)
+GEN_VEXT_SHIFT_VV(vsll_vv_w, uint32_t, uint32_t, H4, H4, DO_SLL, 0x1f, clearl)
+GEN_VEXT_SHIFT_VV(vsll_vv_d, uint64_t, uint64_t, H8, H8, DO_SLL, 0x3f, clearq)
+
+GEN_VEXT_SHIFT_VV(vsrl_vv_b, uint8_t, uint8_t, H1, H1, DO_SRL, 0x7, clearb)
+GEN_VEXT_SHIFT_VV(vsrl_vv_h, uint16_t, uint16_t, H2, H2, DO_SRL, 0xf, clearh)
+GEN_VEXT_SHIFT_VV(vsrl_vv_w, uint32_t, uint32_t, H4, H4, DO_SRL, 0x1f, clearl)
+GEN_VEXT_SHIFT_VV(vsrl_vv_d, uint64_t, uint64_t, H8, H8, DO_SRL, 0x3f, clearq)
+
+GEN_VEXT_SHIFT_VV(vsra_vv_b, uint8_t,  int8_t, H1, H1, DO_SRL, 0x7, clearb)
+GEN_VEXT_SHIFT_VV(vsra_vv_h, uint16_t, int16_t, H2, H2, DO_SRL, 0xf, clearh)
+GEN_VEXT_SHIFT_VV(vsra_vv_w, uint32_t, int32_t, H4, H4, DO_SRL, 0x1f, clearl)
+GEN_VEXT_SHIFT_VV(vsra_vv_d, uint64_t, int64_t, H8, H8, DO_SRL, 0x3f, clearq)
+
+/* generate the helpers for shift instructions with one vector and one scalar */
+#define GEN_VEXT_SHIFT_VX(NAME, TD, TS2, HD, HS2, OP, MASK, CLEAR_FN) \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1,                \
+        void *vs2, CPURISCVState *env, uint32_t desc)                 \
+{                                                                     \
+    uint32_t mlen = vext_mlen(desc);                                  \
+    uint32_t vm = vext_vm(desc);                                      \
+    uint32_t vl = env->vl;                                            \
+    uint32_t esz = sizeof(TD);                                        \
+    uint32_t vlmax = vext_maxsz(desc) / esz;                          \
+    uint32_t i;                                                       \
+                                                                      \
+    for (i = 0; i < vl; i++) {                                        \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {                    \
+            continue;                                                 \
+        }                                                             \
+        TS2 s2 = *((TS2 *)vs2 + HS2(i));                              \
+        *((TD *)vd + HD(i)) = OP(s2, s1 & MASK);                      \
+    }                                                                 \
+    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                          \
+}
+
+GEN_VEXT_SHIFT_VX(vsll_vx_b, uint8_t, int8_t, H1, H1, DO_SLL, 0x7, clearb)
+GEN_VEXT_SHIFT_VX(vsll_vx_h, uint16_t, int16_t, H2, H2, DO_SLL, 0xf, clearh)
+GEN_VEXT_SHIFT_VX(vsll_vx_w, uint32_t, int32_t, H4, H4, DO_SLL, 0x1f, clearl)
+GEN_VEXT_SHIFT_VX(vsll_vx_d, uint64_t, int64_t, H8, H8, DO_SLL, 0x3f, clearq)
+
+GEN_VEXT_SHIFT_VX(vsrl_vx_b, uint8_t, uint8_t, H1, H1, DO_SRL, 0x7, clearb)
+GEN_VEXT_SHIFT_VX(vsrl_vx_h, uint16_t, uint16_t, H2, H2, DO_SRL, 0xf, clearh)
+GEN_VEXT_SHIFT_VX(vsrl_vx_w, uint32_t, uint32_t, H4, H4, DO_SRL, 0x1f, clearl)
+GEN_VEXT_SHIFT_VX(vsrl_vx_d, uint64_t, uint64_t, H8, H8, DO_SRL, 0x3f, clearq)
+
+GEN_VEXT_SHIFT_VX(vsra_vx_b, int8_t, int8_t, H1, H1, DO_SRL, 0x7, clearb)
+GEN_VEXT_SHIFT_VX(vsra_vx_h, int16_t, int16_t, H2, H2, DO_SRL, 0xf, clearh)
+GEN_VEXT_SHIFT_VX(vsra_vx_w, int32_t, int32_t, H4, H4, DO_SRL, 0x1f, clearl)
+GEN_VEXT_SHIFT_VX(vsra_vx_d, int64_t, int64_t, H8, H8, DO_SRL, 0x3f, clearq)
-- 
2.27.0


