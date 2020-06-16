Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9548C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA1E208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="et62m1m2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA1E208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlFIj-0004cR-RE
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF5E-0001nT-Td
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:09:12 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:34274)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF5C-0007YI-Pt
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:09:12 -0400
Received: by mail-wr1-x42a.google.com with SMTP id r7so21590613wro.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t+BSTJ1xzvQLWxMKa/LhLilHEVnIMMztSbawWPlpCgs=;
 b=et62m1m26kp0dyOIDiKiZeCePqla2FuE0M13lVM7RbLKf4ck3durjiDKzesfpFDSux
 42RO2AxcKugZu0AquvvXH+PHzOTJJYkiQZ+0DhZuJYFFQAMTgstcE19U5YgACjUFGP6K
 5cMKE6lCAH9BUErsCaXE8bZiCciPvVbPoHKUgXc7GcLTGUSyfhgiKy4vfhy2fQc53q7N
 cFO8E6oMrbJ0dfZpJtAYtVHvUeMHIj6obpQ5wLE53fCmEXlza9jOzlODkp1GKUcLBVw/
 eGCkTqDVtnkDzFoNmZf5ukPhnHnAAz3vc9bzel028DaS/0QCqB5dBWUUteSmTReC/qfQ
 Bt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t+BSTJ1xzvQLWxMKa/LhLilHEVnIMMztSbawWPlpCgs=;
 b=c38lbAL0vXaTSKfze2tA2E6UdqcYO3zwhOuHHlaka3RNQhGJgjySceb7HRX6zzDqm2
 WVTTtpmhjI5dtyJu6LTQ1KYscfVbdMAoeK+OPHevBAB5yDzmcrBQSWjYGm3KxPigqJg6
 AZiPm1wNkjegEmO9Gj3ifxi3veyRLJczO+0ORVai3kE+p+nRYfTVuHvlpkMaoYvQuYKX
 1ZmzDzRDwaJ/IL3bSfMbDQTua/VnqahP4q3TpCDfEBcvZmC1mwO4RJKydeK6TLh4mGgz
 WAeqrbdOfrStQ4I9XSFlPzXixPGQ8UXyEhzJkueJEObfVMZq0+yIFjVxEgLgjJs28yUo
 xMyQ==
X-Gm-Message-State: AOAM532viJZBqKed/0jfBBDQ8VzHpsmMLdk+8BQjilTek/Tfx0iBMmO1
 vOqxyeB5YclBa0fNmoJpgpSq7A==
X-Google-Smtp-Source: ABdhPJwl8nNcwIs89jzHmD155nKbC4QCOAJ+Wa/CIw0LFfpvBDejdiR95tEyqsid7tcd0M1rm5AjEg==
X-Received: by 2002:a5d:4d89:: with SMTP id b9mr4354008wru.210.1592327349224; 
 Tue, 16 Jun 2020 10:09:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y80sm5263216wmc.34.2020.06.16.10.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 10:09:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 17/21] target/arm: Convert Neon 2-reg-misc VRINT insns to
 decodetree
Date: Tue, 16 Jun 2020 18:08:40 +0100
Message-Id: <20200616170844.13318-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616170844.13318-1-peter.maydell@linaro.org>
References: <20200616170844.13318-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon 2-reg-misc VRINT insns to decodetree.
Giving these insns their own do_vrint() function allows us
to change the rounding mode just once at the start and end
rather than doing it for every element in the vector.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       |  8 +++++
 target/arm/translate-neon.inc.c | 61 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 31 +++--------------
 3 files changed, 74 insertions(+), 26 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index c9acd00f1e8..e0717c7e4a6 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -503,11 +503,19 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
     SHA1SU1      1111 001 11 . 11 .. 10 .... 0 0111 0 . 0 .... @2misc_q1
     SHA256SU0    1111 001 11 . 11 .. 10 .... 0 0111 1 . 0 .... @2misc_q1
 
+    VRINTN       1111 001 11 . 11 .. 10 .... 0 1000 . . 0 .... @2misc
     VRINTX       1111 001 11 . 11 .. 10 .... 0 1001 . . 0 .... @2misc
+    VRINTA       1111 001 11 . 11 .. 10 .... 0 1010 . . 0 .... @2misc
+    VRINTZ       1111 001 11 . 11 .. 10 .... 0 1011 . . 0 .... @2misc
 
     VCVT_F16_F32 1111 001 11 . 11 .. 10 .... 0 1100 0 . 0 .... @2misc_q0
+
+    VRINTM       1111 001 11 . 11 .. 10 .... 0 1101 . . 0 .... @2misc
+
     VCVT_F32_F16 1111 001 11 . 11 .. 10 .... 0 1110 0 . 0 .... @2misc_q0
 
+    VRINTP       1111 001 11 . 11 .. 10 .... 0 1111 . . 0 .... @2misc
+
     VRECPE       1111 001 11 . 11 .. 11 .... 0 1000 . . 0 .... @2misc
     VRSQRTE      1111 001 11 . 11 .. 11 .... 0 1001 . . 0 .... @2misc
     VRECPE_F     1111 001 11 . 11 .. 11 .... 0 1010 . . 0 .... @2misc
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index a62da21b152..0e7f86ad156 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -3796,3 +3796,64 @@ DO_FP_CMP0(VCGE0_F, gen_helper_neon_cge_f32, FWD)
 DO_FP_CMP0(VCEQ0_F, gen_helper_neon_ceq_f32, FWD)
 DO_FP_CMP0(VCLE0_F, gen_helper_neon_cge_f32, REV)
 DO_FP_CMP0(VCLT0_F, gen_helper_neon_cgt_f32, REV)
+
+static bool do_vrint(DisasContext *s, arg_2misc *a, int rmode)
+{
+    /*
+     * Handle a VRINT* operation by iterating 32 bits at a time,
+     * with a specified rounding mode in operation.
+     */
+    int pass;
+    TCGv_ptr fpst;
+    TCGv_i32 tcg_rmode;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON) ||
+        !arm_dc_feature(s, ARM_FEATURE_V8)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if (a->size != 2) {
+        /* TODO: FP16 will be the size == 1 case */
+        return false;
+    }
+
+    if ((a->vd | a->vm) & a->q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fpst = get_fpstatus_ptr(1);
+    tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rmode));
+    gen_helper_set_neon_rmode(tcg_rmode, tcg_rmode, cpu_env);
+    for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
+        TCGv_i32 tmp = neon_load_reg(a->vm, pass);
+        gen_helper_rints(tmp, tmp, fpst);
+        neon_store_reg(a->vd, pass, tmp);
+    }
+    gen_helper_set_neon_rmode(tcg_rmode, tcg_rmode, cpu_env);
+    tcg_temp_free_i32(tcg_rmode);
+    tcg_temp_free_ptr(fpst);
+
+    return true;
+}
+
+#define DO_VRINT(INSN, RMODE)                                   \
+    static bool trans_##INSN(DisasContext *s, arg_2misc *a)     \
+    {                                                           \
+        return do_vrint(s, a, RMODE);                           \
+    }
+
+DO_VRINT(VRINTN, FPROUNDING_TIEEVEN)
+DO_VRINT(VRINTA, FPROUNDING_TIEAWAY)
+DO_VRINT(VRINTZ, FPROUNDING_ZERO)
+DO_VRINT(VRINTM, FPROUNDING_NEGINF)
+DO_VRINT(VRINTP, FPROUNDING_POSINF)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index dc98928856d..61dfc3ae7af 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4959,6 +4959,11 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 case NEON_2RM_VCEQ0_F:
                 case NEON_2RM_VCLE0_F:
                 case NEON_2RM_VCLT0_F:
+                case NEON_2RM_VRINTN:
+                case NEON_2RM_VRINTA:
+                case NEON_2RM_VRINTM:
+                case NEON_2RM_VRINTP:
+                case NEON_2RM_VRINTZ:
                     /* handled by decodetree */
                     return 1;
                 case NEON_2RM_VTRN:
@@ -4993,32 +4998,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             }
                             neon_store_reg(rm, pass, tmp2);
                             break;
-                        case NEON_2RM_VRINTN:
-                        case NEON_2RM_VRINTA:
-                        case NEON_2RM_VRINTM:
-                        case NEON_2RM_VRINTP:
-                        case NEON_2RM_VRINTZ:
-                        {
-                            TCGv_i32 tcg_rmode;
-                            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                            int rmode;
-
-                            if (op == NEON_2RM_VRINTZ) {
-                                rmode = FPROUNDING_ZERO;
-                            } else {
-                                rmode = fp_decode_rm[((op & 0x6) >> 1) ^ 1];
-                            }
-
-                            tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rmode));
-                            gen_helper_set_neon_rmode(tcg_rmode, tcg_rmode,
-                                                      cpu_env);
-                            gen_helper_rints(tmp, tmp, fpstatus);
-                            gen_helper_set_neon_rmode(tcg_rmode, tcg_rmode,
-                                                      cpu_env);
-                            tcg_temp_free_ptr(fpstatus);
-                            tcg_temp_free_i32(tcg_rmode);
-                            break;
-                        }
                         case NEON_2RM_VCVTAU:
                         case NEON_2RM_VCVTAS:
                         case NEON_2RM_VCVTNU:
-- 
2.20.1


