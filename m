Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3313C04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E4782182B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DwcFA9lK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4782182B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35040 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOuMJ-00020Y-JE
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 21:29:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHk-0006Il-4t
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHj-000147-3r
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:16 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOuHi-0000vJ-TD
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:15 -0400
Received: by mail-pg1-x542.google.com with SMTP id d31so2124830pgl.7
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 18:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=8Bh7531eyDC2/9D2e9XWW3j4XTcdT7MvDIqTNSwlf4w=;
	b=DwcFA9lKFVT3ktTPBdbJzkZtg1ifSLhXJomWhhU457RtwvhB+1003y9TgSYGyTBbyM
	/z2t6iHq552O93wdb/aYLTkfJAAGBfO0YjBNo3D/Z+zYXgoU7Wuj59ZIi39uy3kMUq/L
	lcZvUPsnxQyu/HnLIdWIYGkJvJBbhF7oDzUJxTbTQCR0Via3ambGFaBgQ3/3MEPpaIRU
	Gp9EtjI4RnnjFRaMQEV5//jOUgha3LEcCnjNX8VJbAjJlVfSF+p+uW5t6lpjdpCDDzpF
	3oFvj+uUaCnXK16KLelYS4hukbS5p/hUuMa4JHrfhnCphhdy9GbHpPoQV6zUXpf2DYW3
	7DZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=8Bh7531eyDC2/9D2e9XWW3j4XTcdT7MvDIqTNSwlf4w=;
	b=BVQXGPm+CrEl7641O9EKC5zPd6O9raAFqt9+zY654CF/T/ZTmbtPFoz37rzu5sVWj+
	NxlNTf6OuPLRt/KAcJRVoL7vvN28lFn7+MXVzXLxFWAnInCBFPGSJLnZ+Isu5VdCM9jW
	qFhKmTu+aRgdVgil8Ve1Ei1VZXQv15zUNVlwNsZg0ifh1/YoaDkO1/T52n6D2Nj1XEve
	XDP2zVvrsAWAUTUMRxUNNmEOthlIPDmNHKHceeooXXb7pOPxMfEYi82xjdlq7Qm0Qtee
	sAHs1Mf5g1CQ/Qn/rK8P46+dilIWTu3X80XEqRKpfblFbLATgtpqwtDbxRCwq6w5EOEt
	jzYA==
X-Gm-Message-State: APjAAAVxovuw/xRid+n6DLxfxBaGZ7OI/6zF+lWvHat4RaPd9swICcZH
	QDK4gcuZuEVQ5L6ykVEotT+dKzvNIkw=
X-Google-Smtp-Source: APXvYqy2XsBCayaor5ePQNjPm0w4wnvPxOUhf8FpcVBbUIy4eCh+xMgDT8kaZsyQGBjrDaz6XmDwjA==
X-Received: by 2002:a62:1a0d:: with SMTP id a13mr9876113pfa.198.1557451505482; 
	Thu, 09 May 2019 18:25:05 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	n18sm8252700pfi.48.2019.05.09.18.25.04 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 18:25:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 18:24:38 -0700
Message-Id: <20190510012458.22706-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510012458.22706-1-richard.henderson@linaro.org>
References: <20190510012458.22706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v5 04/24] crypto: Do not fail for EINTR during
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


