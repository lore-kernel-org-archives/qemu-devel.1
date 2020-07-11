Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107CBC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:08:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3E4520725
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owPDPZfa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E4520725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juDNH-00062V-1Y
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 07:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1juDMG-0004JN-IC
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:07:52 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1juDMF-0006Mu-40
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:07:52 -0400
Received: by mail-pf1-x444.google.com with SMTP id 1so3683572pfn.9
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 04:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W7ATAkBU+e1u0gzazBhl9zvuSsGWGby/NXXI1rneX3w=;
 b=owPDPZfayFxW1DHQhwpwcVQf5OaPPUZCxE75IoviZoTybQammotxpT8LHVboYS2lXA
 ae/44LlNi0xYwFX0aMqkvCSmTh5/LecK7gHySpUTGx51z++n84gQXsFmJZMnByllslWi
 rYgW6byLfo/OtR7gpJlDzUuD/NQtGbQXrwAAosnmOqbOB09X+EjcB0WkRvuDCxpKndlb
 9OrlOa/WRCjWwEGHK8/tS+7LN8s4PljOYz6DD5kumJF/0wAu7VN2FmstetZfCRdxNBnK
 uXjzGSfMeBuybRZRjFCBpRJ12y3wlfJaC3Pu/Ja5h+qKpejDB+H74Vuuj84AvZRReK8V
 RSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W7ATAkBU+e1u0gzazBhl9zvuSsGWGby/NXXI1rneX3w=;
 b=uGapu5oNnxhBduSTAVQ2wQexm4aF1u/f7XokkGGckt+muJJlpGHNe9FHh+Ejq8S0XO
 SokuMeyeqIxnxym5Ojbcm49S8wv+9aUMvHBZyERx2w/8HzK2Ze9+aO/yrYyZQ4X5GoHm
 VbdR2S24NN6+8SMlfRJ+yhV817yN5DWtR0uLVy5Dyoa8d81Xn8BeQxuOPL5LwGq1CWYV
 wqvWv1S1q95Ktc/Fh1Rb37Q9uKWEdavt1Gz9aCyX48Z4GM6DTc8H0MlqQOVy/0ar4Mj9
 UhT4jzPSCtSN/iTxJJuqUBG/kb+uXBreUE35/i3Wf3nZfzEy5FZwBq9cOxRdiJ55ofDJ
 WQSA==
X-Gm-Message-State: AOAM530vjEFwmQ0pM6s8pSIpjnuoc66lGvrS457dDzYE47luijOTBwHY
 tpzOQJBAYilV2akDuvUbTBj1/IEq
X-Google-Smtp-Source: ABdhPJyw61B+VIxjxdFLrUtWEED1Bj1JyxiCmc+nYVb05LMED7wn8k1m/REh7jj2wFTv9rV0Y1KtQw==
X-Received: by 2002:a62:2b85:: with SMTP id
 r127mr22979159pfr.239.1594465669628; 
 Sat, 11 Jul 2020 04:07:49 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id m31sm8925826pjb.52.2020.07.11.04.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 04:07:48 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 03/22] softfloat: add xtensa specialization for
 pickNaNMulAdd
Date: Sat, 11 Jul 2020 04:06:38 -0700
Message-Id: <20200711110655.20287-4-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200711110655.20287-1-jcmvbkbc@gmail.com>
References: <20200711110655.20287-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pf1-x444.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


