Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F71C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:55:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FD5720714
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RzC2zJG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD5720714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBSv-0004qj-Qg
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAxT-0007i6-1i
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:22:39 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:39338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAxP-0006F8-ML
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:22:38 -0400
Received: by mail-pl1-x62b.google.com with SMTP id b9so655562plx.6
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+D0zPyB+6VBV8sI4ksQukTNEFjnxE7hOXag5S/fiqkI=;
 b=RzC2zJG7GcbxY9lcWv11+Cm7fflMzyBsi83tdplTpoJkc5wT29ivnpf3UUeBm6+rRv
 LQbSYuHBQgQ3echT84pa4BBbvhxMuElo8ijZAGWxpXyH7A3lT4H/nR7fJrkW9ztXE26+
 V6rt1eHKtpRdiCNPk60lvPtenBlulc01o/y5bHpawNEj0vV42Igc0u7IOv7KFcQaITva
 q3DDZ9Mgxkkt4fZz5wxiemljt53D85P2cvPOcEFV2w2H91j7nJdxnMbWiqLBjMQKDQE8
 I4IuduL9KCHlWx0dRMArii9zZuzYm3d5xcHagWCDrK9HxW4LSflIvKuhBLuzdoLeGRI7
 dJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+D0zPyB+6VBV8sI4ksQukTNEFjnxE7hOXag5S/fiqkI=;
 b=gjn7kNWyEip/tfKJX1jT7Mp0ER2Rat8oS2djNfenzUfjHIe6up3o+98G3He0wRCMCN
 R5meHcvuXYJW5R2sCwtWQZ3+HOP2PSVUuDIpylg82bvK56vETfEVIIMo0s1hjcrcMzYn
 nHWWSgNSFvI/ma3C2cRSdbq8YC8InOyiRB/AQBGNR+fPAPAYVH/9WW1AazI1Vglo8N7s
 +VWS8EbzWLrYLLFHQpm0suAHh7u71Le0T/xdnnEyDvs3E0uvdBdO6UZZT3/jz5YayBB+
 aiGFZ7Ka2sOGMCPVC/rHwXJHz+qpMFdIyEOXhTnxw182KM8dqn0D74cJXoMrxUMZ7QKo
 RF1Q==
X-Gm-Message-State: AOAM533mswc1etINg5mLqzVNxAuKyFUt0Wt2jVO2jF1wI6hhhocexzJS
 YqoBzRM5wvPUgZJadT1dmDPZg8t+pJs=
X-Google-Smtp-Source: ABdhPJyyIwtGndCTM2eFkh/+oof+hkkTO4HgvkF8X/8sN78meEB2SD/epJBebI8XIvbo7jVqHog8qQ==
X-Received: by 2002:a17:90a:ac14:: with SMTP id
 o20mr9158568pjq.185.1595409754238; 
 Wed, 22 Jul 2020 02:22:34 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:22:33 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 71/76] target/riscv: rvv-0.9: widening floating-point/integer
 type-convert
Date: Wed, 22 Jul 2020 17:16:34 +0800
Message-Id: <20200722091641.8834-72-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62b.google.com
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Frank Chang <frank.chang@sifive.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/helper.h                   |  6 ++++
 target/riscv/insn32.decode              | 13 +++++---
 target/riscv/insn_trans/trans_rvv.inc.c | 43 +++++++++++++++++++++++--
 target/riscv/vector_helper.c            | 29 ++++++++++++++++-
 4 files changed, 83 insertions(+), 8 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index d74dbffc21..03330fa332 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -977,12 +977,18 @@ DEF_HELPER_5(vfwcvt_xu_f_v_h, void, ptr, ptr, ptr, env, i32)
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
index bc0e44b8ab..55d7a6f338 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -545,11 +545,14 @@ vfcvt_f_xu_v       010010 . ..... 00010 001 ..... 1010111 @r2_vm
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
index 6249f9af5b..775811c9f0 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2915,9 +2915,48 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
 
 GEN_OPFV_WIDEN_TRANS(vfwcvt_xu_f_v)
 GEN_OPFV_WIDEN_TRANS(vfwcvt_x_f_v)
-GEN_OPFV_WIDEN_TRANS(vfwcvt_f_xu_v)
-GEN_OPFV_WIDEN_TRANS(vfwcvt_f_x_v)
 GEN_OPFV_WIDEN_TRANS(vfwcvt_f_f_v)
+GEN_OPFV_WIDEN_TRANS(vfwcvt_rtz_xu_f_v)
+GEN_OPFV_WIDEN_TRANS(vfwcvt_rtz_x_f_v)
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
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);               \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
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
index 4c6755db97..3d12638c4b 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4302,6 +4302,7 @@ GEN_VEXT_V_ENV(vfcvt_rtz_x_f_v_d, 8, 8, clearq)
 
 /* Widening Floating-Point/Integer Type-Convert Instructions */
 /* (TD, T2, TX2) */
+#define WOP_UU_B uint16_t, uint8_t,  uint8_t
 #define WOP_UU_H uint32_t, uint16_t, uint16_t
 #define WOP_UU_W uint64_t, uint32_t, uint32_t
 /* vfwcvt.xu.f.v vd, vs2, vm # Convert float to double-width unsigned integer.*/
@@ -4317,19 +4318,45 @@ GEN_VEXT_V_ENV(vfwcvt_x_f_v_h, 2, 4, clearl)
 GEN_VEXT_V_ENV(vfwcvt_x_f_v_w, 4, 8, clearq)
 
 /* vfwcvt.f.xu.v vd, vs2, vm # Convert unsigned integer to double-width float */
+RVVCALL(OPFVV1, vfwcvt_f_xu_v_b, WOP_UU_B, H2, H1, uint8_to_float16)
 RVVCALL(OPFVV1, vfwcvt_f_xu_v_h, WOP_UU_H, H4, H2, uint16_to_float32)
 RVVCALL(OPFVV1, vfwcvt_f_xu_v_w, WOP_UU_W, H8, H4, uint32_to_float64)
+GEN_VEXT_V_ENV(vfwcvt_f_xu_v_b, 1, 2, clearh)
 GEN_VEXT_V_ENV(vfwcvt_f_xu_v_h, 2, 4, clearl)
 GEN_VEXT_V_ENV(vfwcvt_f_xu_v_w, 4, 8, clearq)
 
 /* vfwcvt.f.x.v vd, vs2, vm # Convert integer to double-width float. */
+RVVCALL(OPFVV1, vfwcvt_f_x_v_b, WOP_UU_B, H2, H1, int8_to_float16)
 RVVCALL(OPFVV1, vfwcvt_f_x_v_h, WOP_UU_H, H4, H2, int16_to_float32)
 RVVCALL(OPFVV1, vfwcvt_f_x_v_w, WOP_UU_W, H8, H4, int32_to_float64)
+GEN_VEXT_V_ENV(vfwcvt_f_x_v_b, 1, 2, clearh)
 GEN_VEXT_V_ENV(vfwcvt_f_x_v_h, 2, 4, clearl)
 GEN_VEXT_V_ENV(vfwcvt_f_x_v_w, 4, 8, clearq)
 
 /*
- * vfwcvt.f.f.v vd, vs2, vm #
+ * vfwcvt.rtz.xu.f.v vd, vs2, vm
+ * Convert float to double-width unsigned integer, truncating
+ */
+FCVT_RTZ_F_V(float16, uint32)
+FCVT_RTZ_F_V(float32, uint64)
+RVVCALL(OPFVV1, vfwcvt_rtz_xu_f_v_h, WOP_UU_H, H4, H2, float16_to_uint32_rtz)
+RVVCALL(OPFVV1, vfwcvt_rtz_xu_f_v_w, WOP_UU_W, H8, H4, float32_to_uint64_rtz)
+GEN_VEXT_V_ENV(vfwcvt_rtz_xu_f_v_h, 2, 4, clearl)
+GEN_VEXT_V_ENV(vfwcvt_rtz_xu_f_v_w, 4, 8, clearq)
+
+/*
+ * vfwcvt.rtz.x.f.v  vd, vs2, vm
+ * Convert float to double-width signed integer, truncating.
+ */
+FCVT_RTZ_F_V(float16, int32)
+FCVT_RTZ_F_V(float32, int64)
+RVVCALL(OPFVV1, vfwcvt_rtz_x_f_v_h, WOP_UU_H, H4, H2, float16_to_int32_rtz)
+RVVCALL(OPFVV1, vfwcvt_rtz_x_f_v_w, WOP_UU_W, H8, H4, float32_to_int64_rtz)
+GEN_VEXT_V_ENV(vfwcvt_rtz_x_f_v_h, 2, 4, clearl)
+GEN_VEXT_V_ENV(vfwcvt_rtz_x_f_v_w, 4, 8, clearq)
+
+/*
+ * vfwcvt.f.f.v vd, vs2, vm
  * Convert single-width float to double-width float.
  */
 static uint32_t vfwcvtffv16(uint16_t a, float_status *s)
-- 
2.17.1


