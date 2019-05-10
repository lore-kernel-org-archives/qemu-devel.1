Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBEFC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:33:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E5C1217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xAjEu1X4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5C1217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47494 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9Ob-0000Nq-LS
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:33:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MH-0007It-Mo
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MG-0005zW-Kf
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:30:57 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP9MG-0005zH-Ey
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:30:56 -0400
Received: by mail-pg1-x542.google.com with SMTP id i21so3315306pgi.12
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=WcaPjSSW8mCEGy+vfZffpT+ukMC7uteGhxOw5c2wJXo=;
	b=xAjEu1X4VlwRNknwmCYR+OOCLDvWztfWn8u8HXL2EOv1yj13dUGgXj20X7w/OaSivF
	rNvoEyyBkHTS2a723pigY9zxxhaJ6uqFF3oTOF498ZLQSqGXEQkujln9Cica1O57I/wb
	HJzBcqNke4rvAV74vwV6rMrwnYt5YImMGdOS91S1bvm1lCe0iBwnmYqOLUaJKadk9vma
	krOvoxFt2kdGlamxH2HhL2tqJZxNYyTzm4tPNhCu7eiwnZtaoARcBBnrkLGly/wz4ZB3
	2JCPBGdj3CmePAXZTmz/qbR2Zb3JNAmvewTtX8HRxgrBhC+F6MA+9OXsdAB5Bi9wrVb3
	cy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=WcaPjSSW8mCEGy+vfZffpT+ukMC7uteGhxOw5c2wJXo=;
	b=H/37sbIeO7BUzawcBwbkZZq9yavTeATFKy5etOVKQHik5NBGMZPEKCIgO+r6f/Nzs0
	UuZo/Fa3WI4SX7uBQnmL65NvGrdblgb5vyDepC1bpc9v+UFJsQODuSCw1VpLWZDNeP5F
	DmyOp+CKzD9j3g9MGQrQyUm717OBpJzOvv7RKwrdCMUjlF5yGikskv2f7RaYUIvdHDfw
	u1qKw5rqmkQpSI+tTB+3r36DY+IRb31EUnNQbQ50+EiuzVjWfy8iMRVI3AdHvj3Xwwcu
	e8F526Qo5Wy9oDhSA4yAaNiFBHCQ5fduOInoRFsdakwNoYUr/Hf3D/Ee/r8P/ytsTHnw
	E4lw==
X-Gm-Message-State: APjAAAV8DnsK9eROcTsGz+N2Dad5XM2uby+OrkrVPGvWCJUQcRBx2b4k
	tUBYitjG8IRQd3OynkVi/BenFcToLUk=
X-Google-Smtp-Source: APXvYqz1xyT4EJQd+Dav5geMMhH3pZxWJj5l5LQE4zF2FambOv4Ia7Bq/gp3cseR5/06lMD/QHPWsw==
X-Received: by 2002:a63:2c4a:: with SMTP id s71mr15157285pgs.373.1557509455148;
	Fri, 10 May 2019 10:30:55 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	v64sm7936792pfv.106.2019.05.10.10.30.54 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 10:30:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 10:30:27 -0700
Message-Id: <20190510173049.28171-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510173049.28171-1-richard.henderson@linaro.org>
References: <20190510173049.28171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v6 03/25] crypto: Reverse code blocks in
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


