Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA61AC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A44BD20873
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gb+xsA4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44BD20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52983 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQd0z-00076D-QB
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 15:23:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcv7-0002RV-MW
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcv6-0006bA-Ad
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:01 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQcv6-0006ZU-4y
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:00 -0400
Received: by mail-pg1-x544.google.com with SMTP id a3so51477pgb.3
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 12:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=WcaPjSSW8mCEGy+vfZffpT+ukMC7uteGhxOw5c2wJXo=;
	b=Gb+xsA4UIYZS7cwRNKCo6SpGCgSreXYfWByMU7/mA9nPjkwQxadgEYrs+xeJJRwj+p
	HNGJuwCiKp31mt8+sW8yHU3VPhI5m+VM82GA98KMPCb4ScXgK1tBtG9DHPTLHYD4X5Yg
	chW0MGy7d14uUDyqsFTiaw7u88J484/7B9XqeWCmTHy+CRRUWMr58lhX5iBb9rGnQwO5
	w+Wm0woCLXjLkAKmbjoQBM9WdUZkxHLT9GhYgU76BEFh77r/GXhg5D4QF6aNKjKRKIXJ
	HKiOsM235FPdDUcc6A1ni0U7RYdBTUtl7k+cIFhmXPNa5kIwpDn3itHIeRHOoGtUlLKs
	2MTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=WcaPjSSW8mCEGy+vfZffpT+ukMC7uteGhxOw5c2wJXo=;
	b=kQkkUAQS157FF6LY1RAtGze/FA5gRRXp9LjUgvYYY8WHyFVnS4EmxR1llQmkWi/7pV
	7f41sTShSKfJWkHXw1XR8PaxPvzxy12X3oFJCaSIZFeLkD1wNEv3qOjen2+yxJ+KtOoV
	mWPPe5vmk3pNWKdBhco4wIcB/fgzOsjY8mPj1smiFRQHQQqxqOe2U+zV0QPm6DWtyICS
	IFxcp69kqam20wU1gry5TI/blW8Lo7BqKLz+SYhCVqLF7poVSgqSl/DtJ7p0BIZd7WIm
	G/l/iOaqrnp+9qSFH+bUTvob5Nw+H6jLiXIrAy8EX8VxrWBW+tZpxfJBtSje/YFsvuk/
	7WxQ==
X-Gm-Message-State: APjAAAVmrKVD5spIm+g0W/F4i3dguH2S0dL5ouVOEs1YPYfht1/YnA8T
	uzF5RAaxegonUMSj9rGcFwmHLDD8i8Y=
X-Google-Smtp-Source: APXvYqwctRHMeI2FniMlH0X5NmEGLWKrgHpwgS5pDI6VemboQXbpmeExGEyHGL+qyi6U+PvXpsu+eQ==
X-Received: by 2002:a62:160b:: with SMTP id 11mr43761787pfw.88.1557861418821; 
	Tue, 14 May 2019 12:16:58 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	o6sm18682982pfa.88.2019.05.14.12.16.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 12:16:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 12:16:31 -0700
Message-Id: <20190514191653.31488-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514191653.31488-1-richard.henderson@linaro.org>
References: <20190514191653.31488-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v7 02/24] crypto: Reverse code blocks in
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
Cc: lvivier@redhat.com, berrange@redhat.com, armbru@redhat.com
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


