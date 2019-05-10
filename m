Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCC9C04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:43:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17F6B217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h0ZEFgoo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F6B217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35243 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOuYy-00058H-EW
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 21:43:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHl-0006Jj-Qy
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHj-00015I-O1
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:17 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOuHj-0000ug-HI
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:15 -0400
Received: by mail-pg1-x541.google.com with SMTP id t22so2116429pgi.10
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 18:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=WcaPjSSW8mCEGy+vfZffpT+ukMC7uteGhxOw5c2wJXo=;
	b=h0ZEFgooJH5WHwPFZMSTligDsA88+EizQ2Gi+JTj1Gqh2Pky11aDt1EnB3vorhNP4o
	pRCm091sCUrQ0Xg0L3f79HpVXkJHUo9Kt/bvwi9mDCe3BCojk/1TRvOl+fo4Ed6qAv6d
	62hcqB+zRhovSakJfwLyOvkba4xXTFWu/LPDSLHIwgLLzZGLfraXnWiMCZKtr63042vI
	yECcmWNAaTpjk4ce4Kl8iyM7LUr7d5B+R2nOZRfMsPQxB5sIRHBkRnhWp0U7PsmmxUb6
	3zaAaVgy6LRf2jMuS7GYc7otnyGdvGDNjNlHoQ3kBf3uIMnmhAv0Bxm8WpnIfe0tOaQB
	7tuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=WcaPjSSW8mCEGy+vfZffpT+ukMC7uteGhxOw5c2wJXo=;
	b=tottwBsIMMJ/sv3OVtfFl4rbZyE5yDEieXhsMuD6VeC0vQywokkMYoMV0+yvBxYETr
	XLyeeLTRpg9EAj4ih5Ht0yjUmOsh1DLyArKHWVJJPBKj0wSHEq7KQDk11MANHtzQtXA4
	iCtRWSEkR94pfa1CFzfVVd46lA8Ui4gwnI7TDWX5C0U1Rhg420Su1O9880mPCOoBASOO
	TJmYCTNbpxHdDuV5yoF0fkPhAr6W7zCZdUVhulkYVALbCmxxVYRenCsvsXOOPbW8lnyA
	Ara1VizhBl33Jjz3zWLRhu93CbAaI9AVHL/vqQOKpXsG0gbjnHAGzDMN5dYZHHI0o6Xt
	jVgA==
X-Gm-Message-State: APjAAAVzVNNyAjhtwtc+xLf9Y8cDFPzrX/VAKDcIheuRXolQSutk8zTT
	AOTIIIgffexhQ5w20JaziYk2TLmo1aA=
X-Google-Smtp-Source: APXvYqzH/bBT0+w7AsLDZsIS77LGYndCzPJZH7YXA5GSzX4hFQgcezxlpcKTLy8NgR1Yf9VD4Px/kQ==
X-Received: by 2002:aa7:8243:: with SMTP id e3mr9817358pfn.213.1557451504149; 
	Thu, 09 May 2019 18:25:04 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	n18sm8252700pfi.48.2019.05.09.18.25.02 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 18:25:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 18:24:37 -0700
Message-Id: <20190510012458.22706-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510012458.22706-1-richard.henderson@linaro.org>
References: <20190510012458.22706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v5 03/24] crypto: Reverse code blocks in
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


