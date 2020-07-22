Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE08C433E8
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:41:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8FDF2068F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PR470QOC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FDF2068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBFS-0003ei-5c
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAvd-0003de-E3
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:20:45 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:43111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAvb-0005q2-Cs
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:20:45 -0400
Received: by mail-pg1-x535.google.com with SMTP id w2so864794pgg.10
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7I29w9Yyi3mvfOblF5aq3CVAkBnj/fLwd8DUfu+tXI4=;
 b=PR470QOCJkLhxZqrs3Q4+wDcgfR4Pq6uU/WeGdXtKumTVdf0lEe1xZ4ftjAbmX5PM2
 FbWAYZlkEzRUHZKp2E/MHZXkbJYylPfHAJHsavDrk5pQw/7pQeoQNW+xcrHC0pe34x8w
 K2/jh1uCFX63XFm4HaDqNSp4oUPlSUoOIiN3D7jV94Yd6zH1v50uUmJWyP3FRoYN91pk
 VXO9osz+1VdR2jvWy6/Cdip16eUICpwRNmB9tWJyjSAuZF3wAGz5zhgwFGF80TLi2nCr
 dTAvPN1cyzaXB4mcXBE23VJFxWXJasKjZbFRfBsjlBniSk0sWIRjEoVugTTg8jEfgoag
 8gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7I29w9Yyi3mvfOblF5aq3CVAkBnj/fLwd8DUfu+tXI4=;
 b=CRslTfvkDwbF09LYpOEFOajaXPvUkVedWemgmaotx5R/7gSlWaCcynFxym6qogeto6
 vVUuTgHTkiEuOlq6C4FaeHlcXnUB84zexpyrwDq14SkiIGkNIK9vZWNL3hWJGXihGE0/
 ZRRvBicC1LfeuoW0sDotfXO0IZV42mYjOUFoAsnbyU3xWyy3TJL+XsfNeNipVHAc3T+O
 l0f7sDjIq7FmJwkgaKl//zbOycFsR1jHFmt0xabf5XDxWvyV6Uwx4NlLOWavH7GonNog
 nsMOubc8/RREr5WDaQYEsdnJBYBBmdKCmf2R2Zv9gftFyJB/p9ouF25PGXvDfTUCXDyP
 yoHA==
X-Gm-Message-State: AOAM5317+NmuDkNIcbSffuZil7mXXM8JpizAP/hyydg9LxOU97DPBC3I
 BD+yyowaAHR61nbljRDRZB/qfgWv+QQ=
X-Google-Smtp-Source: ABdhPJzO1KXlGWIi/QMUnDAVdO1CYeDSCV2bvQv+EamJhNRcn1CKWVk8z1H9oEOVRnNvvcDRIeNh4Q==
X-Received: by 2002:a63:8f51:: with SMTP id r17mr26024640pgn.124.1595409641521; 
 Wed, 22 Jul 2020 02:20:41 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:20:40 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 43/76] target/riscv: rvv-0.9: integer extension instructions
Date: Wed, 22 Jul 2020 17:16:06 +0800
Message-Id: <20200722091641.8834-44-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x535.google.com
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

Add the following instructions:

* vzext.vf2
* vzext.vf4
* vzext.vf8
* vsext.vf2
* vsext.vf4
* vsext.vf8

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/helper.h                   | 14 ++++
 target/riscv/insn32.decode              |  8 +++
 target/riscv/insn_trans/trans_rvv.inc.c | 87 +++++++++++++++++++++++++
 target/riscv/vector_helper.c            | 34 ++++++++++
 4 files changed, 143 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 1dea171599..7eca91e510 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1097,4 +1097,18 @@ DEF_HELPER_6(vcompress_vm_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vcompress_vm_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vcompress_vm_d, void, ptr, ptr, ptr, ptr, env, i32)
 
+DEF_HELPER_5(vzext_vf2_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vzext_vf2_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vzext_vf2_d, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vzext_vf4_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vzext_vf4_d, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vzext_vf8_d, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_5(vsext_vf2_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vsext_vf2_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vsext_vf2_d, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vsext_vf4_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vsext_vf4_d, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vsext_vf8_d, void, ptr, ptr, ptr, env, i32)
+
 DEF_HELPER_3(narrower_nanbox_fpr, i64, i64, i32, env)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 0e1d6b3ead..5c31936a92 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -600,5 +600,13 @@ vmv2r_v         100111 1 ..... 00001 011 ..... 1010111 @r2rd
 vmv4r_v         100111 1 ..... 00011 011 ..... 1010111 @r2rd
 vmv8r_v         100111 1 ..... 00111 011 ..... 1010111 @r2rd
 
+# Vector Integer Extension
+vzext_vf2       010010 . ..... 00110 010 ..... 1010111 @r2_vm
+vzext_vf4       010010 . ..... 00100 010 ..... 1010111 @r2_vm
+vzext_vf8       010010 . ..... 00010 010 ..... 1010111 @r2_vm
+vsext_vf2       010010 . ..... 00111 010 ..... 1010111 @r2_vm
+vsext_vf4       010010 . ..... 00101 010 ..... 1010111 @r2_vm
+vsext_vf8       010010 . ..... 00011 010 ..... 1010111 @r2_vm
+
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 85f22a1495..e18ca432b7 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -3554,3 +3554,90 @@ GEN_VMV_WHOLE_TRANS(vmv1r_v, 1)
 GEN_VMV_WHOLE_TRANS(vmv2r_v, 2)
 GEN_VMV_WHOLE_TRANS(vmv4r_v, 4)
 GEN_VMV_WHOLE_TRANS(vmv8r_v, 8)
+
+static bool int_ext_check(DisasContext *s, arg_rmr *a, uint8_t div)
+{
+    uint32_t from = (1 << (s->sew + 3)) / div;
+    bool ret = require_rvv(s);
+    ret &= (from >= 8 && from <= 64) &&
+           (a->rd != a->rs2) &&
+           require_align(a->rd, s->flmul) &&
+           require_align(a->rs2, s->flmul / div) &&
+           require_vm(a->vm, a->rd);
+    if ((s->flmul / div) < 1) {
+        ret &= require_noover(a->rd, s->flmul, a->rs2, s->flmul / div);
+    } else {
+        ret &= require_noover_widen(a->rd, s->flmul, a->rs2, s->flmul / div);
+    }
+    return ret;
+}
+
+static bool int_ext_op(DisasContext *s, arg_rmr *a, uint8_t seq)
+{
+    uint32_t data = 0;
+    gen_helper_gvec_3_ptr *fn;
+    TCGLabel *over = gen_new_label();
+    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+
+    static gen_helper_gvec_3_ptr * const fns[6][4] = {
+        {
+            NULL, gen_helper_vzext_vf2_h,
+            gen_helper_vzext_vf2_w, gen_helper_vzext_vf2_d
+        },
+        {
+            NULL, NULL,
+            gen_helper_vzext_vf4_w, gen_helper_vzext_vf4_d,
+        },
+        {
+            NULL, NULL,
+            NULL, gen_helper_vzext_vf8_d
+        },
+        {
+            NULL, gen_helper_vsext_vf2_h,
+            gen_helper_vsext_vf2_w, gen_helper_vsext_vf2_d
+        },
+        {
+            NULL, NULL,
+            gen_helper_vsext_vf4_w, gen_helper_vsext_vf4_d,
+        },
+        {
+            NULL, NULL,
+            NULL, gen_helper_vsext_vf8_d
+        }
+    };
+
+    fn = fns[seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    data = FIELD_DP32(data, VDATA, VM, a->vm);
+    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);
+
+    tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
+                       vreg_ofs(s, a->rs2), cpu_env, 0,
+                       s->vlen / 8, data, fn);
+
+    mark_vs_dirty(s);
+    gen_set_label(over);
+    return true;
+}
+
+/* Vector Integer Extension */
+#define GEN_INT_EXT_TRANS(NAME, DIV, SEQ)             \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a) \
+{                                                     \
+    if (int_ext_check(s, a, DIV)) {                   \
+        return int_ext_op(s, a, SEQ);                 \
+    }                                                 \
+    return false;                                     \
+}
+
+GEN_INT_EXT_TRANS(vzext_vf2, 2, 0)
+GEN_INT_EXT_TRANS(vzext_vf4, 4, 1)
+GEN_INT_EXT_TRANS(vzext_vf8, 8, 2)
+GEN_INT_EXT_TRANS(vsext_vf2, 2, 3)
+GEN_INT_EXT_TRANS(vsext_vf4, 4, 4)
+GEN_INT_EXT_TRANS(vsext_vf8, 8, 5)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index c1ed0ff6ad..8516570e5f 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -5002,3 +5002,37 @@ GEN_VEXT_VCOMPRESS_VM(vcompress_vm_b, uint8_t, H1, clearb)
 GEN_VEXT_VCOMPRESS_VM(vcompress_vm_h, uint16_t, H2, clearh)
 GEN_VEXT_VCOMPRESS_VM(vcompress_vm_w, uint32_t, H4, clearl)
 GEN_VEXT_VCOMPRESS_VM(vcompress_vm_d, uint64_t, H8, clearq)
+
+/* Vector Integer Extension */
+#define GEN_VEXT_INT_EXT(NAME, ETYPE, DTYPE, HD, HS1, CLEAR_FN)       \
+void HELPER(NAME)(void *vd, void *v0, void *vs2,                      \
+                  CPURISCVState *env, uint32_t desc)                  \
+{                                                                     \
+    uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);      \
+    uint32_t vta = vext_vta(desc);                                    \
+    uint32_t vl = env->vl;                                            \
+    uint32_t vm = vext_vm(desc);                                      \
+    uint32_t i;                                                       \
+                                                                      \
+    for (i = 0; i < vl; i++) {                                        \
+        if (!vm && !vext_elem_mask(v0, i)) {                          \
+            continue;                                                 \
+        }                                                             \
+        *((ETYPE *)vd + HD(i)) = *((DTYPE *)vs2 + HS1(i));            \
+    }                                                                 \
+    CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE)); \
+}
+
+GEN_VEXT_INT_EXT(vzext_vf2_h, uint16_t, uint8_t,  H2, H1, clearh)
+GEN_VEXT_INT_EXT(vzext_vf2_w, uint32_t, uint16_t, H4, H2, clearl)
+GEN_VEXT_INT_EXT(vzext_vf2_d, uint64_t, uint32_t, H8, H4, clearq)
+GEN_VEXT_INT_EXT(vzext_vf4_w, uint32_t, uint8_t,  H4, H1, clearl)
+GEN_VEXT_INT_EXT(vzext_vf4_d, uint64_t, uint16_t, H8, H2, clearq)
+GEN_VEXT_INT_EXT(vzext_vf8_d, uint64_t, uint8_t,  H8, H1, clearq)
+
+GEN_VEXT_INT_EXT(vsext_vf2_h, int16_t, int8_t,  H2, H1, clearh)
+GEN_VEXT_INT_EXT(vsext_vf2_w, int32_t, int16_t, H4, H2, clearl)
+GEN_VEXT_INT_EXT(vsext_vf2_d, int64_t, int32_t, H8, H4, clearq)
+GEN_VEXT_INT_EXT(vsext_vf4_w, int32_t, int8_t,  H4, H1, clearl)
+GEN_VEXT_INT_EXT(vsext_vf4_d, int64_t, int16_t, H8, H2, clearq)
+GEN_VEXT_INT_EXT(vsext_vf8_d, int64_t, int8_t,  H8, H1, clearq)
-- 
2.17.1


