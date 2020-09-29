Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB42BC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26E4020774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Yjw38KLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E4020774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLiF-0005Ov-6x
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKzt-0008Da-IN
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:09:09 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:37759)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKzp-0002WU-VR
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:09:09 -0400
Received: by mail-pf1-x42a.google.com with SMTP id w7so5544366pfi.4
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=KpMvY9F5J2HJP6wY5E/8ykEjyJrmA+qn+xncru+uaNs=;
 b=Yjw38KLZg63qAQ3CuuGmrmUUJC5cMVPIof0KeiH6VU0deEfCfYabsPdLDPNux6pwSi
 7nQ1sKuV8LNXk9BM9tDDHmUTO2Tf5rsbBG1CunBT16hmO8JnrRtWoLIDbQ0AmnerqI/h
 51VivgfzeJ8wAr4Iew2dRdOAoKg5HEtbjQyxMoLG/qrPKau2No/BCIjWkNrLjI0WHsmM
 NOyaWqwreDn48HHAzIQaklnsbLf8HlaYbrELDseui52+i6yWJpUMKcf+VtcVtnNMhfC8
 +o/WM6OHfFVRspewtWgQaidVub+13v74STkff6zOS3pzV5IaKFST1OMMCBBSqDEy0BOB
 LvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=KpMvY9F5J2HJP6wY5E/8ykEjyJrmA+qn+xncru+uaNs=;
 b=HKffFdWo7nDYGhNVzYLGVwdc+6rNXYrf+sGJVtwhg1Oj63q1udyalNjMftbWODNRkb
 ahy0W3jDZca1wq5tOiWzRwSoeRmJMDP4zlAnty0pekS9nYC1PNUXdmvzZsAWD4B0XoBG
 tk+NqZDWT0z/SmW7hwOI5hhA3ZnrgdSoVi6OvcLd7nwieeKtq8nSkfad9EN8v+cQUZeT
 3s+TexzhbIAnEMR5nkoMfAjbipFLq5E41MUnDsXSNjFep80pivhmj6XNAyuTkOJx9kjN
 /pNl8uIvuoKgmzg3Dd5MYHpePkhja20rTVgt3vom8VmmlRkKZKOhxw6HO4dtStVXJ1Ws
 D1nw==
X-Gm-Message-State: AOAM533QRb048alovTYSMv0rrMK1GRcQ31nA18RB1fTQfPRm9uH4qV4T
 qRIO/pTq2r819T77AAodY8uHjUR45/1wXA==
X-Google-Smtp-Source: ABdhPJz6kX24u1L28wY9xwcx6TCxYNNyZqz5Qa3IlThRm7DVfbYscXFyIiFvayDDifcD4NTIl4rGnQ==
X-Received: by 2002:a17:902:ee0c:b029:d1:8c50:aa63 with SMTP id
 z12-20020a170902ee0cb02900d18c50aa63mr6045315plb.21.1601406543438; 
 Tue, 29 Sep 2020 12:09:03 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:09:03 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 63/68] target/riscv: rvv-1.0: narrowing
 floating-point/integer type-convert
Date: Wed, 30 Sep 2020 03:04:38 +0800
Message-Id: <20200929190448.31116-64-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/riscv/helper.h                   | 22 +++++-----
 target/riscv/insn32.decode              | 15 ++++---
 target/riscv/insn_trans/trans_rvv.c.inc | 58 +++++++++++++++++++++----
 target/riscv/vector_helper.c            | 45 ++++++++++---------
 4 files changed, 96 insertions(+), 44 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 32edc77858..e5510be6f8 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -988,16 +988,18 @@ DEF_HELPER_5(vfwcvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_f_f_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_f_f_v_w, void, ptr, ptr, ptr, env, i32)
 
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
 
 DEF_HELPER_6(vredsum_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vredsum_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6253628b9c..51b4268fa7 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -575,11 +575,16 @@ vfwcvt_f_x_v       010010 . ..... 01011 001 ..... 1010111 @r2_vm
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
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 32e94c496c..db6c3d9bdf 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2873,17 +2873,17 @@ static bool opfv_narrow_check(DisasContext *s, arg_rmr *a)
            vext_check_sd(s, a->rd, a->rs2, a->vm);
 }
 
-#define GEN_OPFV_NARROW_TRANS(NAME)                                \
+#define GEN_OPFV_NARROW_TRANS(NAME, HELPER, FRM)                   \
 static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
 {                                                                  \
     if (opfv_narrow_check(s, a)) {                                 \
         uint32_t data = 0;                                         \
         static gen_helper_gvec_3_ptr * const fns[2] = {            \
-            gen_helper_##NAME##_h,                                 \
-            gen_helper_##NAME##_w,                                 \
+            gen_helper_##HELPER##_h,                               \
+            gen_helper_##HELPER##_w,                               \
         };                                                         \
         TCGLabel *over = gen_new_label();                          \
-        gen_set_rm(s, RISCV_FRM_DYN);                              \
+        gen_set_rm(s, FRM);                                        \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
@@ -2898,11 +2898,51 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
     return false;                                                  \
 }
 
-GEN_OPFV_NARROW_TRANS(vfncvt_xu_f_v)
-GEN_OPFV_NARROW_TRANS(vfncvt_x_f_v)
-GEN_OPFV_NARROW_TRANS(vfncvt_f_xu_v)
-GEN_OPFV_NARROW_TRANS(vfncvt_f_x_v)
-GEN_OPFV_NARROW_TRANS(vfncvt_f_f_v)
+GEN_OPFV_NARROW_TRANS(vfncvt_f_xu_w, vfncvt_f_xu_w, RISCV_FRM_DYN)
+GEN_OPFV_NARROW_TRANS(vfncvt_f_x_w, vfncvt_f_x_w, RISCV_FRM_DYN)
+GEN_OPFV_NARROW_TRANS(vfncvt_f_f_w, vfncvt_f_f_w, RISCV_FRM_DYN)
+/* Reuse the helper function from vfncvt.f.f.w */
+GEN_OPFV_NARROW_TRANS(vfncvt_rod_f_f_w, vfncvt_f_f_w, RISCV_FRM_ROD)
+
+static bool opxfv_narrow_check(DisasContext *s, arg_rmr *a)
+{
+    return require_rvv(s) &&
+           require_scale_rvf(s) &&
+           vext_check_isa_ill(s) &&
+           /* OPFV narrowing instructions ignore vs1 check */
+           vext_check_sd(s, a->rd, a->rs2, a->vm);
+}
+
+#define GEN_OPXFV_NARROW_TRANS(NAME, HELPER, FRM)                  \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
+{                                                                  \
+    if (opxfv_narrow_check(s, a)) {                                \
+        uint32_t data = 0;                                         \
+        static gen_helper_gvec_3_ptr * const fns[3] = {            \
+            gen_helper_##HELPER##_b,                               \
+            gen_helper_##HELPER##_h,                               \
+            gen_helper_##HELPER##_w,                               \
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
+GEN_OPXFV_NARROW_TRANS(vfncvt_xu_f_w, vfncvt_xu_f_w, RISCV_FRM_DYN)
+GEN_OPXFV_NARROW_TRANS(vfncvt_x_f_w, vfncvt_x_f_w, RISCV_FRM_DYN)
+/* Reuse the helper functions from vfncvt.xu.f.w and vfncvt.x.f.w */
+GEN_OPXFV_NARROW_TRANS(vfncvt_rtz_xu_f_w, vfncvt_xu_f_w, RISCV_FRM_RTZ)
+GEN_OPXFV_NARROW_TRANS(vfncvt_rtz_x_f_w, vfncvt_x_f_w, RISCV_FRM_RTZ)
 
 /*
  *** Vector Reduction Operations
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index e8de460b29..8d389af4b7 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4029,31 +4029,36 @@ GEN_VEXT_V_ENV(vfwcvt_f_f_v_w, 4, 8)
 
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
@@ -4061,10 +4066,10 @@ static uint16_t vfncvtffv16(uint32_t a, float_status *s)
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
 
 /*
  *** Vector Reduction Operations
-- 
2.17.1


