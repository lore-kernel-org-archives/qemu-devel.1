Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B88C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49342072D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MDUjXaas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49342072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bKi-0002EE-41
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7atH-00030I-NL
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:53:15 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:36232)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7atD-0005MT-NA
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:53:15 -0400
Received: by mail-pl1-x634.google.com with SMTP id y6so7176673plt.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Y7FEi96RcYcA139nyYex6ZEqekhxPzPj/BC27CHiZ2Y=;
 b=MDUjXaasF3+f/AuHH78sfDWXITd2hloEOf9Sw6cgDqda/AYQy4Zwo2oHSGP44LZuoP
 hi3FcC+c5zKQ5mgeOVf6z3sY0UycMShQvL/gB31ozXVCvyP/n3Jur4VlrmeWKKHkjazg
 ttGNpVc41zwbRv1d1SOsvoTf7lALcMlzqCdO6pYxtO48+XRgwuIkFYkAxu5Kk5yNq1r5
 9gFzB09e6qsd08mNNk/YUBnQu4oslXHZH2/veR3lFvKwzPuWKYrywzIzKfOXzmt44LZI
 gdTCFRQUMiH8IYU3678IZqMna70gxb1JlB7kCTvkChlFhmEfLr/JhG8KB1UuZd9jRoyJ
 nd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Y7FEi96RcYcA139nyYex6ZEqekhxPzPj/BC27CHiZ2Y=;
 b=kOUXtUDULaaM8/YaVflCl86rLEgZJoRFwW7i9IJZphMUQdrRXAWmOe/ryuqSaf0bji
 /G+qGRqJoMOjOkdz4UNrnCEGfAcpsVtHqZyn1qUl4+fpXTXc7zVoOYSw9k1uPTlG8ZLt
 Vmr4rXweQlxtLM83NNn4Q+7LSNFm0nVPsD6XtvQwhvHfvzsXCL5HdX4Hu14o2HzrD5Vh
 gmWiN6+ObBGaCdUe+zRJpWOwGcVgcVVcI8XNcurRtpH9F6bihp6mDeqTmyFWr8nglnNK
 vZ3aUSJwWPrgMIVVU8H1Khk1DiirR5XWvbbU1x+1FAsIwHZxgVdaHdI2cChc5rKXBito
 /UEg==
X-Gm-Message-State: AOAM530zM0Qt1CNqT4kUdkyFyzK0Bg9yBVPVJxq2nCiBoZjqxuBKX0xQ
 dbz/0zsjxkXlYWAQmZBkuraKmLom8KMRIg==
X-Google-Smtp-Source: ABdhPJwTtYCpFD7fPek8csNy8Hvdf2cFr6OP5Hvv1hUBxuyGn5qV1nHpfWn162mYZ71rkgWbcBzIGw==
X-Received: by 2002:a17:90a:fb4b:: with SMTP id
 iq11mr11921200pjb.127.1597654389560; 
 Mon, 17 Aug 2020 01:53:09 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:53:09 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 66/70] target/riscv: rvv-1.0: narrowing
 floating-point/integer type-convert
Date: Mon, 17 Aug 2020 16:49:51 +0800
Message-Id: <20200817084955.28793-67-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x634.google.com
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

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/helper.h                   | 30 ++++++----
 target/riscv/insn32.decode              | 15 +++--
 target/riscv/insn_trans/trans_rvv.inc.c | 51 ++++++++++++++---
 target/riscv/vector_helper.c            | 76 ++++++++++++++++++-------
 4 files changed, 130 insertions(+), 42 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index b128610978d..2ecacdc225e 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1009,16 +1009,26 @@ DEF_HELPER_5(vfwcvt_rtz_xu_f_v_w, void, ptr, ptr, ptr, env, i32)
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
index fae96194078..3b42cb01a77 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -571,11 +571,16 @@ vfwcvt_f_x_v       010010 . ..... 01011 001 ..... 1010111 @r2_vm
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
index 877655d9671..f2edf804460 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2936,7 +2936,7 @@ static bool opfv_narrow_check(DisasContext *s, arg_rmr *a)
            (s->sew != 0);
 }
 
-#define GEN_OPFV_NARROW_TRANS(NAME)                                \
+#define GEN_OPFV_NARROW_TRANS(NAME, FRM)                           \
 static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
 {                                                                  \
     if (opfv_narrow_check(s, a)) {                                 \
@@ -2946,7 +2946,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
             gen_helper_##NAME##_w,                                 \
         };                                                         \
         TCGLabel *over = gen_new_label();                          \
-        gen_set_rm(s, FRM_DYN);                                    \
+        gen_set_rm(s, FRM);                                        \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
@@ -2961,11 +2961,48 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
     return false;                                                  \
 }
 
-GEN_OPFV_NARROW_TRANS(vfncvt_xu_f_v)
-GEN_OPFV_NARROW_TRANS(vfncvt_x_f_v)
-GEN_OPFV_NARROW_TRANS(vfncvt_f_xu_v)
-GEN_OPFV_NARROW_TRANS(vfncvt_f_x_v)
-GEN_OPFV_NARROW_TRANS(vfncvt_f_f_v)
+GEN_OPFV_NARROW_TRANS(vfncvt_f_xu_w, FRM_DYN)
+GEN_OPFV_NARROW_TRANS(vfncvt_f_x_w, FRM_DYN)
+GEN_OPFV_NARROW_TRANS(vfncvt_f_f_w, FRM_DYN)
+GEN_OPFV_NARROW_TRANS(vfncvt_rod_f_f_w, FRM_ROD)
+
+static bool opxfv_narrow_check(DisasContext *s, arg_rmr *a)
+{
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           /* OPFV narrowing instructions ignore vs1 check */
+           vext_check_sds(s, a->rd, 0, a->rs2, a->vm, false);
+}
+
+#define GEN_OPXFV_NARROW_TRANS(NAME, FRM)                          \
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
+        gen_set_rm(s, FRM);                                        \
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
+GEN_OPXFV_NARROW_TRANS(vfncvt_xu_f_w, FRM_DYN)
+GEN_OPXFV_NARROW_TRANS(vfncvt_x_f_w, FRM_DYN)
+GEN_OPXFV_NARROW_TRANS(vfncvt_rtz_xu_f_w, FRM_RTZ)
+GEN_OPXFV_NARROW_TRANS(vfncvt_rtz_x_f_w, FRM_RTZ)
 
 /*
  *** Vector Reduction Operations
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 800f4a2af3c..316e435f8af 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4113,31 +4113,36 @@ GEN_VEXT_V_ENV(vfwcvt_f_f_v_w, 4, 8)
 
 /* Narrowing Floating-Point/Integer Type-Convert Instructions */
 /* (TD, T2, TX2) */
+#define NOP_UU_B uint8_t,  uint16_t, uint32_t
 #define NOP_UU_H uint16_t, uint32_t, uint32_t
 #define NOP_UU_W uint32_t, uint64_t, uint64_t
 /* vfncvt.xu.f.v vd, vs2, vm # Convert float to unsigned integer. */
-RVVCALL(OPFVV1, vfncvt_xu_f_v_h, NOP_UU_H, H2, H4, float32_to_uint16)
-RVVCALL(OPFVV1, vfncvt_xu_f_v_w, NOP_UU_W, H4, H8, float64_to_uint32)
-GEN_VEXT_V_ENV(vfncvt_xu_f_v_h, 2, 2)
-GEN_VEXT_V_ENV(vfncvt_xu_f_v_w, 4, 4)
+RVVCALL(OPFVV1, vfncvt_xu_f_w_b, NOP_UU_B, H1, H2, float16_to_uint8)
+RVVCALL(OPFVV1, vfncvt_xu_f_w_h, NOP_UU_H, H2, H4, float32_to_uint16)
+RVVCALL(OPFVV1, vfncvt_xu_f_w_w, NOP_UU_W, H4, H8, float64_to_uint32)
+GEN_VEXT_V_ENV(vfncvt_xu_f_w_b, 1, 1)
+GEN_VEXT_V_ENV(vfncvt_xu_f_w_h, 2, 2)
+GEN_VEXT_V_ENV(vfncvt_xu_f_w_w, 4, 4)
 
 /* vfncvt.x.f.v vd, vs2, vm # Convert double-width float to signed integer. */
-RVVCALL(OPFVV1, vfncvt_x_f_v_h, NOP_UU_H, H2, H4, float32_to_int16)
-RVVCALL(OPFVV1, vfncvt_x_f_v_w, NOP_UU_W, H4, H8, float64_to_int32)
-GEN_VEXT_V_ENV(vfncvt_x_f_v_h, 2, 2)
-GEN_VEXT_V_ENV(vfncvt_x_f_v_w, 4, 4)
+RVVCALL(OPFVV1, vfncvt_x_f_w_b, NOP_UU_B, H1, H2, float16_to_int8)
+RVVCALL(OPFVV1, vfncvt_x_f_w_h, NOP_UU_H, H2, H4, float32_to_int16)
+RVVCALL(OPFVV1, vfncvt_x_f_w_w, NOP_UU_W, H4, H8, float64_to_int32)
+GEN_VEXT_V_ENV(vfncvt_x_f_w_b, 1, 1)
+GEN_VEXT_V_ENV(vfncvt_x_f_w_h, 2, 2)
+GEN_VEXT_V_ENV(vfncvt_x_f_w_w, 4, 4)
 
 /* vfncvt.f.xu.v vd, vs2, vm # Convert double-width unsigned integer to float */
-RVVCALL(OPFVV1, vfncvt_f_xu_v_h, NOP_UU_H, H2, H4, uint32_to_float16)
-RVVCALL(OPFVV1, vfncvt_f_xu_v_w, NOP_UU_W, H4, H8, uint64_to_float32)
-GEN_VEXT_V_ENV(vfncvt_f_xu_v_h, 2, 2)
-GEN_VEXT_V_ENV(vfncvt_f_xu_v_w, 4, 4)
+RVVCALL(OPFVV1, vfncvt_f_xu_w_h, NOP_UU_H, H2, H4, uint32_to_float16)
+RVVCALL(OPFVV1, vfncvt_f_xu_w_w, NOP_UU_W, H4, H8, uint64_to_float32)
+GEN_VEXT_V_ENV(vfncvt_f_xu_w_h, 2, 2)
+GEN_VEXT_V_ENV(vfncvt_f_xu_w_w, 4, 4)
 
 /* vfncvt.f.x.v vd, vs2, vm # Convert double-width integer to float. */
-RVVCALL(OPFVV1, vfncvt_f_x_v_h, NOP_UU_H, H2, H4, int32_to_float16)
-RVVCALL(OPFVV1, vfncvt_f_x_v_w, NOP_UU_W, H4, H8, int64_to_float32)
-GEN_VEXT_V_ENV(vfncvt_f_x_v_h, 2, 2)
-GEN_VEXT_V_ENV(vfncvt_f_x_v_w, 4, 4)
+RVVCALL(OPFVV1, vfncvt_f_x_w_h, NOP_UU_H, H2, H4, int32_to_float16)
+RVVCALL(OPFVV1, vfncvt_f_x_w_w, NOP_UU_W, H4, H8, int64_to_float32)
+GEN_VEXT_V_ENV(vfncvt_f_x_w_h, 2, 2)
+GEN_VEXT_V_ENV(vfncvt_f_x_w_w, 4, 4)
 
 /* vfncvt.f.f.v vd, vs2, vm # Convert double float to single-width float. */
 static uint16_t vfncvtffv16(uint32_t a, float_status *s)
@@ -4145,10 +4150,41 @@ static uint16_t vfncvtffv16(uint32_t a, float_status *s)
     return float32_to_float16(a, true, s);
 }
 
-RVVCALL(OPFVV1, vfncvt_f_f_v_h, NOP_UU_H, H2, H4, vfncvtffv16)
-RVVCALL(OPFVV1, vfncvt_f_f_v_w, NOP_UU_W, H4, H8, float64_to_float32)
-GEN_VEXT_V_ENV(vfncvt_f_f_v_h, 2, 2)
-GEN_VEXT_V_ENV(vfncvt_f_f_v_w, 4, 4)
+RVVCALL(OPFVV1, vfncvt_f_f_w_h, NOP_UU_H, H2, H4, vfncvtffv16)
+RVVCALL(OPFVV1, vfncvt_f_f_w_w, NOP_UU_W, H4, H8, float64_to_float32)
+GEN_VEXT_V_ENV(vfncvt_f_f_w_h, 2, 2)
+GEN_VEXT_V_ENV(vfncvt_f_f_w_w, 4, 4)
+
+/*
+ * vfncvt.rod.f.f.w vd, vs2, vm
+ * Convert double-width float to single-width float, rounding towards odd.
+ */
+RVVCALL(OPFVV1, vfncvt_rod_f_f_w_h, NOP_UU_H, H2, H4, vfncvtffv16)
+RVVCALL(OPFVV1, vfncvt_rod_f_f_w_w, NOP_UU_W, H4, H8, float64_to_float32)
+GEN_VEXT_V_ENV(vfncvt_rod_f_f_w_h, 2, 2)
+GEN_VEXT_V_ENV(vfncvt_rod_f_f_w_w, 4, 4)
+
+/*
+ * vfncvt.rtz.xu.f.w vd, vs2, vm
+ * Convert double-width float to unsigned integer, truncating.
+ */
+RVVCALL(OPFVV1, vfncvt_rtz_xu_f_w_b, NOP_UU_B, H1, H2, float16_to_uint8)
+RVVCALL(OPFVV1, vfncvt_rtz_xu_f_w_h, NOP_UU_H, H2, H4, float32_to_uint16)
+RVVCALL(OPFVV1, vfncvt_rtz_xu_f_w_w, NOP_UU_W, H4, H8, float64_to_uint32)
+GEN_VEXT_V_ENV(vfncvt_rtz_xu_f_w_b, 1, 1)
+GEN_VEXT_V_ENV(vfncvt_rtz_xu_f_w_h, 2, 2)
+GEN_VEXT_V_ENV(vfncvt_rtz_xu_f_w_w, 4, 4)
+
+/*
+ * vfncvt.rtz.x.f.w  vd, vs2, vm
+ * Convert double-width float to signed integer, truncating.
+ */
+RVVCALL(OPFVV1, vfncvt_rtz_x_f_w_b, NOP_UU_B, H1, H2, float16_to_int8)
+RVVCALL(OPFVV1, vfncvt_rtz_x_f_w_h, NOP_UU_H, H2, H4, float32_to_int16)
+RVVCALL(OPFVV1, vfncvt_rtz_x_f_w_w, NOP_UU_W, H4, H8, float64_to_int32)
+GEN_VEXT_V_ENV(vfncvt_rtz_x_f_w_b, 1, 1)
+GEN_VEXT_V_ENV(vfncvt_rtz_x_f_w_h, 2, 2)
+GEN_VEXT_V_ENV(vfncvt_rtz_x_f_w_w, 4, 4)
 
 /*
  *** Vector Reduction Operations
-- 
2.17.1


