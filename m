Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E817C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:47:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC10C206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UldmjPRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC10C206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIqw-0003hI-To
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtIS7-0002rB-GL
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:22:07 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:55963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtIS3-00017v-J7
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:22:07 -0400
Received: by mail-pj1-x1044.google.com with SMTP id ch3so174656pjb.5
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 15:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jygA66HJUudgdktoH8LBPEhgWsxA1ZK1b+i4DCvQfZw=;
 b=UldmjPRLbfBkz+NT9Zt7tsnPM+CIc/2I6GkB7sZZkcD2o1sQOC8YksZ+dq4EOq0AgL
 fPZpgtQmj265DK0I7oOO+pB96UQOoaJN3SvZoKhiRCsfCyfGCBf5ZSadmiWDFQfC7QzA
 KNY12FFaQgOgQZYdN7kTcEPUVjT+5mS/3utwlBJ+gTTUzvZZgf7emqP+G1Gz+vQOKkr3
 4X53lPDX5GhPzI5+Inl/3ZXQUV9oTz0nFMgVHhzYvyl+d9uBXqUhIeeP6MALd/nVFhX4
 dM6MNI2huyFwc6v+s98NVaadPHfmFGco0F4Z+g4VU0JhzY6oo6eEB5dTq6wNQonccg4o
 hw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jygA66HJUudgdktoH8LBPEhgWsxA1ZK1b+i4DCvQfZw=;
 b=VwD0XGtB9a6qVtGMyCxZ4CsPB3CKXJ1DMcQz/ukutKxsIQ1kXFk0u3t7h70aJ0K8Kr
 P3aXpFMc9mGMVSMv5n8SjAY4IHqhUITz5TGjqZqvNAHDifa6rB7P6yasJQmfgX8yTDpp
 BQYkfhgIUmIJoLdmWYQ5d/gc1GQrqR4x+YezVDN6Zm0ooBTTf0Fvxa8yj2YnXkOOhBQz
 xLTNqdyPuC0jQ/oLo9S2vF2EQT+Runm6sHvZTgZ/96RunNbWXB0T8NfRyvHTZYe6mcgN
 Y30mBX99GvNzGGK/xfTW+bMBdtrm98MNoJf5kLDTo8TSz/VKLyeROb2iKI9cfJZESpwT
 HRuA==
X-Gm-Message-State: AOAM532KUr5mtU2k4uNoAznAYRG/Ke59X/P1/VdYjMVJ61ee6H+4XYRJ
 MuP9SkMjyigLMUckFzaBo6kHHO9T
X-Google-Smtp-Source: ABdhPJyxURL4CweB1kEfB9OBQyWSwnXVJInA5BMv9VWXis3ubcww4HcvN2GWbH0yOAQ1RQTrPGub+g==
X-Received: by 2002:a17:902:b492:: with SMTP id
 y18mr18221359plr.61.1594246921229; 
 Wed, 08 Jul 2020 15:22:01 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id t73sm693517pfc.78.2020.07.08.15.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 15:22:00 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/21] target/xtensa: add DFP option, registers and opcodes
Date: Wed,  8 Jul 2020 15:20:49 -0700
Message-Id: <20200708222101.24568-10-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200708222101.24568-1-jcmvbkbc@gmail.com>
References: <20200708222101.24568-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DFPU may be configured with 32-bit or with 64-bit registers. Xtensa ISA
does not specify how single-precision values are stored in 64-bit
registers. Existing implementations store them in the low half of the
registers.
Add value extraction and write back to single-precision opcodes.
Add new double precision opcodes. Add 64-bit register file.
Add 64-bit values dumping to the xtensa_cpu_dump_state.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.c          |    4 +
 target/xtensa/cpu.h          |    4 +
 target/xtensa/fpu_helper.c   |  252 +++++++-
 target/xtensa/helper.h       |   29 +-
 target/xtensa/overlay_tool.h |    6 +
 target/xtensa/translate.c    | 1088 ++++++++++++++++++++++++++++++++--
 6 files changed, 1338 insertions(+), 45 deletions(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 82c2ee0679f8..5abf3b6f994b 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -31,6 +31,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "fpu/softfloat.h"
 #include "qemu/module.h"
 #include "migration/vmstate.h"
 
@@ -104,6 +105,9 @@ static void xtensa_cpu_reset(DeviceState *dev)
     reset_mmu(env);
     s->halted = env->runstall;
 #endif
+    if (!xtensa_option_enabled(env->config, XTENSA_OPTION_DFP_COPROCESSOR)) {
+        set_no_signaling_nans(true, &env->fp_status);
+    }
 }
 
 static ObjectClass *xtensa_cpu_class_by_name(const char *cpu_model)
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 960f6573447f..76f596922ae6 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -52,6 +52,7 @@ enum {
     XTENSA_OPTION_COPROCESSOR,
     XTENSA_OPTION_BOOLEAN,
     XTENSA_OPTION_FP_COPROCESSOR,
+    XTENSA_OPTION_DFP_COPROCESSOR,
     XTENSA_OPTION_MP_SYNCHRO,
     XTENSA_OPTION_CONDITIONAL_STORE,
     XTENSA_OPTION_ATOMCTL,
@@ -420,6 +421,7 @@ typedef struct XtensaOpcodeTranslators {
 
 extern const XtensaOpcodeTranslators xtensa_core_opcodes;
 extern const XtensaOpcodeTranslators xtensa_fpu2000_opcodes;
+extern const XtensaOpcodeTranslators xtensa_fpu_opcodes;
 
 struct XtensaConfig {
     const char *name;
@@ -482,6 +484,8 @@ struct XtensaConfig {
     unsigned n_mpu_fg_segments;
     unsigned n_mpu_bg_segments;
     const xtensa_mpu_entry *mpu_bg;
+
+    bool use_first_nan;
 };
 
 typedef struct XtensaConfigList {
diff --git a/target/xtensa/fpu_helper.c b/target/xtensa/fpu_helper.c
index fae6836d3223..514b888b3d9a 100644
--- a/target/xtensa/fpu_helper.c
+++ b/target/xtensa/fpu_helper.c
@@ -33,6 +33,30 @@
 #include "exec/exec-all.h"
 #include "fpu/softfloat.h"
 
+enum {
+    XTENSA_FP_I = 0x1,
+    XTENSA_FP_U = 0x2,
+    XTENSA_FP_O = 0x4,
+    XTENSA_FP_Z = 0x8,
+    XTENSA_FP_V = 0x10,
+};
+
+enum {
+    XTENSA_FCR_FLAGS_SHIFT = 2,
+    XTENSA_FSR_FLAGS_SHIFT = 7,
+};
+
+static const struct {
+    uint32_t xtensa_fp_flag;
+    int softfloat_fp_flag;
+} xtensa_fp_flag_map[] = {
+    { XTENSA_FP_I, float_flag_inexact, },
+    { XTENSA_FP_U, float_flag_underflow, },
+    { XTENSA_FP_O, float_flag_overflow, },
+    { XTENSA_FP_Z, float_flag_divbyzero, },
+    { XTENSA_FP_V, float_flag_invalid, },
+};
+
 void HELPER(wur_fpu2k_fcr)(CPUXtensaState *env, uint32_t v)
 {
     static const int rounding_mode[] = {
@@ -46,64 +70,215 @@ void HELPER(wur_fpu2k_fcr)(CPUXtensaState *env, uint32_t v)
     set_float_rounding_mode(rounding_mode[v & 3], &env->fp_status);
 }
 
+void HELPER(wur_fpu_fcr)(CPUXtensaState *env, uint32_t v)
+{
+    static const int rounding_mode[] = {
+        float_round_nearest_even,
+        float_round_to_zero,
+        float_round_up,
+        float_round_down,
+    };
+
+    if (v & 0xfffff000) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "MBZ field of FCR is written non-zero: %08x\n", v);
+    }
+    env->uregs[FCR] = v & 0x0000007f;
+    set_float_rounding_mode(rounding_mode[v & 3], &env->fp_status);
+}
+
+void HELPER(wur_fpu_fsr)(CPUXtensaState *env, uint32_t v)
+{
+    uint32_t flags = v >> XTENSA_FSR_FLAGS_SHIFT;
+    int fef = 0;
+    unsigned i;
+
+    if (v & 0xfffff000) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "MBZ field of FSR is written non-zero: %08x\n", v);
+    }
+    env->uregs[FSR] = v & 0x00000f80;
+    for (i = 0; i < ARRAY_SIZE(xtensa_fp_flag_map); ++i) {
+        if (flags & xtensa_fp_flag_map[i].xtensa_fp_flag) {
+            fef |= xtensa_fp_flag_map[i].softfloat_fp_flag;
+        }
+    }
+    set_float_exception_flags(fef, &env->fp_status);
+}
+
+uint32_t HELPER(rur_fpu_fsr)(CPUXtensaState *env)
+{
+    uint32_t flags = 0;
+    int fef = get_float_exception_flags(&env->fp_status);
+    unsigned i;
+
+    for (i = 0; i < ARRAY_SIZE(xtensa_fp_flag_map); ++i) {
+        if (fef & xtensa_fp_flag_map[i].softfloat_fp_flag) {
+            flags |= xtensa_fp_flag_map[i].xtensa_fp_flag;
+        }
+    }
+    env->uregs[FSR] = flags << XTENSA_FSR_FLAGS_SHIFT;
+    return flags << XTENSA_FSR_FLAGS_SHIFT;
+}
+
+float64 HELPER(abs_d)(float64 v)
+{
+    return float64_abs(v);
+}
+
 float32 HELPER(abs_s)(float32 v)
 {
     return float32_abs(v);
 }
 
+float64 HELPER(neg_d)(float64 v)
+{
+    return float64_chs(v);
+}
+
 float32 HELPER(neg_s)(float32 v)
 {
     return float32_chs(v);
 }
 
+float64 HELPER(add_d)(CPUXtensaState *env, float64 a, float64 b)
+{
+    set_use_first_nan(true, &env->fp_status);
+    return float64_add(a, b, &env->fp_status);
+}
+
 float32 HELPER(add_s)(CPUXtensaState *env, float32 a, float32 b)
 {
+    set_use_first_nan(env->config->use_first_nan, &env->fp_status);
     return float32_add(a, b, &env->fp_status);
 }
 
+float64 HELPER(sub_d)(CPUXtensaState *env, float64 a, float64 b)
+{
+    set_use_first_nan(true, &env->fp_status);
+    return float64_sub(a, b, &env->fp_status);
+}
+
 float32 HELPER(sub_s)(CPUXtensaState *env, float32 a, float32 b)
 {
+    set_use_first_nan(env->config->use_first_nan, &env->fp_status);
     return float32_sub(a, b, &env->fp_status);
 }
 
+float64 HELPER(mul_d)(CPUXtensaState *env, float64 a, float64 b)
+{
+    set_use_first_nan(true, &env->fp_status);
+    return float64_mul(a, b, &env->fp_status);
+}
+
 float32 HELPER(mul_s)(CPUXtensaState *env, float32 a, float32 b)
 {
+    set_use_first_nan(env->config->use_first_nan, &env->fp_status);
     return float32_mul(a, b, &env->fp_status);
 }
 
+float64 HELPER(madd_d)(CPUXtensaState *env, float64 a, float64 b, float64 c)
+{
+    set_use_first_nan(env->config->use_first_nan, &env->fp_status);
+    return float64_muladd(b, c, a, 0, &env->fp_status);
+}
+
 float32 HELPER(madd_s)(CPUXtensaState *env, float32 a, float32 b, float32 c)
 {
+    set_use_first_nan(env->config->use_first_nan, &env->fp_status);
     return float32_muladd(b, c, a, 0, &env->fp_status);
 }
 
+float64 HELPER(msub_d)(CPUXtensaState *env, float64 a, float64 b, float64 c)
+{
+    set_use_first_nan(env->config->use_first_nan, &env->fp_status);
+    return float64_muladd(b, c, a, float_muladd_negate_product,
+                          &env->fp_status);
+}
+
 float32 HELPER(msub_s)(CPUXtensaState *env, float32 a, float32 b, float32 c)
 {
+    set_use_first_nan(env->config->use_first_nan, &env->fp_status);
     return float32_muladd(b, c, a, float_muladd_negate_product,
                           &env->fp_status);
 }
 
-uint32_t HELPER(ftoi_s)(float32 v, uint32_t rounding_mode, uint32_t scale)
+uint32_t HELPER(ftoi_d)(CPUXtensaState *env, float64 v,
+                        uint32_t rounding_mode, uint32_t scale)
+{
+    float_status fp_status = env->fp_status;
+    uint32_t res;
+
+    set_float_rounding_mode(rounding_mode, &fp_status);
+    res = float64_to_int32(float64_scalbn(v, scale, &fp_status), &fp_status);
+    set_float_exception_flags(get_float_exception_flags(&fp_status),
+                              &env->fp_status);
+    return res;
+}
+
+uint32_t HELPER(ftoi_s)(CPUXtensaState *env, float32 v,
+                        uint32_t rounding_mode, uint32_t scale)
 {
-    float_status fp_status = {0};
+    float_status fp_status = env->fp_status;
+    uint32_t res;
 
     set_float_rounding_mode(rounding_mode, &fp_status);
-    return float32_to_int32(float32_scalbn(v, scale, &fp_status), &fp_status);
+    res = float32_to_int32(float32_scalbn(v, scale, &fp_status), &fp_status);
+    set_float_exception_flags(get_float_exception_flags(&fp_status),
+                              &env->fp_status);
+    return res;
 }
 
-uint32_t HELPER(ftoui_s)(float32 v, uint32_t rounding_mode, uint32_t scale)
+uint32_t HELPER(ftoui_d)(CPUXtensaState *env, float64 v,
+                         uint32_t rounding_mode, uint32_t scale)
 {
-    float_status fp_status = {0};
+    float_status fp_status = env->fp_status;
+    float64 res;
+    uint32_t rv;
+
+    set_float_rounding_mode(rounding_mode, &fp_status);
+
+    res = float64_scalbn(v, scale, &fp_status);
+
+    if (float64_is_neg(v) && !float64_is_any_nan(v)) {
+        set_float_exception_flags(float_flag_invalid, &fp_status);
+        rv = float64_to_int32(res, &fp_status);
+    } else {
+        rv = float64_to_uint32(res, &fp_status);
+    }
+    set_float_exception_flags(get_float_exception_flags(&fp_status),
+                              &env->fp_status);
+    return rv;
+}
+
+uint32_t HELPER(ftoui_s)(CPUXtensaState *env, float32 v,
+                         uint32_t rounding_mode, uint32_t scale)
+{
+    float_status fp_status = env->fp_status;
     float32 res;
+    uint32_t rv;
 
     set_float_rounding_mode(rounding_mode, &fp_status);
 
     res = float32_scalbn(v, scale, &fp_status);
 
     if (float32_is_neg(v) && !float32_is_any_nan(v)) {
-        return float32_to_int32(res, &fp_status);
+        rv = float32_to_int32(res, &fp_status);
+        if (rv) {
+            set_float_exception_flags(float_flag_invalid, &fp_status);
+        }
     } else {
-        return float32_to_uint32(res, &fp_status);
+        rv = float32_to_uint32(res, &fp_status);
     }
+    set_float_exception_flags(get_float_exception_flags(&fp_status),
+                              &env->fp_status);
+    return rv;
+}
+
+float64 HELPER(itof_d)(CPUXtensaState *env, uint32_t v, uint32_t scale)
+{
+    return float64_scalbn(int32_to_float64(v, &env->fp_status),
+                          (int32_t)scale, &env->fp_status);
 }
 
 float32 HELPER(itof_s)(CPUXtensaState *env, uint32_t v, uint32_t scale)
@@ -112,22 +287,56 @@ float32 HELPER(itof_s)(CPUXtensaState *env, uint32_t v, uint32_t scale)
                           (int32_t)scale, &env->fp_status);
 }
 
+float64 HELPER(uitof_d)(CPUXtensaState *env, uint32_t v, uint32_t scale)
+{
+    return float64_scalbn(uint32_to_float64(v, &env->fp_status),
+                          (int32_t)scale, &env->fp_status);
+}
+
 float32 HELPER(uitof_s)(CPUXtensaState *env, uint32_t v, uint32_t scale)
 {
     return float32_scalbn(uint32_to_float32(v, &env->fp_status),
                           (int32_t)scale, &env->fp_status);
 }
 
+float64 HELPER(cvtd_s)(CPUXtensaState *env, float32 v)
+{
+    return float32_to_float64(v, &env->fp_status);
+}
+
+float32 HELPER(cvts_d)(CPUXtensaState *env, float64 v)
+{
+    return float64_to_float32(v, &env->fp_status);
+}
+
+uint32_t HELPER(un_d)(CPUXtensaState *env, float64 a, float64 b)
+{
+    return float64_unordered_quiet(a, b, &env->fp_status);
+}
+
 uint32_t HELPER(un_s)(CPUXtensaState *env, float32 a, float32 b)
 {
     return float32_unordered_quiet(a, b, &env->fp_status);
 }
 
+uint32_t HELPER(oeq_d)(CPUXtensaState *env, float64 a, float64 b)
+{
+    return float64_eq_quiet(a, b, &env->fp_status);
+}
+
 uint32_t HELPER(oeq_s)(CPUXtensaState *env, float32 a, float32 b)
 {
     return float32_eq_quiet(a, b, &env->fp_status);
 }
 
+uint32_t HELPER(ueq_d)(CPUXtensaState *env, float64 a, float64 b)
+{
+    FloatRelation v = float64_compare_quiet(a, b, &env->fp_status);
+
+    return v == float_relation_equal ||
+           v == float_relation_unordered;
+}
+
 uint32_t HELPER(ueq_s)(CPUXtensaState *env, float32 a, float32 b)
 {
     FloatRelation v = float32_compare_quiet(a, b, &env->fp_status);
@@ -136,9 +345,22 @@ uint32_t HELPER(ueq_s)(CPUXtensaState *env, float32 a, float32 b)
            v == float_relation_unordered;
 }
 
+uint32_t HELPER(olt_d)(CPUXtensaState *env, float64 a, float64 b)
+{
+    return float64_lt(a, b, &env->fp_status);
+}
+
 uint32_t HELPER(olt_s)(CPUXtensaState *env, float32 a, float32 b)
 {
-    return float32_lt_quiet(a, b, &env->fp_status);
+    return float32_lt(a, b, &env->fp_status);
+}
+
+uint32_t HELPER(ult_d)(CPUXtensaState *env, float64 a, float64 b)
+{
+    FloatRelation v = float64_compare_quiet(a, b, &env->fp_status);
+
+    return v == float_relation_less ||
+           v == float_relation_unordered;
 }
 
 uint32_t HELPER(ult_s)(CPUXtensaState *env, float32 a, float32 b)
@@ -149,9 +371,21 @@ uint32_t HELPER(ult_s)(CPUXtensaState *env, float32 a, float32 b)
            v == float_relation_unordered;
 }
 
+uint32_t HELPER(ole_d)(CPUXtensaState *env, float64 a, float64 b)
+{
+    return float64_le(a, b, &env->fp_status);
+}
+
 uint32_t HELPER(ole_s)(CPUXtensaState *env, float32 a, float32 b)
 {
-    return float32_le_quiet(a, b, &env->fp_status);
+    return float32_le(a, b, &env->fp_status);
+}
+
+uint32_t HELPER(ule_d)(CPUXtensaState *env, float64 a, float64 b)
+{
+    FloatRelation v = float64_compare_quiet(a, b, &env->fp_status);
+
+    return v != float_relation_greater;
 }
 
 uint32_t HELPER(ule_s)(CPUXtensaState *env, float32 a, float32 b)
diff --git a/target/xtensa/helper.h b/target/xtensa/helper.h
index bbada1c0b864..a328af47cd31 100644
--- a/target/xtensa/helper.h
+++ b/target/xtensa/helper.h
@@ -54,10 +54,11 @@ DEF_HELPER_3(sub_s, f32, env, f32, f32)
 DEF_HELPER_3(mul_s, f32, env, f32, f32)
 DEF_HELPER_4(madd_s, f32, env, f32, f32, f32)
 DEF_HELPER_4(msub_s, f32, env, f32, f32, f32)
-DEF_HELPER_FLAGS_3(ftoi_s, TCG_CALL_NO_RWG_SE, i32, f32, i32, i32)
-DEF_HELPER_FLAGS_3(ftoui_s, TCG_CALL_NO_RWG_SE, i32, f32, i32, i32)
+DEF_HELPER_4(ftoi_s, i32, env, f32, i32, i32)
+DEF_HELPER_4(ftoui_s, i32, env, f32, i32, i32)
 DEF_HELPER_3(itof_s, f32, env, i32, i32)
 DEF_HELPER_3(uitof_s, f32, env, i32, i32)
+DEF_HELPER_2(cvtd_s, f64, env, f32)
 
 DEF_HELPER_3(un_s,  i32, env, f32, f32)
 DEF_HELPER_3(oeq_s, i32, env, f32, f32)
@@ -67,5 +68,29 @@ DEF_HELPER_3(ult_s, i32, env, f32, f32)
 DEF_HELPER_3(ole_s, i32, env, f32, f32)
 DEF_HELPER_3(ule_s, i32, env, f32, f32)
 
+DEF_HELPER_2(wur_fpu_fcr, void, env, i32)
+DEF_HELPER_1(rur_fpu_fsr, i32, env)
+DEF_HELPER_2(wur_fpu_fsr, void, env, i32)
+DEF_HELPER_FLAGS_1(abs_d, TCG_CALL_NO_RWG_SE, f64, f64)
+DEF_HELPER_FLAGS_1(neg_d, TCG_CALL_NO_RWG_SE, f64, f64)
+DEF_HELPER_3(add_d, f64, env, f64, f64)
+DEF_HELPER_3(sub_d, f64, env, f64, f64)
+DEF_HELPER_3(mul_d, f64, env, f64, f64)
+DEF_HELPER_4(madd_d, f64, env, f64, f64, f64)
+DEF_HELPER_4(msub_d, f64, env, f64, f64, f64)
+DEF_HELPER_4(ftoi_d, i32, env, f64, i32, i32)
+DEF_HELPER_4(ftoui_d, i32, env, f64, i32, i32)
+DEF_HELPER_3(itof_d, f64, env, i32, i32)
+DEF_HELPER_3(uitof_d, f64, env, i32, i32)
+DEF_HELPER_2(cvts_d, f32, env, f64)
+
+DEF_HELPER_3(un_d,  i32, env, f64, f64)
+DEF_HELPER_3(oeq_d, i32, env, f64, f64)
+DEF_HELPER_3(ueq_d, i32, env, f64, f64)
+DEF_HELPER_3(olt_d, i32, env, f64, f64)
+DEF_HELPER_3(ult_d, i32, env, f64, f64)
+DEF_HELPER_3(ole_d, i32, env, f64, f64)
+DEF_HELPER_3(ule_d, i32, env, f64, f64)
+
 DEF_HELPER_2(rer, i32, env, i32)
 DEF_HELPER_3(wer, void, env, i32, i32)
diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
index eb9f08af0bf6..a41f336d0843 100644
--- a/target/xtensa/overlay_tool.h
+++ b/target/xtensa/overlay_tool.h
@@ -39,6 +39,10 @@
 #define XCHAL_HAVE_DEPBITS 0
 #endif
 
+#ifndef XCHAL_HAVE_DFP
+#define XCHAL_HAVE_DFP 0
+#endif
+
 #ifndef XCHAL_HAVE_DIV32
 #define XCHAL_HAVE_DIV32 0
 #endif
@@ -99,6 +103,7 @@
     XCHAL_OPTION(XCHAL_HAVE_CP, XTENSA_OPTION_COPROCESSOR) | \
     XCHAL_OPTION(XCHAL_HAVE_BOOLEANS, XTENSA_OPTION_BOOLEAN) | \
     XCHAL_OPTION(XCHAL_HAVE_FP, XTENSA_OPTION_FP_COPROCESSOR) | \
+    XCHAL_OPTION(XCHAL_HAVE_DFP, XTENSA_OPTION_DFP_COPROCESSOR) | \
     XCHAL_OPTION(XCHAL_HAVE_RELEASE_SYNC, XTENSA_OPTION_MP_SYNCHRO) | \
     XCHAL_OPTION(XCHAL_HAVE_S32C1I, XTENSA_OPTION_CONDITIONAL_STORE) | \
     XCHAL_OPTION(((XCHAL_HAVE_S32C1I && XCHAL_HW_VERSION >= 230000) || \
@@ -515,6 +520,7 @@
     .ndepc = (XCHAL_XEA_VERSION >= 2), \
     .inst_fetch_width = XCHAL_INST_FETCH_WIDTH, \
     .max_insn_size = XCHAL_MAX_INSTRUCTION_SIZE, \
+    .use_first_nan = !XCHAL_HAVE_DFP, \
     EXCEPTIONS_SECTION, \
     INTERRUPTS_SECTION, \
     TLB_SECTION, \
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 85bd63dffc9f..ab83e259917a 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -79,6 +79,7 @@ struct DisasContext {
 static TCGv_i32 cpu_pc;
 static TCGv_i32 cpu_R[16];
 static TCGv_i32 cpu_FR[16];
+static TCGv_i64 cpu_FRD[16];
 static TCGv_i32 cpu_MR[4];
 static TCGv_i32 cpu_BR[16];
 static TCGv_i32 cpu_BR4[4];
@@ -169,6 +170,13 @@ void xtensa_translate_init(void)
                                            fregnames[i]);
     }
 
+    for (i = 0; i < 16; i++) {
+        cpu_FRD[i] = tcg_global_mem_new_i64(cpu_env,
+                                            offsetof(CPUXtensaState,
+                                                     fregs[i].f64),
+                                            fregnames[i]);
+    }
+
     for (i = 0; i < 4; i++) {
         cpu_MR[i] = tcg_global_mem_new_i32(cpu_env,
                                            offsetof(CPUXtensaState,
@@ -251,6 +259,8 @@ void **xtensa_get_regfile_by_name(const char *name, int entries, int bits)
 
         g_hash_table_insert(xtensa_regfile_table,
                             (void *)"FR 16x32", (void *)cpu_FR);
+        g_hash_table_insert(xtensa_regfile_table,
+                            (void *)"FR 16x64", (void *)cpu_FRD);
 
         g_hash_table_insert(xtensa_regfile_table,
                             (void *)"BR 16x1", (void *)cpu_BR);
@@ -1398,12 +1408,24 @@ void xtensa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         qemu_fprintf(f, "\n");
 
         for (i = 0; i < 16; ++i) {
-            qemu_fprintf(f, "F%02d=%08x (%+10.8e)%c", i,
+            qemu_fprintf(f, "F%02d=%08x (%-+15.8e)%c", i,
                          float32_val(env->fregs[i].f32[FP_F32_LOW]),
                          *(float *)(env->fregs[i].f32 + FP_F32_LOW),
                          (i % 2) == 1 ? '\n' : ' ');
         }
     }
+
+    if ((flags & CPU_DUMP_FPU) &&
+        xtensa_option_enabled(env->config, XTENSA_OPTION_DFP_COPROCESSOR)) {
+        qemu_fprintf(f, "\n");
+
+        for (i = 0; i < 16; ++i) {
+            qemu_fprintf(f, "F%02d=%016"PRIx64" (%-+24.16le)%c", i,
+                         float64_val(env->fregs[i].f64),
+                         *(double *)(&env->fregs[i].f64),
+                         (i % 2) == 1 ? '\n' : ' ');
+        }
+    }
 }
 
 void restore_state_to_opc(CPUXtensaState *env, TranslationBlock *tb,
@@ -6293,17 +6315,154 @@ const XtensaOpcodeTranslators xtensa_core_opcodes = {
 };
 
 
+static inline void get_f32_o1_i3(const OpcodeArg *arg, OpcodeArg *arg32,
+                                 int o0, int i0, int i1, int i2)
+{
+    if ((i0 >= 0 && arg[i0].num_bits == 64) ||
+        (o0 >= 0 && arg[o0].num_bits == 64)) {
+        if (o0 >= 0) {
+            arg32[o0].out = tcg_temp_new_i32();
+        }
+        if (i0 >= 0) {
+            arg32[i0].in = tcg_temp_new_i32();
+            tcg_gen_extrl_i64_i32(arg32[i0].in, arg[i0].in);
+        }
+        if (i1 >= 0) {
+            arg32[i1].in = tcg_temp_new_i32();
+            tcg_gen_extrl_i64_i32(arg32[i1].in, arg[i1].in);
+        }
+        if (i2 >= 0) {
+            arg32[i2].in = tcg_temp_new_i32();
+            tcg_gen_extrl_i64_i32(arg32[i2].in, arg[i2].in);
+        }
+    } else {
+        if (o0 >= 0) {
+            arg32[o0].out = arg[o0].out;
+        }
+        if (i0 >= 0) {
+            arg32[i0].in = arg[i0].in;
+        }
+        if (i1 >= 0) {
+            arg32[i1].in = arg[i1].in;
+        }
+        if (i2 >= 0) {
+            arg32[i2].in = arg[i2].in;
+        }
+    }
+}
+
+static inline void put_f32_o1_i3(const OpcodeArg *arg, const OpcodeArg *arg32,
+                                 int o0, int i0, int i1, int i2)
+{
+    if ((i0 >= 0 && arg[i0].num_bits == 64) ||
+        (o0 >= 0 && arg[o0].num_bits == 64)) {
+        if (o0 >= 0) {
+            tcg_gen_extu_i32_i64(arg[o0].out, arg32[o0].out);
+            tcg_temp_free_i32(arg32[o0].out);
+        }
+        if (i0 >= 0) {
+            tcg_temp_free_i32(arg32[i0].in);
+        }
+        if (i1 >= 0) {
+            tcg_temp_free_i32(arg32[i1].in);
+        }
+        if (i2 >= 0) {
+            tcg_temp_free_i32(arg32[i2].in);
+        }
+    }
+}
+
+static inline void get_f32_o1_i2(const OpcodeArg *arg, OpcodeArg *arg32,
+                                 int o0, int i0, int i1)
+{
+    get_f32_o1_i3(arg, arg32, o0, i0, i1, -1);
+}
+
+static inline void put_f32_o1_i2(const OpcodeArg *arg, const OpcodeArg *arg32,
+                                 int o0, int i0, int i1)
+{
+    put_f32_o1_i3(arg, arg32, o0, i0, i1, -1);
+}
+
+static inline void get_f32_o1_i1(const OpcodeArg *arg, OpcodeArg *arg32,
+                                 int o0, int i0)
+{
+    get_f32_o1_i2(arg, arg32, o0, i0, -1);
+}
+
+static inline void put_f32_o1_i1(const OpcodeArg *arg, const OpcodeArg *arg32,
+                                 int o0, int i0)
+{
+    put_f32_o1_i2(arg, arg32, o0, i0, -1);
+}
+
+static inline void get_f32_o1(const OpcodeArg *arg, OpcodeArg *arg32,
+                              int o0)
+{
+    get_f32_o1_i1(arg, arg32, o0, -1);
+}
+
+static inline void put_f32_o1(const OpcodeArg *arg, const OpcodeArg *arg32,
+                              int o0)
+{
+    put_f32_o1_i1(arg, arg32, o0, -1);
+}
+
+static inline void get_f32_i2(const OpcodeArg *arg, OpcodeArg *arg32,
+                              int i0, int i1)
+{
+    get_f32_o1_i2(arg, arg32, -1, i0, i1);
+}
+
+static inline void put_f32_i2(const OpcodeArg *arg, const OpcodeArg *arg32,
+                              int i0, int i1)
+{
+    put_f32_o1_i2(arg, arg32, -1, i0, i1);
+}
+
+static inline void get_f32_i1(const OpcodeArg *arg, OpcodeArg *arg32,
+                              int i0)
+{
+    get_f32_i2(arg, arg32, i0, -1);
+}
+
+static inline void put_f32_i1(const OpcodeArg *arg, const OpcodeArg *arg32,
+                              int i0)
+{
+    put_f32_i2(arg, arg32, i0, -1);
+}
+
+
+static void translate_abs_d(DisasContext *dc, const OpcodeArg arg[],
+                            const uint32_t par[])
+{
+    gen_helper_abs_d(arg[0].out, arg[1].in);
+}
+
 static void translate_abs_s(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
-    gen_helper_abs_s(arg[0].out, arg[1].in);
+    OpcodeArg arg32[2];
+
+    get_f32_o1_i1(arg, arg32, 0, 1);
+    gen_helper_abs_s(arg32[0].out, arg32[1].in);
+    put_f32_o1_i1(arg, arg32, 0, 1);
 }
 
-static void translate_add_s(DisasContext *dc, const OpcodeArg arg[],
+static void translate_add_d(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
-    gen_helper_add_s(arg[0].out, cpu_env,
-                     arg[1].in, arg[2].in);
+    gen_helper_add_d(arg[0].out, cpu_env, arg[1].in, arg[2].in);
+}
+
+static void translate_add_s(DisasContext *dc, const OpcodeArg arg[],
+                                const uint32_t par[])
+{
+    OpcodeArg arg32[3];
+
+    get_f32_o1_i2(arg, arg32, 0, 1, 2);
+    gen_helper_add_s(arg32[0].out, cpu_env, arg32[1].in, arg32[2].in);
+    put_f32_o1_i2(arg, arg32, 0, 1, 2);
 }
 
 enum {
@@ -6316,6 +6475,37 @@ enum {
     COMPARE_ULE,
 };
 
+static void translate_compare_d(DisasContext *dc, const OpcodeArg arg[],
+                                const uint32_t par[])
+{
+    static void (* const helper[])(TCGv_i32 res, TCGv_env env,
+                                   TCGv_i64 s, TCGv_i64 t) = {
+        [COMPARE_UN] = gen_helper_un_d,
+        [COMPARE_OEQ] = gen_helper_oeq_d,
+        [COMPARE_UEQ] = gen_helper_ueq_d,
+        [COMPARE_OLT] = gen_helper_olt_d,
+        [COMPARE_ULT] = gen_helper_ult_d,
+        [COMPARE_OLE] = gen_helper_ole_d,
+        [COMPARE_ULE] = gen_helper_ule_d,
+    };
+    TCGv_i32 zero = tcg_const_i32(0);
+    TCGv_i32 res = tcg_temp_new_i32();
+    TCGv_i32 set_br = tcg_temp_new_i32();
+    TCGv_i32 clr_br = tcg_temp_new_i32();
+
+    tcg_gen_ori_i32(set_br, arg[0].in, 1 << arg[0].imm);
+    tcg_gen_andi_i32(clr_br, arg[0].in, ~(1 << arg[0].imm));
+
+    helper[par[0]](res, cpu_env, arg[1].in, arg[2].in);
+    tcg_gen_movcond_i32(TCG_COND_NE,
+                        arg[0].out, res, zero,
+                        set_br, clr_br);
+    tcg_temp_free(zero);
+    tcg_temp_free(res);
+    tcg_temp_free(set_br);
+    tcg_temp_free(clr_br);
+}
+
 static void translate_compare_s(DisasContext *dc, const OpcodeArg arg[],
                                 const uint32_t par[])
 {
@@ -6329,6 +6519,7 @@ static void translate_compare_s(DisasContext *dc, const OpcodeArg arg[],
         [COMPARE_OLE] = gen_helper_ole_s,
         [COMPARE_ULE] = gen_helper_ule_s,
     };
+    OpcodeArg arg32[3];
     TCGv_i32 zero = tcg_const_i32(0);
     TCGv_i32 res = tcg_temp_new_i32();
     TCGv_i32 set_br = tcg_temp_new_i32();
@@ -6337,26 +6528,101 @@ static void translate_compare_s(DisasContext *dc, const OpcodeArg arg[],
     tcg_gen_ori_i32(set_br, arg[0].in, 1 << arg[0].imm);
     tcg_gen_andi_i32(clr_br, arg[0].in, ~(1 << arg[0].imm));
 
-    helper[par[0]](res, cpu_env, arg[1].in, arg[2].in);
+    get_f32_i2(arg, arg32, 1, 2);
+    helper[par[0]](res, cpu_env, arg32[1].in, arg32[2].in);
     tcg_gen_movcond_i32(TCG_COND_NE,
                         arg[0].out, res, zero,
                         set_br, clr_br);
+    put_f32_i2(arg, arg32, 1, 2);
     tcg_temp_free(zero);
     tcg_temp_free(res);
     tcg_temp_free(set_br);
     tcg_temp_free(clr_br);
 }
 
+static void translate_const_d(DisasContext *dc, const OpcodeArg arg[],
+                              const uint32_t par[])
+{
+    static const uint64_t v[] = {
+        UINT64_C(0x0000000000000000),
+        UINT64_C(0x3ff0000000000000),
+        UINT64_C(0x4000000000000000),
+        UINT64_C(0x3fe0000000000000),
+    };
+
+    tcg_gen_movi_i64(arg[0].out, v[arg[1].imm % ARRAY_SIZE(v)]);
+    if (arg[1].imm >= ARRAY_SIZE(v)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "const.d f%d, #%d, immediate value is reserved\n",
+                      arg[0].imm, arg[1].imm);
+    }
+}
+
+static void translate_const_s(DisasContext *dc, const OpcodeArg arg[],
+                              const uint32_t par[])
+{
+    static const uint32_t v[] = {
+        0x00000000,
+        0x3f800000,
+        0x40000000,
+        0x3f000000,
+    };
+
+    if (arg[0].num_bits == 32) {
+        tcg_gen_movi_i32(arg[0].out, v[arg[1].imm % ARRAY_SIZE(v)]);
+    } else {
+        tcg_gen_movi_i64(arg[0].out, v[arg[1].imm % ARRAY_SIZE(v)]);
+    }
+    if (arg[1].imm >= ARRAY_SIZE(v)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "const.s f%d, #%d, immediate value is reserved\n",
+                      arg[0].imm, arg[1].imm);
+    }
+}
+
+static void translate_float_d(DisasContext *dc, const OpcodeArg arg[],
+                              const uint32_t par[])
+{
+    TCGv_i32 scale = tcg_const_i32(-arg[2].imm);
+
+    if (par[0]) {
+        gen_helper_uitof_d(arg[0].out, cpu_env, arg[1].in, scale);
+    } else {
+        gen_helper_itof_d(arg[0].out, cpu_env, arg[1].in, scale);
+    }
+    tcg_temp_free(scale);
+}
+
 static void translate_float_s(DisasContext *dc, const OpcodeArg arg[],
                               const uint32_t par[])
 {
     TCGv_i32 scale = tcg_const_i32(-arg[2].imm);
+    OpcodeArg arg32[1];
 
+    get_f32_o1(arg, arg32, 0);
     if (par[0]) {
-        gen_helper_uitof_s(arg[0].out, cpu_env, arg[1].in, scale);
+        gen_helper_uitof_s(arg32[0].out, cpu_env, arg[1].in, scale);
+    } else {
+        gen_helper_itof_s(arg32[0].out, cpu_env, arg[1].in, scale);
+    }
+    put_f32_o1(arg, arg32, 0);
+    tcg_temp_free(scale);
+}
+
+static void translate_ftoi_d(DisasContext *dc, const OpcodeArg arg[],
+                             const uint32_t par[])
+{
+    TCGv_i32 rounding_mode = tcg_const_i32(par[0]);
+    TCGv_i32 scale = tcg_const_i32(arg[2].imm);
+
+    if (par[1]) {
+        gen_helper_ftoui_d(arg[0].out, cpu_env, arg[1].in,
+                           rounding_mode, scale);
     } else {
-        gen_helper_itof_s(arg[0].out, cpu_env, arg[1].in, scale);
+        gen_helper_ftoi_d(arg[0].out, cpu_env, arg[1].in,
+                          rounding_mode, scale);
     }
+    tcg_temp_free(rounding_mode);
     tcg_temp_free(scale);
 }
 
@@ -6365,14 +6631,17 @@ static void translate_ftoi_s(DisasContext *dc, const OpcodeArg arg[],
 {
     TCGv_i32 rounding_mode = tcg_const_i32(par[0]);
     TCGv_i32 scale = tcg_const_i32(arg[2].imm);
+    OpcodeArg arg32[2];
 
+    get_f32_i1(arg, arg32, 1);
     if (par[1]) {
-        gen_helper_ftoui_s(arg[0].out, arg[1].in,
+        gen_helper_ftoui_s(arg[0].out, cpu_env, arg32[1].in,
                            rounding_mode, scale);
     } else {
-        gen_helper_ftoi_s(arg[0].out, arg[1].in,
+        gen_helper_ftoi_s(arg[0].out, cpu_env, arg32[1].in,
                           rounding_mode, scale);
     }
+    put_f32_i1(arg, arg32, 1);
     tcg_temp_free(rounding_mode);
     tcg_temp_free(scale);
 }
@@ -6413,81 +6682,200 @@ static void translate_ldstx(DisasContext *dc, const OpcodeArg arg[],
     tcg_temp_free(addr);
 }
 
-static void translate_madd_s(DisasContext *dc, const OpcodeArg arg[],
+static void translate_madd_d(DisasContext *dc, const OpcodeArg arg[],
                              const uint32_t par[])
 {
-    gen_helper_madd_s(arg[0].out, cpu_env,
+    gen_helper_madd_d(arg[0].out, cpu_env,
                       arg[0].in, arg[1].in, arg[2].in);
 }
 
+static void translate_madd_s(DisasContext *dc, const OpcodeArg arg[],
+                             const uint32_t par[])
+{
+    OpcodeArg arg32[3];
+
+    get_f32_o1_i3(arg, arg32, 0, 0, 1, 2);
+    gen_helper_madd_s(arg32[0].out, cpu_env,
+                      arg32[0].in, arg32[1].in, arg32[2].in);
+    put_f32_o1_i3(arg, arg32, 0, 0, 1, 2);
+}
+
+static void translate_mov_d(DisasContext *dc, const OpcodeArg arg[],
+                                const uint32_t par[])
+{
+    tcg_gen_mov_i64(arg[0].out, arg[1].in);
+}
+
 static void translate_mov_s(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
-    tcg_gen_mov_i32(arg[0].out, arg[1].in);
+    if (arg[0].num_bits == 32) {
+        tcg_gen_mov_i32(arg[0].out, arg[1].in);
+    } else {
+        tcg_gen_mov_i64(arg[0].out, arg[1].in);
+    }
+}
+
+static void translate_movcond_d(DisasContext *dc, const OpcodeArg arg[],
+                                const uint32_t par[])
+{
+    TCGv_i64 zero = tcg_const_i64(0);
+    TCGv_i64 arg2 = tcg_temp_new_i64();
+
+    tcg_gen_ext_i32_i64(arg2, arg[2].in);
+    tcg_gen_movcond_i64(par[0], arg[0].out,
+                        arg2, zero,
+                        arg[1].in, arg[0].in);
+    tcg_temp_free_i64(zero);
+    tcg_temp_free_i64(arg2);
 }
 
 static void translate_movcond_s(DisasContext *dc, const OpcodeArg arg[],
                                 const uint32_t par[])
 {
-    TCGv_i32 zero = tcg_const_i32(0);
+    if (arg[0].num_bits == 32) {
+        TCGv_i32 zero = tcg_const_i32(0);
 
-    tcg_gen_movcond_i32(par[0], arg[0].out,
-                        arg[2].in, zero,
+        tcg_gen_movcond_i32(par[0], arg[0].out,
+                            arg[2].in, zero,
+                            arg[1].in, arg[0].in);
+        tcg_temp_free(zero);
+    } else {
+        translate_movcond_d(dc, arg, par);
+    }
+}
+
+static void translate_movp_d(DisasContext *dc, const OpcodeArg arg[],
+                             const uint32_t par[])
+{
+    TCGv_i64 zero = tcg_const_i64(0);
+    TCGv_i32 tmp1 = tcg_temp_new_i32();
+    TCGv_i64 tmp2 = tcg_temp_new_i64();
+
+    tcg_gen_andi_i32(tmp1, arg[2].in, 1 << arg[2].imm);
+    tcg_gen_extu_i32_i64(tmp2, tmp1);
+    tcg_gen_movcond_i64(par[0],
+                        arg[0].out, tmp2, zero,
                         arg[1].in, arg[0].in);
-    tcg_temp_free(zero);
+    tcg_temp_free_i64(zero);
+    tcg_temp_free_i32(tmp1);
+    tcg_temp_free_i64(tmp2);
 }
 
 static void translate_movp_s(DisasContext *dc, const OpcodeArg arg[],
                              const uint32_t par[])
 {
-    TCGv_i32 zero = tcg_const_i32(0);
-    TCGv_i32 tmp = tcg_temp_new_i32();
+    if (arg[0].num_bits == 32) {
+        TCGv_i32 zero = tcg_const_i32(0);
+        TCGv_i32 tmp = tcg_temp_new_i32();
 
-    tcg_gen_andi_i32(tmp, arg[2].in, 1 << arg[2].imm);
-    tcg_gen_movcond_i32(par[0],
-                        arg[0].out, tmp, zero,
-                        arg[1].in, arg[0].in);
-    tcg_temp_free(tmp);
-    tcg_temp_free(zero);
+        tcg_gen_andi_i32(tmp, arg[2].in, 1 << arg[2].imm);
+        tcg_gen_movcond_i32(par[0],
+                            arg[0].out, tmp, zero,
+                            arg[1].in, arg[0].in);
+        tcg_temp_free(tmp);
+        tcg_temp_free(zero);
+    } else {
+        translate_movp_d(dc, arg, par);
+    }
+}
+
+static void translate_mul_d(DisasContext *dc, const OpcodeArg arg[],
+                            const uint32_t par[])
+{
+    gen_helper_mul_d(arg[0].out, cpu_env, arg[1].in, arg[2].in);
 }
 
 static void translate_mul_s(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
-    gen_helper_mul_s(arg[0].out, cpu_env,
-                     arg[1].in, arg[2].in);
+    OpcodeArg arg32[3];
+
+    get_f32_o1_i2(arg, arg32, 0, 1, 2);
+    gen_helper_mul_s(arg32[0].out, cpu_env, arg32[1].in, arg32[2].in);
+    put_f32_o1_i2(arg, arg32, 0, 1, 2);
 }
 
-static void translate_msub_s(DisasContext *dc, const OpcodeArg arg[],
+static void translate_msub_d(DisasContext *dc, const OpcodeArg arg[],
                              const uint32_t par[])
 {
-    gen_helper_msub_s(arg[0].out, cpu_env,
+    gen_helper_msub_d(arg[0].out, cpu_env,
                       arg[0].in, arg[1].in, arg[2].in);
 }
 
+static void translate_msub_s(DisasContext *dc, const OpcodeArg arg[],
+                             const uint32_t par[])
+{
+    OpcodeArg arg32[3];
+
+    get_f32_o1_i3(arg, arg32, 0, 0, 1, 2);
+    gen_helper_msub_s(arg32[0].out, cpu_env,
+                      arg32[0].in, arg32[1].in, arg32[2].in);
+    put_f32_o1_i3(arg, arg32, 0, 0, 1, 2);
+}
+
+static void translate_neg_d(DisasContext *dc, const OpcodeArg arg[],
+                            const uint32_t par[])
+{
+    gen_helper_neg_d(arg[0].out, arg[1].in);
+}
+
 static void translate_neg_s(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
-    gen_helper_neg_s(arg[0].out, arg[1].in);
+    OpcodeArg arg32[2];
+
+    get_f32_o1_i1(arg, arg32, 0, 1);
+    gen_helper_neg_s(arg32[0].out, arg32[1].in);
+    put_f32_o1_i1(arg, arg32, 0, 1);
+}
+
+static void translate_rfr_d(DisasContext *dc, const OpcodeArg arg[],
+                            const uint32_t par[])
+{
+    tcg_gen_extrh_i64_i32(arg[0].out, arg[1].in);
 }
 
 static void translate_rfr_s(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
-    tcg_gen_mov_i32(arg[0].out, arg[1].in);
+    if (arg[1].num_bits == 32) {
+        tcg_gen_mov_i32(arg[0].out, arg[1].in);
+    } else {
+        tcg_gen_extrl_i64_i32(arg[0].out, arg[1].in);
+    }
+}
+
+static void translate_sub_d(DisasContext *dc, const OpcodeArg arg[],
+                            const uint32_t par[])
+{
+    gen_helper_sub_d(arg[0].out, cpu_env, arg[1].in, arg[2].in);
 }
 
 static void translate_sub_s(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
-    gen_helper_sub_s(arg[0].out, cpu_env,
-                     arg[1].in, arg[2].in);
+    OpcodeArg arg32[3];
+
+    get_f32_o1_i2(arg, arg32, 0, 1, 2);
+    gen_helper_sub_s(arg32[0].out, cpu_env, arg32[1].in, arg32[2].in);
+    put_f32_o1_i2(arg, arg32, 0, 1, 2);
+}
+
+static void translate_wfr_d(DisasContext *dc, const OpcodeArg arg[],
+                            const uint32_t par[])
+{
+    tcg_gen_concat_i32_i64(arg[0].out, arg[2].in, arg[1].in);
 }
 
 static void translate_wfr_s(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
-    tcg_gen_mov_i32(arg[0].out, arg[1].in);
+    if (arg[0].num_bits == 32) {
+        tcg_gen_mov_i32(arg[0].out, arg[1].in);
+    } else {
+        tcg_gen_ext_i32_i64(arg[0].out, arg[1].in);
+    }
 }
 
 static void translate_wur_fpu2k_fcr(DisasContext *dc, const OpcodeArg arg[],
@@ -6718,3 +7106,635 @@ const XtensaOpcodeTranslators xtensa_fpu2000_opcodes = {
     .num_opcodes = ARRAY_SIZE(fpu2000_ops),
     .opcode = fpu2000_ops,
 };
+
+
+static void translate_cvtd_s(DisasContext *dc, const OpcodeArg arg[],
+                             const uint32_t par[])
+{
+    TCGv_i32 v = tcg_temp_new_i32();
+
+    tcg_gen_extrl_i64_i32(v, arg[1].in);
+    gen_helper_cvtd_s(arg[0].out, cpu_env, v);
+    tcg_temp_free_i32(v);
+}
+
+static void translate_cvts_d(DisasContext *dc, const OpcodeArg arg[],
+                             const uint32_t par[])
+{
+    TCGv_i32 v = tcg_temp_new_i32();
+
+    gen_helper_cvts_d(v, cpu_env, arg[1].in);
+    tcg_gen_extu_i32_i64(arg[0].out, v);
+    tcg_temp_free_i32(v);
+}
+
+static void translate_ldsti_d(DisasContext *dc, const OpcodeArg arg[],
+                              const uint32_t par[])
+{
+    TCGv_i32 addr;
+
+    if (par[1]) {
+        addr = tcg_temp_new_i32();
+        tcg_gen_addi_i32(addr, arg[1].in, arg[2].imm);
+    } else {
+        addr = arg[1].in;
+    }
+    gen_load_store_alignment(dc, 3, addr, false);
+    if (par[0]) {
+        tcg_gen_qemu_st64(arg[0].in, addr, dc->cring);
+    } else {
+        tcg_gen_qemu_ld64(arg[0].out, addr, dc->cring);
+    }
+    if (par[2]) {
+        if (par[1]) {
+            tcg_gen_mov_i32(arg[1].out, addr);
+        } else {
+            tcg_gen_addi_i32(arg[1].out, arg[1].in, arg[2].imm);
+        }
+    }
+    if (par[1]) {
+        tcg_temp_free(addr);
+    }
+}
+
+static void translate_ldsti_s(DisasContext *dc, const OpcodeArg arg[],
+                              const uint32_t par[])
+{
+    TCGv_i32 addr;
+    OpcodeArg arg32[1];
+
+    if (par[1]) {
+        addr = tcg_temp_new_i32();
+        tcg_gen_addi_i32(addr, arg[1].in, arg[2].imm);
+    } else {
+        addr = arg[1].in;
+    }
+    gen_load_store_alignment(dc, 2, addr, false);
+    if (par[0]) {
+        get_f32_i1(arg, arg32, 0);
+        tcg_gen_qemu_st32(arg32[0].in, addr, dc->cring);
+        put_f32_i1(arg, arg32, 0);
+    } else {
+        get_f32_o1(arg, arg32, 0);
+        tcg_gen_qemu_ld32u(arg32[0].out, addr, dc->cring);
+        put_f32_o1(arg, arg32, 0);
+    }
+    if (par[2]) {
+        if (par[1]) {
+            tcg_gen_mov_i32(arg[1].out, addr);
+        } else {
+            tcg_gen_addi_i32(arg[1].out, arg[1].in, arg[2].imm);
+        }
+    }
+    if (par[1]) {
+        tcg_temp_free(addr);
+    }
+}
+
+static void translate_ldstx_d(DisasContext *dc, const OpcodeArg arg[],
+                              const uint32_t par[])
+{
+    TCGv_i32 addr;
+
+    if (par[1]) {
+        addr = tcg_temp_new_i32();
+        tcg_gen_add_i32(addr, arg[1].in, arg[2].in);
+    } else {
+        addr = arg[1].in;
+    }
+    gen_load_store_alignment(dc, 3, addr, false);
+    if (par[0]) {
+        tcg_gen_qemu_st64(arg[0].in, addr, dc->cring);
+    } else {
+        tcg_gen_qemu_ld64(arg[0].out, addr, dc->cring);
+    }
+    if (par[2]) {
+        if (par[1]) {
+            tcg_gen_mov_i32(arg[1].out, addr);
+        } else {
+            tcg_gen_add_i32(arg[1].out, arg[1].in, arg[2].in);
+        }
+    }
+    if (par[1]) {
+        tcg_temp_free(addr);
+    }
+}
+
+static void translate_ldstx_s(DisasContext *dc, const OpcodeArg arg[],
+                              const uint32_t par[])
+{
+    TCGv_i32 addr;
+    OpcodeArg arg32[1];
+
+    if (par[1]) {
+        addr = tcg_temp_new_i32();
+        tcg_gen_add_i32(addr, arg[1].in, arg[2].in);
+    } else {
+        addr = arg[1].in;
+    }
+    gen_load_store_alignment(dc, 2, addr, false);
+    if (par[0]) {
+        get_f32_i1(arg, arg32, 0);
+        tcg_gen_qemu_st32(arg32[0].in, addr, dc->cring);
+        put_f32_i1(arg, arg32, 0);
+    } else {
+        get_f32_o1(arg, arg32, 0);
+        tcg_gen_qemu_ld32u(arg32[0].out, addr, dc->cring);
+        put_f32_o1(arg, arg32, 0);
+    }
+    if (par[2]) {
+        if (par[1]) {
+            tcg_gen_mov_i32(arg[1].out, addr);
+        } else {
+            tcg_gen_add_i32(arg[1].out, arg[1].in, arg[2].in);
+        }
+    }
+    if (par[1]) {
+        tcg_temp_free(addr);
+    }
+}
+
+static void translate_wur_fpu_fcr(DisasContext *dc, const OpcodeArg arg[],
+                                  const uint32_t par[])
+{
+    gen_helper_wur_fpu_fcr(cpu_env, arg[0].in);
+}
+
+static void translate_rur_fpu_fsr(DisasContext *dc, const OpcodeArg arg[],
+                                  const uint32_t par[])
+{
+    gen_helper_rur_fpu_fsr(arg[0].out, cpu_env);
+}
+
+static void translate_wur_fpu_fsr(DisasContext *dc, const OpcodeArg arg[],
+                                  const uint32_t par[])
+{
+    gen_helper_wur_fpu_fsr(cpu_env, arg[0].in);
+}
+
+static const XtensaOpcodeOps fpu_ops[] = {
+    {
+        .name = "abs.d",
+        .translate = translate_abs_d,
+        .coprocessor = 0x1,
+    }, {
+        .name = "abs.s",
+        .translate = translate_abs_s,
+        .coprocessor = 0x1,
+    }, {
+        .name = "add.d",
+        .translate = translate_add_d,
+        .coprocessor = 0x1,
+    }, {
+        .name = "add.s",
+        .translate = translate_add_s,
+        .coprocessor = 0x1,
+    }, {
+        .name = "ceil.d",
+        .translate = translate_ftoi_d,
+        .par = (const uint32_t[]){float_round_up, false},
+        .coprocessor = 0x1,
+    }, {
+        .name = "ceil.s",
+        .translate = translate_ftoi_s,
+        .par = (const uint32_t[]){float_round_up, false},
+        .coprocessor = 0x1,
+    }, {
+        .name = "const.d",
+        .translate = translate_const_d,
+        .coprocessor = 0x1,
+    }, {
+        .name = "const.s",
+        .translate = translate_const_s,
+        .coprocessor = 0x1,
+    }, {
+        .name = "cvtd.s",
+        .translate = translate_cvtd_s,
+        .coprocessor = 0x1,
+    }, {
+        .name = "cvts.d",
+        .translate = translate_cvts_d,
+        .coprocessor = 0x1,
+    }, {
+        .name = "float.d",
+        .translate = translate_float_d,
+        .par = (const uint32_t[]){false},
+        .coprocessor = 0x1,
+    }, {
+        .name = "float.s",
+        .translate = translate_float_s,
+        .par = (const uint32_t[]){false},
+        .coprocessor = 0x1,
+    }, {
+        .name = "floor.d",
+        .translate = translate_ftoi_d,
+        .par = (const uint32_t[]){float_round_down, false},
+        .coprocessor = 0x1,
+    }, {
+        .name = "floor.s",
+        .translate = translate_ftoi_s,
+        .par = (const uint32_t[]){float_round_down, false},
+        .coprocessor = 0x1,
+    }, {
+        .name = "ldi",
+        .translate = translate_ldsti_d,
+        .par = (const uint32_t[]){false, true, false},
+        .op_flags = XTENSA_OP_LOAD,
+        .coprocessor = 0x1,
+    }, {
+        .name = "ldip",
+        .translate = translate_ldsti_d,
+        .par = (const uint32_t[]){false, false, true},
+        .op_flags = XTENSA_OP_LOAD,
+        .coprocessor = 0x1,
+    }, {
+        .name = "ldiu",
+        .translate = translate_ldsti_d,
+        .par = (const uint32_t[]){false, true, true},
+        .op_flags = XTENSA_OP_LOAD,
+        .coprocessor = 0x1,
+    }, {
+        .name = "ldx",
+        .translate = translate_ldstx_d,
+        .par = (const uint32_t[]){false, true, false},
+        .op_flags = XTENSA_OP_LOAD,
+        .coprocessor = 0x1,
+    }, {
+        .name = "ldxp",
+        .translate = translate_ldstx_d,
+        .par = (const uint32_t[]){false, false, true},
+        .op_flags = XTENSA_OP_LOAD,
+        .coprocessor = 0x1,
+    }, {
+        .name = "ldxu",
+        .translate = translate_ldstx_d,
+        .par = (const uint32_t[]){false, true, true},
+        .op_flags = XTENSA_OP_LOAD,
+        .coprocessor = 0x1,
+    }, {
+        .name = "lsi",
+        .translate = translate_ldsti_s,
+        .par = (const uint32_t[]){false, true, false},
+        .op_flags = XTENSA_OP_LOAD,
+        .coprocessor = 0x1,
+    }, {
+        .name = "lsip",
+        .translate = translate_ldsti_s,
+        .par = (const uint32_t[]){false, false, true},
+        .op_flags = XTENSA_OP_LOAD,
+        .coprocessor = 0x1,
+    }, {
+        .name = "lsiu",
+        .translate = translate_ldsti_s,
+        .par = (const uint32_t[]){false, true, true},
+        .op_flags = XTENSA_OP_LOAD,
+        .coprocessor = 0x1,
+    }, {
+        .name = "lsx",
+        .translate = translate_ldstx_s,
+        .par = (const uint32_t[]){false, true, false},
+        .op_flags = XTENSA_OP_LOAD,
+        .coprocessor = 0x1,
+    }, {
+        .name = "lsxp",
+        .translate = translate_ldstx_s,
+        .par = (const uint32_t[]){false, false, true},
+        .op_flags = XTENSA_OP_LOAD,
+        .coprocessor = 0x1,
+    }, {
+        .name = "lsxu",
+        .translate = translate_ldstx_s,
+        .par = (const uint32_t[]){false, true, true},
+        .op_flags = XTENSA_OP_LOAD,
+        .coprocessor = 0x1,
+    }, {
+        .name = "madd.d",
+        .translate = translate_madd_d,
+        .coprocessor = 0x1,
+    }, {
+        .name = "madd.s",
+        .translate = translate_madd_s,
+        .coprocessor = 0x1,
+    }, {
+        .name = "mov.d",
+        .translate = translate_mov_d,
+        .coprocessor = 0x1,
+    }, {
+        .name = "mov.s",
+        .translate = translate_mov_s,
+        .coprocessor = 0x1,
+    }, {
+        .name = "moveqz.d",
+        .translate = translate_movcond_d,
+        .par = (const uint32_t[]){TCG_COND_EQ},
+        .coprocessor = 0x1,
+    }, {
+        .name = "moveqz.s",
+        .translate = translate_movcond_s,
+        .par = (const uint32_t[]){TCG_COND_EQ},
+        .coprocessor = 0x1,
+    }, {
+        .name = "movf.d",
+        .translate = translate_movp_d,
+        .par = (const uint32_t[]){TCG_COND_EQ},
+        .coprocessor = 0x1,
+    }, {
+        .name = "movf.s",
+        .translate = translate_movp_s,
+        .par = (const uint32_t[]){TCG_COND_EQ},
+        .coprocessor = 0x1,
+    }, {
+        .name = "movgez.d",
+        .translate = translate_movcond_d,
+        .par = (const uint32_t[]){TCG_COND_GE},
+        .coprocessor = 0x1,
+    }, {
+        .name = "movgez.s",
+        .translate = translate_movcond_s,
+        .par = (const uint32_t[]){TCG_COND_GE},
+        .coprocessor = 0x1,
+    }, {
+        .name = "movltz.d",
+        .translate = translate_movcond_d,
+        .par = (const uint32_t[]){TCG_COND_LT},
+        .coprocessor = 0x1,
+    }, {
+        .name = "movltz.s",
+        .translate = translate_movcond_s,
+        .par = (const uint32_t[]){TCG_COND_LT},
+        .coprocessor = 0x1,
+    }, {
+        .name = "movnez.d",
+        .translate = translate_movcond_d,
+        .par = (const uint32_t[]){TCG_COND_NE},
+        .coprocessor = 0x1,
+    }, {
+        .name = "movnez.s",
+        .translate = translate_movcond_s,
+        .par = (const uint32_t[]){TCG_COND_NE},
+        .coprocessor = 0x1,
+    }, {
+        .name = "movt.d",
+        .translate = translate_movp_d,
+        .par = (const uint32_t[]){TCG_COND_NE},
+        .coprocessor = 0x1,
+    }, {
+        .name = "movt.s",
+        .translate = translate_movp_s,
+        .par = (const uint32_t[]){TCG_COND_NE},
+        .coprocessor = 0x1,
+    }, {
+        .name = "msub.d",
+        .translate = translate_msub_d,
+        .coprocessor = 0x1,
+    }, {
+        .name = "msub.s",
+        .translate = translate_msub_s,
+        .coprocessor = 0x1,
+    }, {
+        .name = "mul.d",
+        .translate = translate_mul_d,
+        .coprocessor = 0x1,
+    }, {
+        .name = "mul.s",
+        .translate = translate_mul_s,
+        .coprocessor = 0x1,
+    }, {
+        .name = "neg.d",
+        .translate = translate_neg_d,
+        .coprocessor = 0x1,
+    }, {
+        .name = "neg.s",
+        .translate = translate_neg_s,
+        .coprocessor = 0x1,
+    }, {
+        .name = "oeq.d",
+        .translate = translate_compare_d,
+        .par = (const uint32_t[]){COMPARE_OEQ},
+        .coprocessor = 0x1,
+    }, {
+        .name = "oeq.s",
+        .translate = translate_compare_s,
+        .par = (const uint32_t[]){COMPARE_OEQ},
+        .coprocessor = 0x1,
+    }, {
+        .name = "ole.d",
+        .translate = translate_compare_d,
+        .par = (const uint32_t[]){COMPARE_OLE},
+        .coprocessor = 0x1,
+    }, {
+        .name = "ole.s",
+        .translate = translate_compare_s,
+        .par = (const uint32_t[]){COMPARE_OLE},
+        .coprocessor = 0x1,
+    }, {
+        .name = "olt.d",
+        .translate = translate_compare_d,
+        .par = (const uint32_t[]){COMPARE_OLT},
+        .coprocessor = 0x1,
+    }, {
+        .name = "olt.s",
+        .translate = translate_compare_s,
+        .par = (const uint32_t[]){COMPARE_OLT},
+        .coprocessor = 0x1,
+    }, {
+        .name = "rfr",
+        .translate = translate_rfr_s,
+        .coprocessor = 0x1,
+    }, {
+        .name = "rfrd",
+        .translate = translate_rfr_d,
+        .coprocessor = 0x1,
+    }, {
+        .name = "round.d",
+        .translate = translate_ftoi_d,
+        .par = (const uint32_t[]){float_round_nearest_even, false},
+        .coprocessor = 0x1,
+    }, {
+        .name = "round.s",
+        .translate = translate_ftoi_s,
+        .par = (const uint32_t[]){float_round_nearest_even, false},
+        .coprocessor = 0x1,
+    }, {
+        .name = "rur.fcr",
+        .translate = translate_rur,
+        .par = (const uint32_t[]){FCR},
+        .coprocessor = 0x1,
+    }, {
+        .name = "rur.fsr",
+        .translate = translate_rur_fpu_fsr,
+        .coprocessor = 0x1,
+    }, {
+        .name = "sdi",
+        .translate = translate_ldsti_d,
+        .par = (const uint32_t[]){true, true, false},
+        .op_flags = XTENSA_OP_STORE,
+        .coprocessor = 0x1,
+    }, {
+        .name = "sdip",
+        .translate = translate_ldsti_d,
+        .par = (const uint32_t[]){true, false, true},
+        .op_flags = XTENSA_OP_STORE,
+        .coprocessor = 0x1,
+    }, {
+        .name = "sdiu",
+        .translate = translate_ldsti_d,
+        .par = (const uint32_t[]){true, true, true},
+        .op_flags = XTENSA_OP_STORE,
+        .coprocessor = 0x1,
+    }, {
+        .name = "sdx",
+        .translate = translate_ldstx_d,
+        .par = (const uint32_t[]){true, true, false},
+        .op_flags = XTENSA_OP_STORE,
+        .coprocessor = 0x1,
+    }, {
+        .name = "sdxp",
+        .translate = translate_ldstx_d,
+        .par = (const uint32_t[]){true, false, true},
+        .op_flags = XTENSA_OP_STORE,
+        .coprocessor = 0x1,
+    }, {
+        .name = "sdxu",
+        .translate = translate_ldstx_d,
+        .par = (const uint32_t[]){true, true, true},
+        .op_flags = XTENSA_OP_STORE,
+        .coprocessor = 0x1,
+    }, {
+        .name = "ssi",
+        .translate = translate_ldsti_s,
+        .par = (const uint32_t[]){true, true, false},
+        .op_flags = XTENSA_OP_STORE,
+        .coprocessor = 0x1,
+    }, {
+        .name = "ssip",
+        .translate = translate_ldsti_s,
+        .par = (const uint32_t[]){true, false, true},
+        .op_flags = XTENSA_OP_STORE,
+        .coprocessor = 0x1,
+    }, {
+        .name = "ssiu",
+        .translate = translate_ldsti_s,
+        .par = (const uint32_t[]){true, true, true},
+        .op_flags = XTENSA_OP_STORE,
+        .coprocessor = 0x1,
+    }, {
+        .name = "ssx",
+        .translate = translate_ldstx_s,
+        .par = (const uint32_t[]){true, true, false},
+        .op_flags = XTENSA_OP_STORE,
+        .coprocessor = 0x1,
+    }, {
+        .name = "ssxp",
+        .translate = translate_ldstx_s,
+        .par = (const uint32_t[]){true, false, true},
+        .op_flags = XTENSA_OP_STORE,
+        .coprocessor = 0x1,
+    }, {
+        .name = "ssxu",
+        .translate = translate_ldstx_s,
+        .par = (const uint32_t[]){true, true, true},
+        .op_flags = XTENSA_OP_STORE,
+        .coprocessor = 0x1,
+    }, {
+        .name = "sub.d",
+        .translate = translate_sub_d,
+        .coprocessor = 0x1,
+    }, {
+        .name = "sub.s",
+        .translate = translate_sub_s,
+        .coprocessor = 0x1,
+    }, {
+        .name = "trunc.d",
+        .translate = translate_ftoi_d,
+        .par = (const uint32_t[]){float_round_to_zero, false},
+        .coprocessor = 0x1,
+    }, {
+        .name = "trunc.s",
+        .translate = translate_ftoi_s,
+        .par = (const uint32_t[]){float_round_to_zero, false},
+        .coprocessor = 0x1,
+    }, {
+        .name = "ueq.d",
+        .translate = translate_compare_d,
+        .par = (const uint32_t[]){COMPARE_UEQ},
+        .coprocessor = 0x1,
+    }, {
+        .name = "ueq.s",
+        .translate = translate_compare_s,
+        .par = (const uint32_t[]){COMPARE_UEQ},
+        .coprocessor = 0x1,
+    }, {
+        .name = "ufloat.d",
+        .translate = translate_float_d,
+        .par = (const uint32_t[]){true},
+        .coprocessor = 0x1,
+    }, {
+        .name = "ufloat.s",
+        .translate = translate_float_s,
+        .par = (const uint32_t[]){true},
+        .coprocessor = 0x1,
+    }, {
+        .name = "ule.d",
+        .translate = translate_compare_d,
+        .par = (const uint32_t[]){COMPARE_ULE},
+        .coprocessor = 0x1,
+    }, {
+        .name = "ule.s",
+        .translate = translate_compare_s,
+        .par = (const uint32_t[]){COMPARE_ULE},
+        .coprocessor = 0x1,
+    }, {
+        .name = "ult.d",
+        .translate = translate_compare_d,
+        .par = (const uint32_t[]){COMPARE_ULT},
+        .coprocessor = 0x1,
+    }, {
+        .name = "ult.s",
+        .translate = translate_compare_s,
+        .par = (const uint32_t[]){COMPARE_ULT},
+        .coprocessor = 0x1,
+    }, {
+        .name = "un.d",
+        .translate = translate_compare_d,
+        .par = (const uint32_t[]){COMPARE_UN},
+        .coprocessor = 0x1,
+    }, {
+        .name = "un.s",
+        .translate = translate_compare_s,
+        .par = (const uint32_t[]){COMPARE_UN},
+        .coprocessor = 0x1,
+    }, {
+        .name = "utrunc.d",
+        .translate = translate_ftoi_d,
+        .par = (const uint32_t[]){float_round_to_zero, true},
+        .coprocessor = 0x1,
+    }, {
+        .name = "utrunc.s",
+        .translate = translate_ftoi_s,
+        .par = (const uint32_t[]){float_round_to_zero, true},
+        .coprocessor = 0x1,
+    }, {
+        .name = "wfr",
+        .translate = translate_wfr_s,
+        .coprocessor = 0x1,
+    }, {
+        .name = "wfrd",
+        .translate = translate_wfr_d,
+        .coprocessor = 0x1,
+    }, {
+        .name = "wur.fcr",
+        .translate = translate_wur_fpu_fcr,
+        .par = (const uint32_t[]){FCR},
+        .coprocessor = 0x1,
+    }, {
+        .name = "wur.fsr",
+        .translate = translate_wur_fpu_fsr,
+        .coprocessor = 0x1,
+    },
+};
+
+const XtensaOpcodeTranslators xtensa_fpu_opcodes = {
+    .num_opcodes = ARRAY_SIZE(fpu_ops),
+    .opcode = fpu_ops,
+};
-- 
2.20.1


