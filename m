Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6CFC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:15:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C659C20674
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUjeiVyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C659C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jamAr-00067U-01
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 16:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jam5u-0006YY-A9
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:10:38 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:36365)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jam5t-0002KQ-1b
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:10:37 -0400
Received: by mail-lf1-x142.google.com with SMTP id c21so9207848lfb.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 13:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7DTiRZYqiOEJbT1KL7IFIXdClbFolr0SKEXu5py2ATU=;
 b=UUjeiVyCpaZdD8g8M80+E5jiy5CeaVt4zONTLZAMtWAR2FwEE7hB21FJnPcqJS2+DL
 bBupD4dI36B1Rra2Ieogl+vzDpgYoqcoOYQkrC0Lqe89F6/149wSAO86vRcXQMm2ZORS
 GIKnXw8oPNv4bD+8EwAqC42om84kYFVjT+Hi/ytGy5UshLkKmig3PDS/n+jSBybj/SNE
 dVUgnWHY5PBxGFpx1isHtmudzKtDi7dlZ4UsJOAoCTGUOTNaKyI4qQMoZO2baGhdw8nl
 ANtM0ShLTisizWYwdv2bLNdJDTRtJv0hJ7OX1vQNtNlK5Erqf5wJhrQ+RjUSahrUMo2E
 1CuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7DTiRZYqiOEJbT1KL7IFIXdClbFolr0SKEXu5py2ATU=;
 b=CngxqJF2XLZsCrfyF2iXPEP4Jk7t9/Ix9XyaRSoSO9DzLYQxV8hUQ1CKa9vCIMm7je
 hWfKzEXN18TUUFdcusWWPttqkTSNuSCVYV8AWQ2oPE82SuYv+bep1HTBUY+0tjWGrJ61
 J+DD+DXkA6soWhjCBteThDYR7gj0/kaCSEB7kHs66f+DiDFo3wi4vn7p4YEY6zRj7wR7
 5rohYP8T+aiTbBG64qDegTeNa791QVDWeW4rKqllqAMUCoKmc8cq4Mh+HEaueJ6/fM0a
 jsi9utQ2uYx8zqzmbINpSGrbKuqWAm9vqJLpb+hANJsga60B11BpO89W5yOkYhOLFCZm
 Nz0w==
X-Gm-Message-State: AOAM533XIOFcdUXcYjEvgMIh2NkLBAJjKvv+upL78/KwJVhrmCoytPoI
 Q8nOJbi4MlQVBytWOWeIoPxD2VsU6Io=
X-Google-Smtp-Source: ABdhPJzXrKgrboohMmlj3t73fp9qBInn3cp+iPZz0W7cVDRBz4mlTHygRAdfZIjI4VnLmGeqjpuNGg==
X-Received: by 2002:ac2:5106:: with SMTP id q6mr13109692lfb.59.1589832635272; 
 Mon, 18 May 2020 13:10:35 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id c78sm8700591lfd.63.2020.05.18.13.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 13:10:34 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 11/21] target/mips: fpu: Demacro CLASS.<D|S>
Date: Mon, 18 May 2020 22:09:10 +0200
Message-Id: <20200518200920.17344-12-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518200920.17344-1-aleksandar.qemu.devel@gmail.com>
References: <20200518200920.17344-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is just a cosmetic change to enable tools like gcov, gdb,
callgrind, etc. to better display involved source code.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 70 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 2 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index e8e50e4bc0..b3903f5357 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1165,10 +1165,76 @@ uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,          \
     return float_ ## name(arg, &env->active_fpu.fp_status);          \
 }
 
-FLOAT_CLASS(class_s, 32)
-FLOAT_CLASS(class_d, 64)
 #undef FLOAT_CLASS
 
+uint64_t float_class_d(uint64_t arg, float_status *status)
+{
+    if (float64_is_signaling_nan(arg, status)) {
+        return FLOAT_CLASS_SIGNALING_NAN;
+    } else if (float64_is_quiet_nan(arg, status)) {
+        return FLOAT_CLASS_QUIET_NAN;
+    } else if (float64_is_neg(arg)) {
+        if (float64_is_infinity(arg)) {
+            return FLOAT_CLASS_NEGATIVE_INFINITY;
+        } else if (float64_is_zero(arg)) {
+            return FLOAT_CLASS_NEGATIVE_ZERO;
+        } else if (float64_is_zero_or_denormal(arg)) {
+            return FLOAT_CLASS_NEGATIVE_SUBNORMAL;
+        } else {
+            return FLOAT_CLASS_NEGATIVE_NORMAL;
+        }
+    } else {
+        if (float64_is_infinity(arg)) {
+            return FLOAT_CLASS_POSITIVE_INFINITY;
+        } else if (float64_is_zero(arg)) {
+            return FLOAT_CLASS_POSITIVE_ZERO;
+        } else if (float64_is_zero_or_denormal(arg)) {
+            return FLOAT_CLASS_POSITIVE_SUBNORMAL;
+        } else {
+            return FLOAT_CLASS_POSITIVE_NORMAL;
+        }
+    }
+}
+
+uint64_t helper_float_class_d(CPUMIPSState *env, uint64_t arg)
+{
+    return float_class_d(arg, &env->active_fpu.fp_status);
+}
+
+uint32_t float_class_s(uint32_t arg, float_status *status)
+{
+    if (float32_is_signaling_nan(arg, status)) {
+        return FLOAT_CLASS_SIGNALING_NAN;
+    } else if (float32_is_quiet_nan(arg, status)) {
+        return FLOAT_CLASS_QUIET_NAN;
+    } else if (float32_is_neg(arg)) {
+        if (float32_is_infinity(arg)) {
+            return FLOAT_CLASS_NEGATIVE_INFINITY;
+        } else if (float32_is_zero(arg)) {
+            return FLOAT_CLASS_NEGATIVE_ZERO;
+        } else if (float32_is_zero_or_denormal(arg)) {
+            return FLOAT_CLASS_NEGATIVE_SUBNORMAL;
+        } else {
+            return FLOAT_CLASS_NEGATIVE_NORMAL;
+        }
+    } else {
+        if (float32_is_infinity(arg)) {
+            return FLOAT_CLASS_POSITIVE_INFINITY;
+        } else if (float32_is_zero(arg)) {
+            return FLOAT_CLASS_POSITIVE_ZERO;
+        } else if (float32_is_zero_or_denormal(arg)) {
+            return FLOAT_CLASS_POSITIVE_SUBNORMAL;
+        } else {
+            return FLOAT_CLASS_POSITIVE_NORMAL;
+        }
+    }
+}
+
+uint32_t helper_float_class_s(CPUMIPSState *env, uint32_t arg)
+{
+    return float_class_s(arg, &env->active_fpu.fp_status);
+}
+
 /* binary operations */
 
 uint64_t helper_float_add_d(CPUMIPSState *env,
-- 
2.20.1


