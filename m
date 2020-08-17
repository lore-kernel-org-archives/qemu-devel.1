Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08508C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:19:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B76452080D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OTfgETI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76452080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bIP-0004Xm-Tq
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7atA-0002x9-En
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:53:09 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:45122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7at7-0005Lp-Oi
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:53:08 -0400
Received: by mail-pf1-x431.google.com with SMTP id f193so7888788pfa.12
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5AjfmtQommI4WFj3gggWIT4v4V9UzRQA/qIzKnaOag8=;
 b=OTfgETI8iIf50bmFsz3yCXXr/oaFxU/ck4N+m+1BbtHNr7i4oAgBqc9SUqwxgzHIK+
 +9oXZTOCiAP6UONSYF9XpHxuP9R83cQ8b667bsAny1fprmB10B76ZI/j1WLx0toIAWfm
 LR1jW/XjTtMlLli9sHjgUPZ9muuhEDq2BWf/94LREDAYkrgK6jJTI24c2tVED0G0S/lG
 9u2V9oyKVQdV79Hqqzk7sHuyJN09rH8JhQJn4U9UhQVOUnYnM1TEFHsM1Jxt88SuMT1n
 KinjKKwIlCSqTZfPfEJn3JZZT2EQxpomNoAQdsfDUScOH15b3FG6IDLBzbkAO++VMkJI
 TlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5AjfmtQommI4WFj3gggWIT4v4V9UzRQA/qIzKnaOag8=;
 b=P+ZWLymuty2FiDyVAQS6x7Ke0c1d7SMnEo8l80nShqsIiRgl+spVIoFCNEOOYKphc9
 X7RRKSTYtlhmpVBe1SxeSXmg2PJ72189FZPnp5U0OX2dSOfOC7CDTkzyEFtdl0iwmMz4
 GsTcwx/tpyujMflvYpG1Gew1ugxy+yR1qIOraCumz0iumpepLgbLjVP8J423f3eD2muO
 vWGXhh1t24t2DB4uMpkXRYNwr2NlM0BtmuBSbzGF59d3sk8oXfaH+po10BiLvl3KShqz
 zxk37ug3VwiHRGebjlWtktzI35mG4yiLrLsffJnz70jV6iaI4n2vIftlKzvozaplP0HS
 bYAw==
X-Gm-Message-State: AOAM532poBeADttxYrhGDo0Ec1Nd3I+bya6Cz8dwfiFhjGnF5kJ8Zpfn
 gEM6SLZK/b4v2K+H6+M0m4ys8/y6rYZkIw==
X-Google-Smtp-Source: ABdhPJytoo1uvWoCNyWdANKyoXpylsXC5wWL0KQJjf7g3F5QENsGb2tN0c6KvDWKfB6OrsPv+xGgiQ==
X-Received: by 2002:a62:2707:: with SMTP id n7mr6186620pfn.38.1597654384206;
 Mon, 17 Aug 2020 01:53:04 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:53:03 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 64/70] target/riscv: rvv-1.0: widening floating-point/integer
 type-convert
Date: Mon, 17 Aug 2020 16:49:49 +0800
Message-Id: <20200817084955.28793-65-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x431.google.com
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
 target/riscv/insn_trans/trans_rvv.inc.c | 50 +++++++++++++++++++++----
 target/riscv/vector_helper.c            | 25 ++++++++++++-
 4 files changed, 81 insertions(+), 13 deletions(-)

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
index 9cc5e2315cd..877655d9671 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2854,7 +2854,7 @@ static bool opfv_widen_check(DisasContext *s, arg_rmr *a)
            (s->sew != 0);
 }
 
-#define GEN_OPFV_WIDEN_TRANS(NAME)                                 \
+#define GEN_OPFV_WIDEN_TRANS(NAME, FRM)                            \
 static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
 {                                                                  \
     if (opfv_widen_check(s, a)) {                                  \
@@ -2864,7 +2864,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
             gen_helper_##NAME##_w,                                 \
         };                                                         \
         TCGLabel *over = gen_new_label();                          \
-        gen_set_rm(s, FRM_DYN);                                        \
+        gen_set_rm(s, FRM);                                        \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
@@ -2879,11 +2879,47 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
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
+        gen_set_rm(s, FRM_DYN);                                    \
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
+                                                                   \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
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
index 644ebf8538e..800f4a2af3c 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4048,6 +4048,7 @@ GEN_VEXT_V_ENV(vfcvt_rtz_x_f_v_d, 8, 8)
 
 /* Widening Floating-Point/Integer Type-Convert Instructions */
 /* (TD, T2, TX2) */
+#define WOP_UU_B uint16_t, uint8_t,  uint8_t
 #define WOP_UU_H uint32_t, uint16_t, uint16_t
 #define WOP_UU_W uint64_t, uint32_t, uint32_t
 /* vfwcvt.xu.f.v vd, vs2, vm # Convert float to double-width unsigned integer.*/
@@ -4063,19 +4064,41 @@ GEN_VEXT_V_ENV(vfwcvt_x_f_v_h, 2, 4)
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


