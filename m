Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BF7C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:12:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74DF7206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VZwN9XJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DF7206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtspN-0004bb-63
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqeY-0005kW-SB
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:53:14 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:36836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqeT-0006pP-1S
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:53:14 -0400
Received: by mail-pl1-x62c.google.com with SMTP id d10so2106743pll.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8b327ix3NdI+IyOCojftJRh9SEKGizCjfc1TFHjeQ9U=;
 b=VZwN9XJhn2jvr10USyXeZHHWHgYMbHDXDeFHg5W7XsHBUMv4+znEQxkPnGEfzw00QY
 2Zcc8IHMiTHphtYNQtbqbbAKSHMIo0en7RCjSH5dd2Iz4H9taW4bk2uhGczXKuYb+LmG
 RW6G2OlvvUjMyReFSFqT33gv0gXeaUJh28sNi+Kr58V84CbwCSuO9Pl9hxmWTMhvS9Fi
 9NaEONHm40e/+nIHPDcyDWnL0hHQxM4YSkFfYQkKdiuCzf96ultn5xthmCoA556zoSnp
 Uv+5BR2WErVTILp863lH6PKow5tsQVrFC4Jt7nCrJ0BIFRYrJCJrdZzslWbLA6okR8q4
 uRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8b327ix3NdI+IyOCojftJRh9SEKGizCjfc1TFHjeQ9U=;
 b=uggAUe5sU8w4yBqie+1rnZtSwEco85yGGMMPmKiItOkGnPsOA/ScpoIl1sGOX8f1Ns
 OUCdSFwAC3jA845kOrWQiDSQsJfGN1NzkAy+7Zs989pSJ/tpWcP28vs/2JOrMB0Mi1oS
 0RfmCHK9IGKYVFAE2LH4gjo4QPKo25JALAU9M2/Ns0ZZuIEc7UQB6AO15nEGZpwVMElC
 1Nyvt2YW+nb4sYsQ7aWGe4I/e/0v2TbQOboyShwzf8M9ZJiUfOcAFoUw27hrF7Drx4Ah
 1EzKCnBJh7YbrqgQAbQEuByCgQKG1nsX/rd+zAiiha4+F9OjgCQmYBZBP80ySl5tZGzA
 jVzw==
X-Gm-Message-State: AOAM530Qrqf8bJWoNlSwN8PklSJ02yfNqxmRXHpKLBzFa/obCX5i003S
 IjpnpA+V8QCDYtp+kmRG+TqGabJ4oxXQ7w==
X-Google-Smtp-Source: ABdhPJyPjogd93mChuVAtAMQfFOM/unHlKDYHICNgocpfMYwf/PcHy2FAkywUJ5/PxpJo4fZf/CoxQ==
X-Received: by 2002:a17:902:b287:: with SMTP id
 u7mr48681577plr.107.1594378387492; 
 Fri, 10 Jul 2020 03:53:07 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:53:07 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 38/65] target/riscv: rvv-0.9: integer merge and move instructions
Date: Fri, 10 Jul 2020 18:48:52 +0800
Message-Id: <20200710104920.13550-39-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62c.google.com
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
 target/riscv/insn_trans/trans_rvv.inc.c | 179 ++++++++++++------------
 1 file changed, 90 insertions(+), 89 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 89718fdbc7..53c8dce159 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2008,121 +2008,122 @@ GEN_OPIVX_QUAD_WIDEN_TRANS(vqmacc_vx)
 GEN_OPIVX_QUAD_WIDEN_TRANS(vqmaccsu_vx)
 GEN_OPIVX_QUAD_WIDEN_TRANS(vqmaccus_vx)
 
+/* Vector Integer Move Instructions */
 static bool trans_vmv_v_v(DisasContext *s, arg_vmv_v_v *a)
 {
-    if (vext_check_isa_ill(s) &&
-        vext_check_reg(s, a->rd, false) &&
-        vext_check_reg(s, a->rs1, false)) {
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    /* vmv.v.v has rs2 = 0 and vm = 1 */
+    VEXT_CHECK_SSS(s, a->rd, a->rs1, 0, 1, true);
 
-        if (s->vl_eq_vlmax) {
-            tcg_gen_gvec_mov(s->sew, vreg_ofs(s, a->rd),
-                             vreg_ofs(s, a->rs1),
-                             MAXSZ(s), MAXSZ(s));
-        } else {
-            uint32_t data = 0;
-            data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
-            data = FIELD_DP32(data, VDATA, VTA, s->vta);
-            static gen_helper_gvec_2_ptr * const fns[4] = {
-                gen_helper_vmv_v_v_b, gen_helper_vmv_v_v_h,
-                gen_helper_vmv_v_v_w, gen_helper_vmv_v_v_d,
-            };
-            TCGLabel *over = gen_new_label();
-            tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+    if (s->vl_eq_vlmax) {
+        tcg_gen_gvec_mov(s->sew, vreg_ofs(s, a->rd),
+                         vreg_ofs(s, a->rs1),
+                         MAXSZ(s), MAXSZ(s));
+    } else {
+        uint32_t data = 0;
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);
+        static gen_helper_gvec_2_ptr * const fns[4] = {
+            gen_helper_vmv_v_v_b, gen_helper_vmv_v_v_h,
+            gen_helper_vmv_v_v_w, gen_helper_vmv_v_v_d,
+        };
+        TCGLabel *over = gen_new_label();
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
 
-            tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs1),
-                               cpu_env, 0, s->vlen / 8, data, fns[s->sew]);
-            gen_set_label(over);
-        }
-        return true;
+        tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs1),
+                           cpu_env, 0, s->vlen / 8, data, fns[s->sew]);
+        gen_set_label(over);
     }
-    return false;
+    return true;
 }
 
 typedef void gen_helper_vmv_vx(TCGv_ptr, TCGv_i64, TCGv_env, TCGv_i32);
 static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
 {
-    if (vext_check_isa_ill(s) &&
-        vext_check_reg(s, a->rd, false)) {
-
-        TCGv s1;
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    /* vmv.v.x has rs2 = 0 and vm = 1 */
+    VEXT_CHECK_SSS(s, a->rd, a->rs1, 0, 1, false);
 
-        s1 = tcg_temp_new();
-        gen_get_gpr(s1, a->rs1);
+    TCGv s1;
+    TCGLabel *over = gen_new_label();
+    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
 
-        if (s->vl_eq_vlmax) {
-            tcg_gen_gvec_dup_tl(s->sew, vreg_ofs(s, a->rd),
-                                MAXSZ(s), MAXSZ(s), s1);
-        } else {
-            TCGv_i32 desc ;
-            TCGv_i64 s1_i64 = tcg_temp_new_i64();
-            TCGv_ptr dest = tcg_temp_new_ptr();
-            uint32_t data = 0;
-            data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
-            data = FIELD_DP32(data, VDATA, VTA, s->vta);
-            static gen_helper_vmv_vx * const fns[4] = {
-                gen_helper_vmv_v_x_b, gen_helper_vmv_v_x_h,
-                gen_helper_vmv_v_x_w, gen_helper_vmv_v_x_d,
-            };
+    s1 = tcg_temp_new();
+    gen_get_gpr(s1, a->rs1);
 
-            tcg_gen_ext_tl_i64(s1_i64, s1);
-            desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
-            tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, a->rd));
-            fns[s->sew](dest, s1_i64, cpu_env, desc);
+    if (s->vl_eq_vlmax) {
+        tcg_gen_gvec_dup_tl(s->sew, vreg_ofs(s, a->rd),
+                            MAXSZ(s), MAXSZ(s), s1);
+    } else {
+        TCGv_i32 desc ;
+        TCGv_i64 s1_i64 = tcg_temp_new_i64();
+        TCGv_ptr dest = tcg_temp_new_ptr();
+        uint32_t data = 0;
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);
+        static gen_helper_vmv_vx * const fns[4] = {
+            gen_helper_vmv_v_x_b, gen_helper_vmv_v_x_h,
+            gen_helper_vmv_v_x_w, gen_helper_vmv_v_x_d,
+        };
 
-            tcg_temp_free_ptr(dest);
-            tcg_temp_free_i32(desc);
-            tcg_temp_free_i64(s1_i64);
-        }
+        tcg_gen_ext_tl_i64(s1_i64, s1);
+        desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
+        tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, a->rd));
+        fns[s->sew](dest, s1_i64, cpu_env, desc);
 
-        tcg_temp_free(s1);
-        gen_set_label(over);
-        return true;
+        tcg_temp_free_ptr(dest);
+        tcg_temp_free_i32(desc);
+        tcg_temp_free_i64(s1_i64);
     }
-    return false;
+
+    tcg_temp_free(s1);
+    gen_set_label(over);
+    return true;
 }
 
 static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
 {
-    if (vext_check_isa_ill(s) &&
-        vext_check_reg(s, a->rd, false)) {
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    /* vmv.v.i has rs2 = 0 and vm = 1 */
+    VEXT_CHECK_SSS(s, a->rd, a->rs1, 0, 1, false);
 
-        int64_t simm = sextract64(a->rs1, 0, 5);
-        if (s->vl_eq_vlmax) {
-            tcg_gen_gvec_dup_imm(s->sew, vreg_ofs(s, a->rd),
-                                 MAXSZ(s), MAXSZ(s), simm);
-        } else {
-            TCGv_i32 desc;
-            TCGv_i64 s1;
-            TCGv_ptr dest;
-            uint32_t data = 0;
-            data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
-            data = FIELD_DP32(data, VDATA, VTA, s->vta);
-            data = FIELD_DP32(data, VDATA, VMA, s->vma);
-            static gen_helper_vmv_vx * const fns[4] = {
-                gen_helper_vmv_v_x_b, gen_helper_vmv_v_x_h,
-                gen_helper_vmv_v_x_w, gen_helper_vmv_v_x_d,
-            };
-            TCGLabel *over = gen_new_label();
-            tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+    int64_t simm = sextract64(a->rs1, 0, 5);
+    if (s->vl_eq_vlmax) {
+        tcg_gen_gvec_dup_imm(s->sew, vreg_ofs(s, a->rd),
+                             MAXSZ(s), MAXSZ(s), simm);
+    } else {
+        TCGv_i32 desc;
+        TCGv_i64 s1;
+        TCGv_ptr dest;
+        uint32_t data = 0;
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);
+        static gen_helper_vmv_vx * const fns[4] = {
+            gen_helper_vmv_v_x_b, gen_helper_vmv_v_x_h,
+            gen_helper_vmv_v_x_w, gen_helper_vmv_v_x_d,
+        };
+        TCGLabel *over = gen_new_label();
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
 
-            s1 = tcg_const_i64(simm);
-            dest = tcg_temp_new_ptr();
-            desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
-            tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, a->rd));
-            fns[s->sew](dest, s1, cpu_env, desc);
+        s1 = tcg_const_i64(simm);
+        dest = tcg_temp_new_ptr();
+        desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
+        tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, a->rd));
+        fns[s->sew](dest, s1, cpu_env, desc);
 
-            tcg_temp_free_ptr(dest);
-            tcg_temp_free_i32(desc);
-            tcg_temp_free_i64(s1);
-            gen_set_label(over);
-        }
-        return true;
+        tcg_temp_free_ptr(dest);
+        tcg_temp_free_i32(desc);
+        tcg_temp_free_i64(s1);
+        gen_set_label(over);
     }
-    return false;
+    return true;
 }
 
+/* Vector Integer Merge Instructions */
 GEN_OPIVV_TRANS(vmerge_vvm, opivv_vadc_check)
 GEN_OPIVX_TRANS(vmerge_vxm, opivx_vadc_check)
 GEN_OPIVI_TRANS(vmerge_vim, 0, vmerge_vxm, opivx_vadc_check)
-- 
2.17.1


