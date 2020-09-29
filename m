Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A35C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:12:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEA9420774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EH9EwYAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA9420774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNL2v-0002wm-RT
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKwV-0002Y5-1T
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:05:39 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:33946)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKwR-0001ji-BV
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:05:38 -0400
Received: by mail-pf1-x436.google.com with SMTP id k13so5547020pfg.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hH3rbTzbXxJJxcF/KrEw3wk5h03DS7rQJpeuilDMPWM=;
 b=EH9EwYAvEyqRUTZu47Rbd+sYg35A10N9AR9DTbscQy0nCLpJuGGOs6N9mhYW3Ury8U
 tsqkUkoqWW5Ed1UbRLTEwEC4g2ZR0eot4TQ0unjbTlBwWwkGV1jFDHeh4oaRvvWP0rzZ
 8hl7DKMswnDLBbkcW532CC5ZT6CucyATGKXmDj9az3kPw7hQFJ/xMQDS3k48E9rsjURS
 NPhJ9dlptKBBgy0IdPJGkaplbfnTzgDIY3N6pIC67AuH9nFbEcCbFk+CpjqOtvhAxDeo
 2J1gqIVVWJ7t6TI8z5FI3URnk0MtInqD9zU25EWBetYsM9PF88G6jx4x6KiM01Dw3rw2
 6xSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=hH3rbTzbXxJJxcF/KrEw3wk5h03DS7rQJpeuilDMPWM=;
 b=mMWjkDCpodUuLJmWn4JtdT74OjV0MW9fPAjOKrLEe9zgJKre7eyF03ghgW1z3bcZtA
 3MThs/jNl5Qds1YVpxeA15UoOiJcZia9zbBKCTutXXw+umAeC1khmHhfs8DCQJeeDWwG
 v3IulLA5BVStemcl4GuPoDRHgPJ7T6L5yt7sWvlcaEGj75IjMWU5/FyPl0CFkMyFwZri
 vs6l4jEbgGGFU6tXq7ZrWdcihhA2hn9WD2q0nkkZjWCfpm9GsU4EZogiI7M1z9FoygQM
 szVhvU6lb4cJTucjeSCQ4q+a4aQI2ISm2yxWr/4Woqtp77xeOocfSA+OMmXaUyvyZ06x
 /yYQ==
X-Gm-Message-State: AOAM530MwXQXN6b8IwuAUw44Rrp0D34FYMWmL5Bh8KscKj0PGGeRRLuN
 wv2nELq5n7L/YB0iXcWW3FvWkQo2dGyL9w==
X-Google-Smtp-Source: ABdhPJwl9pJty+tR67Ju6xmq3ZSUcBxQe/favrHfN4y/ZOxX3bKq26IqU13d8MD83jgienP6Oz56gQ==
X-Received: by 2002:a17:902:24d:b029:d2:564c:654b with SMTP id
 71-20020a170902024db02900d2564c654bmr5775949plc.8.1601406333227; 
 Tue, 29 Sep 2020 12:05:33 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:05:32 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 06/68] target/riscv: rvv-1.0: add translation-time vector
 context status
Date: Wed, 30 Sep 2020 03:03:41 +0800
Message-Id: <20200929190448.31116-7-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x436.google.com
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

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 70 ++++++++++++++++++++-----
 target/riscv/translate.c                | 33 ++++++++++++
 2 files changed, 90 insertions(+), 13 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 887c6b8883..8be1add158 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -41,6 +41,7 @@ static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl *a)
     gen_get_gpr(s2, a->rs2);
     gen_helper_vsetvl(dst, cpu_env, s1, s2);
     gen_set_gpr(a->rd, dst);
+    mark_vs_dirty(ctx);
     tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);
     lookup_and_goto_ptr(ctx);
     ctx->base.is_jmp = DISAS_NORETURN;
@@ -72,7 +73,7 @@ static bool trans_vsetvli(DisasContext *ctx, arg_vsetvli *a)
     }
     gen_helper_vsetvl(dst, cpu_env, s1, s2);
     gen_set_gpr(a->rd, dst);
-    gen_goto_tb(ctx, 0, ctx->pc_succ_insn);
+    mark_vs_dirty(ctx);
     ctx->base.is_jmp = DISAS_NORETURN;
 
     tcg_temp_free(s1);
@@ -163,7 +164,8 @@ typedef void gen_helper_ldst_us(TCGv_ptr, TCGv_ptr, TCGv,
                                 TCGv_env, TCGv_i32);
 
 static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
-                          gen_helper_ldst_us *fn, DisasContext *s)
+                          gen_helper_ldst_us *fn, DisasContext *s,
+                          bool is_store)
 {
     TCGv_ptr dest, mask;
     TCGv base;
@@ -195,6 +197,9 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     tcg_temp_free_ptr(mask);
     tcg_temp_free(base);
     tcg_temp_free_i32(desc);
+    if (!is_store) {
+        mark_vs_dirty(s);
+    }
     gen_set_label(over);
     return true;
 }
@@ -245,7 +250,7 @@ static bool ld_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
-    return ldst_us_trans(a->rd, a->rs1, data, fn, s);
+    return ldst_us_trans(a->rd, a->rs1, data, fn, s, false);
 }
 
 static bool ld_us_check(DisasContext *s, arg_r2nfvm* a)
@@ -298,7 +303,7 @@ static bool st_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
-    return ldst_us_trans(a->rd, a->rs1, data, fn, s);
+    return ldst_us_trans(a->rd, a->rs1, data, fn, s, true);
 }
 
 static bool st_us_check(DisasContext *s, arg_r2nfvm* a)
@@ -321,7 +326,7 @@ typedef void gen_helper_ldst_stride(TCGv_ptr, TCGv_ptr, TCGv,
 
 static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
                               uint32_t data, gen_helper_ldst_stride *fn,
-                              DisasContext *s)
+                              DisasContext *s, bool is_store)
 {
     TCGv_ptr dest, mask;
     TCGv base, stride;
@@ -348,6 +353,9 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
     tcg_temp_free(base);
     tcg_temp_free(stride);
     tcg_temp_free_i32(desc);
+    if (!is_store) {
+        mark_vs_dirty(s);
+    }
     gen_set_label(over);
     return true;
 }
@@ -382,7 +390,7 @@ static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
-    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s, false);
 }
 
 static bool ld_stride_check(DisasContext *s, arg_rnfvm* a)
@@ -426,7 +434,7 @@ static bool st_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
         return false;
     }
 
-    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s, true);
 }
 
 static bool st_stride_check(DisasContext *s, arg_rnfvm* a)
@@ -449,7 +457,7 @@ typedef void gen_helper_ldst_index(TCGv_ptr, TCGv_ptr, TCGv,
 
 static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
                              uint32_t data, gen_helper_ldst_index *fn,
-                             DisasContext *s)
+                             DisasContext *s, bool is_store)
 {
     TCGv_ptr dest, mask, index;
     TCGv base;
@@ -476,6 +484,9 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     tcg_temp_free_ptr(index);
     tcg_temp_free(base);
     tcg_temp_free_i32(desc);
+    if (!is_store) {
+        mark_vs_dirty(s);
+    }
     gen_set_label(over);
     return true;
 }
@@ -510,7 +521,7 @@ static bool ld_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
-    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s, false);
 }
 
 /*
@@ -562,7 +573,7 @@ static bool st_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
-    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s, true);
 }
 
 static bool st_index_check(DisasContext *s, arg_rnfvm* a)
@@ -606,6 +617,7 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     tcg_temp_free_ptr(mask);
     tcg_temp_free(base);
     tcg_temp_free_i32(desc);
+    mark_vs_dirty(s);
     gen_set_label(over);
     return true;
 }
@@ -685,6 +697,7 @@ static bool amo_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     tcg_temp_free_ptr(index);
     tcg_temp_free(base);
     tcg_temp_free_i32(desc);
+    mark_vs_dirty(s);
     gen_set_label(over);
     return true;
 }
@@ -832,6 +845,7 @@ do_opivv_gvec(DisasContext *s, arg_rmrr *a, GVecGen3Fn *gvec_fn,
                            vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),
                            cpu_env, 0, s->vlen / 8, data, fn);
     }
+    mark_vs_dirty(s);
     gen_set_label(over);
     return true;
 }
@@ -886,6 +900,7 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, uint32_t vs2, uint32_t vm,
     tcg_temp_free_ptr(src2);
     tcg_temp_free(src1);
     tcg_temp_free_i32(desc);
+    mark_vs_dirty(s);
     gen_set_label(over);
     return true;
 }
@@ -920,6 +935,7 @@ do_opivx_gvec(DisasContext *s, arg_rmrr *a, GVecGen2sFn *gvec_fn,
 
         tcg_temp_free_i64(src1);
         tcg_temp_free(tmp);
+        mark_vs_dirty(s);
         return true;
     }
     return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s);
@@ -1033,6 +1049,7 @@ static bool opivi_trans(uint32_t vd, uint32_t imm, uint32_t vs2, uint32_t vm,
     tcg_temp_free_ptr(src2);
     tcg_temp_free(src1);
     tcg_temp_free_i32(desc);
+    mark_vs_dirty(s);
     gen_set_label(over);
     return true;
 }
@@ -1056,10 +1073,10 @@ do_opivi_gvec(DisasContext *s, arg_rmrr *a, GVecGen2iFn *gvec_fn,
             gvec_fn(s->sew, vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2),
                     sextract64(a->rs1, 0, 5), MAXSZ(s), MAXSZ(s));
         }
-    } else {
-        return opivi_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s, zx);
+        mark_vs_dirty(s);
+        return true;
     }
-    return true;
+    return opivi_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s, zx);
 }
 
 /* OPIVI with GVEC IR */
@@ -1120,6 +1137,7 @@ static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
                            vreg_ofs(s, a->rs2),
                            cpu_env, 0, s->vlen / 8,
                            data, fn);
+        mark_vs_dirty(s);
         gen_set_label(over);
         return true;
     }
@@ -1207,6 +1225,7 @@ static bool do_opiwv_widen(DisasContext *s, arg_rmrr *a,
                            vreg_ofs(s, a->rs1),
                            vreg_ofs(s, a->rs2),
                            cpu_env, 0, s->vlen / 8, data, fn);
+        mark_vs_dirty(s);
         gen_set_label(over);
         return true;
     }
@@ -1285,6 +1304,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                            vreg_ofs(s, a->rs1),                    \
                            vreg_ofs(s, a->rs2), cpu_env, 0,        \
                            s->vlen / 8, data, fns[s->sew]);        \
+        mark_vs_dirty(s);                                          \
         gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
@@ -1416,6 +1436,7 @@ do_opivx_gvec_shift(DisasContext *s, arg_rmrr *a, GVecGen2sFn32 *gvec_fn,
 
         tcg_temp_free_i32(src1);
         tcg_temp_free(tmp);
+        mark_vs_dirty(s);
         return true;
     }
     return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s);
@@ -1474,6 +1495,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                            vreg_ofs(s, a->rs1),                    \
                            vreg_ofs(s, a->rs2), cpu_env, 0,        \
                            s->vlen / 8, data, fns[s->sew]);        \
+        mark_vs_dirty(s);                                          \
         gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
@@ -1657,6 +1679,7 @@ static bool trans_vmv_v_v(DisasContext *s, arg_vmv_v_v *a)
                                cpu_env, 0, s->vlen / 8, data, fns[s->sew]);
             gen_set_label(over);
         }
+        mark_vs_dirty(s);
         return true;
     }
     return false;
@@ -1699,6 +1722,7 @@ static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
         }
 
         tcg_temp_free(s1);
+        mark_vs_dirty(s);
         gen_set_label(over);
         return true;
     }
@@ -1714,6 +1738,7 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
         if (s->vl_eq_vlmax) {
             tcg_gen_gvec_dup_imm(s->sew, vreg_ofs(s, a->rd),
                                  MAXSZ(s), MAXSZ(s), simm);
+            mark_vs_dirty(s);
         } else {
             TCGv_i32 desc;
             TCGv_i64 s1;
@@ -1735,6 +1760,7 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
             tcg_temp_free_ptr(dest);
             tcg_temp_free_i32(desc);
             tcg_temp_free_i64(s1);
+            mark_vs_dirty(s);
             gen_set_label(over);
         }
         return true;
@@ -1839,6 +1865,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                            vreg_ofs(s, a->rs1),                    \
                            vreg_ofs(s, a->rs2), cpu_env, 0,        \
                            s->vlen / 8, data, fns[s->sew - 1]);    \
+        mark_vs_dirty(s);                                          \
         gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
@@ -1874,6 +1901,7 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     tcg_temp_free_ptr(mask);
     tcg_temp_free_ptr(src2);
     tcg_temp_free_i32(desc);
+    mark_vs_dirty(s);
     gen_set_label(over);
     return true;
 }
@@ -1951,6 +1979,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
                            vreg_ofs(s, a->rs1),                  \
                            vreg_ofs(s, a->rs2), cpu_env, 0,      \
                            s->vlen / 8, data, fns[s->sew - 1]);  \
+        mark_vs_dirty(s);                                        \
         gen_set_label(over);                                     \
         return true;                                             \
     }                                                            \
@@ -2025,6 +2054,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                            vreg_ofs(s, a->rs1),                    \
                            vreg_ofs(s, a->rs2), cpu_env, 0,        \
                            s->vlen / 8, data, fns[s->sew - 1]);    \
+        mark_vs_dirty(s);                                          \
         gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
@@ -2139,6 +2169,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs2), cpu_env, 0,        \
                            s->vlen / 8, data, fns[s->sew - 1]);    \
+        mark_vs_dirty(s);                                          \
         gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
@@ -2211,6 +2242,7 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
         if (s->vl_eq_vlmax) {
             tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
                                  MAXSZ(s), MAXSZ(s), cpu_fpr[a->rs1]);
+            mark_vs_dirty(s);
         } else {
             TCGv_ptr dest;
             TCGv_i32 desc;
@@ -2230,6 +2262,7 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
 
             tcg_temp_free_ptr(dest);
             tcg_temp_free_i32(desc);
+            mark_vs_dirty(s);
             gen_set_label(over);
         }
         return true;
@@ -2279,6 +2312,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs2), cpu_env, 0,        \
                            s->vlen / 8, data, fns[s->sew - 1]);    \
+        mark_vs_dirty(s);                                          \
         gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
@@ -2327,6 +2361,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs2), cpu_env, 0,        \
                            s->vlen / 8, data, fns[s->sew - 1]);    \
+        mark_vs_dirty(s);                                          \
         gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
@@ -2389,6 +2424,7 @@ static bool trans_##NAME(DisasContext *s, arg_r *a)                \
                            vreg_ofs(s, a->rs1),                    \
                            vreg_ofs(s, a->rs2), cpu_env, 0,        \
                            s->vlen / 8, data, fn);                 \
+        mark_vs_dirty(s);                                          \
         gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
@@ -2486,6 +2522,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd),                     \
                            vreg_ofs(s, 0), vreg_ofs(s, a->rs2),    \
                            cpu_env, 0, s->vlen / 8, data, fn);     \
+        mark_vs_dirty(s);                                          \
         gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
@@ -2517,6 +2554,7 @@ static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
                            vreg_ofs(s, a->rs2), cpu_env, 0,
                            s->vlen / 8, data, fns[s->sew]);
+        mark_vs_dirty(s);
         gen_set_label(over);
         return true;
     }
@@ -2542,6 +2580,7 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
         };
         tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
                            cpu_env, 0, s->vlen / 8, data, fns[s->sew]);
+        mark_vs_dirty(s);
         gen_set_label(over);
         return true;
     }
@@ -2717,6 +2756,7 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
         tcg_gen_extu_tl_i64(t1, cpu_gpr[a->rs1]);
         vec_element_storei(s, a->rd, 0, t1);
         tcg_temp_free_i64(t1);
+        mark_vs_dirty(s);
     done:
         gen_set_label(over);
         return true;
@@ -2767,6 +2807,7 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
         }
         vec_element_storei(s, a->rd, 0, t1);
         tcg_temp_free_i64(t1);
+        mark_vs_dirty(s);
         gen_set_label(over);
         return true;
     }
@@ -2833,6 +2874,7 @@ static bool trans_vrgather_vx(DisasContext *s, arg_rmrr *a)
         tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
                              MAXSZ(s), MAXSZ(s), dest);
         tcg_temp_free_i64(dest);
+        mark_vs_dirty(s);
     } else {
         static gen_helper_opivx * const fns[4] = {
             gen_helper_vrgather_vx_b, gen_helper_vrgather_vx_h,
@@ -2859,6 +2901,7 @@ static bool trans_vrgather_vi(DisasContext *s, arg_rmrr *a)
                                  endian_ofs(s, a->rs2, a->rs1),
                                  MAXSZ(s), MAXSZ(s));
         }
+        mark_vs_dirty(s);
     } else {
         static gen_helper_opivx * const fns[4] = {
             gen_helper_vrgather_vx_b, gen_helper_vrgather_vx_h,
@@ -2895,6 +2938,7 @@ static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
                            vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),
                            cpu_env, 0, s->vlen / 8, data, fns[s->sew]);
+        mark_vs_dirty(s);
         gen_set_label(over);
         return true;
     }
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 79dca2291b..faca57f9aa 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -47,6 +47,7 @@ typedef struct DisasContext {
     bool virt_enabled;
     uint32_t opcode;
     uint32_t mstatus_fs;
+    uint32_t mstatus_vs;
     uint32_t misa;
     uint32_t mem_idx;
     /* Remember the rounding mode encoded in the previous fp instruction,
@@ -445,6 +446,37 @@ static void mark_fs_dirty(DisasContext *ctx)
 static inline void mark_fs_dirty(DisasContext *ctx) { }
 #endif
 
+#ifndef CONFIG_USER_ONLY
+/* The states of mstatus_vs are:
+ * 0 = disabled, 1 = initial, 2 = clean, 3 = dirty
+ * We will have already diagnosed disabled state,
+ * and need to turn initial/clean into dirty.
+ */
+static void mark_vs_dirty(DisasContext *ctx)
+{
+    TCGv tmp;
+    if (ctx->mstatus_vs == MSTATUS_VS) {
+        return;
+    }
+    /* Remember the state change for the rest of the TB.  */
+    ctx->mstatus_vs = MSTATUS_VS;
+
+    tmp = tcg_temp_new();
+    tcg_gen_ld_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
+    tcg_gen_ori_tl(tmp, tmp, MSTATUS_VS | MSTATUS_SD);
+    tcg_gen_st_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
+
+    if (ctx->virt_enabled) {
+        tcg_gen_ld_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus_hs));
+        tcg_gen_ori_tl(tmp, tmp, MSTATUS_VS | MSTATUS_SD);
+        tcg_gen_st_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus_hs));
+    }
+    tcg_temp_free(tmp);
+}
+#else
+static inline void mark_vs_dirty(DisasContext *ctx) { }
+#endif
+
 #if !defined(TARGET_RISCV64)
 static void gen_fp_load(DisasContext *ctx, uint32_t opc, int rd,
         int rs1, target_long imm)
@@ -793,6 +825,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->pc_succ_insn = ctx->base.pc_first;
     ctx->mem_idx = tb_flags & TB_FLAGS_MMU_MASK;
     ctx->mstatus_fs = tb_flags & TB_FLAGS_MSTATUS_FS;
+    ctx->mstatus_vs = tb_flags & TB_FLAGS_MSTATUS_VS;
     ctx->priv_ver = env->priv_ver;
 #if !defined(CONFIG_USER_ONLY)
     if (riscv_has_ext(env, RVH)) {
-- 
2.17.1


