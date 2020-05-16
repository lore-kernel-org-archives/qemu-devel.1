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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B516C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 17:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F97206D4
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 17:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxZgjP/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F97206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ja10W-0007pK-32
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 13:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ja0tZ-0003Lc-Ei
 for qemu-devel@nongnu.org; Sat, 16 May 2020 13:46:45 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:42307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ja0tY-0008O1-I8
 for qemu-devel@nongnu.org; Sat, 16 May 2020 13:46:45 -0400
Received: by mail-lf1-x143.google.com with SMTP id x27so4373233lfg.9
 for <qemu-devel@nongnu.org>; Sat, 16 May 2020 10:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w2OdNVDRCHhqd+l8vRPrEWsQJ/Qc25fF1W1YvWmwiFQ=;
 b=GxZgjP/NZqFnY7wFAQI59MIyJrVjh516Uml+/SNZpajSsbrSZPTDBYwVpfe2Y+5jRS
 3jwWwfmnpeeWPbegDqhRcWpzqN7l/jHgUzFWe71WxBeV3TQkovUJm5mKmEikwGG0HeRd
 GdF8TPcVrVquR8sqMZr4yLgBVgRU6Z3YXM9nIphERiA7Q1/whYyv0mdbjJb+W3yUuX6H
 gSKxN6mTi/PGmUEm5gVft/mF3JL2/J6KMTlvy259WbyKUwKa7ctylnkAG+Rgo8aN5jff
 lcrhjCH7E6yFwvOTj1X3PkZRpyBiwfUAB8YfPJHRw7lBi1QVlwetn93DvdHWMWORCG+9
 sOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w2OdNVDRCHhqd+l8vRPrEWsQJ/Qc25fF1W1YvWmwiFQ=;
 b=eNjDuwWr6/uSMxyg7hvM/OMDjcqG33/wfUv/WZbdHFWUSDHhFPGtXRNOYZJcO+5X9m
 W1VNuyE5P2eBlkLMKj1MBEG6Pz3KSgVh3zlbnB9Pv5nh1aRJ07E9btXYIYNUXcaAhXdT
 Xf2VauexVEun+xaulMZsPud+/MJva3WAoUwnF0xRfKdmUgjflb69qp8H4wEU5oHXBjk4
 CdoD/yyvFjb0UaeQuuy5ow4EYbqu+TZJZJueycVBmlo+Q9j2g7wxJ36xW4vszHY9lTnQ
 FjMQGXmerP1SNF6xCXHBPGlpjgDTEStS2f2tSEBKZOerPoSqbXDpBhnWlOT1xMFjNb7Y
 7E2w==
X-Gm-Message-State: AOAM533UYoBrrpoU6YIwslTUzCdh8WTI6gAg03+GjKJCsSAKv65DagTd
 xyWXQ7tyzvaLuh7srgLaYdEAInJYA3g=
X-Google-Smtp-Source: ABdhPJwHZGfUC5ptJ5JkShu7r1D4halLR97pWx14koadZkxqc75A7JIp1lGQpXEHIX4FYJntehFzKw==
X-Received: by 2002:ac2:511d:: with SMTP id q29mr1073460lfb.24.1589651202878; 
 Sat, 16 May 2020 10:46:42 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id i1sm3024759lja.3.2020.05.16.10.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2020 10:46:42 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/18] target/mips: fpu: Demacro CLASS.<D|S>
Date: Sat, 16 May 2020 19:45:41 +0200
Message-Id: <20200516174548.7631-12-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200516174548.7631-1-aleksandar.qemu.devel@gmail.com>
References: <20200516174548.7631-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lf1-x143.google.com
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


