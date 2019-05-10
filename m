Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C02AC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:33:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5953D217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rqRq/qk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5953D217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47496 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9Oe-0000QX-JI
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:33:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MI-0007Jf-MZ
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MH-00060O-Ok
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:30:58 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP9MH-0005zk-IO
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:30:57 -0400
Received: by mail-pl1-x643.google.com with SMTP id f12so1118456plt.8
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=8Bh7531eyDC2/9D2e9XWW3j4XTcdT7MvDIqTNSwlf4w=;
	b=rqRq/qk3z5LDC9iz6nYAtBTgYUsQzGLpDUzuUnkdd8e8U47ENPNnTjWZlAyVXFwBat
	whBGTBdYMfEFgqXDuKGEjd62qQlKYonCB1snwzTL8P6S2M+hDDqFxS85MjKn4NuP4hg4
	wIjPLolf6alu4O9/6T+qQrjVORrAIQymVRh55XESRP2xgi5F5IQearzkRGBfVjDnSBLC
	z73MKP7jYqWbkBUVmUq5JGEopAw1TeBXUTLW8JEiALiLsLayMqNpa0qaaH+UiyNJDznW
	e7i3n1GHfqNc5T0zYctCx8WdfNvvU2BiCKTAgMrKtoBJLpFot0CWF7uQGagAWGcQ3qt/
	Xv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=8Bh7531eyDC2/9D2e9XWW3j4XTcdT7MvDIqTNSwlf4w=;
	b=QMYELBOMefFjXbMJOVuVeaEcKMev01nOeepIeE2vl8suTqaRPMPdO92ID2E44E54f5
	+ZYaEeCX3B6BwBLT9gAJu5YBcmwvIV9wFv18ypQ8xP5GuZRGAcaN96Jg7nlUbZRfhnSr
	f0q5eaj6VDvAY5p0x8E+KbK3ZVjxmLThVwINXNJTH/pIH7NLys09tEjCYKu8jUCxWu2y
	fH9YSN/L+U+HwiJNL+n6u79YkY5GEbHJq/JfypmcPAXLE8XlQw3bnTRH8JjeqgVOFbwu
	nFNKd+iZouf2VU108HSE1d2DFAMjD+lt6I4AXrGHJhommhPgei+hDLfXHdzMlv3ME80L
	mK7A==
X-Gm-Message-State: APjAAAVdpV8s3cUvJ5J6Kpa+WZR3NO2BvyGcp8Li/jEPdI8s9TKiwoUz
	7RR9mLWtMzy1uWCWw4OG93zBBPfRMI4=
X-Google-Smtp-Source: APXvYqxcgPDQ5Yi632qCo0kbqFUx5d1it9CksudC+VUCLqqfC4uYeQuNdmiwjoCXYlzRFHWoZEds/g==
X-Received: by 2002:a17:902:bf44:: with SMTP id
	u4mr14546915pls.171.1557509456326; 
	Fri, 10 May 2019 10:30:56 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	v64sm7936792pfv.106.2019.05.10.10.30.55 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 10:30:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 10:30:28 -0700
Message-Id: <20190510173049.28171-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510173049.28171-1-richard.henderson@linaro.org>
References: <20190510173049.28171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v6 04/25] crypto: Do not fail for EINTR during
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
v3: Rearrage the read loop again.
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


