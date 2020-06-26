Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7FBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:07:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5358620C09
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ELfZcTJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5358620C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowVa-0000Ma-HK
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowIP-0003Al-1H
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:54:06 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowIB-00031I-Us
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208432; x=1624744432;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XEo2MJaxNQLk5RdP2wQ/n8RMBKf8xmY0rYE9scPqw8I=;
 b=ELfZcTJx32f6/dzfFTPAW+3+m2YSYqsbIXmUeHRZ1AEaNLQ+joLup+OH
 ddobvKpjrsk3LJaxXA/7bE7YhRt/bVw45LbeIK+a0nyL0UdvQAa1OpQqp
 j3rg+/0N3/m01E22b3+CJJ7xEWDHQxSoY8sAN4rXctl1TTDLfsi6x5wyb
 FBMBAv15vMIRDbiZuGo59Hmwf72bMAZC3asPVu9aQ6nopx5635i6+Sqok
 3yeX0Itd1cFbdjMTarAGuSmtfg9nYKqi3tSH0KlPJC8oV/0JvOKlWBhWP
 DLL4oLfFKo+5n7uTBdRL6LvHujWJqDRaBs4ik0ZPMOECQCaZMkzev5UxA Q==;
IronPort-SDR: wsM9rSFk+VGpQO6RDKB/Utzr/VHjTvoq0HGnoc28Vqca6vWaesGoGOBYJ+d2tI3x6kJGSoe9+r
 znFvJgZ5yTbLmwQQjwKlD+di3rd+ZPb/GyWwhpQBvkof6ds99YYbc9AyEEF21OZ6WgGCzHIiVC
 7N4O4ubYe7bP0agpKEQPd1PhlX5xQZGJZUXo88c+YXFq69fRxUW+9mZGNgcc7COwX9CGp41hnQ
 cxarP0UYQRQwKf1uzuR+J4VtamCUefXX/GKO3FuBGaQzUrvLfLCtS045TUnVlfwg6AY7oo8ZXm
 Nv0=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="244048394"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:46 +0800
IronPort-SDR: Mxeht9JweAe+t/YUFQHAeqQj/ANM0uVwpTDjrqv4/0PwfPx/2JeNT73IgLz0ria9Bben+0obMa
 Jafzriyx+EW8Uv0Skeft3nEZInLPrh5MA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:43 -0700
IronPort-SDR: lLD/4X1mkdINK8mYieheHNZFA6PXA91POuBOdcUYFeBc5LSsRUdE6S4wigWXCFZmA8KWFAwk97
 ePjqxUdOBrjg==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:45 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 38/63] target/riscv: vector floating-point square-root
 instruction
Date: Fri, 26 Jun 2020 14:43:45 -0700
Message-Id: <20200626214410.3613258-39-alistair.francis@wdc.com>
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
Message-id: 20200623215920.2594-37-zhiwei_liu@c-sky.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  4 +++
 target/riscv/insn32.decode              |  3 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 43 +++++++++++++++++++++++++
 target/riscv/vector_helper.c            | 43 +++++++++++++++++++++++++
 4 files changed, 93 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index b537030a11..8d44154ad2 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -923,3 +923,7 @@ DEF_HELPER_6(vfwmsac_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwnmsac_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwnmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_5(vfsqrt_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfsqrt_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfsqrt_v_d, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index c9d5078385..0d58c4c5e8 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -45,6 +45,7 @@
 &shift     shamt rs1 rd
 &atomic    aq rl rs2 rs1 rd
 &rmrr      vm rd rs1 rs2
+&rmr       vm rd rs2
 &rwdvm     vm wd rd rs1 rs2
 &r2nfvm    vm rd rs1 nf
 &rnfvm     vm rd rs1 rs2 nf
@@ -68,6 +69,7 @@
 @r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
 @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
 @r2_nfvm ... ... vm:1 ..... ..... ... ..... ....... &r2nfvm %nf %rs1 %rd
+@r2_vm   ...... vm:1 ..... ..... ... ..... ....... &rmr %rs2 %rd
 @r_nfvm  ... ... vm:1 ..... ..... ... ..... ....... &rnfvm %nf %rs2 %rs1 %rd
 @r_vm    ...... vm:1 ..... ..... ... ..... ....... &rmrr %rs2 %rs1 %rd
 @r_vm_1  ...... . ..... ..... ... ..... .......    &rmrr vm=1 %rs2 %rs1 %rd
@@ -489,6 +491,7 @@ vfwmsac_vv      111110 . ..... ..... 001 ..... 1010111 @r_vm
 vfwmsac_vf      111110 . ..... ..... 101 ..... 1010111 @r_vm
 vfwnmsac_vv     111111 . ..... ..... 001 ..... 1010111 @r_vm
 vfwnmsac_vf     111111 . ..... ..... 101 ..... 1010111 @r_vm
+vfsqrt_v        100011 . ..... 00000 001 ..... 1010111 @r2_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 3a5fd0cf89..e875c0e48a 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2089,3 +2089,46 @@ GEN_OPFVF_WIDEN_TRANS(vfwmacc_vf)
 GEN_OPFVF_WIDEN_TRANS(vfwnmacc_vf)
 GEN_OPFVF_WIDEN_TRANS(vfwmsac_vf)
 GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf)
+
+/* Vector Floating-Point Square-Root Instruction */
+
+/*
+ * If the current SEW does not correspond to a supported IEEE floating-point
+ * type, an illegal instruction exception is raised
+ */
+static bool opfv_check(DisasContext *s, arg_rmr *a)
+{
+   return (vext_check_isa_ill(s) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            (s->sew != 0));
+}
+
+#define GEN_OPFV_TRANS(NAME, CHECK)                                \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
+{                                                                  \
+    if (CHECK(s, a)) {                                             \
+        uint32_t data = 0;                                         \
+        static gen_helper_gvec_3_ptr * const fns[3] = {            \
+            gen_helper_##NAME##_h,                                 \
+            gen_helper_##NAME##_w,                                 \
+            gen_helper_##NAME##_d,                                 \
+        };                                                         \
+        TCGLabel *over = gen_new_label();                          \
+        gen_set_rm(s, 7);                                          \
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
+                                                                   \
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);             \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
+                           vreg_ofs(s, a->rs2), cpu_env, 0,        \
+                           s->vlen / 8, data, fns[s->sew - 1]);    \
+        gen_set_label(over);                                       \
+        return true;                                               \
+    }                                                              \
+    return false;                                                  \
+}
+
+GEN_OPFV_TRANS(vfsqrt_v, opfv_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 27d5b3837f..cea62174c3 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3774,3 +3774,46 @@ RVVCALL(OPFVF3, vfwnmsac_vf_h, WOP_UUU_H, H4, H2, fwnmsac16)
 RVVCALL(OPFVF3, vfwnmsac_vf_w, WOP_UUU_W, H8, H4, fwnmsac32)
 GEN_VEXT_VF(vfwnmsac_vf_h, 2, 4, clearl)
 GEN_VEXT_VF(vfwnmsac_vf_w, 4, 8, clearq)
+
+/* Vector Floating-Point Square-Root Instruction */
+/* (TD, T2, TX2) */
+#define OP_UU_H uint16_t, uint16_t, uint16_t
+#define OP_UU_W uint32_t, uint32_t, uint32_t
+#define OP_UU_D uint64_t, uint64_t, uint64_t
+
+#define OPFVV1(NAME, TD, T2, TX2, HD, HS2, OP)        \
+static void do_##NAME(void *vd, void *vs2, int i,      \
+        CPURISCVState *env)                            \
+{                                                      \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                    \
+    *((TD *)vd + HD(i)) = OP(s2, &env->fp_status);     \
+}
+
+#define GEN_VEXT_V_ENV(NAME, ESZ, DSZ, CLEAR_FN)       \
+void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
+        CPURISCVState *env, uint32_t desc)             \
+{                                                      \
+    uint32_t vlmax = vext_maxsz(desc) / ESZ;           \
+    uint32_t mlen = vext_mlen(desc);                   \
+    uint32_t vm = vext_vm(desc);                       \
+    uint32_t vl = env->vl;                             \
+    uint32_t i;                                        \
+                                                       \
+    if (vl == 0) {                                     \
+        return;                                        \
+    }                                                  \
+    for (i = 0; i < vl; i++) {                         \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {     \
+            continue;                                  \
+        }                                              \
+        do_##NAME(vd, vs2, i, env);                    \
+    }                                                  \
+    CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);          \
+}
+
+RVVCALL(OPFVV1, vfsqrt_v_h, OP_UU_H, H2, H2, float16_sqrt)
+RVVCALL(OPFVV1, vfsqrt_v_w, OP_UU_W, H4, H4, float32_sqrt)
+RVVCALL(OPFVV1, vfsqrt_v_d, OP_UU_D, H8, H8, float64_sqrt)
+GEN_VEXT_V_ENV(vfsqrt_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfsqrt_v_w, 4, 4, clearl)
+GEN_VEXT_V_ENV(vfsqrt_v_d, 8, 8, clearq)
-- 
2.27.0


