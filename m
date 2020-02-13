Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD6CC352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:09:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 080412082F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qfVW2oUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080412082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60733 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2NcA-0005Mu-9m
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 18:09:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NTZ-0002Y9-PR
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NTY-0002cN-G8
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:00:53 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:37339)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j2NTY-0002Yr-4n
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:00:52 -0500
Received: by mail-wm1-x331.google.com with SMTP id a6so8652046wme.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 15:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LM7CKlGDQQ+uKXRKtjMMvs0F+UsijFwZIGBIi2qQw/Q=;
 b=qfVW2oUzLqRug/aLV6Y9TNPG2a5TkiHjAHWnpxNSLz56sNjjDscu/WsAQp13sji8V9
 E8bJAgsrTnpjozDWbzCw3VRopqX0xuCFlo8b3WjBSwAeLWcVrv4Fyj9yQfZVGA7ff3fu
 9Cva+Df/8rx6xOwVq1uhrEm0dNbTXNqEJSX3Xy7DD8f5sUs8nWct3+lw5gbS/BqexWfQ
 n0BMedHsC8kx/asNpCshF5LLbv0XLaMEN73l1svNbY/0Bp2YF2gVFaGm3s9y4fHW9oNZ
 CyX03PUQoMm79c/MJFCZsWdC7E6IYTQlRiS44Ylm33CrHuQmlejAIDD4f1nu5IostMBH
 py/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LM7CKlGDQQ+uKXRKtjMMvs0F+UsijFwZIGBIi2qQw/Q=;
 b=VwFZdl2k99zPE2ggOtt/JSgrokvwfNUtFpEpL+1fngdnAmcTELsYzzRDb2K9SUww7C
 TonHcudg60Yt4z5/FdWuA/l40YCgklt9J5ly0FdC9nw9M7LNS16SM+yCeXYDCpr7QZU1
 E7a6SlLgF3EXWaW/qOexmKgcYPUh0o+1LQD/6YIyyQSlDwWcip2rB+p3rtx61CR2ppv2
 pdui+BmjoJeQswF5oIyaTbgHUndb2G3LWfVVw8u6+uo8F0B/F9F+3kl/pOCHHgBE3VVw
 oGtUV9JDE5wKlQ8AqbTz24I02qSi/5Ncx+5HEIxRpbGnO9iD4vhIpTzQwLUNMfBiSW/j
 MUGQ==
X-Gm-Message-State: APjAAAWgLTbScCgEcQrk4pp5KGaMXo55afRwXlwT69wKuRhUEu0dz/9F
 WbXo8r3aGraI52LbI0cwq2aVmg==
X-Google-Smtp-Source: APXvYqy3FM1UHxkksxLUjLHga8c0vG8IxJhnXVTnC6gu4TEOl9s6AhuymItty/lTFFqo3SW0hZIywA==
X-Received: by 2002:a05:600c:214a:: with SMTP id
 v10mr358086wml.182.1581634850234; 
 Thu, 13 Feb 2020 15:00:50 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g15sm4363854wro.65.2020.02.13.15.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 15:00:45 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4B08F1FFAA;
 Thu, 13 Feb 2020 22:51:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 19/19] tests/tcg: take into account expected clashes pauth-4
Date: Thu, 13 Feb 2020 22:51:09 +0000
Message-Id: <20200213225109.13120-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213225109.13120-1-alex.bennee@linaro.org>
References: <20200213225109.13120-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: fam@euphon.net, Peter Maydell <peter.maydell@linaro.org>,
 berrange@redhat.com, robert.foley@linaro.org, pbonzini@redhat.com,
 stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 marcandre.lureau@redhat.com, aaron@os.amperecomputing.com, cota@braap.org,
 stefanha@redhat.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pointer authentication isn't perfect so measure the percentage of
failed checks. As we want to vary the pointer that is authenticated we
recurse down the stack.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/pauth-4.c | 54 +++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/tests/tcg/aarch64/pauth-4.c b/tests/tcg/aarch64/pauth-4.c
index 1040e92aec3..24a639e36ca 100644
--- a/tests/tcg/aarch64/pauth-4.c
+++ b/tests/tcg/aarch64/pauth-4.c
@@ -1,25 +1,45 @@
 #include <stdint.h>
 #include <assert.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#define TESTS 1000
 
 int main()
 {
-  uintptr_t x, y;
+    int i, count = 0;
+    float perc;
+    void *base = malloc(TESTS);
+
+    for (i = 0; i < TESTS; i++) {
+        uintptr_t in, x, y;
+
+        in = i + (uintptr_t) base;
+
+        asm("mov %0, %[in]\n\t"
+            "pacia %0, sp\n\t"        /* sigill if pauth not supported */
+            "eor %0, %0, #4\n\t"      /* corrupt single bit */
+            "mov %1, %0\n\t"
+            "autia %1, sp\n\t"        /* validate corrupted pointer */
+            "xpaci %0\n\t"            /* strip pac from corrupted pointer */
+            : /* out */ "=r"(x), "=r"(y)
+            : /* in */ [in] "r" (in)
+            : /* clobbers */);
 
-  asm("mov %0, lr\n\t"
-      "pacia %0, sp\n\t"        /* sigill if pauth not supported */
-      "eor %0, %0, #4\n\t"      /* corrupt single bit */
-      "mov %1, %0\n\t"
-      "autia %1, sp\n\t"        /* validate corrupted pointer */
-      "xpaci %0\n\t"            /* strip pac from corrupted pointer */
-      : "=r"(x), "=r"(y));
+        /*
+         * Once stripped, the corrupted pointer is of the form 0x0000...wxyz.
+         * We expect the autia to indicate failure, producing a pointer of the
+         * form 0x000e....wxyz.  Use xpaci and != for the test, rather than
+         * extracting explicit bits from the top, because the location of the
+         * error code "e" depends on the configuration of virtual memory.
+         */
+        if (x != y) {
+            count++;
+        }
 
-  /*
-   * Once stripped, the corrupted pointer is of the form 0x0000...wxyz.
-   * We expect the autia to indicate failure, producing a pointer of the
-   * form 0x000e....wxyz.  Use xpaci and != for the test, rather than
-   * extracting explicit bits from the top, because the location of the
-   * error code "e" depends on the configuration of virtual memory.
-   */
-  assert(x != y);
-  return 0;
+    }
+    perc = (float) count / (float) TESTS;
+    printf("Checks Passed: %0.2f%%", perc * 100.0);
+    assert(perc > 0.95);
+    return 0;
 }
-- 
2.20.1


