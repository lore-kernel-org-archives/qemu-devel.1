Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1FDC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:29:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 887D620675
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C2fXkltt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887D620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50150 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWw0-0004kA-Pa
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:29:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWOr-00086d-Be
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWC9-00082C-II
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:34 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:33820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTWC9-00081c-CR
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:33 -0400
Received: by mail-yb1-xb43.google.com with SMTP id v78so1266115ybv.1
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 11:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=VqY3mH4YRn0WtpmEi7qlWT5KRhdZPDg5AxBMBXlF56s=;
	b=C2fXklttaFB55rJ9U5Po24wtMKgUXJCFBv8eyRy82xHDen3Y67tB6R0FHjz+XIxhMf
	TVbBFlEUBGn1mwgOeIZL/Z5mWUeY6SXf3L2gSVrD2L4Gnp0/1Icf6W1+MExagrXiN/12
	wU/NZ1W3Cc4ROgH8/iDeGkNrbYnZGzpRk49VISUf52ZbwxMuN0MZPTaFQFbZ1rxLi+DY
	XCrAIpwqUveEhfbZ/Oh9p/7EgU1UYTCUzQHAZGlkFvYKEj/MPZrnncqxTvn2/pPKEHks
	5ZvNIjd5vcVHdRoyHQo9RB9bXUAnemWYvxIXTqQLn961ErKS79Sju/WZyruO9q3UaUK3
	7sUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=VqY3mH4YRn0WtpmEi7qlWT5KRhdZPDg5AxBMBXlF56s=;
	b=lEq42MIfoHqVnkhYviWu2BdIcbJrzk548BHCuxxRYEPMqhcB4kLrmiORDmYw3J3Uxp
	hbezfEl+xoIspqnCT9WtcyK0+Q2E+zsW5EHjuh4z14SARclsZZL57SYWiuTDgKqspsQC
	6r24atuvEjciKoyQhvTwVBulwwG38J0yH/4l+nQ21ak/5Cf72WN2c2o4raYzMPGUa5xY
	xf/ed1sykS4yXRjtPbry+CtH2C4HM4PehgsfKWPZRqgjeKQI2WxgzJLiOmCbl/D16RjI
	Iz+YOMVlPwTdNvamqsNxxsh4t8mcn5UAvhbJthAE1AYY4mq7s9obK+NPz59E1T0NklfF
	3dNQ==
X-Gm-Message-State: APjAAAUgKOZU0xZscQUDRXzqWtIMnuila7MbAzKRWYqpDpy3T0vO1ESZ
	efMhX5awJpmM1CsczcG4vSbuekcBkEs=
X-Google-Smtp-Source: APXvYqy8eEUipVxpaPl1CVfaByk2gkpzdFvmNdfkTtG9SGEsERhvwYj1QhIG3aPxTmZY0sCX2qh2jQ==
X-Received: by 2002:a25:ef10:: with SMTP id g16mr10101072ybd.510.1558550552342;
	Wed, 22 May 2019 11:42:32 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id
	206sm1299445ywq.74.2019.05.22.11.42.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 11:42:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 14:42:05 -0400
Message-Id: <20190522184226.17871-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522184226.17871-1-richard.henderson@linaro.org>
References: <20190522184226.17871-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: [Qemu-devel] [PULL 04/25] crypto: Do not fail for EINTR during
 qcrypto_random_bytes
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

We can always get EINTR for read; /dev/urandom is no exception.

Rearrange the order of tests for likelihood; allow degenerate buflen==0
case to perform a no-op zero-length read.  This means that the normal
success path is a straight line with a single test for success.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/random-platform.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/crypto/random-platform.c b/crypto/random-platform.c
index f995fc0ef1..260b64564d 100644
--- a/crypto/random-platform.c
+++ b/crypto/random-platform.c
@@ -65,29 +65,23 @@ int qcrypto_random_bytes(uint8_t *buf G_GNUC_UNUSED,
                          "Unable to read random bytes");
         return -1;
     }
-
-    return 0;
 #else
-    int ret = -1;
-    int got;
-
-    while (buflen > 0) {
-        got = read(fd, buf, buflen);
-        if (got < 0) {
-            error_setg_errno(errp, errno,
-                             "Unable to read random bytes");
-            goto cleanup;
-        } else if (!got) {
-            error_setg(errp,
-                       "Unexpected EOF reading random bytes");
-            goto cleanup;
+    while (1) {
+        ssize_t got = read(fd, buf, buflen);
+        if (likely(got == buflen)) {
+            return 0;
+        }
+        if (got > 0) {
+            buflen -= got;
+            buf += got;
+        } else if (got == 0) {
+            error_setg(errp, "Unexpected EOF reading random bytes");
+            return -1;
+        } else if (errno != EINTR) {
+            error_setg_errno(errp, errno, "Unable to read random bytes");
+            return -1;
         }
-        buflen -= got;
-        buf += got;
     }
-
-    ret = 0;
- cleanup:
-    return ret;
 #endif
+    return 0;
 }
-- 
2.17.1


