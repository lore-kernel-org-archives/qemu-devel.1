Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF483C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:08:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A870A206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PynxNDsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A870A206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufy5-0002OI-2V
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:08:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRX-0000Bl-L5
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRW-0003eU-5L
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:51 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:36479)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iueRV-0003d9-U8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:50 -0500
Received: by mail-wm1-x329.google.com with SMTP id p17so2982946wma.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 07:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=cgmfL+4gTnqZBGjqUeHy8Uwc1+lP8StkbgIKZkWqXCE=;
 b=PynxNDsZuaPABhERy5hHA3Tylf1nEDvaFSAQZoCrk58OosLM2+LszDlJ1m0WOBiP37
 Fl9f9yTPSPSnuL9+yFX3R5UDZC4UqFgU++Tj+dTEVirKKzBaZDJT6M/MLpbarILUr3jm
 1/lOn5BsBEPGBavGgR59RAR31LaOeQ4o9mTN1YyUYWX1A/hSquHolqqsniuMuZxnkUb9
 aH2uqPw/7HGgqxmUtsk7Li+HbqJzhJVa27cX4tl4bUsqh5qTBHVs7PnMVKc1ujqi+P00
 hrsl6nby+Vvk/G2RPH2svMgyQoIC22auUwfr1Kd0pwYVBe0CenZi8V20l3NpVZEs8E8D
 WFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cgmfL+4gTnqZBGjqUeHy8Uwc1+lP8StkbgIKZkWqXCE=;
 b=KtjIPszAh30n508ZN8ANFNlQHx5A/TUHglMn+SjuZlqHsIRakvjI0nMO6yVCzymRtc
 2tSXCD/FV0yvGvnNQvfn5bdMhE9fgy1ILKSUsJE7L5YPksLzKwX5/N4MfLh0YKAxrLrt
 SUw3UN/vO0zco60HmYEG3VprLg1BRr+LtZRMlrKNxA0lIH7uEq3G3ooGMV3qZT6d6QTA
 c/qzqZlPjtLugWyyDOOdq2BtDGc27XHJ/wXwOGtGdeUGfo7b64LR75AB0ZMqjw3xNqTL
 nLxqIsUHyXV9/lDuOyuMMnRJY2uNEiOzR9EBIDyDzKNjNxpjP1PZTEccXvtLzrKsdnIc
 5L7Q==
X-Gm-Message-State: APjAAAW/Yoi76WnJGHAWlAG30yTKViSr7rxU+WrpAIbysDc2+xHaj4o6
 JvfdmVmIixfrW9A3z+ZwPQRnbBvhTDYh0w==
X-Google-Smtp-Source: APXvYqz+b4qX5P0By5uQzBXXZ9imLSmd91t8Omo1Xf9ZZ3ujFIo0hgQTv0Y8POvqo3gqrWOGjOjXmg==
X-Received: by 2002:a7b:cb01:: with SMTP id u1mr4970324wmj.156.1579793448353; 
 Thu, 23 Jan 2020 07:30:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s139sm2903592wme.35.2020.01.23.07.30.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 07:30:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/20] tests/tcg/aarch64: Add pauth-4
Date: Thu, 23 Jan 2020 15:30:26 +0000
Message-Id: <20200123153041.4248-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123153041.4248-1-peter.maydell@linaro.org>
References: <20200123153041.4248-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Perform the set of operations and test described in LP 1859713.

Suggested-by: Adrien GRASSEIN <adrien.grassein@smile.fr>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200116230809.19078-5-richard.henderson@linaro.org
[PMM: fixed hard-coded tabs]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/Makefile.target |  2 +-
 tests/tcg/aarch64/pauth-4.c       | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/pauth-4.c

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 374c8d6830f..efa67cf1e9e 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -18,7 +18,7 @@ run-fcvt: fcvt
 	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
 
 # Pauth Tests
-AARCH64_TESTS += pauth-1 pauth-2
+AARCH64_TESTS += pauth-1 pauth-2 pauth-4
 run-pauth-%: QEMU_OPTS += -cpu max
 pauth-%: CFLAGS += -march=armv8.3-a
 
diff --git a/tests/tcg/aarch64/pauth-4.c b/tests/tcg/aarch64/pauth-4.c
new file mode 100644
index 00000000000..1040e92aec3
--- /dev/null
+++ b/tests/tcg/aarch64/pauth-4.c
@@ -0,0 +1,25 @@
+#include <stdint.h>
+#include <assert.h>
+
+int main()
+{
+  uintptr_t x, y;
+
+  asm("mov %0, lr\n\t"
+      "pacia %0, sp\n\t"        /* sigill if pauth not supported */
+      "eor %0, %0, #4\n\t"      /* corrupt single bit */
+      "mov %1, %0\n\t"
+      "autia %1, sp\n\t"        /* validate corrupted pointer */
+      "xpaci %0\n\t"            /* strip pac from corrupted pointer */
+      : "=r"(x), "=r"(y));
+
+  /*
+   * Once stripped, the corrupted pointer is of the form 0x0000...wxyz.
+   * We expect the autia to indicate failure, producing a pointer of the
+   * form 0x000e....wxyz.  Use xpaci and != for the test, rather than
+   * extracting explicit bits from the top, because the location of the
+   * error code "e" depends on the configuration of virtual memory.
+   */
+  assert(x != y);
+  return 0;
+}
-- 
2.20.1


