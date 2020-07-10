Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44095C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFCE2207BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="h5FOrAQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCE2207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtt3I-0007DR-85
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqft-0006FE-8b
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:54:37 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:40361)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqfp-00072R-OF
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:54:36 -0400
Received: by mail-pf1-x42d.google.com with SMTP id u5so2383799pfn.7
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CQxchCagHr5Gl4S7DSGppoBRtsJyZ3qDYq23QfuT5vA=;
 b=h5FOrAQvLlLAGs5F5Ync8voBlIFuGKg4Xf0OXCutShe3e0sxbkEUN1+t2LKKzCXMTW
 vKaav9l5SINmgdHSDzyEt4boawFL/jQDUE2VKrU9iZ92JW8MXm3SfqFSazzFQEUHUAKa
 fOgM20mL2VL7lldERy3SUl6zQqIQr9mePh13VcpQ3FxHjx7k4EZieacqxFYYXAwJL48L
 luS/pch65hTpYhs2bkdlmaFfDTlWXiE1pwKdbyR2J0fSN4qp1lDR5dNvOokK5cN8wKnH
 pGNHw01ul9VPUxki2B539qXQlRZbmiDJxxrylBgkI3eMrwDoQkB4mg3kmM9+VUTND4AZ
 oE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CQxchCagHr5Gl4S7DSGppoBRtsJyZ3qDYq23QfuT5vA=;
 b=NOcTJ1NfZQ9vBI+PUymHxtaWSnk5ch0l8S55qRQ1ogFLsMSppeFZCeZgXUMXS4E/rd
 GO6aaZ66pLcErX50QO92dQ3I0vGo1mEreZERtim1C+ze+OSBT7H5fHll+JoRZMU3qtZo
 e860jiS5a2kyG8aL4csZbtvC5oSVowum7u+nH+dEuibzgbnsIsB1h23WK6ecVq+w+GPA
 334JAl+hxEgFLWM1aXRESGtqUqh1chaMqfGR1TlSq17SEYcWEbBznjkAcZq3wgoP2ZCV
 345By7P2tLvcH4aKe7vWOtOATlqBerRaYX6jjFsHgMo26g1ovZouSH55CPqldLH3HJt9
 IvBw==
X-Gm-Message-State: AOAM530DdRswrqV0BY2d3dDcE8STeygwsfhI+l556RUnhPxIJh29gBQu
 JQ1EWtwpKWzXO3svpXxowlJkurP/MA4+pg==
X-Google-Smtp-Source: ABdhPJx9KcG2A4cegzwCqFOxX9y/0Q1ApT4uIhKsblsj/jtoTeKincOfX45Yi2uMiqDtuOsFnt2zJw==
X-Received: by 2002:a63:eb52:: with SMTP id b18mr56239600pgk.434.1594378472223; 
 Fri, 10 Jul 2020 03:54:32 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:54:31 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 59/65] target/riscv: rvv-0.9: narrowing floating-point/integer
 type-convert
Date: Fri, 10 Jul 2020 18:49:13 +0800
Message-Id: <20200710104920.13550-60-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42d.google.com
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
X-Mailman-Approved-At: Fri, 10 Jul 2020 08:57:18 -0400
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
 target/riscv/helper.h                   | 30 +++++---
 target/riscv/insn32.decode              | 15 ++--
 target/riscv/insn_trans/trans_rvv.inc.c | 50 +++++++++++--
 target/riscv/vector_helper.c            | 99 ++++++++++++++++++++-----
 4 files changed, 154 insertions(+), 40 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 0cd5979288..f8c657737f 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -990,16 +990,26 @@ DEF_HELPER_5(vfwcvt_rtz_xu_f_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_rtz_x_f_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_rtz_x_f_v_w, void, ptr, ptr, ptr, env, i32)
 
-DEF_HELPER_5(vfncvt_xu_f_v_h, void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_5(vfncvt_xu_f_v_w, void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_5(vfncvt_x_f_v_h, void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_5(vfncvt_x_f_v_w, void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_5(vfncvt_f_xu_v_h, void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_5(vfncvt_f_xu_v_w, void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_5(vfncvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_5(vfncvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_5(vfncvt_f_f_v_h, void, ptr, ptr, ptr, env, i32)
-DEF_HELPER_5(vfncvt_f_f_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_xu_f_w_b, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_xu_f_w_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_xu_f_w_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_x_f_w_b, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_x_f_w_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_x_f_w_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_f_xu_w_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_f_xu_w_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_f_x_w_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_f_x_w_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_f_f_w_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_f_f_w_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_rod_f_f_w_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_rod_f_f_w_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_rtz_xu_f_w_b, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_rtz_xu_f_w_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_rtz_xu_f_w_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_rtz_x_f_w_b, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_rtz_x_f_w_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_rtz_x_f_w_w, void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_6(vredsum_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vredsum_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 55d7a6f338..17350227c6 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -553,11 +553,16 @@ vfwcvt_f_x_v       010010 . ..... 01011 001 ..... 1010111 @r2_vm
 vfwcvt_f_f_v       010010 . ..... 01100 001 ..... 1010111 @r2_vm
 vfwcvt_rtz_xu_f_v  010010 . ..... 01110 001 ..... 1010111 @r2_vm
 vfwcvt_rtz_x_f_v   010010 . ..... 01111 001 ..... 1010111 @r2_vm
-vfncvt_xu_f_v   100010 . ..... 10000 001 ..... 1010111 @r2_vm
-vfncvt_x_f_v    100010 . ..... 10001 001 ..... 1010111 @r2_vm
-vfncvt_f_xu_v   100010 . ..... 10010 001 ..... 1010111 @r2_vm
-vfncvt_f_x_v    100010 . ..... 10011 001 ..... 1010111 @r2_vm
-vfncvt_f_f_v    100010 . ..... 10100 001 ..... 1010111 @r2_vm
+
+vfncvt_xu_f_w      010010 . ..... 10000 001 ..... 1010111 @r2_vm
+vfncvt_x_f_w       010010 . ..... 10001 001 ..... 1010111 @r2_vm
+vfncvt_f_xu_w      010010 . ..... 10010 001 ..... 1010111 @r2_vm
+vfncvt_f_x_w       010010 . ..... 10011 001 ..... 1010111 @r2_vm
+vfncvt_f_f_w       010010 . ..... 10100 001 ..... 1010111 @r2_vm
+vfncvt_rod_f_f_w   010010 . ..... 10101 001 ..... 1010111 @r2_vm
+vfncvt_rtz_xu_f_w  010010 . ..... 10110 001 ..... 1010111 @r2_vm
+vfncvt_rtz_x_f_w   010010 . ..... 10111 001 ..... 1010111 @r2_vm
+
 vredsum_vs      000000 . ..... ..... 010 ..... 1010111 @r_vm
 vredand_vs      000001 . ..... ..... 010 ..... 1010111 @r_vm
 vredor_vs       000010 . ..... ..... 010 ..... 1010111 @r_vm
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 4840200f01..dffe554966 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2761,11 +2761,51 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
     return false;                                                  \
 }
 
-GEN_OPFV_NARROW_TRANS(vfncvt_xu_f_v)
-GEN_OPFV_NARROW_TRANS(vfncvt_x_f_v)
-GEN_OPFV_NARROW_TRANS(vfncvt_f_xu_v)
-GEN_OPFV_NARROW_TRANS(vfncvt_f_x_v)
-GEN_OPFV_NARROW_TRANS(vfncvt_f_f_v)
+GEN_OPFV_NARROW_TRANS(vfncvt_f_xu_w)
+GEN_OPFV_NARROW_TRANS(vfncvt_f_x_w)
+GEN_OPFV_NARROW_TRANS(vfncvt_f_f_w)
+GEN_OPFV_NARROW_TRANS(vfncvt_rod_f_f_w)
+
+static bool opxfv_narrow_check(DisasContext *s, arg_rmr *a)
+{
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    /* OPFV narrowing instructions ignore vs1 check */
+    VEXT_CHECK_SDS(s, a->rd, 0, a->rs2, a->vm, false);
+    return true;
+}
+
+#define GEN_OPXFV_NARROW_TRANS(NAME)                               \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
+{                                                                  \
+    if (opxfv_narrow_check(s, a)) {                                \
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
+        gen_set_label(over);                                       \
+        return true;                                               \
+    }                                                              \
+    return false;                                                  \
+}
+
+GEN_OPXFV_NARROW_TRANS(vfncvt_xu_f_w)
+GEN_OPXFV_NARROW_TRANS(vfncvt_x_f_w)
+GEN_OPXFV_NARROW_TRANS(vfncvt_rtz_xu_f_w)
+GEN_OPXFV_NARROW_TRANS(vfncvt_rtz_x_f_w)
 
 /*
  *** Vector Reduction Operations
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 0b6dd4c93f..aac055c6b6 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4265,6 +4265,16 @@ static DTYPE##_t STYPE##_to_##DTYPE##_rtz(STYPE a, float_status * s) \
     return result;                                                   \
 }
 
+#define FCVT_ROD_F_F(STYPE, DTYPE)                               \
+static DTYPE STYPE##_to_##DTYPE##_rod(STYPE a, float_status * s) \
+{                                                                \
+    signed char frm = s->float_rounding_mode;                    \
+    s->float_rounding_mode = float_round_to_odd;                 \
+    DTYPE result = STYPE##_to_##DTYPE(a, s);                     \
+    s->float_rounding_mode = frm;                                \
+    return result;                                               \
+}
+
 /*
  * vfcvt.rtz.xu.f.v vd, vs2, vm
  * Convert float to unsigned integer, truncating.
@@ -4364,31 +4374,36 @@ GEN_VEXT_V_ENV(vfwcvt_f_f_v_w, 4, 8, clearq)
 
 /* Narrowing Floating-Point/Integer Type-Convert Instructions */
 /* (TD, T2, TX2) */
+#define NOP_UU_B uint8_t,  uint16_t, uint32_t
 #define NOP_UU_H uint16_t, uint32_t, uint32_t
 #define NOP_UU_W uint32_t, uint64_t, uint64_t
 /* vfncvt.xu.f.v vd, vs2, vm # Convert float to unsigned integer. */
-RVVCALL(OPFVV1, vfncvt_xu_f_v_h, NOP_UU_H, H2, H4, float32_to_uint16)
-RVVCALL(OPFVV1, vfncvt_xu_f_v_w, NOP_UU_W, H4, H8, float64_to_uint32)
-GEN_VEXT_V_ENV(vfncvt_xu_f_v_h, 2, 2, clearh)
-GEN_VEXT_V_ENV(vfncvt_xu_f_v_w, 4, 4, clearl)
+RVVCALL(OPFVV1, vfncvt_xu_f_w_b, NOP_UU_B, H1, H2, float16_to_uint8)
+RVVCALL(OPFVV1, vfncvt_xu_f_w_h, NOP_UU_H, H2, H4, float32_to_uint16)
+RVVCALL(OPFVV1, vfncvt_xu_f_w_w, NOP_UU_W, H4, H8, float64_to_uint32)
+GEN_VEXT_V_ENV(vfncvt_xu_f_w_b, 1, 1, clearb)
+GEN_VEXT_V_ENV(vfncvt_xu_f_w_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfncvt_xu_f_w_w, 4, 4, clearl)
 
 /* vfncvt.x.f.v vd, vs2, vm # Convert double-width float to signed integer. */
-RVVCALL(OPFVV1, vfncvt_x_f_v_h, NOP_UU_H, H2, H4, float32_to_int16)
-RVVCALL(OPFVV1, vfncvt_x_f_v_w, NOP_UU_W, H4, H8, float64_to_int32)
-GEN_VEXT_V_ENV(vfncvt_x_f_v_h, 2, 2, clearh)
-GEN_VEXT_V_ENV(vfncvt_x_f_v_w, 4, 4, clearl)
+RVVCALL(OPFVV1, vfncvt_x_f_w_b, NOP_UU_B, H1, H2, float16_to_int8)
+RVVCALL(OPFVV1, vfncvt_x_f_w_h, NOP_UU_H, H2, H4, float32_to_int16)
+RVVCALL(OPFVV1, vfncvt_x_f_w_w, NOP_UU_W, H4, H8, float64_to_int32)
+GEN_VEXT_V_ENV(vfncvt_x_f_w_b, 1, 1, clearb)
+GEN_VEXT_V_ENV(vfncvt_x_f_w_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfncvt_x_f_w_w, 4, 4, clearl)
 
 /* vfncvt.f.xu.v vd, vs2, vm # Convert double-width unsigned integer to float */
-RVVCALL(OPFVV1, vfncvt_f_xu_v_h, NOP_UU_H, H2, H4, uint32_to_float16)
-RVVCALL(OPFVV1, vfncvt_f_xu_v_w, NOP_UU_W, H4, H8, uint64_to_float32)
-GEN_VEXT_V_ENV(vfncvt_f_xu_v_h, 2, 2, clearh)
-GEN_VEXT_V_ENV(vfncvt_f_xu_v_w, 4, 4, clearl)
+RVVCALL(OPFVV1, vfncvt_f_xu_w_h, NOP_UU_H, H2, H4, uint32_to_float16)
+RVVCALL(OPFVV1, vfncvt_f_xu_w_w, NOP_UU_W, H4, H8, uint64_to_float32)
+GEN_VEXT_V_ENV(vfncvt_f_xu_w_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfncvt_f_xu_w_w, 4, 4, clearl)
 
 /* vfncvt.f.x.v vd, vs2, vm # Convert double-width integer to float. */
-RVVCALL(OPFVV1, vfncvt_f_x_v_h, NOP_UU_H, H2, H4, int32_to_float16)
-RVVCALL(OPFVV1, vfncvt_f_x_v_w, NOP_UU_W, H4, H8, int64_to_float32)
-GEN_VEXT_V_ENV(vfncvt_f_x_v_h, 2, 2, clearh)
-GEN_VEXT_V_ENV(vfncvt_f_x_v_w, 4, 4, clearl)
+RVVCALL(OPFVV1, vfncvt_f_x_w_h, NOP_UU_H, H2, H4, int32_to_float16)
+RVVCALL(OPFVV1, vfncvt_f_x_w_w, NOP_UU_W, H4, H8, int64_to_float32)
+GEN_VEXT_V_ENV(vfncvt_f_x_w_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfncvt_f_x_w_w, 4, 4, clearl)
 
 /* vfncvt.f.f.v vd, vs2, vm # Convert double float to single-width float. */
 static uint16_t vfncvtffv16(uint32_t a, float_status *s)
@@ -4396,10 +4411,54 @@ static uint16_t vfncvtffv16(uint32_t a, float_status *s)
     return float32_to_float16(a, true, s);
 }
 
-RVVCALL(OPFVV1, vfncvt_f_f_v_h, NOP_UU_H, H2, H4, vfncvtffv16)
-RVVCALL(OPFVV1, vfncvt_f_f_v_w, NOP_UU_W, H4, H8, float64_to_float32)
-GEN_VEXT_V_ENV(vfncvt_f_f_v_h, 2, 2, clearh)
-GEN_VEXT_V_ENV(vfncvt_f_f_v_w, 4, 4, clearl)
+RVVCALL(OPFVV1, vfncvt_f_f_w_h, NOP_UU_H, H2, H4, vfncvtffv16)
+RVVCALL(OPFVV1, vfncvt_f_f_w_w, NOP_UU_W, H4, H8, float64_to_float32)
+GEN_VEXT_V_ENV(vfncvt_f_f_w_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfncvt_f_f_w_w, 4, 4, clearl)
+
+/*
+ * vfncvt.rod.f.f.w vd, vs2, vm
+ * Convert double-width float to single-width float, rounding towards odd.
+ */
+static uint16_t vfncvtffv16_rod(uint32_t a, float_status * s)
+{
+    s->float_rounding_mode = float_round_to_odd;
+    return float32_to_float16(a, true, s);
+}
+
+FCVT_ROD_F_F(float64, float32)
+RVVCALL(OPFVV1, vfncvt_rod_f_f_w_h, NOP_UU_H, H2, H4, vfncvtffv16_rod)
+RVVCALL(OPFVV1, vfncvt_rod_f_f_w_w, NOP_UU_W, H4, H8, float64_to_float32_rod)
+GEN_VEXT_V_ENV(vfncvt_rod_f_f_w_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfncvt_rod_f_f_w_w, 4, 4, clearl)
+
+/*
+ * vfncvt.rtz.xu.f.w vd, vs2, vm
+ * Convert double-width float to unsigned integer, truncating.
+ */
+FCVT_RTZ_F_V(float16, uint8)
+FCVT_RTZ_F_V(float32, uint16)
+FCVT_RTZ_F_V(float64, uint32)
+RVVCALL(OPFVV1, vfncvt_rtz_xu_f_w_b, NOP_UU_B, H1, H2, float16_to_uint8_rtz)
+RVVCALL(OPFVV1, vfncvt_rtz_xu_f_w_h, NOP_UU_H, H2, H4, float32_to_uint16_rtz)
+RVVCALL(OPFVV1, vfncvt_rtz_xu_f_w_w, NOP_UU_W, H4, H8, float64_to_uint32_rtz)
+GEN_VEXT_V_ENV(vfncvt_rtz_xu_f_w_b, 1, 1, clearb)
+GEN_VEXT_V_ENV(vfncvt_rtz_xu_f_w_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfncvt_rtz_xu_f_w_w, 4, 4, clearl)
+
+/*
+ * vfncvt.rtz.x.f.w  vd, vs2, vm
+ * Convert double-width float to signed integer, truncating.
+ */
+FCVT_RTZ_F_V(float16, int8)
+FCVT_RTZ_F_V(float32, int16)
+FCVT_RTZ_F_V(float64, int32)
+RVVCALL(OPFVV1, vfncvt_rtz_x_f_w_b, NOP_UU_B, H1, H2, float16_to_int8_rtz)
+RVVCALL(OPFVV1, vfncvt_rtz_x_f_w_h, NOP_UU_H, H2, H4, float32_to_int16_rtz)
+RVVCALL(OPFVV1, vfncvt_rtz_x_f_w_w, NOP_UU_W, H4, H8, float64_to_int32_rtz)
+GEN_VEXT_V_ENV(vfncvt_rtz_x_f_w_b, 1, 1, clearb)
+GEN_VEXT_V_ENV(vfncvt_rtz_x_f_w_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfncvt_rtz_x_f_w_w, 4, 4, clearl)
 
 /*
  *** Vector Reduction Operations
-- 
2.17.1


