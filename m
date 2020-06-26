Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4832EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:21:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F124D2088E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gf8aETik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F124D2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowiW-0005nK-8Q
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowIt-00041F-PV
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:54:35 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:52691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowIp-0002yi-F8
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208472; x=1624744472;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YFM+5is6HkV4i+XudxVEPxW/kClSXpUQ2AvpicfvBqI=;
 b=gf8aETik0UmqZTok+MAs2biBHUySn1fo6l2DQJ/uMLQ+nbcqJGbvbfZ4
 bkYhJL3KizbaMf/ago3m3zdQbVQtSHkSa73SeZip8haKpUZUwhiz6k8lm
 Mki7+ph7Pe+rS5tHJ+9fO+vAhuVwEi5f71cd67jjoFqzZUC8JPuELVEgA
 AtLej5P3cUGhe2k6giMv3R8sRE3cwsN7CTamdaUNzuSLkwi5uHtJUnmyo
 Y1L1bFvS6mOQqjXkKoyeQNzRhnzUWj0bz1a4REMZr04VkCWw+JqVO+j0Q
 AeBH958uCdmWr2nIC/DzC5AJn5Qu8CKhGS6XHwlMAAkMGzRoHIcl+9DD2 g==;
IronPort-SDR: bbE+FLocVuZyRcoo7CbqjemPn8TmctJDJydEELiwOiAebgEpEFIquMHaFnDCql0NvNoNcPpf5y
 jY6lbgPXUcbzAPYCy9zPmD91ed0HbCNgZcznCafSj2BkiPG48jStqyo0UXWQfpsYRheS4luvIF
 54jm7y7C28Eh020gSkr843UTlNYhKxOKFq5ftUVVdKqheZipHYWBd4UQWCoeHk+z7BnAikg+4w
 v5E+l+O7b5EzQ8MN6x5EWuEfZ8zLeKLr5A55YMW5vAgap7+nFjYRZ8gBO119q07XT88wwLdcem
 v14=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="145360044"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:44 +0800
IronPort-SDR: SrpyQZP7reOD0WP4eEKFPT5j0WOeYZxrsSOmfTh2W099c4QMTcw2rtHbf78FMy2J1cn4klR8in
 gCltu/S+BUpuRwIHwEoxLkIQNvsycBd3g=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:42 -0700
IronPort-SDR: HzTFopLPoIXIK+9Ie3mTbP/ik6esmh4Gi5w4N+Z1Ap2ncxNj+GXUmzhBhAEmVG+Co96hQrSrKQ
 Rx+U6dDhM1UA==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:43 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 33/63] target/riscv: vector widening floating-point
 add/subtract instructions
Date: Fri, 26 Jun 2020 14:43:40 -0700
Message-Id: <20200626214410.3613258-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200626214410.3613258-1-alistair.francis@wdc.com>
References: <20200626214410.3613258-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=439617756=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 17:53:34
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
Message-id: 20200623215920.2594-32-zhiwei_liu@c-sky.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  17 +++
 target/riscv/insn32.decode              |   8 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 149 ++++++++++++++++++++++++
 target/riscv/vector_helper.c            |  83 +++++++++++++
 4 files changed, 257 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index ba8a3710e1..828b145150 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -819,3 +819,20 @@ DEF_HELPER_6(vfsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfrsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfrsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfrsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_6(vfwadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwadd_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwadd_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwsub_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwsub_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwadd_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwadd_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwadd_wf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwadd_wf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwsub_wf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwsub_wf_w, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 9e26ed36e7..42d8a967d0 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -450,6 +450,14 @@ vfadd_vf        000000 . ..... ..... 101 ..... 1010111 @r_vm
 vfsub_vv        000010 . ..... ..... 001 ..... 1010111 @r_vm
 vfsub_vf        000010 . ..... ..... 101 ..... 1010111 @r_vm
 vfrsub_vf       100111 . ..... ..... 101 ..... 1010111 @r_vm
+vfwadd_vv       110000 . ..... ..... 001 ..... 1010111 @r_vm
+vfwadd_vf       110000 . ..... ..... 101 ..... 1010111 @r_vm
+vfwadd_wv       110100 . ..... ..... 001 ..... 1010111 @r_vm
+vfwadd_wf       110100 . ..... ..... 101 ..... 1010111 @r_vm
+vfwsub_vv       110010 . ..... ..... 001 ..... 1010111 @r_vm
+vfwsub_vf       110010 . ..... ..... 101 ..... 1010111 @r_vm
+vfwsub_wv       110110 . ..... ..... 001 ..... 1010111 @r_vm
+vfwsub_wf       110110 . ..... ..... 101 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 55a6e514a9..0224b66962 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1901,3 +1901,152 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)            \
 GEN_OPFVF_TRANS(vfadd_vf,  opfvf_check)
 GEN_OPFVF_TRANS(vfsub_vf,  opfvf_check)
 GEN_OPFVF_TRANS(vfrsub_vf,  opfvf_check)
+
+/* Vector Widening Floating-Point Add/Subtract Instructions */
+static bool opfvv_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
+            vext_check_reg(s, a->rd, true) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_reg(s, a->rs1, false) &&
+            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs2,
+                                     1 << s->lmul) &&
+            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs1,
+                                     1 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
+}
+
+/* OPFVV with WIDEN */
+#define GEN_OPFVV_WIDEN_TRANS(NAME, CHECK)                       \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
+{                                                                \
+    if (CHECK(s, a)) {                                           \
+        uint32_t data = 0;                                       \
+        static gen_helper_gvec_4_ptr * const fns[2] = {          \
+            gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
+        };                                                       \
+        TCGLabel *over = gen_new_label();                        \
+        gen_set_rm(s, 7);                                        \
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);        \
+                                                                 \
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);           \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);               \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),   \
+                           vreg_ofs(s, a->rs1),                  \
+                           vreg_ofs(s, a->rs2), cpu_env, 0,      \
+                           s->vlen / 8, data, fns[s->sew - 1]);  \
+        gen_set_label(over);                                     \
+        return true;                                             \
+    }                                                            \
+    return false;                                                \
+}
+
+GEN_OPFVV_WIDEN_TRANS(vfwadd_vv, opfvv_widen_check)
+GEN_OPFVV_WIDEN_TRANS(vfwsub_vv, opfvv_widen_check)
+
+static bool opfvf_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
+            vext_check_reg(s, a->rd, true) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs2,
+                                     1 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
+}
+
+/* OPFVF with WIDEN */
+#define GEN_OPFVF_WIDEN_TRANS(NAME)                              \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
+{                                                                \
+    if (opfvf_widen_check(s, a)) {                               \
+        uint32_t data = 0;                                       \
+        static gen_helper_opfvf *const fns[2] = {                \
+            gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
+        };                                                       \
+        gen_set_rm(s, 7);                                        \
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);           \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);               \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
+        return opfvf_trans(a->rd, a->rs1, a->rs2, data,          \
+                           fns[s->sew - 1], s);                  \
+    }                                                            \
+    return false;                                                \
+}
+
+GEN_OPFVF_WIDEN_TRANS(vfwadd_vf)
+GEN_OPFVF_WIDEN_TRANS(vfwsub_vf)
+
+static bool opfwv_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
+            vext_check_reg(s, a->rd, true) &&
+            vext_check_reg(s, a->rs2, true) &&
+            vext_check_reg(s, a->rs1, false) &&
+            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs1,
+                                     1 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
+}
+
+/* WIDEN OPFVV with WIDEN */
+#define GEN_OPFWV_WIDEN_TRANS(NAME)                                \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
+{                                                                  \
+    if (opfwv_widen_check(s, a)) {                                 \
+        uint32_t data = 0;                                         \
+        static gen_helper_gvec_4_ptr * const fns[2] = {            \
+            gen_helper_##NAME##_h, gen_helper_##NAME##_w,          \
+        };                                                         \
+        TCGLabel *over = gen_new_label();                          \
+        gen_set_rm(s, 7);                                          \
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
+                                                                   \
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);             \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
+                           vreg_ofs(s, a->rs1),                    \
+                           vreg_ofs(s, a->rs2), cpu_env, 0,        \
+                           s->vlen / 8, data, fns[s->sew - 1]);    \
+        gen_set_label(over);                                       \
+        return true;                                               \
+    }                                                              \
+    return false;                                                  \
+}
+
+GEN_OPFWV_WIDEN_TRANS(vfwadd_wv)
+GEN_OPFWV_WIDEN_TRANS(vfwsub_wv)
+
+static bool opfwf_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
+            vext_check_reg(s, a->rd, true) &&
+            vext_check_reg(s, a->rs2, true) &&
+            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
+}
+
+/* WIDEN OPFVF with WIDEN */
+#define GEN_OPFWF_WIDEN_TRANS(NAME)                              \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
+{                                                                \
+    if (opfwf_widen_check(s, a)) {                               \
+        uint32_t data = 0;                                       \
+        static gen_helper_opfvf *const fns[2] = {                \
+            gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
+        };                                                       \
+        gen_set_rm(s, 7);                                        \
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);           \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);               \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
+        return opfvf_trans(a->rd, a->rs1, a->rs2, data,          \
+                           fns[s->sew - 1], s);                  \
+    }                                                            \
+    return false;                                                \
+}
+
+GEN_OPFWF_WIDEN_TRANS(vfwadd_wf)
+GEN_OPFWF_WIDEN_TRANS(vfwsub_wf)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 7213d910be..85d1f08bd0 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3278,3 +3278,86 @@ RVVCALL(OPFVF2, vfrsub_vf_d, OP_UUU_D, H8, H8, float64_rsub)
 GEN_VEXT_VF(vfrsub_vf_h, 2, 2, clearh)
 GEN_VEXT_VF(vfrsub_vf_w, 4, 4, clearl)
 GEN_VEXT_VF(vfrsub_vf_d, 8, 8, clearq)
+
+/* Vector Widening Floating-Point Add/Subtract Instructions */
+static uint32_t vfwadd16(uint16_t a, uint16_t b, float_status *s)
+{
+    return float32_add(float16_to_float32(a, true, s),
+            float16_to_float32(b, true, s), s);
+}
+
+static uint64_t vfwadd32(uint32_t a, uint32_t b, float_status *s)
+{
+    return float64_add(float32_to_float64(a, s),
+            float32_to_float64(b, s), s);
+
+}
+
+RVVCALL(OPFVV2, vfwadd_vv_h, WOP_UUU_H, H4, H2, H2, vfwadd16)
+RVVCALL(OPFVV2, vfwadd_vv_w, WOP_UUU_W, H8, H4, H4, vfwadd32)
+GEN_VEXT_VV_ENV(vfwadd_vv_h, 2, 4, clearl)
+GEN_VEXT_VV_ENV(vfwadd_vv_w, 4, 8, clearq)
+RVVCALL(OPFVF2, vfwadd_vf_h, WOP_UUU_H, H4, H2, vfwadd16)
+RVVCALL(OPFVF2, vfwadd_vf_w, WOP_UUU_W, H8, H4, vfwadd32)
+GEN_VEXT_VF(vfwadd_vf_h, 2, 4, clearl)
+GEN_VEXT_VF(vfwadd_vf_w, 4, 8, clearq)
+
+static uint32_t vfwsub16(uint16_t a, uint16_t b, float_status *s)
+{
+    return float32_sub(float16_to_float32(a, true, s),
+            float16_to_float32(b, true, s), s);
+}
+
+static uint64_t vfwsub32(uint32_t a, uint32_t b, float_status *s)
+{
+    return float64_sub(float32_to_float64(a, s),
+            float32_to_float64(b, s), s);
+
+}
+
+RVVCALL(OPFVV2, vfwsub_vv_h, WOP_UUU_H, H4, H2, H2, vfwsub16)
+RVVCALL(OPFVV2, vfwsub_vv_w, WOP_UUU_W, H8, H4, H4, vfwsub32)
+GEN_VEXT_VV_ENV(vfwsub_vv_h, 2, 4, clearl)
+GEN_VEXT_VV_ENV(vfwsub_vv_w, 4, 8, clearq)
+RVVCALL(OPFVF2, vfwsub_vf_h, WOP_UUU_H, H4, H2, vfwsub16)
+RVVCALL(OPFVF2, vfwsub_vf_w, WOP_UUU_W, H8, H4, vfwsub32)
+GEN_VEXT_VF(vfwsub_vf_h, 2, 4, clearl)
+GEN_VEXT_VF(vfwsub_vf_w, 4, 8, clearq)
+
+static uint32_t vfwaddw16(uint32_t a, uint16_t b, float_status *s)
+{
+    return float32_add(a, float16_to_float32(b, true, s), s);
+}
+
+static uint64_t vfwaddw32(uint64_t a, uint32_t b, float_status *s)
+{
+    return float64_add(a, float32_to_float64(b, s), s);
+}
+
+RVVCALL(OPFVV2, vfwadd_wv_h, WOP_WUUU_H, H4, H2, H2, vfwaddw16)
+RVVCALL(OPFVV2, vfwadd_wv_w, WOP_WUUU_W, H8, H4, H4, vfwaddw32)
+GEN_VEXT_VV_ENV(vfwadd_wv_h, 2, 4, clearl)
+GEN_VEXT_VV_ENV(vfwadd_wv_w, 4, 8, clearq)
+RVVCALL(OPFVF2, vfwadd_wf_h, WOP_WUUU_H, H4, H2, vfwaddw16)
+RVVCALL(OPFVF2, vfwadd_wf_w, WOP_WUUU_W, H8, H4, vfwaddw32)
+GEN_VEXT_VF(vfwadd_wf_h, 2, 4, clearl)
+GEN_VEXT_VF(vfwadd_wf_w, 4, 8, clearq)
+
+static uint32_t vfwsubw16(uint32_t a, uint16_t b, float_status *s)
+{
+    return float32_sub(a, float16_to_float32(b, true, s), s);
+}
+
+static uint64_t vfwsubw32(uint64_t a, uint32_t b, float_status *s)
+{
+    return float64_sub(a, float32_to_float64(b, s), s);
+}
+
+RVVCALL(OPFVV2, vfwsub_wv_h, WOP_WUUU_H, H4, H2, H2, vfwsubw16)
+RVVCALL(OPFVV2, vfwsub_wv_w, WOP_WUUU_W, H8, H4, H4, vfwsubw32)
+GEN_VEXT_VV_ENV(vfwsub_wv_h, 2, 4, clearl)
+GEN_VEXT_VV_ENV(vfwsub_wv_w, 4, 8, clearq)
+RVVCALL(OPFVF2, vfwsub_wf_h, WOP_WUUU_H, H4, H2, vfwsubw16)
+RVVCALL(OPFVF2, vfwsub_wf_w, WOP_WUUU_W, H8, H4, vfwsubw32)
+GEN_VEXT_VF(vfwsub_wf_h, 2, 4, clearl)
+GEN_VEXT_VF(vfwsub_wf_w, 4, 8, clearq)
-- 
2.27.0


