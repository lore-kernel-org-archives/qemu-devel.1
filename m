Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA71C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 04:58:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CBF421743
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 04:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kDW+qddN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBF421743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvE2D-0003Py-KI
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 00:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40720)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvDxT-0001Mr-KX
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvDxR-0004sG-TV
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:55 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44206)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvDxR-0004rj-MB
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:53 -0400
Received: by mail-pg1-x542.google.com with SMTP id i18so42795158pgl.11
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 21:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=KqRxLQ5NjEif5jD98C5/dVAXZSJ+KGuz1k72NllRGYo=;
 b=kDW+qddNeql4fOnYl+XcPcJeqQUA8a6dFAUNCj3MCpzbKv6WbVh8MhT5+8/0ZghZdz
 Zonm+OYekOBi3c6YipJSBFiLaJ3K5QV8aj8MMyzaXXZVWBtTLoFDDaUXmh734Ac6kJeh
 m4GpWqb7mXVCNEmbwKx7QaX0fjlbmhG66tQapMup9LFISi2Xr4F34JutdiYK/PKf29Mf
 wNzmJy20IePh3F+y55YLVXKdcsPn5GIidFyqsHF3kFCtsTCvF7IcEkizDce7UAQ7NRLz
 NzqQ698edfgnABx1r5fWVXrsDv6gn8Y5n39Wf0oRHPr/1rwRH1WgzOm5YL+ywEWGT5aa
 Iv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=KqRxLQ5NjEif5jD98C5/dVAXZSJ+KGuz1k72NllRGYo=;
 b=aw83MSslYQ2VyIjRTPbv7IuJZBAjo3npTkuFeS6igt3r0z5Irz5ChQ2oom+EJbhMz6
 EWMoYpF8ntWgW5Ig1xbvo99/XDg+Y1m2FoWxxbMNX5mPL1ueaxPkvqUBmjbek4p85tZJ
 32ba6k81PHGNj8ap2AruLU2Su8ZoMHpjsbOD7RvZHEuEGqiUsLyq7SFyO4hociOsHWT6
 /QviFawzME66TmIgVnHuMx9sjq3VP0aqsEeRVKNES01f+JoTshYEopjyje6aqEHsSKts
 V8LZKx4bcN5f9PkDnDcHsmYsqCxstSikCWPpeUAMVlSpSX5BGy2cVBuw/Rqq21EFJERt
 e51Q==
X-Gm-Message-State: APjAAAWBgwwm3XYY8jSi7/Bh50B/8AUXSr0cDxIQjYlDKS7LAo3l4qyj
 SikhgsNW2cWdKuCo78dYX4Jr92AWu0w=
X-Google-Smtp-Source: APXvYqwDx2D/tPa7hH/S9SyvfJQRC9VGUlaodW6MraA896FdznrkeVvSahAH9r6Ayo801zLVrDhNig==
X-Received: by 2002:aa7:84d1:: with SMTP id x17mr7434373pfn.188.1565153632249; 
 Tue, 06 Aug 2019 21:53:52 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t9sm24347921pji.18.2019.08.06.21.53.51
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 06 Aug 2019 21:53:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  6 Aug 2019 21:53:31 -0700
Message-Id: <20190807045335.1361-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190807045335.1361-1-richard.henderson@linaro.org>
References: <20190807045335.1361-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH 07/11] target/arm: Replace offset with pc in
 gen_exception_insn
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The offset is variable depending on the instruction set, whereas
we have stored values for the current pc and the next pc.  Passing
in the actual value is clearer in intent.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c     | 25 ++++++++++++++-----------
 target/arm/translate-vfp.inc.c |  6 +++---
 target/arm/translate.c         | 31 ++++++++++++++++---------------
 3 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e640e116b0..92aa6db12e 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -273,10 +273,10 @@ static void gen_exception_internal_insn(DisasContext *s, int offset, int excp)
     s->base.is_jmp = DISAS_NORETURN;
 }
 
-static void gen_exception_insn(DisasContext *s, int offset, int excp,
+static void gen_exception_insn(DisasContext *s, uint64_t pc, int excp,
                                uint32_t syndrome, uint32_t target_el)
 {
-    gen_a64_set_pc_im(s->base.pc_next - offset);
+    gen_a64_set_pc_im(pc);
     gen_exception(excp, syndrome, target_el);
     s->base.is_jmp = DISAS_NORETURN;
 }
@@ -356,7 +356,7 @@ static inline void gen_goto_tb(DisasContext *s, int n, uint64_t dest)
 void unallocated_encoding(DisasContext *s)
 {
     /* Unallocated and reserved encodings are uncategorized */
-    gen_exception_insn(s, 4, EXCP_UDEF, syn_uncategorized(),
+    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
                        default_exception_el(s));
 }
 
@@ -1128,8 +1128,8 @@ static inline bool fp_access_check(DisasContext *s)
         return true;
     }
 
-    gen_exception_insn(s, 4, EXCP_UDEF, syn_fp_access_trap(1, 0xe, false),
-                       s->fp_excp_el);
+    gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
+                       syn_fp_access_trap(1, 0xe, false), s->fp_excp_el);
     return false;
 }
 
@@ -1139,7 +1139,7 @@ static inline bool fp_access_check(DisasContext *s)
 bool sve_access_check(DisasContext *s)
 {
     if (s->sve_excp_el) {
-        gen_exception_insn(s, 4, EXCP_UDEF, syn_sve_access_trap(),
+        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_sve_access_trap(),
                            s->sve_excp_el);
         return false;
     }
@@ -1873,8 +1873,8 @@ static void disas_exc(DisasContext *s, uint32_t insn)
         switch (op2_ll) {
         case 1:                                                     /* SVC */
             gen_ss_advance(s);
-            gen_exception_insn(s, 0, EXCP_SWI, syn_aa64_svc(imm16),
-                               default_exception_el(s));
+            gen_exception_insn(s, s->base.pc_next, EXCP_SWI,
+                               syn_aa64_svc(imm16), default_exception_el(s));
             break;
         case 2:                                                     /* HVC */
             if (s->current_el == 0) {
@@ -1887,7 +1887,8 @@ static void disas_exc(DisasContext *s, uint32_t insn)
             gen_a64_set_pc_im(s->pc_curr);
             gen_helper_pre_hvc(cpu_env);
             gen_ss_advance(s);
-            gen_exception_insn(s, 0, EXCP_HVC, syn_aa64_hvc(imm16), 2);
+            gen_exception_insn(s, s->base.pc_next, EXCP_HVC,
+                               syn_aa64_hvc(imm16), 2);
             break;
         case 3:                                                     /* SMC */
             if (s->current_el == 0) {
@@ -1899,7 +1900,8 @@ static void disas_exc(DisasContext *s, uint32_t insn)
             gen_helper_pre_smc(cpu_env, tmp);
             tcg_temp_free_i32(tmp);
             gen_ss_advance(s);
-            gen_exception_insn(s, 0, EXCP_SMC, syn_aa64_smc(imm16), 3);
+            gen_exception_insn(s, s->base.pc_next, EXCP_SMC,
+                               syn_aa64_smc(imm16), 3);
             break;
         default:
             unallocated_encoding(s);
@@ -14078,7 +14080,8 @@ static void disas_a64_insn(CPUARMState *env, DisasContext *s)
             if (s->btype != 0
                 && s->guarded_page
                 && !btype_destination_ok(insn, s->bt, s->btype)) {
-                gen_exception_insn(s, 4, EXCP_UDEF, syn_btitrap(s->btype),
+                gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
+                                   syn_btitrap(s->btype),
                                    default_exception_el(s));
                 return;
             }
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 262d4177e5..5065d4524c 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -96,10 +96,10 @@ static bool full_vfp_access_check(DisasContext *s, bool ignore_vfp_enabled)
 {
     if (s->fp_excp_el) {
         if (arm_dc_feature(s, ARM_FEATURE_M)) {
-            gen_exception_insn(s, 4, EXCP_NOCP, syn_uncategorized(),
+            gen_exception_insn(s, s->pc_curr, EXCP_NOCP, syn_uncategorized(),
                                s->fp_excp_el);
         } else {
-            gen_exception_insn(s, 4, EXCP_UDEF,
+            gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
                                syn_fp_access_trap(1, 0xe, false),
                                s->fp_excp_el);
         }
@@ -108,7 +108,7 @@ static bool full_vfp_access_check(DisasContext *s, bool ignore_vfp_enabled)
 
     if (!s->vfp_enabled && !ignore_vfp_enabled) {
         assert(!arm_dc_feature(s, ARM_FEATURE_M));
-        gen_exception_insn(s, 4, EXCP_UDEF, syn_uncategorized(),
+        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
                            default_exception_el(s));
         return false;
     }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index dfbaa592ab..7a05ecae87 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1264,11 +1264,11 @@ static void gen_exception_internal_insn(DisasContext *s, int offset, int excp)
     s->base.is_jmp = DISAS_NORETURN;
 }
 
-static void gen_exception_insn(DisasContext *s, int offset, int excp,
+static void gen_exception_insn(DisasContext *s, uint32_t pc, int excp,
                                int syn, uint32_t target_el)
 {
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->base.pc_next - offset);
+    gen_set_pc_im(s, pc);
     gen_exception(excp, syn, target_el);
     s->base.is_jmp = DISAS_NORETURN;
 }
@@ -1315,7 +1315,7 @@ static inline void gen_hlt(DisasContext *s, int imm)
         return;
     }
 
-    gen_exception_insn(s, s->thumb ? 2 : 4, EXCP_UDEF, syn_uncategorized(),
+    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
                        default_exception_el(s));
 }
 
@@ -3192,7 +3192,8 @@ static bool msr_banked_access_decode(DisasContext *s, int r, int sysm, int rn,
 
 undef:
     /* If we get here then some access check did not pass */
-    gen_exception_insn(s, 4, EXCP_UDEF, syn_uncategorized(), exc_target);
+    gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
+                       syn_uncategorized(), exc_target);
     return false;
 }
 
@@ -3586,7 +3587,7 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
      * for attempts to execute invalid vfp/neon encodings with FP disabled.
      */
     if (s->fp_excp_el) {
-        gen_exception_insn(s, 4, EXCP_UDEF,
+        gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
                            syn_simd_access_trap(1, 0xe, false), s->fp_excp_el);
         return 0;
     }
@@ -4857,7 +4858,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
      * for attempts to execute invalid vfp/neon encodings with FP disabled.
      */
     if (s->fp_excp_el) {
-        gen_exception_insn(s, 4, EXCP_UDEF,
+        gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
                            syn_simd_access_trap(1, 0xe, false), s->fp_excp_el);
         return 0;
     }
@@ -6985,7 +6986,7 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
     }
 
     if (s->fp_excp_el) {
-        gen_exception_insn(s, 4, EXCP_UDEF,
+        gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
                            syn_simd_access_trap(1, 0xe, false), s->fp_excp_el);
         return 0;
     }
@@ -7108,7 +7109,7 @@ static int disas_neon_insn_2reg_scalar_ext(DisasContext *s, uint32_t insn)
         off_rm = vfp_reg_offset(0, rm);
     }
     if (s->fp_excp_el) {
-        gen_exception_insn(s, 4, EXCP_UDEF,
+        gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
                            syn_simd_access_trap(1, 0xe, false), s->fp_excp_el);
         return 0;
     }
@@ -7601,7 +7602,7 @@ static void gen_srs(DisasContext *s,
      * For the UNPREDICTABLE cases we choose to UNDEF.
      */
     if (s->current_el == 1 && !s->ns && mode == ARM_CPU_MODE_MON) {
-        gen_exception_insn(s, 4, EXCP_UDEF, syn_uncategorized(), 3);
+        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(), 3);
         return;
     }
 
@@ -7637,7 +7638,7 @@ static void gen_srs(DisasContext *s,
     }
 
     if (undef) {
-        gen_exception_insn(s, 4, EXCP_UDEF, syn_uncategorized(),
+        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
                            default_exception_el(s));
         return;
     }
@@ -7728,7 +7729,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
      * UsageFault exception.
      */
     if (arm_dc_feature(s, ARM_FEATURE_M)) {
-        gen_exception_insn(s, 4, EXCP_INVSTATE, syn_uncategorized(),
+        gen_exception_insn(s, s->pc_curr, EXCP_INVSTATE, syn_uncategorized(),
                            default_exception_el(s));
         return;
     }
@@ -9265,7 +9266,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             break;
         default:
         illegal_op:
-            gen_exception_insn(s, 4, EXCP_UDEF, syn_uncategorized(),
+            gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
                                default_exception_el(s));
             break;
         }
@@ -10290,7 +10291,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             }
 
             /* All other insns: NOCP */
-            gen_exception_insn(s, 4, EXCP_NOCP, syn_uncategorized(),
+            gen_exception_insn(s, s->pc_curr, EXCP_NOCP, syn_uncategorized(),
                                default_exception_el(s));
             break;
         }
@@ -10954,7 +10955,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
     }
     return;
 illegal_op:
-    gen_exception_insn(s, 4, EXCP_UDEF, syn_uncategorized(),
+    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
                        default_exception_el(s));
 }
 
@@ -11778,7 +11779,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     return;
 illegal_op:
 undef:
-    gen_exception_insn(s, 2, EXCP_UDEF, syn_uncategorized(),
+    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
                        default_exception_el(s));
 }
 
-- 
2.17.1


