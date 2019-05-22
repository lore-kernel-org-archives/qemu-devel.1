Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E046C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AE95217D4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WqoBSRUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE95217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50128 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWuB-0003P8-F8
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:28:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWOr-0008P8-BW
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWC8-00081S-Eh
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:33 -0400
Received: from mail-yw1-xc29.google.com ([2607:f8b0:4864:20::c29]:35728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTWC8-00081D-8o
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:32 -0400
Received: by mail-yw1-xc29.google.com with SMTP id k128so1247876ywf.2
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 11:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=WcaPjSSW8mCEGy+vfZffpT+ukMC7uteGhxOw5c2wJXo=;
	b=WqoBSRUTTGnpLM+sdJxTl9/3hxQssulEWF+W79mNBvMYMqcWZuIYbo0rmAqiUMlwOG
	79hIZG9TUAIpN6S3PVWHtrEuAmgmnNzdaQhfYBmURM2ZAtKtfEuf9bFu8DpK/MBNpiM5
	d9nzvej5A+Dk/WKjDK2Us/E5OkQZZIaY5VcQ2R+m1O9rhH//DmRk10OBTXmEVFq/r/vI
	gTKDDOXRiSR85+1nRpqC324Zr1b92Umjv986mx52tcPnf6vV4khqYNyiyLuj8Ug8VglR
	zAFS1DrYn9xpmLn3zo1zua5BcjuCmbo5CJJuPhM/LfEHNZuDIIKUSl6b+CoYcrhcFYcj
	ED7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=WcaPjSSW8mCEGy+vfZffpT+ukMC7uteGhxOw5c2wJXo=;
	b=TyYVEsMboPyieAIQNWz8uMynB7ltamqjOhoMbT8w1AXomvObdzIkX/IExSZfJyqn0h
	pBbgiW5s+t98WJqhincv2Rir2UsCdkMLteCjdAk5W25EtIpXtJNQKvN8EMhzrPbHiDcN
	0uj4YXWupfjzpKS9lbK57x5WXr+umtPxRu6WKVhhtZ3Uy1ukH+lBK3tvXJIbN2WcwDmj
	wtGRgKTAm4g/ZFJLqnsd0A29wFUZb+Vd0Ylys1P/kOqGJJQJtWC0VVW3Ag55lbLNhvlJ
	n0azSefn4Sls15e4+52osfjuEhfDAReTARcOZiSh/aZ2ZiuqFyFeK9xdJ24I8oegM651
	S3Mg==
X-Gm-Message-State: APjAAAV6+wjbirf2bagGl2hmmEZ7sVO9dMDYk7w9bkMh1VLJCkk7kyEk
	uKVPSDd7A5IEADqgVb65XAkg/knQ2Cc=
X-Google-Smtp-Source: APXvYqykL065Hu7PERVtp4xqAIf62J/mHbBJTVYxSpQfgp6R/FlgNPv9kVpQlFug2umdfhGmJYDeHA==
X-Received: by 2002:a81:b84:: with SMTP id 126mr41880660ywl.257.1558550551317; 
	Wed, 22 May 2019 11:42:31 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id
	206sm1299445ywq.74.2019.05.22.11.42.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 11:42:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 14:42:04 -0400
Message-Id: <20190522184226.17871-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522184226.17871-1-richard.henderson@linaro.org>
References: <20190522184226.17871-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c29
Subject: [Qemu-devel] [PULL 03/25] crypto: Reverse code blocks in
 random-platform.c
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

Use #ifdef _WIN32 instead of #ifndef _WIN32.
This will make other tests easier to sequence.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/random-platform.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/crypto/random-platform.c b/crypto/random-platform.c
index 7541b4cae7..f995fc0ef1 100644
--- a/crypto/random-platform.c
+++ b/crypto/random-platform.c
@@ -32,7 +32,14 @@ static int fd; /* a file handle to either /dev/urandom or /dev/random */
 
 int qcrypto_random_init(Error **errp)
 {
-#ifndef _WIN32
+#ifdef _WIN32
+    if (!CryptAcquireContext(&hCryptProv, NULL, NULL, PROV_RSA_FULL,
+                             CRYPT_SILENT | CRYPT_VERIFYCONTEXT)) {
+        error_setg_win32(errp, GetLastError(),
+                         "Unable to create cryptographic provider");
+        return -1;
+    }
+#else
     /* TBD perhaps also add support for BSD getentropy / Linux
      * getrandom syscalls directly */
     fd = open("/dev/urandom", O_RDONLY);
@@ -44,15 +51,7 @@ int qcrypto_random_init(Error **errp)
         error_setg(errp, "No /dev/urandom or /dev/random found");
         return -1;
     }
-#else
-    if (!CryptAcquireContext(&hCryptProv, NULL, NULL, PROV_RSA_FULL,
-                             CRYPT_SILENT | CRYPT_VERIFYCONTEXT)) {
-        error_setg_win32(errp, GetLastError(),
-                         "Unable to create cryptographic provider");
-        return -1;
-    }
 #endif
-
     return 0;
 }
 
@@ -60,7 +59,15 @@ int qcrypto_random_bytes(uint8_t *buf G_GNUC_UNUSED,
                          size_t buflen G_GNUC_UNUSED,
                          Error **errp)
 {
-#ifndef _WIN32
+#ifdef _WIN32
+    if (!CryptGenRandom(hCryptProv, buflen, buf)) {
+        error_setg_win32(errp, GetLastError(),
+                         "Unable to read random bytes");
+        return -1;
+    }
+
+    return 0;
+#else
     int ret = -1;
     int got;
 
@@ -82,13 +89,5 @@ int qcrypto_random_bytes(uint8_t *buf G_GNUC_UNUSED,
     ret = 0;
  cleanup:
     return ret;
-#else
-    if (!CryptGenRandom(hCryptProv, buflen, buf)) {
-        error_setg_win32(errp, GetLastError(),
-                         "Unable to read random bytes");
-        return -1;
-    }
-
-    return 0;
 #endif
 }
-- 
2.17.1


