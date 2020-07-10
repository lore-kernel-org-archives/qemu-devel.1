Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E13C433EA
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:11:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91362078D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TIaEopqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91362078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsoK-0002Qe-Pw
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqf2-0005wT-Jw
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:53:44 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:35471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqez-0006vS-LY
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:53:44 -0400
Received: by mail-pl1-x631.google.com with SMTP id x9so2108025plr.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RihXg84FjDeVLFolFz2utaTiEAaEOxIfUOHxy3Jd+OI=;
 b=TIaEopqdNYkQmWAHeYm/isurotnEZDjgMrM++Ng+D5d0kJkNwFaAKPOuTHac5oswk7
 l2jLMPjstFPCbFcTM7K3KdDO4yLJ1HC2z3NaxtCa1RYVmKXW4jfuxjvEcXNNWeymzktm
 AD7btFi5nYdrtciVuoqvnju2Ba0dofqWpHw3/APSgHmK49xZyXTepaSGUJshNYaB0pm9
 GmJLo+gBir9CdsVk/PLWakhXc2B2TUHE9Wjekarg8MYaMORaUjug9Rr2VCiBzoBbAoDX
 TpSfwC8U5Vv9y6/LZJoTLBISHDqC1iOQhmY4lOdVohsaHV02FmxNAhj3r7ZE+7cPPJyy
 Bb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RihXg84FjDeVLFolFz2utaTiEAaEOxIfUOHxy3Jd+OI=;
 b=uQJIEOYTM0bCQhbFFpocPAFR1lDAtAKFrkMN//72jzqXGcpZCxw91TjcwRdFGDHj/R
 dlHnxhZVY/ttTI/d5IKw+N38aBF0Y7BBaLS5UebcSEDYYYHPFQloR3As0o9U3YgbcdZ7
 zChS9iLjNgjRWAUoSJqeZTI1N+SnsYSJLQqLkq0EWGcTjesftW+OO1s71J09sGEKwo1F
 26h1lDKJKk4oSUlm108R0h9sUW/ILGyu4I3SUHUNmYr5V+uZ0AynoMzJzc1ALSaD/mZR
 g0/QDjYsJODilkaPDziFjF2KrInZOrmQg06BwUcZeu7TPTlGs7GgFWEalG2avVNJYbiP
 7KGg==
X-Gm-Message-State: AOAM531nXh5Sg6/mGRgAPDVphieaLAp42kjCMdVvcGxzTliUfVbdF2pr
 R7p7nlFCDlXPo4LaV/z82r8r+Zy3CdPmfw==
X-Google-Smtp-Source: ABdhPJxGul1srCkjnrqDF7ErNGXwzPol32XUGEEvfy/Pm96T8KzAT9948dOMkqw9cQUOpyPbnALo+g==
X-Received: by 2002:a17:90b:3684:: with SMTP id
 mj4mr5251225pjb.66.1594378420277; 
 Fri, 10 Jul 2020 03:53:40 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:53:39 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 46/65] target/riscv: rvv-0.9: slide instructions
Date: Fri, 10 Jul 2020 18:49:00 +0800
Message-Id: <20200710104920.13550-47-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x631.google.com
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
 target/riscv/insn_trans/trans_rvv.inc.c | 35 ++++++++---
 target/riscv/vector_helper.c            | 83 +++++++++++--------------
 2 files changed, 64 insertions(+), 54 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 50f9782a96..dab642ab7a 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -379,6 +379,18 @@ static uint32_t vreg_ofs(DisasContext *s, int reg)
     require_align(rs2, s->flmul)                   \
 } while (0)
 
+/*
+ * Check function for vector slide instructions.
+ */
+#define VEXT_CHECK_SLIDE(s, rd, rs2, vm, is_over) do { \
+    require_align(rs2, s->flmul);                      \
+    require_align(rd, s->flmul);                       \
+    require_vm(vm, rd);                                \
+    if (is_over) {                                     \
+        require(rd != rs2);                            \
+    }                                                  \
+} while (0)
+
 /*
  * Check function for vector integer extension instructions.
  */
@@ -3214,20 +3226,27 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
 /* Vector Slide Instructions */
 static bool slideup_check(DisasContext *s, arg_rmrr *a)
 {
-    return (vext_check_isa_ill(s) &&
-            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, false) &&
-            (a->rd != a->rs2));
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    VEXT_CHECK_SLIDE(s, a->rd, a->rs2, a->vm, true);
+    return true;
 }
 
 GEN_OPIVX_TRANS(vslideup_vx, slideup_check)
 GEN_OPIVX_TRANS(vslide1up_vx, slideup_check)
 GEN_OPIVI_TRANS(vslideup_vi, 1, vslideup_vx, slideup_check)
 
-GEN_OPIVX_TRANS(vslidedown_vx, opivx_check)
-GEN_OPIVX_TRANS(vslide1down_vx, opivx_check)
-GEN_OPIVI_TRANS(vslidedown_vi, 1, vslidedown_vx, opivx_check)
+static bool slidedown_check(DisasContext *s, arg_rmrr *a)
+{
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    VEXT_CHECK_SLIDE(s, a->rd, a->rs2, a->vm, false);
+    return true;
+}
+
+GEN_OPIVX_TRANS(vslidedown_vx, slidedown_check)
+GEN_OPIVX_TRANS(vslide1down_vx, slidedown_check)
+GEN_OPIVI_TRANS(vslidedown_vi, 1, vslidedown_vx, slidedown_check)
 
 /* Vector Register Gather Instruction */
 static bool vrgather_vv_check(DisasContext *s, arg_rmrr *a)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 6484c660c6..050f4fd895 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4916,64 +4916,59 @@ GEN_VEXT_VID_V(vid_v_d, uint64_t, H8, clearq)
  */
 
 /* Vector Slide Instructions */
-#define GEN_VEXT_VSLIDEUP_VX(NAME, ETYPE, H, CLEAR_FN)                    \
-void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
-                  CPURISCVState *env, uint32_t desc)                      \
-{                                                                         \
-    uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);          \
-    uint32_t vm = vext_vm(desc);                                          \
-    uint32_t vta = vext_vta(desc);                                        \
-    uint32_t vl = env->vl;                                                \
-    target_ulong offset = s1, i;                                          \
-                                                                          \
-    for (i = offset; i < vl; i++) {                                       \
-        if (!vm && !vext_elem_mask(v0, i)) {                              \
-            continue;                                                     \
-        }                                                                 \
-        *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
-    }                                                                     \
-    CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
+#define GEN_VEXT_VSLIDEUP_VX(NAME, ETYPE, H)                      \
+void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2, \
+                  CPURISCVState *env, uint32_t desc)              \
+{                                                                 \
+    uint32_t vm = vext_vm(desc);                                  \
+    uint32_t vl = env->vl;                                        \
+    target_ulong offset = s1, i;                                  \
+                                                                  \
+    for (i = offset; i < vl; i++) {                               \
+        if (!vm && !vext_elem_mask(v0, i)) {                      \
+            continue;                                             \
+        }                                                         \
+        *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));  \
+    }                                                             \
 }
 
 /* vslideup.vx vd, vs2, rs1, vm # vd[i+rs1] = vs2[i] */
-GEN_VEXT_VSLIDEUP_VX(vslideup_vx_b, uint8_t, H1, clearb)
-GEN_VEXT_VSLIDEUP_VX(vslideup_vx_h, uint16_t, H2, clearh)
-GEN_VEXT_VSLIDEUP_VX(vslideup_vx_w, uint32_t, H4, clearl)
-GEN_VEXT_VSLIDEUP_VX(vslideup_vx_d, uint64_t, H8, clearq)
+GEN_VEXT_VSLIDEUP_VX(vslideup_vx_b, uint8_t,  H1)
+GEN_VEXT_VSLIDEUP_VX(vslideup_vx_h, uint16_t, H2)
+GEN_VEXT_VSLIDEUP_VX(vslideup_vx_w, uint32_t, H4)
+GEN_VEXT_VSLIDEUP_VX(vslideup_vx_d, uint64_t, H8)
 
-#define GEN_VEXT_VSLIDEDOWN_VX(NAME, ETYPE, H, CLEAR_FN)                  \
+#define GEN_VEXT_VSLIDEDOWN_VX(NAME, ETYPE, H)                            \
 void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
+    uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);          \
     uint32_t vm = vext_vm(desc);                                          \
-    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
     target_ulong offset = s1, i;                                          \
                                                                           \
     for (i = 0; i < vl; ++i) {                                            \
+        /* offset may be a large value, which j may overflow */           \
         target_ulong j = i + offset;                                      \
+        bool is_valid = (offset >= vlmax || j >= vlmax) ? false : true;   \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
             continue;                                                     \
         }                                                                 \
-        *((ETYPE *)vd + H(i)) = j >= vlmax ? 0 : *((ETYPE *)vs2 + H(j));  \
+        *((ETYPE *)vd + H(i)) = is_valid ? *((ETYPE *)vs2 + H(j)) : 0;  \
     }                                                                     \
-    CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
 }
 
 /* vslidedown.vx vd, vs2, rs1, vm # vd[i] = vs2[i+rs1] */
-GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_b, uint8_t, H1, clearb)
-GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_h, uint16_t, H2, clearh)
-GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_w, uint32_t, H4, clearl)
-GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_d, uint64_t, H8, clearq)
+GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_b, uint8_t,  H1)
+GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_h, uint16_t, H2)
+GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_w, uint32_t, H4)
+GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_d, uint64_t, H8)
 
-#define GEN_VEXT_VSLIDE1UP_VX(NAME, ETYPE, H, CLEAR_FN)                   \
+#define GEN_VEXT_VSLIDE1UP_VX(NAME, ETYPE, H)                             \
 void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
-    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
     uint32_t i;                                                           \
                                                                           \
@@ -4987,22 +4982,19 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
             *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - 1));           \
         }                                                                 \
     }                                                                     \
-    CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
 }
 
 /* vslide1up.vx vd, vs2, rs1, vm # vd[0]=x[rs1], vd[i+1] = vs2[i] */
-GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_b, uint8_t, H1, clearb)
-GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_h, uint16_t, H2, clearh)
-GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_w, uint32_t, H4, clearl)
-GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_d, uint64_t, H8, clearq)
+GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_b, uint8_t,  H1)
+GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_h, uint16_t, H2)
+GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_w, uint32_t, H4)
+GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_d, uint64_t, H8)
 
-#define GEN_VEXT_VSLIDE1DOWN_VX(NAME, ETYPE, H, CLEAR_FN)                 \
+#define GEN_VEXT_VSLIDE1DOWN_VX(NAME, ETYPE, H)                           \
 void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
-    uint32_t vta = vext_vta(desc);                                        \
     uint32_t vl = env->vl;                                                \
     uint32_t i;                                                           \
                                                                           \
@@ -5016,14 +5008,13 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
             *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i + 1));           \
         }                                                                 \
     }                                                                     \
-    CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
 }
 
 /* vslide1down.vx vd, vs2, rs1, vm # vd[i] = vs2[i+1], vd[vl-1]=x[rs1] */
-GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_b, uint8_t, H1, clearb)
-GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_h, uint16_t, H2, clearh)
-GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_w, uint32_t, H4, clearl)
-GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_d, uint64_t, H8, clearq)
+GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_b, uint8_t,  H1)
+GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_h, uint16_t, H2)
+GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_w, uint32_t, H4)
+GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_d, uint64_t, H8)
 
 /* Vector Register Gather Instruction */
 #define GEN_VEXT_VRGATHER_VV(NAME, ETYPE, H, CLEAR_FN)                    \
-- 
2.17.1


