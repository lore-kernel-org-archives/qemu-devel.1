Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FC6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4058320774
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqaJbdNT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4058320774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihMl-0002xl-Fo
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jih7L-00068b-QN
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:28:51 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:53093)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jih7K-00018h-QR
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:28:51 -0400
Received: by mail-wm1-x336.google.com with SMTP id r9so3445575wmh.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RA+GMo5/JhIr5pjMfgPHglQEmrYL6LlTpxySPG4HNjs=;
 b=cqaJbdNTCKPKu4URElRRg20BW0emBxP2PjM9kvyPnxfm2Gce6SZbFlcodbjLSlLAm2
 DMAsdij9/KeuJERGkHjmsQslE7BxUnf5jIQioDyoFtAwN6VvhXhjHsWx/kmS68P8zeRs
 0hIXJyA2smtQ892NPPkSDgKXMJMNaS/LNnY8d8qnoPzw9eP5nicS9lg/8p1hZzQEA8HT
 L6/oyJvhJTTVufKzAm9Sh1C4YIwgCn5Wu1bONdz6Ns+ckWDf8IgQdCs6pX+7h0Ai3A1A
 wZUWnryBzW9GNedxmRicuHPrhuX5t7UHJQLLDOC8wK/MGwcGmvKuPHO3qLHA4GwbHtfr
 S2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RA+GMo5/JhIr5pjMfgPHglQEmrYL6LlTpxySPG4HNjs=;
 b=SOnHacUIzOF+6mQa395kkVog9bGsLS7xrxrtL53QkPFbH3OMEwYF8QKBYgIgaCwi/b
 2k1fr4r4WRl9uTgANrJG/aFLZoh0zn4aFnHht+KfG2a9pHDRicAlMUy2PEUCsgs3aiNh
 El7MTNCoN0Wz8Q5wQ2gNfbOyIEOGanhgukjQZDtCVtOv4w/x/FM0tt/ob/X8Cx9AsOVg
 u+GynWvYDkQ9k5HCqtSU5G4ltOg/79/dgwX514ZJtvP8xyUDZ0Olwq6k4M389CZiApZQ
 QsdyF1sddEJszYEGhLW5ktsYwAwwD2Q2VKvRp7S/KUSO8fCup9IMUs5XsaPDdI4OmzSx
 a/qw==
X-Gm-Message-State: AOAM5312oZQ3fwAGgNnrTh1tnvhNgpAhWj4o/XvpLGyH7M/6usuPvuPB
 z0nsAPhi/WXl9S3IbQ1dR7I+XczW
X-Google-Smtp-Source: ABdhPJwKVq30DjrX2l2EKVZG27PW42yokLUdsL/JMH+Q0BeZEktNG5y7pSUBgcBtlyCD9IGDQckucQ==
X-Received: by 2002:a05:600c:2201:: with SMTP id
 z1mr4856619wml.70.1591720129160; 
 Tue, 09 Jun 2020 09:28:49 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id 23sm3643598wmo.18.2020.06.09.09.28.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jun 2020 09:28:48 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 13/20] target/mips: fpu: Demacro CLASS.<D|S>
Date: Tue,  9 Jun 2020 18:28:31 +0200
Message-Id: <1591720118-7378-14-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591720118-7378-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591720118-7378-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is just a cosmetic change to enable tools like gcov, gdb,
callgrind, etc. to better display involved source code.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <20200518200920.17344-12-aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 2 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index e8e50e4..b3903f5 100644
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
2.7.4


