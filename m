Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17A4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:11:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC2CA20663
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oZPgwvbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2CA20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowYp-0006Ve-U6
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowIT-0003HO-7c
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:54:09 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowIP-00033f-Pp
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208453; x=1624744453;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OcnLiHM/9oUkB82AqqCcjoCkNJPkf97IOq/fEyRbdF4=;
 b=oZPgwvbMP15ibqq4XRFSQH+lV1WkNyZ6aqEJAhPJJ2tMDknXQ4sAGYMO
 5eVllQRsbS0aFxH1spNaQkwew9aR/b8buPtaYbc4vLb3FKCs04cGxGX1y
 D6OhiHThv8G4PtvdOmGfHnuEqkRPRIY9gfnr+9mLGOQshar0dEMHlIkCt
 RP/skfKNuMsmHl6rXUiGIBMWa/CC97yGVltWUGI/NneDhmnrcsUlmEL7G
 OxMVfJcMyhjaqtZsE1NaGfkrFkr1gcpHnoUd+EXlIMWqhPppYj94ifovD
 sZbQ2/3CCuPJEnAy6WaF1r63gL7clpkHzKBH1i/Qy4irmf/+TQx19OYIp Q==;
IronPort-SDR: 4NmG0DLzyguw4quXPU3keOvHqoBQhzEVWRboC9nR7AvUe/seOK89uW1HIQGx4POSz/p+CSEhPG
 PodYjR6GZ3EfhvTd+KL3uUAwyJuLCdIaDm94VSdX1Zem46QjI3J1HvfICbgw7XNwTYVZav2bOw
 WcrMMOZWHiWlA0x4ZcTcLr8lXPtDgEUnzgGp4ddjQPGFIRe3L1lNoNuQwJjiUChK3DKKk8+v81
 9uFNqxE9sGN9M1k/uwiYYahDfDdn5XRyGfbC4sJyBn+sAX8bG04NDSnN3NU2Mxwxna6qev030E
 5wg=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="244048400"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:48 +0800
IronPort-SDR: ZcEAk1ds7xi3h/TRMAvj8zvccuWp6Xfejob7LS0FuD6/WHjixwNejCji/lt21C9o5MKNOCU1yP
 v3/zyq78L81Boy8naPkJQyC0XPReKj4kU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:45 -0700
IronPort-SDR: Xx+JLARnX4X04/V/1iZxfRFcFehsJaHo+gIb3OeHtKYcFZr2NjbrhtF0hOX9uoWIxIdisUhpk8
 bgBx417Shnlw==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:46 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 43/63] target/riscv: vector floating-point merge instructions
Date: Fri, 26 Jun 2020 14:43:50 -0700
Message-Id: <20200626214410.3613258-44-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200626214410.3613258-1-alistair.francis@wdc.com>
References: <20200626214410.3613258-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=439617756=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 17:53:44
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
Message-id: 20200623215920.2594-42-zhiwei_liu@c-sky.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  4 +++
 target/riscv/insn32.decode              |  2 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 38 +++++++++++++++++++++++++
 target/riscv/vector_helper.c            | 24 ++++++++++++++++
 4 files changed, 68 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index fb744c5ec9..2c3f0a4e0c 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1000,3 +1000,7 @@ DEF_HELPER_6(vmford_vf_d, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_5(vfclass_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfclass_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfclass_v_d, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_6(vfmerge_vfm_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmerge_vfm_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmerge_vfm_d, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6912eda259..38e7445a16 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -515,6 +515,8 @@ vmfge_vf        011111 . ..... ..... 101 ..... 1010111 @r_vm
 vmford_vv       011010 . ..... ..... 001 ..... 1010111 @r_vm
 vmford_vf       011010 . ..... ..... 101 ..... 1010111 @r_vm
 vfclass_v       100011 . ..... 10000 001 ..... 1010111 @r2_vm
+vfmerge_vfm     010111 0 ..... ..... 101 ..... 1010111 @r_vm_0
+vfmv_v_f        010111 1 00000 ..... 101 ..... 1010111 @r2
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 361bdce654..b6872376ce 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2184,3 +2184,41 @@ GEN_OPFVF_TRANS(vmford_vf, opfvf_cmp_check)
 
 /* Vector Floating-Point Classify Instruction */
 GEN_OPFV_TRANS(vfclass_v, opfv_check)
+
+/* Vector Floating-Point Merge Instruction */
+GEN_OPFVF_TRANS(vfmerge_vfm,  opfvf_check)
+
+static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
+{
+    if (vext_check_isa_ill(s) &&
+        vext_check_reg(s, a->rd, false) &&
+        (s->sew != 0)) {
+
+        if (s->vl_eq_vlmax) {
+            tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
+                                 MAXSZ(s), MAXSZ(s), cpu_fpr[a->rs1]);
+        } else {
+            TCGv_ptr dest;
+            TCGv_i32 desc;
+            uint32_t data = FIELD_DP32(0, VDATA, LMUL, s->lmul);
+            static gen_helper_vmv_vx * const fns[3] = {
+                gen_helper_vmv_v_x_h,
+                gen_helper_vmv_v_x_w,
+                gen_helper_vmv_v_x_d,
+            };
+            TCGLabel *over = gen_new_label();
+            tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+
+            dest = tcg_temp_new_ptr();
+            desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
+            tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, a->rd));
+            fns[s->sew - 1](dest, cpu_fpr[a->rs1], cpu_env, desc);
+
+            tcg_temp_free_ptr(dest);
+            tcg_temp_free_i32(desc);
+            gen_set_label(over);
+        }
+        return true;
+    }
+    return false;
+}
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 67cd409112..51c86a5acf 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4194,3 +4194,27 @@ RVVCALL(OPIVV1, vfclass_v_d, OP_UU_D, H8, H8, fclass_d)
 GEN_VEXT_V(vfclass_v_h, 2, 2, clearh)
 GEN_VEXT_V(vfclass_v_w, 4, 4, clearl)
 GEN_VEXT_V(vfclass_v_d, 8, 8, clearq)
+
+/* Vector Floating-Point Merge Instruction */
+#define GEN_VFMERGE_VF(NAME, ETYPE, H, CLEAR_FN)              \
+void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
+                  CPURISCVState *env, uint32_t desc)          \
+{                                                             \
+    uint32_t mlen = vext_mlen(desc);                          \
+    uint32_t vm = vext_vm(desc);                              \
+    uint32_t vl = env->vl;                                    \
+    uint32_t esz = sizeof(ETYPE);                             \
+    uint32_t vlmax = vext_maxsz(desc) / esz;                  \
+    uint32_t i;                                               \
+                                                              \
+    for (i = 0; i < vl; i++) {                                \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
+        *((ETYPE *)vd + H(i))                                 \
+          = (!vm && !vext_elem_mask(v0, mlen, i) ? s2 : s1);  \
+    }                                                         \
+    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                  \
+}
+
+GEN_VFMERGE_VF(vfmerge_vfm_h, int16_t, H2, clearh)
+GEN_VFMERGE_VF(vfmerge_vfm_w, int32_t, H4, clearl)
+GEN_VFMERGE_VF(vfmerge_vfm_d, int64_t, H8, clearq)
-- 
2.27.0


