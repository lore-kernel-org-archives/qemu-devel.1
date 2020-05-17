Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0DAC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 09:26:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11CC820727
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 09:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rvdh5uon"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CC820727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaFZL-0001LM-75
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 05:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaFX5-0004MU-J1
 for qemu-devel@nongnu.org; Sun, 17 May 2020 05:24:31 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:41988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaFX3-0001oE-WA
 for qemu-devel@nongnu.org; Sun, 17 May 2020 05:24:30 -0400
Received: by mail-lf1-x144.google.com with SMTP id x27so5260795lfg.9
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 02:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w2OdNVDRCHhqd+l8vRPrEWsQJ/Qc25fF1W1YvWmwiFQ=;
 b=Rvdh5uonvoKn6GA6sgk/VNrVkz9cvNjdYjToDKXlDZHPZGJV+o15xEp2P0ax9nPcVx
 h4DVjBxlZc6JkrmAdZcjgy0uS2E9a0BHnPiZxdT7uThv1xJj9I8GCeWfQ0gLmV12VfgF
 aB2wZ0HIfBDFUzuxbc0p1ihqBXUNIr2Tg55HAH5Fl3MpqAoYGkPdRHFgrvjwIyNtVf1V
 7FC0HJ4+RdRSJENzjUJxiWVDswtJ7xQUkoxMyZm4469301y360rizwt2OBLOxavvdRJP
 cSEMXaGV/Xik4ChP63bojBZwesogqHbRL9oZzgcJtC0vlMUOhI3JR/gj1wgEWanY9HTT
 NOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w2OdNVDRCHhqd+l8vRPrEWsQJ/Qc25fF1W1YvWmwiFQ=;
 b=KCqGRmDGjql7IghEU8I145e6C/fMhWAFdKSmeyzbyiKccyYunsmSJMze/ajkdudX1j
 DUMhn9KqS3gAnzun+p7/NCRBFdumZvFKVdC5TbnZhhOGyYd5Y6FaqsKdo2xNmffJs2ky
 DCEGAaOyf1DrUnLEe6qLZm9pFAsFgnz02Km3J1Wuk0+8IAdQRLbij9D7joaBF75oYm84
 3DrUl+493uc9miyoU37P9UkoZrrwKSBNxqzjDLPc9r943rU4X43iMV+GFL0m5976NJo7
 GCWQpp2iq9a8syvliEeUFLUWg+MT/NimAITSkZeLJW7VVXNwtUQCj3AuOQDb1hQHWvGw
 xZLg==
X-Gm-Message-State: AOAM530NQZzlTQwZ/0+8j1EsQU2jDsSREnLcn6CP9xZQieRje1h/c5wT
 LyQM5R2aibru2j7sYJkbyzWQ/XHBRuk=
X-Google-Smtp-Source: ABdhPJxErLD50h6f+RcOrwN/wuJWlzI2b8Xame3UM8lo/EonhGbfmMDx5naMLDQDcJ5L4Jw6dVVPIA==
X-Received: by 2002:a05:6512:14c:: with SMTP id
 m12mr8066580lfo.165.1589707467678; 
 Sun, 17 May 2020 02:24:27 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id l2sm3872138ljg.89.2020.05.17.02.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2020 02:24:27 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 11/19] target/mips: fpu: Demacro CLASS.<D|S>
Date: Sun, 17 May 2020 11:23:49 +0200
Message-Id: <20200517092357.1469-12-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200517092357.1469-1-aleksandar.qemu.devel@gmail.com>
References: <20200517092357.1469-1-aleksandar.qemu.devel@gmail.com>
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
Cc: aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is just a cosmetic change to enable tools like gcov, gdb,
callgrind, etc. to better display involved source code.

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


