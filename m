Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54497C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F50520B1F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WKbtvGwr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F50520B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowKL-00066T-8P
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 17:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowIA-00031q-Jd
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:50 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3622)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowI6-0002yu-Kq
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208426; x=1624744426;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eG/gQauqiqB7pnRKQNR5DJPgXbWrFHCFFDYCA+EJf6s=;
 b=WKbtvGwrNK3avWFpOy6Zv0N1yLBV3jLneYpuAx7spLKjDP3qfFuINwyz
 lbSHXsBvsk2ft7dZUmucesQ/e3k3WKIrMOo5um3CJcXaRZ4WGUyWL7G6D
 DG2OsgSackPeS31YmmIh0KV/BWksFORLmGnQxkD+zn7frbciuGwertD4G
 eexrnmaiHmWa0Pnc2d84YNmP2K67jJBQmtXzzed+HeSaqaxg1DYSZBfaK
 UkJO5QBFz/kUdzpZr/JXXr752CJaB/4jjcqkpCvFsXz0lD8QMe+IbWrNn
 8HwUBiiKS4MCdutgcW4wYaXtswuHlXvzWExcBXbc74Gd4i0sk6b7JoKBP g==;
IronPort-SDR: rsxOUiDChYA0LBc251N3X1FG7UZ7KvuKaMgaKFuoL85/18dYM7/Ly3io7HSa76hBRtElkC8IMT
 xutmcRZkz/xPEAtjc5cB+alDGtyvCzJNlwa6Jd590ZsW0H07UoEzBFTgfhZS+n8TZ6EJF1/Xwm
 tWVZE0ra1n2ooChC9aNIXhhho6lf1LkGMxGG0SWqQW19xtZWKetbxBeXpLmuZY6c8WfU2nUmE9
 O4/h0IjBHoyKOxLy4HJSpiZED8JDRZRXHrY5DD/FINJe9X2hOlh1cQW4/Uy3qZZajJsvjTn4L+
 WBo=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="250261254"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:39 +0800
IronPort-SDR: zNhZy9LIXGpCTdrZn5gH0euIsekXX+jexYfaubZfrVXOE6lOyvf1bEm8/EnDukLI/jozQDowlt
 qo4dUW5setSjl87LEMUMSXtouqP30FLnY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:37 -0700
IronPort-SDR: inQc7ckG0dqza7GcwVyRG6fy1yDvopl6Nhs0GdffGt2zy2bcm4izHhME5ZjChubrnNB/I00c5E
 k4WbY0C7L5pQ==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:39 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 17/63] target/riscv: vector narrowing integer right shift
 instructions
Date: Fri, 26 Jun 2020 14:43:24 -0700
Message-Id: <20200626214410.3613258-18-alistair.francis@wdc.com>
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
Message-id: 20200623215920.2594-16-zhiwei_liu@c-sky.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   | 13 ++++
 target/riscv/insn32.decode              |  6 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 90 +++++++++++++++++++++++++
 target/riscv/vector_helper.c            | 14 ++++
 4 files changed, 123 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 6805bf7dbd..1ec2202814 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -432,3 +432,16 @@ DEF_HELPER_6(vsra_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsra_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsra_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsra_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+
+DEF_HELPER_6(vnsrl_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnsrl_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnsrl_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnsra_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnsra_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnsra_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnsrl_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnsrl_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnsrl_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnsra_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnsra_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnsra_vx_w, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index e5334230df..435415f9f9 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -331,6 +331,12 @@ vsrl_vi         101000 . ..... ..... 011 ..... 1010111 @r_vm
 vsra_vv         101001 . ..... ..... 000 ..... 1010111 @r_vm
 vsra_vx         101001 . ..... ..... 100 ..... 1010111 @r_vm
 vsra_vi         101001 . ..... ..... 011 ..... 1010111 @r_vm
+vnsrl_vv        101100 . ..... ..... 000 ..... 1010111 @r_vm
+vnsrl_vx        101100 . ..... ..... 100 ..... 1010111 @r_vm
+vnsrl_vi        101100 . ..... ..... 011 ..... 1010111 @r_vm
+vnsra_vv        101101 . ..... ..... 000 ..... 1010111 @r_vm
+vnsra_vx        101101 . ..... ..... 100 ..... 1010111 @r_vm
+vnsra_vi        101101 . ..... ..... 011 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index d2dbf701c8..9d2c327366 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1425,3 +1425,93 @@ GEN_OPIVX_GVEC_SHIFT_TRANS(vsra_vx,  sars)
 GEN_OPIVI_GVEC_TRANS(vsll_vi, 1, vsll_vx,  shli)
 GEN_OPIVI_GVEC_TRANS(vsrl_vi, 1, vsrl_vx,  shri)
 GEN_OPIVI_GVEC_TRANS(vsra_vi, 1, vsra_vx,  sari)
+
+/* Vector Narrowing Integer Right Shift Instructions */
+static bool opivv_narrow_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, true) &&
+            vext_check_reg(s, a->rs1, false) &&
+            vext_check_overlap_group(a->rd, 1 << s->lmul, a->rs2,
+                2 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3));
+}
+
+/* OPIVV with NARROW */
+#define GEN_OPIVV_NARROW_TRANS(NAME)                               \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
+{                                                                  \
+    if (opivv_narrow_check(s, a)) {                                \
+        uint32_t data = 0;                                         \
+        static gen_helper_gvec_4_ptr * const fns[3] = {            \
+            gen_helper_##NAME##_b,                                 \
+            gen_helper_##NAME##_h,                                 \
+            gen_helper_##NAME##_w,                                 \
+        };                                                         \
+        TCGLabel *over = gen_new_label();                          \
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
+                                                                   \
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);             \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
+                           vreg_ofs(s, a->rs1),                    \
+                           vreg_ofs(s, a->rs2), cpu_env, 0,        \
+                           s->vlen / 8, data, fns[s->sew]);        \
+        gen_set_label(over);                                       \
+        return true;                                               \
+    }                                                              \
+    return false;                                                  \
+}
+GEN_OPIVV_NARROW_TRANS(vnsra_vv)
+GEN_OPIVV_NARROW_TRANS(vnsrl_vv)
+
+static bool opivx_narrow_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, true) &&
+            vext_check_overlap_group(a->rd, 1 << s->lmul, a->rs2,
+                2 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3));
+}
+
+/* OPIVX with NARROW */
+#define GEN_OPIVX_NARROW_TRANS(NAME)                                     \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
+{                                                                        \
+    if (opivx_narrow_check(s, a)) {                                      \
+        static gen_helper_opivx * const fns[3] = {                       \
+            gen_helper_##NAME##_b,                                       \
+            gen_helper_##NAME##_h,                                       \
+            gen_helper_##NAME##_w,                                       \
+        };                                                               \
+        return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fns[s->sew], s);\
+    }                                                                    \
+    return false;                                                        \
+}
+
+GEN_OPIVX_NARROW_TRANS(vnsra_vx)
+GEN_OPIVX_NARROW_TRANS(vnsrl_vx)
+
+/* OPIVI with NARROW */
+#define GEN_OPIVI_NARROW_TRANS(NAME, ZX, OPIVX)                          \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
+{                                                                        \
+    if (opivx_narrow_check(s, a)) {                                      \
+        static gen_helper_opivx * const fns[3] = {                       \
+            gen_helper_##OPIVX##_b,                                      \
+            gen_helper_##OPIVX##_h,                                      \
+            gen_helper_##OPIVX##_w,                                      \
+        };                                                               \
+        return opivi_trans(a->rd, a->rs1, a->rs2, a->vm,                 \
+                           fns[s->sew], s, ZX);                          \
+    }                                                                    \
+    return false;                                                        \
+}
+
+GEN_OPIVI_NARROW_TRANS(vnsra_vi, 1, vnsra_vx)
+GEN_OPIVI_NARROW_TRANS(vnsrl_vi, 1, vnsrl_vx)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index f63f06bd37..7b59719baa 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -1395,3 +1395,17 @@ GEN_VEXT_SHIFT_VX(vsra_vx_b, int8_t, int8_t, H1, H1, DO_SRL, 0x7, clearb)
 GEN_VEXT_SHIFT_VX(vsra_vx_h, int16_t, int16_t, H2, H2, DO_SRL, 0xf, clearh)
 GEN_VEXT_SHIFT_VX(vsra_vx_w, int32_t, int32_t, H4, H4, DO_SRL, 0x1f, clearl)
 GEN_VEXT_SHIFT_VX(vsra_vx_d, int64_t, int64_t, H8, H8, DO_SRL, 0x3f, clearq)
+
+/* Vector Narrowing Integer Right Shift Instructions */
+GEN_VEXT_SHIFT_VV(vnsrl_vv_b, uint8_t,  uint16_t, H1, H2, DO_SRL, 0xf, clearb)
+GEN_VEXT_SHIFT_VV(vnsrl_vv_h, uint16_t, uint32_t, H2, H4, DO_SRL, 0x1f, clearh)
+GEN_VEXT_SHIFT_VV(vnsrl_vv_w, uint32_t, uint64_t, H4, H8, DO_SRL, 0x3f, clearl)
+GEN_VEXT_SHIFT_VV(vnsra_vv_b, uint8_t,  int16_t, H1, H2, DO_SRL, 0xf, clearb)
+GEN_VEXT_SHIFT_VV(vnsra_vv_h, uint16_t, int32_t, H2, H4, DO_SRL, 0x1f, clearh)
+GEN_VEXT_SHIFT_VV(vnsra_vv_w, uint32_t, int64_t, H4, H8, DO_SRL, 0x3f, clearl)
+GEN_VEXT_SHIFT_VX(vnsrl_vx_b, uint8_t, uint16_t, H1, H2, DO_SRL, 0xf, clearb)
+GEN_VEXT_SHIFT_VX(vnsrl_vx_h, uint16_t, uint32_t, H2, H4, DO_SRL, 0x1f, clearh)
+GEN_VEXT_SHIFT_VX(vnsrl_vx_w, uint32_t, uint64_t, H4, H8, DO_SRL, 0x3f, clearl)
+GEN_VEXT_SHIFT_VX(vnsra_vx_b, int8_t, int16_t, H1, H2, DO_SRL, 0xf, clearb)
+GEN_VEXT_SHIFT_VX(vnsra_vx_h, int16_t, int32_t, H2, H4, DO_SRL, 0x1f, clearh)
+GEN_VEXT_SHIFT_VX(vnsra_vx_w, int32_t, int64_t, H4, H8, DO_SRL, 0x3f, clearl)
-- 
2.27.0


