Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074E4C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 18:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C251A2070A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 18:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WMeP33kb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C251A2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZfO2-00012f-U2
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 14:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZfMo-000839-No
 for qemu-devel@nongnu.org; Fri, 15 May 2020 14:47:31 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36588)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZfMn-0005xs-QT
 for qemu-devel@nongnu.org; Fri, 15 May 2020 14:47:30 -0400
Received: by mail-pg1-x542.google.com with SMTP id c75so393273pga.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 11:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cMmDD1w5euAwfTOHzuv67r0X2MSI19HIQQ5/Y6AnMtU=;
 b=WMeP33kbglvSe6Z92DcVtJdWXUK7zTT51QmEKEhoOL/RppYemcNQR+0Mpm+NOfuftg
 +nV4DJfRT97m/sLsu6jjVNhGPQEmhHQS2xrCDhE57IYW/+VPEkCSEKsTRr5NlXAdlpDB
 H2ZeO0Z/kEmgcq2BHEdNFrAQxyzbJmLwTB2UoSbk4YDisE5CfXkLJORMQVxGBCIuTJ2V
 8UNHWY2brM5m/ARpvQO1U/Cpn8YEhzR8xTjmx8Me7nI90RXE8to0PrWR/hN2rTyPUdwm
 lw/ijzK4+xJ202PTBWXVf1zm2Iz+M+bwv41+ho2PZB9WdE5mpVuBVmz8N7+5SLZLoANs
 BoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cMmDD1w5euAwfTOHzuv67r0X2MSI19HIQQ5/Y6AnMtU=;
 b=q+jwCZtDkGTsWhic7hXSePpdcFm692j6VkUJpsohhgwygdUz74VwcCoKL318fGYvt4
 S0WRcDLPHfDA1LRIkOWWqVCXcEP9/YuMqMxmM2qnvUKFSAwX9rlirElpCSVTbXYrpY3z
 1+kR8i7s7avdecUyyuBMB1PgGr3VtPY5mv+RhabuFmGlvMB4uE0ZQexcBJe5OVdezngv
 BwUZONodXRkJ9VP+zYzv4fCCRNbcc6YS9fRPKNge6UBSaqTiOIwUFH+xBLinbGEypUlO
 cyysuo0ZYgPOWh7i1TFn9xFl01k6dbmcsDHS3udQ/8R9tuMr6tZe1JBIoYWXrkr8zx0e
 oiEg==
X-Gm-Message-State: AOAM531ZQ5KPSZeSn/1laRA2T7BK3c/mm1JcDq1BgLmbgIWkk4zASnqF
 e7uiGX4dylsjFtsAHt2QsG6zaMXAnfE=
X-Google-Smtp-Source: ABdhPJzjjdrPb3MCpUKaDtqPhd9hscA0JHAB9t/D/iRAyv1gSgDzLeGHtN1BTn63lPdDCnRGBcc8pw==
X-Received: by 2002:a62:754f:: with SMTP id q76mr5428030pfc.14.1589568447897; 
 Fri, 15 May 2020 11:47:27 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id u73sm2743630pfc.0.2020.05.15.11.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 11:47:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/4] softfloat: fix floatx80 pseudo-denormal comparisons
Date: Fri, 15 May 2020 11:47:21 -0700
Message-Id: <20200515184722.31182-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515184722.31182-1-richard.henderson@linaro.org>
References: <20200515184722.31182-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: peter.maydell@linaro.org, Joseph Myers <joseph@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joseph Myers <joseph@codesourcery.com>

The softfloat floatx80 comparisons fail to allow for pseudo-denormals,
which should compare equal to corresponding values with biased
exponent 1 rather than 0.  Add an adjustment for that case when
comparing numbers with the same sign.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
Message-Id: <alpine.DEB.2.21.2005042338470.22972@digraph.polyomino.org.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c                            | 7 +++++++
 tests/tcg/i386/test-i386-pseudo-denormal.c | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 6094d267b5..c57f72e3a6 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -7966,6 +7966,13 @@ static inline int floatx80_compare_internal(floatx80 a, floatx80 b,
             return 1 - (2 * aSign);
         }
     } else {
+        /* Normalize pseudo-denormals before comparison.  */
+        if ((a.high & 0x7fff) == 0 && a.low & UINT64_C(0x8000000000000000)) {
+            ++a.high;
+        }
+        if ((b.high & 0x7fff) == 0 && b.low & UINT64_C(0x8000000000000000)) {
+            ++b.high;
+        }
         if (a.low == b.low && a.high == b.high) {
             return float_relation_equal;
         } else {
diff --git a/tests/tcg/i386/test-i386-pseudo-denormal.c b/tests/tcg/i386/test-i386-pseudo-denormal.c
index cfa2a500b0..acf2b9cf03 100644
--- a/tests/tcg/i386/test-i386-pseudo-denormal.c
+++ b/tests/tcg/i386/test-i386-pseudo-denormal.c
@@ -20,5 +20,9 @@ int main(void)
         printf("FAIL: pseudo-denormal add\n");
         ret = 1;
     }
+    if (ld_pseudo_m16382.ld != 0x1p-16382L) {
+        printf("FAIL: pseudo-denormal compare\n");
+        ret = 1;
+    }
     return ret;
 }
-- 
2.20.1


