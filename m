Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751E2C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:36:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42C73206A3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QlAFgO6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C73206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59926 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhX2-0002Y6-Gk
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:36:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhV9-00010o-3N
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhV5-0001Fm-2Y
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:05 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNhV3-0001Dv-2O
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:02 -0400
Received: by mail-pl1-x644.google.com with SMTP id b3so6706946plr.7
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 10:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=O1PQbxI86I2bI4Y4HCTdo78SLn5JqRTP/j+lnThrZ4M=;
	b=QlAFgO6bdhjojlKOog/QcrhXghb0rPMOgocTzc6WOYuB9M9c9XWFW5GG7hObkuqCht
	pBpqklm8CjGR79JFXs0OJlutcc1ViafuuU5LGZNKxVSjPlW+ow3qAZqePYbdOSXJ2LaZ
	oOy+Ig55KCJhAvOhbuVgWvjPrGhR+AxEe3ma0ockDfm3hgssTi3poJXuG385cSYsLZId
	+S5M0SuH0w7Gn2JnJmlBLliWl9P70nBbYTtmW4oZHCs5ivlfiXjK1D25tMjpKaJY+B6a
	iJBA3d2zv91M+nHBuTewjMNGnZTRY/GcCO9Gb1A6A0ToGiBTsr6LXRORaRqj6t5GmygW
	HyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=O1PQbxI86I2bI4Y4HCTdo78SLn5JqRTP/j+lnThrZ4M=;
	b=n/0E/1oTSLfjKR4eoF3sf/KmCV4DtGqKxtrE+oqUvl2LDlmU39/eSWfGe0d9zv6UrQ
	NypLreU0eBKSnq1C+CJ1+1Cp+amMUk8bsc+iVxOCRmxY4xmxAxZSjkIMRnaHvkAEiH30
	8I7fUdl5TGObSEvxxw0E5I0fUkWilgOWYhWlo80KNG/JoFLsUaqq4CkfrEnIw3CWZi1+
	58R9AQODRG/+9eBrqDWRyx84FV8OFIfxhUuGmUzkMAZSLFpHJgzqlS86aUzOHD5W7unS
	6H4BzDsTUJUCz8HOXLY/Avd0z08MfRRspOWICp+Kly3D6bQHtP+srvvn2G1NWVG2Old2
	F+Hg==
X-Gm-Message-State: APjAAAUO/p7hwfgTHiuUSg+uq3BAMMbue03uvmuH1tYSPd933cjn7k+G
	OjHpk70Sdo82YoKIpUWE5mjmAieATys=
X-Google-Smtp-Source: APXvYqze7WdOEl63SvFyvueS7l2jIOZw+VLFgZ/GaAvxAb9CDb726Xd5HnDC2ADAsS/BaFTNOtoHtQ==
X-Received: by 2002:a17:902:e612:: with SMTP id
	cm18mr10597325plb.255.1557164039170; 
	Mon, 06 May 2019 10:33:59 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	k9sm2268839pfa.180.2019.05.06.10.33.58 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 10:33:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 10:33:32 -0700
Message-Id: <20190506173353.32206-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506173353.32206-1-richard.henderson@linaro.org>
References: <20190506173353.32206-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v4 03/24] crypto: Reverse code blocks in
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


