Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBAAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16D2E20720
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lvFM9Np0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D2E20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2Hv-0004oa-BW
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr29d-0003hU-T0
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:33:41 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr29a-0000AD-3c
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707618; x=1625243618;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ioo2pHWED5QWEHLzdA5TwHdNatCNlghwyqns4DoTyVo=;
 b=lvFM9Np0VgDzFQzfv5xtiYl5KQrhTNi+oCE1cGLGyxKbDq7Ppk6dTfqH
 iSXP3Nq02oclQZFCLPj0trt7WjtxZTmxezCqsLGbpTyjVgPvDHPLOKIqO
 4a4Rbt5n69ahVT8cUZP7mBNml3MT6iLYqJkOkAHUVYiHzpl4qqWVszotX
 LMiZGOIiQ49fXagOD+UXukxPPgSKQvaaklynmRom5hkz5gmJCEyenOgcO
 3WwahUHDUmzlLqDSbZpTIh1Qx5c0mbdGg+jv3CqLuHikl5Ib6VPBA1u7U
 NYlre21JSFVQlXLljeMLMcCXgxk0XMe5ZYQ7XnISA6TVMd6v2LIivYq/c Q==;
IronPort-SDR: ghRVaoJGm8kdbVpMm2mLn4O92Dnrz7Dgq12SirhPRLFdVkp5BFOSTq/HiqCu+fTCGaCNh/6KK1
 PdCMo6FdkLeiYMgVZ40x5msgbDkkcf5qEVoKALf6IEk1+7i0wnX4HOc2it+aDudiwC45fGQ5Mg
 f+jEf3jviJWxPEWxIRoKmIprTmm09zhQyO5hE6iDt4wZ/p7+Z+eGp6tE2cL+vRR9s/JAVztyO0
 qs1lIBslq2fTKPSf8QTWJEq1HYPhgAhtM56RmyLE6ECfUkURUmRNW5dzNA63qTTOp7ycNDbwKn
 6rU=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498471"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:22 +0800
IronPort-SDR: U8ev6SesCVfPp8Ti7/VACG7j621VWmQpAs0IzDKLXOrPRzXXbAYbsMwYkr/8tBKCHAobrRpHvy
 YOSODqwvTXQCI26I35hHTBuoVCS5RKvCc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:37 -0700
IronPort-SDR: 6y4AcX2a7XMGuKyfJ76B45AWKgpBlGkpWORXpYBzQYd3QQwLrSQpaWyRgOfg+eUWqdUq204zOb
 2w0E8jcN34Sw==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:21 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 10/64] target/riscv: add vector index load and store
 instructions
Date: Thu,  2 Jul 2020 09:23:00 -0700
Message-Id: <20200702162354.928528-11-alistair.francis@wdc.com>
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
Cc: alistair23@gmail.com, Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Vector indexed operations add the contents of each element of the
vector offset operand specified by vs2 to the base effective address
to give the effective address of each element.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200701152549.1218-8-zhiwei_liu@c-sky.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  35 +++++++
 target/riscv/insn32.decode              |  13 +++
 target/riscv/insn_trans/trans_rvv.inc.c | 129 ++++++++++++++++++++++++
 target/riscv/vector_helper.c            | 116 +++++++++++++++++++++
 4 files changed, 293 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index f03b3d52f5..f3650f736e 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -189,3 +189,38 @@ DEF_HELPER_6(vsse_v_b, void, ptr, ptr, tl, tl, env, i32)
 DEF_HELPER_6(vsse_v_h, void, ptr, ptr, tl, tl, env, i32)
 DEF_HELPER_6(vsse_v_w, void, ptr, ptr, tl, tl, env, i32)
 DEF_HELPER_6(vsse_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlxb_v_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxb_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxb_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxb_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxh_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxh_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxh_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxw_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxw_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxe_v_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxe_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxe_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxe_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxbu_v_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxbu_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxbu_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxbu_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxhu_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxhu_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxhu_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxwu_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxwu_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxb_v_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxb_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxb_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxb_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxh_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxh_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxh_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxw_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxw_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxe_v_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxe_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxe_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxe_v_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 58b95792e6..287d52bcc9 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -243,6 +243,19 @@ vssh_v     ... 010 . ..... ..... 101 ..... 0100111 @r_nfvm
 vssw_v     ... 010 . ..... ..... 110 ..... 0100111 @r_nfvm
 vsse_v     ... 010 . ..... ..... 111 ..... 0100111 @r_nfvm
 
+vlxb_v     ... 111 . ..... ..... 000 ..... 0000111 @r_nfvm
+vlxh_v     ... 111 . ..... ..... 101 ..... 0000111 @r_nfvm
+vlxw_v     ... 111 . ..... ..... 110 ..... 0000111 @r_nfvm
+vlxe_v     ... 011 . ..... ..... 111 ..... 0000111 @r_nfvm
+vlxbu_v    ... 011 . ..... ..... 000 ..... 0000111 @r_nfvm
+vlxhu_v    ... 011 . ..... ..... 101 ..... 0000111 @r_nfvm
+vlxwu_v    ... 011 . ..... ..... 110 ..... 0000111 @r_nfvm
+# Vector ordered-indexed and unordered-indexed store insns.
+vsxb_v     ... -11 . ..... ..... 000 ..... 0100111 @r_nfvm
+vsxh_v     ... -11 . ..... ..... 101 ..... 0100111 @r_nfvm
+vsxw_v     ... -11 . ..... ..... 110 ..... 0100111 @r_nfvm
+vsxe_v     ... -11 . ..... ..... 111 ..... 0100111 @r_nfvm
+
 # *** new major opcode OP-V ***
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 451ab05f69..11a3a89d54 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -432,3 +432,132 @@ GEN_VEXT_TRANS(vssb_v, 0, rnfvm, st_stride_op, st_stride_check)
 GEN_VEXT_TRANS(vssh_v, 1, rnfvm, st_stride_op, st_stride_check)
 GEN_VEXT_TRANS(vssw_v, 2, rnfvm, st_stride_op, st_stride_check)
 GEN_VEXT_TRANS(vsse_v, 3, rnfvm, st_stride_op, st_stride_check)
+
+/*
+ *** index load and store
+ */
+typedef void gen_helper_ldst_index(TCGv_ptr, TCGv_ptr, TCGv,
+                                   TCGv_ptr, TCGv_env, TCGv_i32);
+
+static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
+                             uint32_t data, gen_helper_ldst_index *fn,
+                             DisasContext *s)
+{
+    TCGv_ptr dest, mask, index;
+    TCGv base;
+    TCGv_i32 desc;
+
+    TCGLabel *over = gen_new_label();
+    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+
+    dest = tcg_temp_new_ptr();
+    mask = tcg_temp_new_ptr();
+    index = tcg_temp_new_ptr();
+    base = tcg_temp_new();
+    desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
+
+    gen_get_gpr(base, rs1);
+    tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, vd));
+    tcg_gen_addi_ptr(index, cpu_env, vreg_ofs(s, vs2));
+    tcg_gen_addi_ptr(mask, cpu_env, vreg_ofs(s, 0));
+
+    fn(dest, mask, base, index, cpu_env, desc);
+
+    tcg_temp_free_ptr(dest);
+    tcg_temp_free_ptr(mask);
+    tcg_temp_free_ptr(index);
+    tcg_temp_free(base);
+    tcg_temp_free_i32(desc);
+    gen_set_label(over);
+    return true;
+}
+
+static bool ld_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
+{
+    uint32_t data = 0;
+    gen_helper_ldst_index *fn;
+    static gen_helper_ldst_index * const fns[7][4] = {
+        { gen_helper_vlxb_v_b,  gen_helper_vlxb_v_h,
+          gen_helper_vlxb_v_w,  gen_helper_vlxb_v_d },
+        { NULL,                 gen_helper_vlxh_v_h,
+          gen_helper_vlxh_v_w,  gen_helper_vlxh_v_d },
+        { NULL,                 NULL,
+          gen_helper_vlxw_v_w,  gen_helper_vlxw_v_d },
+        { gen_helper_vlxe_v_b,  gen_helper_vlxe_v_h,
+          gen_helper_vlxe_v_w,  gen_helper_vlxe_v_d },
+        { gen_helper_vlxbu_v_b, gen_helper_vlxbu_v_h,
+          gen_helper_vlxbu_v_w, gen_helper_vlxbu_v_d },
+        { NULL,                 gen_helper_vlxhu_v_h,
+          gen_helper_vlxhu_v_w, gen_helper_vlxhu_v_d },
+        { NULL,                 NULL,
+          gen_helper_vlxwu_v_w, gen_helper_vlxwu_v_d },
+    };
+
+    fn =  fns[seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
+    data = FIELD_DP32(data, VDATA, VM, a->vm);
+    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, NF, a->nf);
+    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+}
+
+static bool ld_index_check(DisasContext *s, arg_rnfvm* a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_nf(s, a->nf));
+}
+
+GEN_VEXT_TRANS(vlxb_v, 0, rnfvm, ld_index_op, ld_index_check)
+GEN_VEXT_TRANS(vlxh_v, 1, rnfvm, ld_index_op, ld_index_check)
+GEN_VEXT_TRANS(vlxw_v, 2, rnfvm, ld_index_op, ld_index_check)
+GEN_VEXT_TRANS(vlxe_v, 3, rnfvm, ld_index_op, ld_index_check)
+GEN_VEXT_TRANS(vlxbu_v, 4, rnfvm, ld_index_op, ld_index_check)
+GEN_VEXT_TRANS(vlxhu_v, 5, rnfvm, ld_index_op, ld_index_check)
+GEN_VEXT_TRANS(vlxwu_v, 6, rnfvm, ld_index_op, ld_index_check)
+
+static bool st_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
+{
+    uint32_t data = 0;
+    gen_helper_ldst_index *fn;
+    static gen_helper_ldst_index * const fns[4][4] = {
+        { gen_helper_vsxb_v_b,  gen_helper_vsxb_v_h,
+          gen_helper_vsxb_v_w,  gen_helper_vsxb_v_d },
+        { NULL,                 gen_helper_vsxh_v_h,
+          gen_helper_vsxh_v_w,  gen_helper_vsxh_v_d },
+        { NULL,                 NULL,
+          gen_helper_vsxw_v_w,  gen_helper_vsxw_v_d },
+        { gen_helper_vsxe_v_b,  gen_helper_vsxe_v_h,
+          gen_helper_vsxe_v_w,  gen_helper_vsxe_v_d }
+    };
+
+    fn =  fns[seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
+    data = FIELD_DP32(data, VDATA, VM, a->vm);
+    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, NF, a->nf);
+    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+}
+
+static bool st_index_check(DisasContext *s, arg_rnfvm* a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_nf(s, a->nf));
+}
+
+GEN_VEXT_TRANS(vsxb_v, 0, rnfvm, st_index_op, st_index_check)
+GEN_VEXT_TRANS(vsxh_v, 1, rnfvm, st_index_op, st_index_check)
+GEN_VEXT_TRANS(vsxw_v, 2, rnfvm, st_index_op, st_index_check)
+GEN_VEXT_TRANS(vsxe_v, 3, rnfvm, st_index_op, st_index_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 5c98da8a4e..bbf5991688 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -461,3 +461,119 @@ GEN_VEXT_ST_US(vse_v_b, int8_t,  int8_t , ste_b)
 GEN_VEXT_ST_US(vse_v_h, int16_t, int16_t, ste_h)
 GEN_VEXT_ST_US(vse_v_w, int32_t, int32_t, ste_w)
 GEN_VEXT_ST_US(vse_v_d, int64_t, int64_t, ste_d)
+
+/*
+ *** index: access vector element from indexed memory
+ */
+typedef target_ulong vext_get_index_addr(target_ulong base,
+        uint32_t idx, void *vs2);
+
+#define GEN_VEXT_GET_INDEX_ADDR(NAME, ETYPE, H)        \
+static target_ulong NAME(target_ulong base,            \
+                         uint32_t idx, void *vs2)      \
+{                                                      \
+    return (base + *((ETYPE *)vs2 + H(idx)));          \
+}
+
+GEN_VEXT_GET_INDEX_ADDR(idx_b, int8_t,  H1)
+GEN_VEXT_GET_INDEX_ADDR(idx_h, int16_t, H2)
+GEN_VEXT_GET_INDEX_ADDR(idx_w, int32_t, H4)
+GEN_VEXT_GET_INDEX_ADDR(idx_d, int64_t, H8)
+
+static inline void
+vext_ldst_index(void *vd, void *v0, target_ulong base,
+                void *vs2, CPURISCVState *env, uint32_t desc,
+                vext_get_index_addr get_index_addr,
+                vext_ldst_elem_fn *ldst_elem,
+                clear_fn *clear_elem,
+                uint32_t esz, uint32_t msz, uintptr_t ra,
+                MMUAccessType access_type)
+{
+    uint32_t i, k;
+    uint32_t nf = vext_nf(desc);
+    uint32_t vm = vext_vm(desc);
+    uint32_t mlen = vext_mlen(desc);
+    uint32_t vlmax = vext_maxsz(desc) / esz;
+
+    /* probe every access*/
+    for (i = 0; i < env->vl; i++) {
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        probe_pages(env, get_index_addr(base, i, vs2), nf * msz, ra,
+                    access_type);
+    }
+    /* load bytes from guest memory */
+    for (i = 0; i < env->vl; i++) {
+        k = 0;
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        while (k < nf) {
+            abi_ptr addr = get_index_addr(base, i, vs2) + k * msz;
+            ldst_elem(env, addr, i + k * vlmax, vd, ra);
+            k++;
+        }
+    }
+    /* clear tail elements */
+    if (clear_elem) {
+        for (k = 0; k < nf; k++) {
+            clear_elem(vd, env->vl + k * vlmax, env->vl * esz, vlmax * esz);
+        }
+    }
+}
+
+#define GEN_VEXT_LD_INDEX(NAME, MTYPE, ETYPE, INDEX_FN, LOAD_FN, CLEAR_FN) \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,                   \
+                  void *vs2, CPURISCVState *env, uint32_t desc)            \
+{                                                                          \
+    vext_ldst_index(vd, v0, base, vs2, env, desc, INDEX_FN,                \
+                    LOAD_FN, CLEAR_FN, sizeof(ETYPE), sizeof(MTYPE),       \
+                    GETPC(), MMU_DATA_LOAD);                               \
+}
+
+GEN_VEXT_LD_INDEX(vlxb_v_b,  int8_t,   int8_t,   idx_b, ldb_b,  clearb)
+GEN_VEXT_LD_INDEX(vlxb_v_h,  int8_t,   int16_t,  idx_h, ldb_h,  clearh)
+GEN_VEXT_LD_INDEX(vlxb_v_w,  int8_t,   int32_t,  idx_w, ldb_w,  clearl)
+GEN_VEXT_LD_INDEX(vlxb_v_d,  int8_t,   int64_t,  idx_d, ldb_d,  clearq)
+GEN_VEXT_LD_INDEX(vlxh_v_h,  int16_t,  int16_t,  idx_h, ldh_h,  clearh)
+GEN_VEXT_LD_INDEX(vlxh_v_w,  int16_t,  int32_t,  idx_w, ldh_w,  clearl)
+GEN_VEXT_LD_INDEX(vlxh_v_d,  int16_t,  int64_t,  idx_d, ldh_d,  clearq)
+GEN_VEXT_LD_INDEX(vlxw_v_w,  int32_t,  int32_t,  idx_w, ldw_w,  clearl)
+GEN_VEXT_LD_INDEX(vlxw_v_d,  int32_t,  int64_t,  idx_d, ldw_d,  clearq)
+GEN_VEXT_LD_INDEX(vlxe_v_b,  int8_t,   int8_t,   idx_b, lde_b,  clearb)
+GEN_VEXT_LD_INDEX(vlxe_v_h,  int16_t,  int16_t,  idx_h, lde_h,  clearh)
+GEN_VEXT_LD_INDEX(vlxe_v_w,  int32_t,  int32_t,  idx_w, lde_w,  clearl)
+GEN_VEXT_LD_INDEX(vlxe_v_d,  int64_t,  int64_t,  idx_d, lde_d,  clearq)
+GEN_VEXT_LD_INDEX(vlxbu_v_b, uint8_t,  uint8_t,  idx_b, ldbu_b, clearb)
+GEN_VEXT_LD_INDEX(vlxbu_v_h, uint8_t,  uint16_t, idx_h, ldbu_h, clearh)
+GEN_VEXT_LD_INDEX(vlxbu_v_w, uint8_t,  uint32_t, idx_w, ldbu_w, clearl)
+GEN_VEXT_LD_INDEX(vlxbu_v_d, uint8_t,  uint64_t, idx_d, ldbu_d, clearq)
+GEN_VEXT_LD_INDEX(vlxhu_v_h, uint16_t, uint16_t, idx_h, ldhu_h, clearh)
+GEN_VEXT_LD_INDEX(vlxhu_v_w, uint16_t, uint32_t, idx_w, ldhu_w, clearl)
+GEN_VEXT_LD_INDEX(vlxhu_v_d, uint16_t, uint64_t, idx_d, ldhu_d, clearq)
+GEN_VEXT_LD_INDEX(vlxwu_v_w, uint32_t, uint32_t, idx_w, ldwu_w, clearl)
+GEN_VEXT_LD_INDEX(vlxwu_v_d, uint32_t, uint64_t, idx_d, ldwu_d, clearq)
+
+#define GEN_VEXT_ST_INDEX(NAME, MTYPE, ETYPE, INDEX_FN, STORE_FN)\
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,         \
+                  void *vs2, CPURISCVState *env, uint32_t desc)  \
+{                                                                \
+    vext_ldst_index(vd, v0, base, vs2, env, desc, INDEX_FN,      \
+                    STORE_FN, NULL, sizeof(ETYPE), sizeof(MTYPE),\
+                    GETPC(), MMU_DATA_STORE);                    \
+}
+
+GEN_VEXT_ST_INDEX(vsxb_v_b, int8_t,  int8_t,  idx_b, stb_b)
+GEN_VEXT_ST_INDEX(vsxb_v_h, int8_t,  int16_t, idx_h, stb_h)
+GEN_VEXT_ST_INDEX(vsxb_v_w, int8_t,  int32_t, idx_w, stb_w)
+GEN_VEXT_ST_INDEX(vsxb_v_d, int8_t,  int64_t, idx_d, stb_d)
+GEN_VEXT_ST_INDEX(vsxh_v_h, int16_t, int16_t, idx_h, sth_h)
+GEN_VEXT_ST_INDEX(vsxh_v_w, int16_t, int32_t, idx_w, sth_w)
+GEN_VEXT_ST_INDEX(vsxh_v_d, int16_t, int64_t, idx_d, sth_d)
+GEN_VEXT_ST_INDEX(vsxw_v_w, int32_t, int32_t, idx_w, stw_w)
+GEN_VEXT_ST_INDEX(vsxw_v_d, int32_t, int64_t, idx_d, stw_d)
+GEN_VEXT_ST_INDEX(vsxe_v_b, int8_t,  int8_t,  idx_b, ste_b)
+GEN_VEXT_ST_INDEX(vsxe_v_h, int16_t, int16_t, idx_h, ste_h)
+GEN_VEXT_ST_INDEX(vsxe_v_w, int32_t, int32_t, idx_w, ste_w)
+GEN_VEXT_ST_INDEX(vsxe_v_d, int64_t, int64_t, idx_d, ste_d)
-- 
2.27.0


