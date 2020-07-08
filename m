Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E46C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:55:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5102A206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiAP1j+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5102A206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIy8-0002MH-Gs
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtIRz-0002Wh-6q
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:21:59 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37497)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtIRx-00015U-FM
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:21:58 -0400
Received: by mail-pl1-x641.google.com with SMTP id p1so9497556pls.4
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 15:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sA/z7F3JWfxJA7eMGjytzkGriTWneuIgK2NudSTLW7Y=;
 b=TiAP1j+Z3pJCRKwcXagprMBjEzUwr6BcG9wxcsTj66eCeKhG1daVUJaQpBPjWcRwoM
 iDgx5XxE66BAymFEKo2hjABD5t5A5DS6P04lgJJ/RrXaZ1WPrWOOHQgoVSl8ofJ6PDms
 8EHE5Vb5xte2aqKhZKQG4iq017Yzz0CT5AOGcoxbYbGirFJ3++dSzNxsjG7lC6QKtwG7
 plnoE2uVmUC76MQPrA6z+/6PKIdnw8m81yfn3QeP3rgBBCzHG+alJL3j770XxxAv3l99
 86ge6ho57gYRCibSAFjFh4KBcEvR/aRbjHX8kXJlATnQiAqSImJyRSgLlfSy8+wq7+3h
 QNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sA/z7F3JWfxJA7eMGjytzkGriTWneuIgK2NudSTLW7Y=;
 b=M5bDZbDBfutEF4BjSa/LGaQiX0y140v6znLB3k9K+O5yjVT5xBzOSpiduFmf5+QTQb
 0yazDIC41T7FxY/kbLzxuQlrLN7kb0WC+B+5ibzQmBV9arTBJQw/eODOa6ObGNGxZiy4
 nGI1gPl1Vi6a3Lti8NX1gLY3i2mBUyS2vuk5EgAfJvsJLGfbLDqZcIWMde13cAj5KF1n
 Gfo8rWulYxdFs3LZTQs5GCrZX1YNsMllw5rf5IkyfV2mRsLg0Az8K7A6E3bSf9WTtIzl
 OHkxFHGizUuzpRkZHiMhkSe1DkxNRBajKfU7GMfm0rGBWxSw0U6H0vjOl1vY9n8Y1oRf
 AmGA==
X-Gm-Message-State: AOAM533v5ob8+/ce4JVITiWRiShe2oPGSCRK6mOsQcsufzGxf2BHHFwy
 99dDqVhjgu2MgCrzDrBc/aiHmjr2
X-Google-Smtp-Source: ABdhPJz6STK7+8jNdbgq0CQEM3H3eXUJe26iPEvb1EAlUGtLlZ4SzRxgZJBU48HaPwjTxYirYVZT3A==
X-Received: by 2002:a17:90a:e007:: with SMTP id
 u7mr12473321pjy.9.1594246915862; 
 Wed, 08 Jul 2020 15:21:55 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id t73sm693517pfc.78.2020.07.08.15.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 15:21:55 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/21] softfloat: add xtensa specialization for
 pickNaNMulAdd
Date: Wed,  8 Jul 2020 15:20:43 -0700
Message-Id: <20200708222101.24568-4-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200708222101.24568-1-jcmvbkbc@gmail.com>
References: <20200708222101.24568-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x641.google.com
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
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

pickNaNMulAdd logic on Xtensa is to apply pickNaN to the inputs of the
expression (a * b) + c. However if default NaN is produces as a result
of (a * b) calculation it is not considered when c is NaN.
So with two pickNaN variants there must be two pickNaNMulAdd variants.
In addition the invalid flag is always set when (a * b) produces NaN.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: "Alex Bennée" <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v2->v3:
- handle infzero case in pickNaNMulAdd properly and reword commit
  message

 fpu/softfloat-specialize.inc.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/fpu/softfloat-specialize.inc.c b/fpu/softfloat-specialize.inc.c
index f519beca1b74..914deac46ecf 100644
--- a/fpu/softfloat-specialize.inc.c
+++ b/fpu/softfloat-specialize.inc.c
@@ -585,6 +585,32 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
     } else {
         return 1;
     }
+#elif defined(TARGET_XTENSA)
+    /*
+     * For Xtensa, the (inf,zero,nan) case sets InvalidOp and returns
+     * an input NaN if we have one (ie c).
+     */
+    if (infzero) {
+        float_raise(float_flag_invalid, status);
+        return 2;
+    }
+    if (status->use_first_nan) {
+        if (is_nan(a_cls)) {
+            return 0;
+        } else if (is_nan(b_cls)) {
+            return 1;
+        } else {
+            return 2;
+        }
+    } else {
+        if (is_nan(c_cls)) {
+            return 2;
+        } else if (is_nan(b_cls)) {
+            return 1;
+        } else {
+            return 0;
+        }
+    }
 #else
     /* A default implementation: prefer a to b to c.
      * This is unlikely to actually match any real implementation.
-- 
2.20.1


