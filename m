Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC47EC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A22206C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gJ8vsBFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A22206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7b3E-0005aN-SY
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7as7-0001N6-IK
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:52:04 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:34373)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7as1-0005AK-Oo
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:52:03 -0400
Received: by mail-pg1-x52c.google.com with SMTP id i10so2256691pgk.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3kZu2XYR0hkPzBPJPZsJf1NLHPXc023NUWo/+dJQYAU=;
 b=gJ8vsBFKIFZTR5gO85AzXgCV4Ww3Nvyxk4FHZ/rSk1st3qH1j/5RooXBeXJvuqZ4Lw
 G5daWo43XclUS9MsNmLrVI14vayiLKVFrqN8pc1qNYjLww8oSJIJJrMbDeVS4adDMYkx
 Rpv6Ukzy+AMw4WGzy0GU7owec7fUBw+ISG9vzO8m+UPa4yd7Mp8qXOuhCJGKwhWuoFnU
 WfKchOBgeBaoWw/8HqDv/GX9vVUtRBXcxF37/KTcEoSXSu70klFX7QZCoo8Dl5168Z0y
 GlspROz3REYg0meIcjZ2cTkOb1Y1PNIdgqHCDNU+Sil+VhlvM2lHr1AYSdCBRushz68h
 ElAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3kZu2XYR0hkPzBPJPZsJf1NLHPXc023NUWo/+dJQYAU=;
 b=QOISx5n1sSE6L/qYRxY4cjZA996fRC+ctUNLpmoQpp/Uef1lebZ9KYqVuuLp/uzEbc
 udNHzTXKs6dIYP4J9N84kxM8rvz8yNaAAPXUGN0lgVrb4xKVeRtFM8RK4ErTT78lLxpU
 VVbpDAWdJQbTc5TrDqGbuoKtHXbJ00wAz7Mka6SeAcmopGzhPfUVl1x8MW4oNe/rd5pX
 n/bfEx6obTBCFPKuaFpk6VWmKPhmgXtir+jNaulGz6K+3lnzERBoEVbU+noYa6i+K0Tc
 6b28f+0Cbn5rARD/n7ks9zuSd7M5GxYyVMALzwWTTxgM6Tw7SQ/+TMF6z6G8wb8EL1oP
 1vYg==
X-Gm-Message-State: AOAM530c2N32j95lClpNRpfKi4k+/IKaBPdJxHIIekEGe9TbU5Mh5Kw6
 HRWAtPPvbTwi576vOIEvIOhM7qCG3cvriQ==
X-Google-Smtp-Source: ABdhPJyoOyLW1bxIxLN7vXM58tkW6IWs7a3k72L68G8sbhNXGNBizsvioOGNt+0aaE4GvvmB9PAxeA==
X-Received: by 2002:a05:6a00:15d0:: with SMTP id
 o16mr10560646pfu.230.1597654315246; 
 Mon, 17 Aug 2020 01:51:55 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:51:54 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 39/70] target/riscv: rvv-1.0: integer extension instructions
Date: Mon, 17 Aug 2020 16:49:24 +0800
Message-Id: <20200817084955.28793-40-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x52c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

* vzext.vf2
* vzext.vf4
* vzext.vf8
* vsext.vf2
* vsext.vf4
* vsext.vf8

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/helper.h                   | 14 ++++
 target/riscv/insn32.decode              |  8 +++
 target/riscv/insn_trans/trans_rvv.inc.c | 86 +++++++++++++++++++++++++
 target/riscv/vector_helper.c            | 31 +++++++++
 4 files changed, 139 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 35fb09d2892..7ce2fa08d58 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1118,3 +1118,17 @@ DEF_HELPER_6(vcompress_vm_b, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vcompress_vm_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vcompress_vm_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vcompress_vm_d, void, ptr, ptr, ptr, ptr, env, i32)
+
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
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 65ff1688c25..2b9700a42ad 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -619,5 +619,13 @@ vmv2r_v         100111 1 ..... 00001 011 ..... 1010111 @r2rd
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
index 52f2f4902c0..5cd099bed7b 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -3504,3 +3504,89 @@ GEN_VMV_WHOLE_TRANS(vmv1r_v, 1)
 GEN_VMV_WHOLE_TRANS(vmv2r_v, 2)
 GEN_VMV_WHOLE_TRANS(vmv4r_v, 4)
 GEN_VMV_WHOLE_TRANS(vmv8r_v, 8)
+
+static bool int_ext_check(DisasContext *s, arg_rmr *a, uint8_t div)
+{
+    uint8_t from = (s->sew + 3) - div;
+    bool ret = require_rvv(s);
+    ret &= (from >= 3 && from <= 8) &&
+           (a->rd != a->rs2) &&
+           require_align(a->rd, 1 << s->lmul) &&
+           require_align(a->rs2, 1 << (s->lmul - div)) &&
+           require_vm(a->vm, a->rd);
+    if ((s->lmul - div) < 0) {
+        ret &= require_noover(a->rd, 1 << s->lmul,
+                              a->rs2, 1 << (s->lmul - div));
+    } else {
+        ret &= require_noover_widen(a->rd, 1 << s->lmul, a->rs2,
+                                    1 << (s->lmul - div));
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
+GEN_INT_EXT_TRANS(vzext_vf2, 1, 0)
+GEN_INT_EXT_TRANS(vzext_vf4, 2, 1)
+GEN_INT_EXT_TRANS(vzext_vf8, 3, 2)
+GEN_INT_EXT_TRANS(vsext_vf2, 1, 3)
+GEN_INT_EXT_TRANS(vsext_vf4, 2, 4)
+GEN_INT_EXT_TRANS(vsext_vf8, 3, 5)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 26a8ac6fe25..ad3408888d4 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4775,3 +4775,34 @@ GEN_VEXT_VCOMPRESS_VM(vcompress_vm_b, uint8_t,  H1)
 GEN_VEXT_VCOMPRESS_VM(vcompress_vm_h, uint16_t, H2)
 GEN_VEXT_VCOMPRESS_VM(vcompress_vm_w, uint32_t, H4)
 GEN_VEXT_VCOMPRESS_VM(vcompress_vm_d, uint64_t, H8)
+
+/* Vector Integer Extension */
+#define GEN_VEXT_INT_EXT(NAME, ETYPE, DTYPE, HD, HS1)            \
+void HELPER(NAME)(void *vd, void *v0, void *vs2,                 \
+                  CPURISCVState *env, uint32_t desc)             \
+{                                                                \
+    uint32_t vl = env->vl;                                       \
+    uint32_t vm = vext_vm(desc);                                 \
+    uint32_t i;                                                  \
+                                                                 \
+    for (i = 0; i < vl; i++) {                                   \
+        if (!vm && !vext_elem_mask(v0, i)) {                     \
+            continue;                                            \
+        }                                                        \
+        *((ETYPE *)vd + HD(i)) = *((DTYPE *)vs2 + HS1(i));       \
+    }                                                            \
+}
+
+GEN_VEXT_INT_EXT(vzext_vf2_h, uint16_t, uint8_t,  H2, H1)
+GEN_VEXT_INT_EXT(vzext_vf2_w, uint32_t, uint16_t, H4, H2)
+GEN_VEXT_INT_EXT(vzext_vf2_d, uint64_t, uint32_t, H8, H4)
+GEN_VEXT_INT_EXT(vzext_vf4_w, uint32_t, uint8_t,  H4, H1)
+GEN_VEXT_INT_EXT(vzext_vf4_d, uint64_t, uint16_t, H8, H2)
+GEN_VEXT_INT_EXT(vzext_vf8_d, uint64_t, uint8_t,  H8, H1)
+
+GEN_VEXT_INT_EXT(vsext_vf2_h, int16_t, int8_t,  H2, H1)
+GEN_VEXT_INT_EXT(vsext_vf2_w, int32_t, int16_t, H4, H2)
+GEN_VEXT_INT_EXT(vsext_vf2_d, int64_t, int32_t, H8, H4)
+GEN_VEXT_INT_EXT(vsext_vf4_w, int32_t, int8_t,  H4, H1)
+GEN_VEXT_INT_EXT(vsext_vf4_d, int64_t, int16_t, H8, H2)
+GEN_VEXT_INT_EXT(vsext_vf8_d, int64_t, int8_t,  H8, H1)
-- 
2.17.1


