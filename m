Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70610C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 17:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D6AB206D4
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 17:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezN/mbRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6AB206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ja14Z-0005KH-Gw
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 13:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ja0th-0003dj-5x
 for qemu-devel@nongnu.org; Sat, 16 May 2020 13:46:53 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:45674)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ja0tf-0008TY-EW
 for qemu-devel@nongnu.org; Sat, 16 May 2020 13:46:52 -0400
Received: by mail-lf1-x144.google.com with SMTP id a4so4474341lfh.12
 for <qemu-devel@nongnu.org>; Sat, 16 May 2020 10:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5yZ4H4scvEuLdRxQjpBX/SfwA9bJahjWfAJAK11Z058=;
 b=ezN/mbRSmOZ80qkTmVRrCjimoiDMushDqeNeFOOSIzZisNl1r5t8y4lNzHy1jWQlsO
 rONcd/ir1bE+6g3eQAyrthq97U3sEJ87dadU1FiGS2+EgHFSzSNBY34lOg68dkvDTmps
 EaWMswhGBucX5tsNOAE4UbBerNk40PDIbTggo1uKbyiqo47HxSnSrTyu7jQuOo6Sfvuq
 D6dbTZbndDpjQHxn5R7rcggrIHcev3abgAGyzLZn3hwDvfxcCd2TMKB90oyCHvDGATHV
 Z6pnCZFQgTnR6bGkvKrXA26woBPWZWP4w65KqoSuAk4WakvIzuaoMojayO51/QgQbqo9
 Z3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5yZ4H4scvEuLdRxQjpBX/SfwA9bJahjWfAJAK11Z058=;
 b=Ov+6bKObPJPYabjSoef3rMVMOLfbk634FecJxpU4G47/h5sChu3ff6ZJiRdIkd8tn7
 rbrfkpah5hEO+hAEG1bS38Ib4tF5ykqw3V5Rf1qk15fruICvuXxLuPTj0vpeUGEeB2RX
 5qxn+W5qudRCXEQr3HKvyMglyYETYfmDhcsHhAgZZs3z+xasknwDZJbfhNzSlkZCz0Qf
 L0tWulz+D1il4jZCfHzpy5/CpgHFa7mJZaidsqeRLufO3erYRvXTYFz/tltx+RJcXUQf
 1RhH9E6F52PU8JeNQPe6B7cQ0aGEZugj/C3+Jn6pwpCi+d9nth7I3oFaOYvGTCx7920D
 3H/Q==
X-Gm-Message-State: AOAM533jOUZhf+a3NJUuVCIz689c/jDHpaRJVE17l3BLfH71ZSMm8b4z
 igJ3GyxzFx9sTO83pb7sb1nvZnbZ7T0=
X-Google-Smtp-Source: ABdhPJwVEWMQUyYYtHH2BBBlqYNb6XdH0N3vmkBBWdVo6NZ6qgzYGL0mXADG0x5z1OfgiRODdcvGHw==
X-Received: by 2002:ac2:4105:: with SMTP id b5mr6305268lfi.94.1589651209610;
 Sat, 16 May 2020 10:46:49 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id i1sm3024759lja.3.2020.05.16.10.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2020 10:46:49 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 16/18] target/mips: fpu: Refactor conversion from ieee to
 mips exception flags
Date: Sat, 16 May 2020 19:45:46 +0200
Message-Id: <20200516174548.7631-17-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200516174548.7631-1-aleksandar.qemu.devel@gmail.com>
References: <20200516174548.7631-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@rt-rk.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The original coversion function is used for regular and MSA floating
point instructions handling. Since there are some nuanced differences
between regular and MSA floatin point excetion handling, provide two
instances of the conversion function, rather than just a common one.
Inline both of these function instances for the sake of performance.
Improve variable naming in surrounding code for clarity.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 55 +++++++++++++++-------------
 target/mips/internal.h   |  1 -
 target/mips/msa_helper.c | 77 +++++++++++++++++++++++++++-------------
 3 files changed, 82 insertions(+), 51 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index dbb8ca5692..7a3a61cab3 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -189,43 +189,48 @@ void helper_ctc1(CPUMIPSState *env, target_ulong arg1, uint32_t fs, uint32_t rt)
     }
 }
 
-int ieee_ex_to_mips(int xcpt)
+static inline int ieee_to_mips_xcpt(int ieee_xcpt)
 {
-    int ret = 0;
-    if (xcpt) {
-        if (xcpt & float_flag_invalid) {
-            ret |= FP_INVALID;
-        }
-        if (xcpt & float_flag_overflow) {
-            ret |= FP_OVERFLOW;
-        }
-        if (xcpt & float_flag_underflow) {
-            ret |= FP_UNDERFLOW;
-        }
-        if (xcpt & float_flag_divbyzero) {
-            ret |= FP_DIV0;
-        }
-        if (xcpt & float_flag_inexact) {
-            ret |= FP_INEXACT;
-        }
+    int mips_xcpt = 0;
+
+    if (ieee_xcpt & float_flag_invalid) {
+        mips_xcpt |= FP_INVALID;
+    }
+    if (ieee_xcpt & float_flag_overflow) {
+        mips_xcpt |= FP_OVERFLOW;
     }
-    return ret;
+    if (ieee_xcpt & float_flag_underflow) {
+        mips_xcpt |= FP_UNDERFLOW;
+    }
+    if (ieee_xcpt & float_flag_divbyzero) {
+        mips_xcpt |= FP_DIV0;
+    }
+    if (ieee_xcpt & float_flag_inexact) {
+        mips_xcpt |= FP_INEXACT;
+    }
+
+    return mips_xcpt;
 }
 
 static inline void update_fcr31(CPUMIPSState *env, uintptr_t pc)
 {
-    int tmp = ieee_ex_to_mips(get_float_exception_flags(
-                                  &env->active_fpu.fp_status));
+    int ieee_exception_flags = get_float_exception_flags(
+                                   &env->active_fpu.fp_status);
+    int mips_exception_flags = 0;
+
+    if (ieee_exception_flags) {
+        mips_exception_flags = ieee_to_mips_xcpt(ieee_exception_flags);
+    }
 
-    SET_FP_CAUSE(env->active_fpu.fcr31, tmp);
+    SET_FP_CAUSE(env->active_fpu.fcr31, mips_exception_flags);
 
-    if (tmp) {
+    if (mips_exception_flags)  {
         set_float_exception_flags(0, &env->active_fpu.fp_status);
 
-        if (GET_FP_ENABLE(env->active_fpu.fcr31) & tmp) {
+        if (GET_FP_ENABLE(env->active_fpu.fcr31) & mips_exception_flags) {
             do_raise_exception(env, EXCP_FPE, pc);
         } else {
-            UPDATE_FP_FLAGS(env->active_fpu.fcr31, tmp);
+            UPDATE_FP_FLAGS(env->active_fpu.fcr31, mips_exception_flags);
         }
     }
 }
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 1bf274b3ef..684356e309 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -224,7 +224,6 @@ uint32_t float_class_s(uint32_t arg, float_status *fst);
 uint64_t float_class_d(uint64_t arg, float_status *fst);
 
 extern unsigned int ieee_rm[];
-int ieee_ex_to_mips(int xcpt);
 void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagemask);
 
 static inline void restore_rounding_mode(CPUMIPSState *env)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 4065cfe4f7..c520405929 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -5419,54 +5419,81 @@ static inline void check_msacsr_cause(CPUMIPSState *env, uintptr_t retaddr)
 #define CLEAR_IS_INEXACT   2
 #define RECIPROCAL_INEXACT 4
 
-static inline int update_msacsr(CPUMIPSState *env, int action, int denormal)
+
+static inline int ieee_to_mips_xcpt_msa(int ieee_xcpt)
 {
-    int ieee_ex;
+    int mips_xcpt = 0;
 
-    int c;
+    if (ieee_xcpt & float_flag_invalid) {
+        mips_xcpt |= FP_INVALID;
+    }
+    if (ieee_xcpt & float_flag_overflow) {
+        mips_xcpt |= FP_OVERFLOW;
+    }
+    if (ieee_xcpt & float_flag_underflow) {
+        mips_xcpt |= FP_UNDERFLOW;
+    }
+    if (ieee_xcpt & float_flag_divbyzero) {
+        mips_xcpt |= FP_DIV0;
+    }
+    if (ieee_xcpt & float_flag_inexact) {
+        mips_xcpt |= FP_INEXACT;
+    }
+
+    return mips_xcpt;
+}
+
+static inline int update_msacsr(CPUMIPSState *env, int action, int denormal)
+{
+    int ieee_exception_flags;
+    int mips_exception_flags = 0;
     int cause;
     int enable;
 
-    ieee_ex = get_float_exception_flags(&env->active_tc.msa_fp_status);
+    ieee_exception_flags = get_float_exception_flags(
+                               &env->active_tc.msa_fp_status);
 
     /* QEMU softfloat does not signal all underflow cases */
     if (denormal) {
-        ieee_ex |= float_flag_underflow;
+        ieee_exception_flags |= float_flag_underflow;
+    }
+    if (ieee_exception_flags) {
+        mips_exception_flags = ieee_to_mips_xcpt_msa(ieee_exception_flags);
     }
-
-    c = ieee_ex_to_mips(ieee_ex);
     enable = GET_FP_ENABLE(env->active_tc.msacsr) | FP_UNIMPLEMENTED;
 
     /* Set Inexact (I) when flushing inputs to zero */
-    if ((ieee_ex & float_flag_input_denormal) &&
+    if ((ieee_exception_flags & float_flag_input_denormal) &&
             (env->active_tc.msacsr & MSACSR_FS_MASK) != 0) {
         if (action & CLEAR_IS_INEXACT) {
-            c &= ~FP_INEXACT;
+            mips_exception_flags &= ~FP_INEXACT;
         } else {
-            c |=  FP_INEXACT;
+            mips_exception_flags |= FP_INEXACT;
         }
     }
 
     /* Set Inexact (I) and Underflow (U) when flushing outputs to zero */
-    if ((ieee_ex & float_flag_output_denormal) &&
+    if ((ieee_exception_flags & float_flag_output_denormal) &&
             (env->active_tc.msacsr & MSACSR_FS_MASK) != 0) {
-        c |= FP_INEXACT;
+        mips_exception_flags |= FP_INEXACT;
         if (action & CLEAR_FS_UNDERFLOW) {
-            c &= ~FP_UNDERFLOW;
+            mips_exception_flags &= ~FP_UNDERFLOW;
         } else {
-            c |=  FP_UNDERFLOW;
+            mips_exception_flags |= FP_UNDERFLOW;
         }
     }
 
     /* Set Inexact (I) when Overflow (O) is not enabled */
-    if ((c & FP_OVERFLOW) != 0 && (enable & FP_OVERFLOW) == 0) {
-        c |= FP_INEXACT;
+    if ((mips_exception_flags & FP_OVERFLOW) != 0 &&
+           (enable & FP_OVERFLOW) == 0) {
+        mips_exception_flags |= FP_INEXACT;
     }
 
     /* Clear Exact Underflow when Underflow (U) is not enabled */
-    if ((c & FP_UNDERFLOW) != 0 && (enable & FP_UNDERFLOW) == 0 &&
-            (c & FP_INEXACT) == 0) {
-        c &= ~FP_UNDERFLOW;
+    if ((mips_exception_flags & FP_UNDERFLOW) != 0 &&
+           (enable & FP_UNDERFLOW) == 0 &&
+           (mips_exception_flags & FP_INEXACT) == 0) {
+        mips_exception_flags &= ~FP_UNDERFLOW;
     }
 
     /*
@@ -5474,11 +5501,11 @@ static inline int update_msacsr(CPUMIPSState *env, int action, int denormal)
      * divide by zero
      */
     if ((action & RECIPROCAL_INEXACT) &&
-            (c & (FP_INVALID | FP_DIV0)) == 0) {
-        c = FP_INEXACT;
+            (mips_exception_flags & (FP_INVALID | FP_DIV0)) == 0) {
+        mips_exception_flags = FP_INEXACT;
     }
 
-    cause = c & enable;    /* all current enabled exceptions */
+    cause = mips_exception_flags & enable; /* all current enabled exceptions */
 
     if (cause == 0) {
         /*
@@ -5486,7 +5513,7 @@ static inline int update_msacsr(CPUMIPSState *env, int action, int denormal)
          * with all current exceptions
          */
         SET_FP_CAUSE(env->active_tc.msacsr,
-                (GET_FP_CAUSE(env->active_tc.msacsr) | c));
+            (GET_FP_CAUSE(env->active_tc.msacsr) | mips_exception_flags));
     } else {
         /* Current exceptions are enabled */
         if ((env->active_tc.msacsr & MSACSR_NX_MASK) == 0) {
@@ -5495,11 +5522,11 @@ static inline int update_msacsr(CPUMIPSState *env, int action, int denormal)
              * with all enabled exceptions
              */
             SET_FP_CAUSE(env->active_tc.msacsr,
-                    (GET_FP_CAUSE(env->active_tc.msacsr) | c));
+                (GET_FP_CAUSE(env->active_tc.msacsr) | mips_exception_flags));
         }
     }
 
-    return c;
+    return mips_exception_flags;
 }
 
 static inline int get_enabled_exceptions(const CPUMIPSState *env, int c)
-- 
2.20.1


