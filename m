Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D5FC04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 783852182B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R9QrGTMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783852182B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35046 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOuMq-0002PZ-KR
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 21:30:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHy-0006TY-Ee
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHx-0001Q7-Ib
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:30 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:40871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOuHx-0001Pc-D8
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:29 -0400
Received: by mail-pl1-x641.google.com with SMTP id b3so1992003plr.7
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 18:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=dA7IdM9XxYp0KA0mciB9Wmn94LeseL1766ubkiFpUuY=;
	b=R9QrGTMbhpFv2ooDE+rHY1/EyvH3DxR/YxJSC/g2s5Gs6Rr70N9h6O+6AU6/5WBRfC
	U72/8Oa50Lb3jN6+s1dizVR/WJfPz/mCAcOOefsqRuNoQeLmWoPnVf8DAka9HXfnEHCA
	Q2N+OMuQ353YW+xHvdX032IyOWr9b0EoXAfyERsO7N15QDd9lIdyygdvxRzGmGCjSfP/
	2sO/ytnNDccHpuILQ1Vo3xizTzd84J6FuauNfCJhiPp/DKI9cv2yJ7u+EeAHGsezZEJE
	PNfLcEHkUg7zAHrv9zo4FONf69Wk8aTbjuW6Pv9VCwWunqulpknwewDqXNua8gsztflC
	1qAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=dA7IdM9XxYp0KA0mciB9Wmn94LeseL1766ubkiFpUuY=;
	b=nIBGEZzhobfw2AwAD4Yqa2JuPGO1yZooQ7pEBQPdJ7QnMZxqaVl8su91mqE/hJM/v1
	GNOspaQWja5NQFKxocteeQ6cX1VXfMfOFrImthGmj2dXMkWD9YbV1u4kS1hV5LR9WB2Z
	8/yBINcPbRj51CWjWI6q8zP3R8/GTpNgxOCG7xe3aaBZGnvrkPFestm1OQUPrzSLsonJ
	slHW3XuTUXTZD3kb1zL/Hi90kX95Lm01plPHUM3hYC8A68cELrM/OapBA3zMrixi3bws
	CCMMZk9brPKqQmrnfcSv9L00GlBXhdPloojo7BJc1VmfmGfYDH6tgxi/u9TuRM1/H/5n
	zyNg==
X-Gm-Message-State: APjAAAXswqowxkGDn0toRC9DSA4MPTBkuIN/jed58dFmwPxhW7FxcaKz
	Ew6mMBx61yLAVu4CDUwWh0L7LHICoy4=
X-Google-Smtp-Source: APXvYqy5dzaF4U8GduIeEIw7MuTfv8nZJrsGlXv2lcf1NF3P1m3Rmz+JHaJTwNrpiQ5qGWRfJGqAKw==
X-Received: by 2002:a17:902:b202:: with SMTP id
	t2mr9102123plr.69.1557451528176; 
	Thu, 09 May 2019 18:25:28 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	n18sm8252700pfi.48.2019.05.09.18.25.27 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 18:25:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 18:24:57 -0700
Message-Id: <20190510012458.22706-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510012458.22706-1-richard.henderson@linaro.org>
References: <20190510012458.22706-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v5 23/24] target/ppc: Use qemu_guest_getrandom
 for DARN
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We now have an interface for guest visible random numbers.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v5: Do not loop for darn64; use sizeof.
---
 target/ppc/int_helper.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index f6a088ac08..9af779ad38 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -23,6 +23,8 @@
 #include "exec/helper-proto.h"
 #include "crypto/aes.h"
 #include "fpu/softfloat.h"
+#include "qapi/error.h"
+#include "qemu/guest-random.h"
 
 #include "helper_regs.h"
 /*****************************************************************************/
@@ -158,25 +160,38 @@ uint32_t helper_cmpeqb(target_ulong ra, target_ulong rb)
 #undef hasvalue
 
 /*
- * Return invalid random number.
- *
- * FIXME: Add rng backend or other mechanism to get cryptographically suitable
- * random number
+ * Return a random number.
  */
-target_ulong helper_darn32(void)
+uint64_t helper_darn32(void)
 {
-    return -1;
+    Error *err = NULL;
+    uint32_t ret;
+
+    if (qemu_guest_getrandom(&ret, sizeof(ret), &err) < 0) {
+        qemu_log_mask(LOG_UNIMP, "darn: Crypto failure: %s",
+                      error_get_pretty(err));
+        error_free(err);
+        return -1;
+    }
+
+    return ret;
 }
 
-target_ulong helper_darn64(void)
+uint64_t helper_darn64(void)
 {
-    return -1;
+    Error *err = NULL;
+    uint64_t ret;
+
+    if (qemu_guest_getrandom(&ret, sizeof(ret), &err) < 0) {
+        qemu_log_mask(LOG_UNIMP, "darn: Crypto failure: %s",
+                      error_get_pretty(err));
+        error_free(err);
+        return -1;
+    }
+
+    return ret;
 }
 
-#endif
-
-#if defined(TARGET_PPC64)
-
 uint64_t helper_bpermd(uint64_t rs, uint64_t rb)
 {
     int i;
-- 
2.17.1


