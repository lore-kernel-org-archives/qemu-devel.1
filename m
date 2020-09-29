Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4650C4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:51:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF06E20774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="l+yhGWmO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF06E20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLf9-0000ft-T1
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKzk-00088e-Jf
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:09:00 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a]:56311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKzi-0002Uj-98
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:09:00 -0400
Received: by mail-pj1-x102a.google.com with SMTP id q4so3180530pjh.5
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tol8ajDdJms4rPhU7FDHrrxL+q0QqkVuAMJEL7t2f3s=;
 b=l+yhGWmOWWgwJyjNCoxKJ9L+lZnd6yYeAF4OiR15/Ih+10ypbQ3QD4IlXOOKRULWmx
 S1RYq7uQqybSNW+RnA/Fhv2hM4vjtKEhoSYs85MDIZHolYn+Gsqlhvs9O+N/6e2sOtl/
 rQ+iMFGNZl+3Lebz4pPQHrBepr4S2+Xskwi4Dt6jf6tvdYIpwS1UDrqho/R/3TVQJeDw
 CVTzMcW6aq1ywmeYn4s788bVKvEX7xHBzgHY8xNcxZO7nW7kNb5w2Ry3ue6H04pQFOmp
 VI3S2f7P20sx0RAWdtOlaTYDoV9m2rpaiCmRn1DD3bn7IE3N9U6YArztaq7rAF8OOx4Q
 vf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=tol8ajDdJms4rPhU7FDHrrxL+q0QqkVuAMJEL7t2f3s=;
 b=E7PGQocfHvZud48HX4S+V6h//9F0syJm/kZZozypu9HI0OikVNlm3eGU52ZGSySToA
 UaFqvizdohnKjQGOLgb3xPXNwGl0k7XN9Jw3sJbpp1sCsGXgcIV+QlphBzXPVfJ+3Bcy
 vrN/ydBGHLK/QlIyubB4tosDivRlvFDISY4O4cpz5Wf3BASn6gKTBeNfb4fZ+D+08C2D
 p77hBEB8W/fHmk161147xHCjQLblgiF0239ZBmTZCYDGzi6zxgwN91SGijYuKPtsH5L2
 LsH9MQLbIX+F8zKIyv1T0EEXtM4F2/X7IP7fr1dE6UEi41+AbkuKSf+6LdWZGK4D8nQI
 BaQg==
X-Gm-Message-State: AOAM530AtmXq0HA+ALOEYk7tTSReWscQGzTKXEDcOv6vMCvJAJyWeRjS
 EbNfS28UC4/teU2RZtBYlnNR76opnVcKhw==
X-Google-Smtp-Source: ABdhPJzrmUtUi8V0McJ8clWbSWnIhE9wp9m1cnpSR8+K12oAg1ByUtxv6eR1MPu277oSUpsG1fGIVw==
X-Received: by 2002:a17:90b:164e:: with SMTP id
 il14mr4943774pjb.5.1601406535897; 
 Tue, 29 Sep 2020 12:08:55 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:08:55 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 61/68] target/riscv: rvv-1.0: widening floating-point/integer
 type-convert
Date: Wed, 30 Sep 2020 03:04:36 +0800
Message-Id: <20200929190448.31116-62-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x102a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the following instructions:

* vfwcvt.rtz.xu.f.v
* vfwcvt.rtz.x.f.v

Also adjust GEN_OPFV_WIDEN_TRANS() to accept multiple floating-point
rounding modes.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/helper.h                   |  2 +
 target/riscv/insn32.decode              | 13 +++---
 target/riscv/insn_trans/trans_rvv.c.inc | 54 +++++++++++++++++++++----
 target/riscv/vector_helper.c            |  7 +++-
 4 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index cdaf427060..2a31c7bba1 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -978,8 +978,10 @@ DEF_HELPER_5(vfwcvt_xu_f_v_h, void, ptr, ptr, ptr, env, i32)
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
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 88d8f0eb0b..6253628b9c 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -567,11 +567,14 @@ vfcvt_f_xu_v       010010 . ..... 00010 001 ..... 1010111 @r2_vm
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
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 452447e5ed..32e94c496c 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2788,12 +2788,54 @@ static bool opfv_widen_check(DisasContext *s, arg_rmr *a)
            vext_check_ds(s, a->rd, a->rs2, a->vm);
 }
 
-#define GEN_OPFV_WIDEN_TRANS(NAME)                                 \
+#define GEN_OPFV_WIDEN_TRANS(NAME, HELPER, FRM)                    \
 static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
 {                                                                  \
     if (opfv_widen_check(s, a)) {                                  \
         uint32_t data = 0;                                         \
         static gen_helper_gvec_3_ptr * const fns[2] = {            \
+            gen_helper_##HELPER##_h,                               \
+            gen_helper_##HELPER##_w,                               \
+        };                                                         \
+        TCGLabel *over = gen_new_label();                          \
+        gen_set_rm(s, FRM);                                        \
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
+                                                                   \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
+                           vreg_ofs(s, a->rs2), cpu_env, 0,        \
+                           s->vlen / 8, data, fns[s->sew - 1]);    \
+        mark_vs_dirty(s);                                          \
+        gen_set_label(over);                                       \
+        return true;                                               \
+    }                                                              \
+    return false;                                                  \
+}
+
+GEN_OPFV_WIDEN_TRANS(vfwcvt_xu_f_v, vfwcvt_xu_f_v, RISCV_FRM_DYN)
+GEN_OPFV_WIDEN_TRANS(vfwcvt_x_f_v, vfwcvt_x_f_v, RISCV_FRM_DYN)
+GEN_OPFV_WIDEN_TRANS(vfwcvt_f_f_v, vfwcvt_f_f_v, RISCV_FRM_DYN)
+/* Reuse the helper functions from vfwcvt.xu.f.v and vfwcvt.x.f.v */
+GEN_OPFV_WIDEN_TRANS(vfwcvt_rtz_xu_f_v, vfwcvt_xu_f_v, RISCV_FRM_RTZ)
+GEN_OPFV_WIDEN_TRANS(vfwcvt_rtz_x_f_v, vfwcvt_x_f_v, RISCV_FRM_RTZ)
+
+static bool opfxv_widen_check(DisasContext *s, arg_rmr *a)
+{
+    return require_rvv(s) &&
+           require_scale_rvf(s) &&
+           vext_check_isa_ill(s) &&
+           /* OPFV widening instructions ignore vs1 check */
+           vext_check_ds(s, a->rd, a->rs2, a->vm);
+}
+
+#define GEN_OPFXV_WIDEN_TRANS(NAME)                                \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
+{                                                                  \
+    if (opfxv_widen_check(s, a)) {                                 \
+        uint32_t data = 0;                                         \
+        static gen_helper_gvec_3_ptr * const fns[3] = {            \
+            gen_helper_##NAME##_b,                                 \
             gen_helper_##NAME##_h,                                 \
             gen_helper_##NAME##_w,                                 \
         };                                                         \
@@ -2802,10 +2844,9 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
-        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs2), cpu_env, 0,        \
-                           s->vlen / 8, data, fns[s->sew - 1]);    \
+                           s->vlen / 8, data, fns[s->sew]);        \
         mark_vs_dirty(s);                                          \
         gen_set_label(over);                                       \
         return true;                                               \
@@ -2813,11 +2854,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
     return false;                                                  \
 }
 
-GEN_OPFV_WIDEN_TRANS(vfwcvt_xu_f_v)
-GEN_OPFV_WIDEN_TRANS(vfwcvt_x_f_v)
-GEN_OPFV_WIDEN_TRANS(vfwcvt_f_xu_v)
-GEN_OPFV_WIDEN_TRANS(vfwcvt_f_x_v)
-GEN_OPFV_WIDEN_TRANS(vfwcvt_f_f_v)
+GEN_OPFXV_WIDEN_TRANS(vfwcvt_f_xu_v)
+GEN_OPFXV_WIDEN_TRANS(vfwcvt_f_x_v)
 
 /* Narrowing Floating-Point/Integer Type-Convert Instructions */
 
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index e3056a06fe..e8de460b29 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3982,6 +3982,7 @@ GEN_VEXT_V_ENV(vfcvt_f_x_v_d, 8, 8)
 
 /* Widening Floating-Point/Integer Type-Convert Instructions */
 /* (TD, T2, TX2) */
+#define WOP_UU_B uint16_t, uint8_t,  uint8_t
 #define WOP_UU_H uint32_t, uint16_t, uint16_t
 #define WOP_UU_W uint64_t, uint32_t, uint32_t
 /* vfwcvt.xu.f.v vd, vs2, vm # Convert float to double-width unsigned integer.*/
@@ -3997,19 +3998,23 @@ GEN_VEXT_V_ENV(vfwcvt_x_f_v_h, 2, 4)
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
+ * vfwcvt.f.f.v vd, vs2, vm
  * Convert single-width float to double-width float.
  */
 static uint32_t vfwcvtffv16(uint16_t a, float_status *s)
-- 
2.17.1


