Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C2AC433E3
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D5B20885
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UmId49Qf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D5B20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2cE-0000Si-Ge
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2Aq-0006uO-QD
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:56 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2Ao-0000Az-Hi
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707694; x=1625243694;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Nht9iyie5hUYDHGdQBvfft0oYNHogNWeH8Y5eO2+JbY=;
 b=UmId49QfZsgUQVfD/5BHA/dCLbdfp9hTsIv/Yj3fYFHdmEvlktvtC+4p
 4wh37/S87xpPY9h3scUy5BsQNdeaN6EArq7X9oySr5/iBezmBpSD1nWdm
 4YkaSrxtNuyuQVQ9fxLlGfSX/7CibFNtT6uZZmdNpcNCG55La5RCd5a6P
 0JaJes2Rw3HqccvdNW3pHQprmpbXur605K0ZK9sIrBgCsC0HaMIXWqATy
 qqecsYT5ndmTSkbEPNbNcCbkGCVYJLJKsE7rQA6efZJPKo18NIuGvktwn
 P41KdTREeZatzraaBJmm6xazsZGYk2pbebRFMHsIe/FfdPaMriepwo1q4 A==;
IronPort-SDR: wKrVukooZMUJyP+olDRocUfKVYMwTgJR0vNVgUiujyXvYaWREoQLtq/TJejLmpMFONp6/esRAd
 00Kp/NpSDLPzmLdBPbOh5muGVJ3E3xGH6ean2r8u/WicGkch/yR6C30qUI2f0YYiOnJUBAFcOA
 6y9EZVvDhLhSZrUqKJv91HfQaV4z3REWtV9vIc1OlFuW+enkJZCYbUViTz44iC34eVJCuAhWcn
 t8CT/YjTLH16attHzlCyZs6F807q+5aaBjyM9qulunjFlx+W4FJR0++1L+jf9yWIKMhixgjYg1
 LQ4=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498549"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:34 +0800
IronPort-SDR: JweNh0ouxioI9jMeMCIkpRpqxQgHCCZ8YA6zm0JCcq0H4ehCbiH/6j8FuGb2WwpcwyaTxjCZb8
 Qa7uI+ZplCIHgZjE5mAXid17PpdfSGMyE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:49 -0700
IronPort-SDR: GdeVkSE9Jh/r60hfZNchox1oFfTTEMemmqs9jqddujHZPiQOSRi5RIxjAJXk5Jcjyyx6C+FnIb
 RUCGENMACCJQ==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:33 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 52/64] target/riscv: vector mask-register logical
 instructions
Date: Thu,  2 Jul 2020 09:23:42 -0700
Message-Id: <20200702162354.928528-53-alistair.francis@wdc.com>
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
Message-Id: <20200701152549.1218-50-zhiwei_liu@c-sky.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  9 ++++++
 target/riscv/insn32.decode              |  8 +++++
 target/riscv/insn_trans/trans_rvv.inc.c | 35 ++++++++++++++++++++++
 target/riscv/vector_helper.c            | 40 +++++++++++++++++++++++++
 4 files changed, 92 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 217f09a55c..292279f0c5 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1092,3 +1092,12 @@ DEF_HELPER_6(vfredmin_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_6(vfwredsum_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwredsum_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_6(vmand_mm, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmnand_mm, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmandnot_mm, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmxor_mm, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmor_mm, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmnor_mm, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmornot_mm, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmxnor_mm, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 2668d483a7..c71cbef182 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -547,6 +547,14 @@ vfredmin_vs     000101 . ..... ..... 001 ..... 1010111 @r_vm
 vfredmax_vs     000111 . ..... ..... 001 ..... 1010111 @r_vm
 # Vector widening ordered and unordered float reduction sum
 vfwredsum_vs    1100-1 . ..... ..... 001 ..... 1010111 @r_vm
+vmand_mm        011001 - ..... ..... 010 ..... 1010111 @r
+vmnand_mm       011101 - ..... ..... 010 ..... 1010111 @r
+vmandnot_mm     011000 - ..... ..... 010 ..... 1010111 @r
+vmxor_mm        011011 - ..... ..... 010 ..... 1010111 @r
+vmor_mm         011010 - ..... ..... 010 ..... 1010111 @r
+vmnor_mm        011110 - ..... ..... 010 ..... 1010111 @r
+vmornot_mm      011100 - ..... ..... 010 ..... 1010111 @r
+vmxnor_mm       011111 - ..... ..... 010 ..... 1010111 @r
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index b78829be36..e2954aa99a 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2354,3 +2354,38 @@ GEN_OPFVV_TRANS(vfredmin_vs, reduction_check)
 
 /* Vector Widening Floating-Point Reduction Instructions */
 GEN_OPFVV_WIDEN_TRANS(vfwredsum_vs, reduction_check)
+
+/*
+ *** Vector Mask Operations
+ */
+
+/* Vector Mask-Register Logical Instructions */
+#define GEN_MM_TRANS(NAME)                                         \
+static bool trans_##NAME(DisasContext *s, arg_r *a)                \
+{                                                                  \
+    if (vext_check_isa_ill(s)) {                                   \
+        uint32_t data = 0;                                         \
+        gen_helper_gvec_4_ptr *fn = gen_helper_##NAME;             \
+        TCGLabel *over = gen_new_label();                          \
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
+                                                                   \
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);             \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
+                           vreg_ofs(s, a->rs1),                    \
+                           vreg_ofs(s, a->rs2), cpu_env, 0,        \
+                           s->vlen / 8, data, fn);                 \
+        gen_set_label(over);                                       \
+        return true;                                               \
+    }                                                              \
+    return false;                                                  \
+}
+
+GEN_MM_TRANS(vmand_mm)
+GEN_MM_TRANS(vmnand_mm)
+GEN_MM_TRANS(vmandnot_mm)
+GEN_MM_TRANS(vmxor_mm)
+GEN_MM_TRANS(vmor_mm)
+GEN_MM_TRANS(vmnor_mm)
+GEN_MM_TRANS(vmornot_mm)
+GEN_MM_TRANS(vmxnor_mm)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 3ebf2482b8..ca44e733e8 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4502,3 +4502,43 @@ void HELPER(vfwredsum_vs_w)(void *vd, void *v0, void *vs1,
     *((uint64_t *)vd) = s1;
     clearq(vd, 1, sizeof(uint64_t), tot);
 }
+
+/*
+ *** Vector Mask Operations
+ */
+/* Vector Mask-Register Logical Instructions */
+#define GEN_VEXT_MASK_VV(NAME, OP)                        \
+void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
+                  void *vs2, CPURISCVState *env,          \
+                  uint32_t desc)                          \
+{                                                         \
+    uint32_t mlen = vext_mlen(desc);                      \
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;   \
+    uint32_t vl = env->vl;                                \
+    uint32_t i;                                           \
+    int a, b;                                             \
+                                                          \
+    for (i = 0; i < vl; i++) {                            \
+        a = vext_elem_mask(vs1, mlen, i);                 \
+        b = vext_elem_mask(vs2, mlen, i);                 \
+        vext_set_elem_mask(vd, mlen, i, OP(b, a));        \
+    }                                                     \
+    for (; i < vlmax; i++) {                              \
+        vext_set_elem_mask(vd, mlen, i, 0);               \
+    }                                                     \
+}
+
+#define DO_NAND(N, M)  (!(N & M))
+#define DO_ANDNOT(N, M)  (N & !M)
+#define DO_NOR(N, M)  (!(N | M))
+#define DO_ORNOT(N, M)  (N | !M)
+#define DO_XNOR(N, M)  (!(N ^ M))
+
+GEN_VEXT_MASK_VV(vmand_mm, DO_AND)
+GEN_VEXT_MASK_VV(vmnand_mm, DO_NAND)
+GEN_VEXT_MASK_VV(vmandnot_mm, DO_ANDNOT)
+GEN_VEXT_MASK_VV(vmxor_mm, DO_XOR)
+GEN_VEXT_MASK_VV(vmor_mm, DO_OR)
+GEN_VEXT_MASK_VV(vmnor_mm, DO_NOR)
+GEN_VEXT_MASK_VV(vmornot_mm, DO_ORNOT)
+GEN_VEXT_MASK_VV(vmxnor_mm, DO_XNOR)
-- 
2.27.0


