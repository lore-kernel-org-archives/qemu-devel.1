Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C8AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 144D922D2C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="R4y8rc3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144D922D2C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dwt-0004XY-Ej
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dTL-0004qT-Ja
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:50:07 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:35940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dTI-00086j-69
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:50:07 -0400
Received: by mail-pl1-x62a.google.com with SMTP id y6so133005plt.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RNjhUwcTj4GhGlUzbjNs+OyVRhJlAAx83sl5y90KNOI=;
 b=R4y8rc3Z+p48mKtGtFSlpx/U5bgpJMKHuhXlTiHzzhMMc3HvUR7VgMK6So6fMLTcna
 FHeENUVNNMB8XpcCchpjNBe6iXIfd2lXyMXHq5ENv2BsX5pyxtNRJ2MiHLjs74Zgglem
 tovCng0dh8k37DZlemKLtgC4XsGtdZetDuOg+Imv90O3WjzcXRyNOix9LjIaEiTRlgNo
 6wM1cYKwUU5jecgP9KfbSlTBCRHJdNZVg+v1gMyi22DA5uGQaLeO8II67pIhtYKMsdb9
 KMH/P5vszQ/Jc/scVbfmIBqYvT6xj0tqOJZ0VX6ONrEJUPnhrhGlYlNMfs7bkB7yRPtz
 MKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RNjhUwcTj4GhGlUzbjNs+OyVRhJlAAx83sl5y90KNOI=;
 b=AGa3ghKuYXnjKjX+wJ3S+8+JPL1qZHNu/rGs2Cwo56jq78YSNbyBb90ucQrWc+nxh2
 i17b1wqHDYJz7Grj5RNXbXI3TJ37Zun2XZk9OX7nZ6aV/dHw4W/P7iEg48STA3MEbujt
 YUAtNNhFqWvRc0tBY8c1HU6dtVC86QSqECtvzEnIVfIDhNx2EBpnbxjlndymn5AcP6xT
 2a5ABy1udaIZPf5SXeTeTFvxwwQm6b2jKya7qXDi+PzW3AJNVjEC4qHUCx3CdiPJnaXA
 AqPCrRsKWDVjMUueAw3EICF0E5Lzgnt62sSIbGy8gFuBhHfHcULiA+QzRVmlBkbhkTpt
 O9UQ==
X-Gm-Message-State: AOAM533+cWodKZsQjfZ09nLtJe1VKbrxct2h3FbO/Cj2YxEUzWQ9QX1V
 VW86XhVjStdGaKtZd5o0FS58ckXvq3o=
X-Google-Smtp-Source: ABdhPJwmYsDmH6e+yzWN84wGIfKK2Q4qlLxcuhSlYQa70Wum340nP7OmmPlPM0DC0zVp68hkDW2cVQ==
X-Received: by 2002:a17:902:ac82:: with SMTP id
 h2mr7243108plr.300.1596711000438; 
 Thu, 06 Aug 2020 03:50:00 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:50:00 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 66/71] target/riscv: rvv-1.0: widening floating-point/integer
 type-convert
Date: Thu,  6 Aug 2020 18:47:03 +0800
Message-Id: <20200806104709.13235-67-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Add the following instructions:

* vfwcvt.rtz.xu.f.v
* vfwcvt.rtz.x.f.v

Also adjust GEN_OPFV_WIDEN_TRANS() to accept multiple floating-point
rounding modes.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/helper.h                   |  6 +++
 target/riscv/insn32.decode              | 13 ++++---
 target/riscv/insn_trans/trans_rvv.inc.c | 51 +++++++++++++++++++++----
 target/riscv/vector_helper.c            | 25 +++++++++++-
 4 files changed, 82 insertions(+), 13 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 5ef37b9dc49..7539b4a5004 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -995,12 +995,18 @@ DEF_HELPER_5(vfwcvt_xu_f_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_xu_f_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_x_f_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_x_f_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfwcvt_f_xu_v_b, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_f_xu_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_f_xu_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfwcvt_f_x_v_b, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_f_f_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_f_f_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfwcvt_rtz_xu_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfwcvt_rtz_xu_f_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfwcvt_rtz_x_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfwcvt_rtz_x_f_v_w, void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_5(vfncvt_xu_f_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfncvt_xu_f_v_w, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index c25c03dfb7c..fae96194078 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -563,11 +563,14 @@ vfcvt_f_xu_v       010010 . ..... 00010 001 ..... 1010111 @r2_vm
 vfcvt_f_x_v        010010 . ..... 00011 001 ..... 1010111 @r2_vm
 vfcvt_rtz_xu_f_v   010010 . ..... 00110 001 ..... 1010111 @r2_vm
 vfcvt_rtz_x_f_v    010010 . ..... 00111 001 ..... 1010111 @r2_vm
-vfwcvt_xu_f_v   100010 . ..... 01000 001 ..... 1010111 @r2_vm
-vfwcvt_x_f_v    100010 . ..... 01001 001 ..... 1010111 @r2_vm
-vfwcvt_f_xu_v   100010 . ..... 01010 001 ..... 1010111 @r2_vm
-vfwcvt_f_x_v    100010 . ..... 01011 001 ..... 1010111 @r2_vm
-vfwcvt_f_f_v    100010 . ..... 01100 001 ..... 1010111 @r2_vm
+
+vfwcvt_xu_f_v      010010 . ..... 01000 001 ..... 1010111 @r2_vm
+vfwcvt_x_f_v       010010 . ..... 01001 001 ..... 1010111 @r2_vm
+vfwcvt_f_xu_v      010010 . ..... 01010 001 ..... 1010111 @r2_vm
+vfwcvt_f_x_v       010010 . ..... 01011 001 ..... 1010111 @r2_vm
+vfwcvt_f_f_v       010010 . ..... 01100 001 ..... 1010111 @r2_vm
+vfwcvt_rtz_xu_f_v  010010 . ..... 01110 001 ..... 1010111 @r2_vm
+vfwcvt_rtz_x_f_v   010010 . ..... 01111 001 ..... 1010111 @r2_vm
 vfncvt_xu_f_v   100010 . ..... 10000 001 ..... 1010111 @r2_vm
 vfncvt_x_f_v    100010 . ..... 10001 001 ..... 1010111 @r2_vm
 vfncvt_f_xu_v   100010 . ..... 10010 001 ..... 1010111 @r2_vm
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index e1627637aff..7db3de8e032 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2842,7 +2842,7 @@ static bool opfv_widen_check(DisasContext *s, arg_rmr *a)
            (s->sew != 0);
 }
 
-#define GEN_OPFV_WIDEN_TRANS(NAME)                                 \
+#define GEN_OPFV_WIDEN_TRANS(NAME, FRM)                            \
 static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
 {                                                                  \
     if (opfv_widen_check(s, a)) {                                  \
@@ -2852,7 +2852,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
             gen_helper_##NAME##_w,                                 \
         };                                                         \
         TCGLabel *over = gen_new_label();                          \
-        gen_set_rm(s, FRM_DYN);                                        \
+        gen_set_rm(s, FRM);                                        \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
@@ -2867,11 +2867,48 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
     return false;                                                  \
 }
 
-GEN_OPFV_WIDEN_TRANS(vfwcvt_xu_f_v)
-GEN_OPFV_WIDEN_TRANS(vfwcvt_x_f_v)
-GEN_OPFV_WIDEN_TRANS(vfwcvt_f_xu_v)
-GEN_OPFV_WIDEN_TRANS(vfwcvt_f_x_v)
-GEN_OPFV_WIDEN_TRANS(vfwcvt_f_f_v)
+GEN_OPFV_WIDEN_TRANS(vfwcvt_xu_f_v, FRM_DYN)
+GEN_OPFV_WIDEN_TRANS(vfwcvt_x_f_v, FRM_DYN)
+GEN_OPFV_WIDEN_TRANS(vfwcvt_f_f_v, FRM_DYN)
+GEN_OPFV_WIDEN_TRANS(vfwcvt_rtz_xu_f_v, FRM_RTZ)
+GEN_OPFV_WIDEN_TRANS(vfwcvt_rtz_x_f_v, FRM_RTZ)
+
+static bool opfxv_widen_check(DisasContext *s, arg_rmr *a)
+{
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           /* OPFV widening instructions ignore vs1 check */
+           vext_check_dss(s, a->rd, 0, a->rs2, a->vm, false);
+}
+
+#define GEN_OPFXV_WIDEN_TRANS(NAME)                                \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
+{                                                                  \
+    if (opfxv_widen_check(s, a)) {                                 \
+        uint32_t data = 0;                                         \
+        static gen_helper_gvec_3_ptr * const fns[3] = {            \
+            gen_helper_##NAME##_b,                                 \
+            gen_helper_##NAME##_h,                                 \
+            gen_helper_##NAME##_w,                                 \
+        };                                                         \
+        TCGLabel *over = gen_new_label();                          \
+        gen_set_rm(s, 7);                                          \
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
+                                                                   \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
+                           vreg_ofs(s, a->rs2), cpu_env, 0,        \
+                           s->vlen / 8, data, fns[s->sew]);        \
+        mark_vs_dirty(s);                                          \
+        gen_set_label(over);                                       \
+        return true;                                               \
+    }                                                              \
+    return false;                                                  \
+}
+
+GEN_OPFXV_WIDEN_TRANS(vfwcvt_f_xu_v)
+GEN_OPFXV_WIDEN_TRANS(vfwcvt_f_x_v)
 
 /* Narrowing Floating-Point/Integer Type-Convert Instructions */
 
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index c12d697c440..2f5a2dca336 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4066,6 +4066,7 @@ GEN_VEXT_V_ENV(vfcvt_rtz_x_f_v_d, 8, 8)
 
 /* Widening Floating-Point/Integer Type-Convert Instructions */
 /* (TD, T2, TX2) */
+#define WOP_UU_B uint16_t, uint8_t,  uint8_t
 #define WOP_UU_H uint32_t, uint16_t, uint16_t
 #define WOP_UU_W uint64_t, uint32_t, uint32_t
 /* vfwcvt.xu.f.v vd, vs2, vm # Convert float to double-width unsigned integer.*/
@@ -4081,19 +4082,41 @@ GEN_VEXT_V_ENV(vfwcvt_x_f_v_h, 2, 4)
 GEN_VEXT_V_ENV(vfwcvt_x_f_v_w, 4, 8)
 
 /* vfwcvt.f.xu.v vd, vs2, vm # Convert unsigned integer to double-width float */
+RVVCALL(OPFVV1, vfwcvt_f_xu_v_b, WOP_UU_B, H2, H1, uint8_to_float16)
 RVVCALL(OPFVV1, vfwcvt_f_xu_v_h, WOP_UU_H, H4, H2, uint16_to_float32)
 RVVCALL(OPFVV1, vfwcvt_f_xu_v_w, WOP_UU_W, H8, H4, uint32_to_float64)
+GEN_VEXT_V_ENV(vfwcvt_f_xu_v_b, 1, 2)
 GEN_VEXT_V_ENV(vfwcvt_f_xu_v_h, 2, 4)
 GEN_VEXT_V_ENV(vfwcvt_f_xu_v_w, 4, 8)
 
 /* vfwcvt.f.x.v vd, vs2, vm # Convert integer to double-width float. */
+RVVCALL(OPFVV1, vfwcvt_f_x_v_b, WOP_UU_B, H2, H1, int8_to_float16)
 RVVCALL(OPFVV1, vfwcvt_f_x_v_h, WOP_UU_H, H4, H2, int16_to_float32)
 RVVCALL(OPFVV1, vfwcvt_f_x_v_w, WOP_UU_W, H8, H4, int32_to_float64)
+GEN_VEXT_V_ENV(vfwcvt_f_x_v_b, 1, 2)
 GEN_VEXT_V_ENV(vfwcvt_f_x_v_h, 2, 4)
 GEN_VEXT_V_ENV(vfwcvt_f_x_v_w, 4, 8)
 
 /*
- * vfwcvt.f.f.v vd, vs2, vm #
+ * vfwcvt.rtz.xu.f.v vd, vs2, vm
+ * Convert float to double-width unsigned integer, truncating
+ */
+RVVCALL(OPFVV1, vfwcvt_rtz_xu_f_v_h, WOP_UU_H, H4, H2, float16_to_uint32)
+RVVCALL(OPFVV1, vfwcvt_rtz_xu_f_v_w, WOP_UU_W, H8, H4, float32_to_uint64)
+GEN_VEXT_V_ENV(vfwcvt_rtz_xu_f_v_h, 2, 4)
+GEN_VEXT_V_ENV(vfwcvt_rtz_xu_f_v_w, 4, 8)
+
+/*
+ * vfwcvt.rtz.x.f.v  vd, vs2, vm
+ * Convert float to double-width signed integer, truncating.
+ */
+RVVCALL(OPFVV1, vfwcvt_rtz_x_f_v_h, WOP_UU_H, H4, H2, float16_to_int32)
+RVVCALL(OPFVV1, vfwcvt_rtz_x_f_v_w, WOP_UU_W, H8, H4, float32_to_int64)
+GEN_VEXT_V_ENV(vfwcvt_rtz_x_f_v_h, 2, 4)
+GEN_VEXT_V_ENV(vfwcvt_rtz_x_f_v_w, 4, 8)
+
+/*
+ * vfwcvt.f.f.v vd, vs2, vm
  * Convert single-width float to double-width float.
  */
 static uint32_t vfwcvtffv16(uint16_t a, float_status *s)
-- 
2.17.1


