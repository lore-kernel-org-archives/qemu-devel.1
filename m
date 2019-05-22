Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62612C282DC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:00:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F4820645
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="obXPQmve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F4820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49696 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWTl-0004CX-Do
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:00:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWOm-0008Lh-RQ
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWCU-0008Cz-NV
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:55 -0400
Received: from mail-yw1-xc2a.google.com ([2607:f8b0:4864:20::c2a]:44152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTWCU-0008Cn-JK
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:54 -0400
Received: by mail-yw1-xc2a.google.com with SMTP id e74so1232055ywe.11
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 11:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=bpjcbv60JSWpD1TbbxFv9kSVFeLonJbRE1N/VVDdCYY=;
	b=obXPQmveNKyNSXpvyCvQgGuL84HmN38d+ocQ4xu6Hy01Ako0r2YNybJi3sRWYgL+L+
	vwdcq9wugcF7ZN1vN1Sro1ztACdStOwROqJYX5n9Kx7PHT3tne4Pm6I5qJnq4fuAW7eX
	8syO7oe2HUAdAHIFe+fNyMGHHtU1vUpDVZmeYHB6O/oU8H/oUlro/vl+A8GGP7KZk4DI
	Z+vu0eg9D42r5+pS6S1fPUTUDu1RfDNTZAGf+ttHjebL1EpUNAO0RT9OS7RQDDNRwo6H
	ycmRoNuq3sRHPNsovVxSMUSJbQ9Gr50NTbAIc4zSH1otjeUSzHPPJoHRmVMoOayrI0/T
	Remg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=bpjcbv60JSWpD1TbbxFv9kSVFeLonJbRE1N/VVDdCYY=;
	b=a0eCcq1tzvUHZKRmTvBR9v28no1C1mx8aa3bDZUuozTsjq8rSe+DYDZ64JDk0RB4rJ
	31areLsoRuOF1pzdGvCdFRMcjM8SrRDx1HhrbN0jKoAfGcfPdoj3qUaxU/4bn3oedsFh
	Beg0XV5Z1NXkuTxUCQ9VNhDfQf4+uvnEm+JoxwOY8pD9WGtPabBpJQW6aYegZFMzBKqa
	e/Ls1sUTbuJav7ezN42anCbNHii6k9d6OlNT1jjEgh3GU81/a+ehf8LFd1S2ohMihou8
	PKfIhxUyBUapMfQ2JLWYc00sg9FL+pVnYt2K2hxOTs8aZKK4ER90hf2xNDY9fw+/gTvf
	Xd7g==
X-Gm-Message-State: APjAAAWDjyBTDqA2+/nAPevy8vDPYPyB5qOPCbovTEyXFSL379oothyI
	63JFYN31IXVa00IqWD/zgZwXxu+TkIo=
X-Google-Smtp-Source: APXvYqyCrGxOAQ446qneF6y9PxvIQ1IC2fm2mt+hSc5eLKZN/tvXP+J+lB4XtoY271IU2qKjddELeA==
X-Received: by 2002:a81:924f:: with SMTP id j76mr40316861ywg.199.1558550573715;
	Wed, 22 May 2019 11:42:53 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id
	206sm1299445ywq.74.2019.05.22.11.42.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 11:42:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 14:42:25 -0400
Message-Id: <20190522184226.17871-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522184226.17871-1-richard.henderson@linaro.org>
References: <20190522184226.17871-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c2a
Subject: [Qemu-devel] [PULL 24/25] target/ppc: Use qemu_guest_getrandom for
 DARN
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We now have an interface for guest visible random numbers.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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


