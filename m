Return-Path: <SRS0=Pynu=7U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1FCC433E2
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 19:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 950BC2074B
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 19:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j78nsUw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950BC2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ji1N6-0004Qb-Qf
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 15:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ji1Fe-0003wa-A2
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:46:38 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:37132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ji1Fd-0004mY-Bq
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:46:37 -0400
Received: by mail-wr1-x42b.google.com with SMTP id x13so15161424wrv.4
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2020 12:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RA+GMo5/JhIr5pjMfgPHglQEmrYL6LlTpxySPG4HNjs=;
 b=j78nsUw9gbhgT1RBdZkmQvdTbuBAoRzqbo6Qg6XHkN+xWT4BlZusr9HhyUmcN+aRst
 aPul6WLzcEjpL4dJKqQLmU0QKzf1s5zgy4shb9nPsYJ3X+di+/DijDSMFFoHsOCYPN8e
 /wT6VmL0YGNM7xOUJj8QG4lefWAKmFEWaUWarZium0lOpuHmib9jtnSG3K8r1dJCNW8Q
 iedL6Zv3JMfMwXiluv3dDI2mRwVGV3qraTx+CiQx8nQZSP6vjVCqeWjFqlJ2xsLa/XWO
 GTJ0+ewpUrwLqqfvCexow2TakgMhWxsrLgQ0wzA/ddLpYoMIKwP8R4bawjeBE44/UNLf
 iGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RA+GMo5/JhIr5pjMfgPHglQEmrYL6LlTpxySPG4HNjs=;
 b=XhyR7VqDIC9CZhxttOpYFIzKYKmP/vqeHv4dat7cJz28JXrbZKnSjwHm+VPEuc/Hr8
 gEy4fo5I3oJB1U8qudbXedbDTlToq4GvY0sJUAxJKXLI9Qts4Ri5AVc+jAZrJnRihS33
 H3MNaIMqCOcRxtBtohg+0mfxPwxJEmye4P6knXH2+Qp1DSTdYov00/c6S+qz7U5fLV71
 nWYSSco3O6DfWNfWtIg8ifp43kmsQ4YqCfPFyOn/BwGYkp1Nf+XMAZIkhzsnnep9qC9g
 uOf9fVzjNzA/lzu86ECgxqDNNHbq0xFMV8QtlO7ShBbixksv1VrmZLWtuR6qT2PaE+Uh
 ZLoA==
X-Gm-Message-State: AOAM530pUFcx4B6SmNPT9UVuhbqUUxqGLfwLTUwPY69yJZGJsFQQh3ip
 nFDlmMm0ywrB0sOYm2xxsMxqtCsA
X-Google-Smtp-Source: ABdhPJwwr1cA1Z1OADuRrDIxo8IBjTv2qz0FUisQdVxQLmT7TaOfYnFNlOaW5bSRA6+/kdhV5X9/1Q==
X-Received: by 2002:adf:d852:: with SMTP id k18mr20286325wrl.177.1591559195813; 
 Sun, 07 Jun 2020 12:46:35 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id u130sm21091339wmg.32.2020.06.07.12.46.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 07 Jun 2020 12:46:35 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 13/21] target/mips: fpu: Demacro CLASS.<D|S>
Date: Sun,  7 Jun 2020 21:46:17 +0200
Message-Id: <1591559185-31287-14-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x42b.google.com
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


