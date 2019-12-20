Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278B3C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:24:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E161E206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BJZ6TIXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E161E206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiIGz-0001mQ-II
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 08:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43245)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiIF8-0007aP-O4
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:22:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiIF7-0005jj-EP
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:22:58 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:51079)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiIF6-0005fe-Ta
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:22:57 -0500
Received: by mail-wm1-x332.google.com with SMTP id a5so8924090wmb.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 05:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=06XcrWFNlcIoXvMNfQG79LGFIvgNsdfFUwprXyUXHHk=;
 b=BJZ6TIXhZiMuci54F//kmtNJyI9a8Qfq7aXKUYE2HiTdFLJ5SQyge6LGDKSo76ka/I
 +gyflGd0LltpF4bcNJ4YAAOcliYbDN+JytvtbNFy/MlcfhgQ+g0f+yLYzqwdH7YWinC8
 1sqN3hJ6MmWWgP5OKItYdamq8eOq2MhUIttW5x9yJ8QEIwqxGbHOWnj9jJIE/vugj93+
 fWW7BqSSYgfu62Ube+TKCr2LnsdICrIUypUOsCX05j9XptDJtn74NKGko+fY5Q500lvd
 Ar7BP5ZeTtIc5aHdnh18+0Jx6SGWMfT2VVoSc4CNjzAlMFpHfVYtVA5Pl6rAwRODJ1A/
 mtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=06XcrWFNlcIoXvMNfQG79LGFIvgNsdfFUwprXyUXHHk=;
 b=KomLBhV0X+AuqZqyjx4Okm9rAPe8Yajq5LdGTRHZ3T8KN1gHauzc9EYZGyC/gH0sn/
 dFrMZNuqHMYdZ8oE6Ju5BQRIF5cczVCb2iUAn27LrVzs3/Xvfd/2PbX6oEVayt6nFzR+
 lJNtNHpFThyP2X1yRmrS7Hy6V3SPFb4QfJeQonMDT1/gEarxFPWF4DRRjTzsowkpGsnP
 61vqvrL2SCDY2jBteEBG80+2TDw/FWd2vB92CTywaZma40Ff+lL8OVe5HaSaNRVuWl3P
 c9dXAo6aeJhXM0YXxIQkuU+7qeffErfwObRs6mC4Kx3W3xckZ0/SLfnf+YjMCGwiWcAh
 P2Yw==
X-Gm-Message-State: APjAAAWuB3afo2LgWg7Jvk4ac4IoJ6kxfkCBVXlEYnJMBwU5NtJ5gSGN
 s8aw2AR9w5NWgE7y2x4rZlW6fA==
X-Google-Smtp-Source: APXvYqy+imwWgoxl3NSahuYuepF+nQFzo3osPvHv/D3n6Kviu43fMGBRDuHPwFxE7PBMUNXvZNC7FA==
X-Received: by 2002:a7b:c001:: with SMTP id c1mr16623663wmb.96.1576848175612; 
 Fri, 20 Dec 2019 05:22:55 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x132sm13756583wmg.0.2019.12.20.05.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 05:22:53 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 259591FF92;
 Fri, 20 Dec 2019 13:22:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/5] tests/tcg: add user version of dumb-as-bricks
 semiconsole test
Date: Fri, 20 Dec 2019 13:22:46 +0000
Message-Id: <20191220132246.6759-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220132246.6759-1-alex.bennee@linaro.org>
References: <20191220132246.6759-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: Peter Maydell <peter.maydell@linaro.org>, keithp@keithp.com,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are linux-user users of semihosting so we'd better check things
work for them as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/arm/semiconsole.c   | 47 +++++++++++++++++++++++++++++++++++
 tests/tcg/arm/Makefile.target |  7 ++++++
 2 files changed, 54 insertions(+)
 create mode 100644 tests/tcg/arm/semiconsole.c

diff --git a/tests/tcg/arm/semiconsole.c b/tests/tcg/arm/semiconsole.c
new file mode 100644
index 00000000000..cc9266b87df
--- /dev/null
+++ b/tests/tcg/arm/semiconsole.c
@@ -0,0 +1,47 @@
+/*
+ * linux-user semihosting console
+ *
+ * Copyright (c) 2019
+ * Written by Alex Bennée <alex.bennee@linaro.org>
+ *
+ * SPDX-License-Identifier: GPL-3.0-or-later
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+
+#define SYS_READC  0x7
+
+uintptr_t __semi_call(uintptr_t type, uintptr_t arg0)
+{
+#if defined(__arm__)
+    register uintptr_t t asm("r0") = type;
+    register uintptr_t a0 asm("r1") = arg0;
+    asm("svc 0xab"
+        : "=r" (t)
+        : "r" (t), "r" (a0));
+#else
+    register uintptr_t t asm("x0") = type;
+    register uintptr_t a0 asm("x1") = arg0;
+    asm("hlt 0xf000"
+        : "=r" (t)
+        : "r" (t), "r" (a0));
+#endif
+
+    return t;
+}
+
+int main(void)
+{
+    char c;
+
+    printf("Semihosting Console Test\n");
+    printf("hit X to exit:");
+
+    do {
+        c = __semi_call(SYS_READC, 0);
+        printf("got '%c'\n", c);
+    } while (c != 'X');
+
+    return 0;
+}
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 0765f37ff04..997e6e78ed9 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -40,6 +40,13 @@ run-plugin-semihosting-with-%:
 		 $(call strip-plugin,$<) 2> $<.err, \
 		"$< on $(TARGET_NAME) with $*")
 
+ARM_TESTS += semiconsole
+run-semiconsole: semiconsole
+	$(call skip-test, $<, "MANUAL ONLY")
+
+run-semiconsole-with-%:
+	$(call skip-test, $<, "MANUAL ONLY")
+
 TESTS += $(ARM_TESTS)
 
 # On ARM Linux only supports 4k pages
-- 
2.20.1


