Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA0FC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:41:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAE6D2082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pkil7NXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE6D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59999 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhc5-0007Pb-Ki
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:41:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVA-00011n-5x
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhV9-0001IE-3l
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:08 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNhV5-0001Ee-03
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:04 -0400
Received: by mail-pf1-x443.google.com with SMTP id z28so7145429pfk.0
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 10:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=SxHcSgvXH46Lcz+sBihH+DQ9BaQG6plA/B5ZKvOuxJA=;
	b=pkil7NXwQ0LqaEBzco3zRNKPlgnZYoK7PI32QoHcMkfhprBVa99RoQqn/KxfbNUL6f
	RzNppNhYONng6jOice7MGDn2zEVZHhdecPTJSWaMIKKLHAH2vamr9OdQ8PvekzWNkR20
	/5q+jzRDAzNwpQB3YnfEcbJ4BZxtGIO3pSSu/RPY3MxaLfbkF6ZEQo0nhHc+YjQLcHDN
	i9fXAcPn/IJOMT5DuRTDMP/EY2DYx2Lm6H0WeDlgBLG3DUN+h9aj4u+4il7mWeSVrVwF
	7R4JBa0ynT2c7RW151zD6hJnZmrqnMsjlmlTVzdb7vCpoEy6dQ44Bz90jc8c6ZZ93gSo
	S5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=SxHcSgvXH46Lcz+sBihH+DQ9BaQG6plA/B5ZKvOuxJA=;
	b=cMS6Tbr4oiVKNJ56B7PzqlVYh9ooEgFOFq0PlUBPEzwBwFKqb/pBVM3woy6wkLbjOg
	UaEFdCSH0i3MZFS8qaJwOOvTWvs12/r6u29vfV2R0ETb2jcifRCtz/sQTKsjkFTo1fcQ
	u0rB7Ahu6pnI4hrRHXC1SYRiKoFQQsxKUCiDop6oUYC02qXt05xhiNXOqeGn0a3Yuhuw
	w9wLdWaoE1xclv/42hrbpZa1k1wFthL2ziL87nc/ZXZDW8Y27Pj7Wx1Vlw1sRDHzAbuG
	fca+wQXJcdKZxJ4DgxwBjKAKI2SmlyNQNljHiHuY/c5AHrvGevzqoG8b2LwnwCOr9ALQ
	WyCA==
X-Gm-Message-State: APjAAAXcBHo4lzwkyNNwwTEmCFkxMfBPFXieFuUkLAGrFouQ2nCBFy/O
	sFr96i+oRoLSYt+PmBqGO71pOfoQu9Y=
X-Google-Smtp-Source: APXvYqxb38FwDYIByAhdPO3V7+E9BOFbTlDNsKardpoR4xNDU1CQ9HmBOON6QzU6O+evYqmrodPW7Q==
X-Received: by 2002:a63:4a5a:: with SMTP id j26mr32302687pgl.361.1557164040520;
	Mon, 06 May 2019 10:34:00 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	k9sm2268839pfa.180.2019.05.06.10.33.59 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 10:33:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 10:33:33 -0700
Message-Id: <20190506173353.32206-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506173353.32206-1-richard.henderson@linaro.org>
References: <20190506173353.32206-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v4 04/24] crypto: Do not fail for EINTR during
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


