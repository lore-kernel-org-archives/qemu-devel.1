Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A77AC04AAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3784F20815
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZklSu4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3784F20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40206 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRSuT-0003fM-EA
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 22:47:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmU-0005Ne-HW
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmT-00020l-GC
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:34 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRSmT-0001zx-AI
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:33 -0400
Received: by mail-pf1-x442.google.com with SMTP id v80so2879662pfa.3
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 19:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=VqY3mH4YRn0WtpmEi7qlWT5KRhdZPDg5AxBMBXlF56s=;
	b=bZklSu4nLG9mzO4Em6BjiaiukE2qTMXlROCJUwW7jLFSfh4FmkSKL8zMx/h20r7zPk
	3QCBpWW6AuyLAGNrq48A24n2UOsItxqVbtqXd3ZfoMnQF7MaV+kxKfr6vhFJ9XSynyc4
	/k+r71HE3Vf9fjtaG7nMjk7bSdUBImGMqmQP89LPMzMvhnUGKJFPUDvM81BW+cYA4Gkg
	X6vrX06U9ZgE9gT/AdiIPq2yiGPRxd9Swve70MDZaM2HmYMWtitNFxf7i4/8kFx+A72z
	KoigzvcXeuGNs5nT8wHC9yn0R2lR+GnAZrUmqeKKfy0nJpC54JlsTAka11Eg9aAfeUKw
	43yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=VqY3mH4YRn0WtpmEi7qlWT5KRhdZPDg5AxBMBXlF56s=;
	b=BHfwTaMiiubONQspuZ8lchYanQmamtdFnn4wwVbdPOmphpe0z1M0KtcogbgJAfyvXN
	AakKgTooycZhugiUCV6L/MgDJ/Id56I2zI7TshfHhI/RJ92/nMD9G5XFnGCUtYt0u3pT
	vQqA7NRKKDtjJ9nPyzeQCwV82Xr/0nc550uqRVNtm4xDNDSL9Wk+8Xps5qcpPyZ68gY+
	WcUh9y0gviEPWH6R/KHHGADw9xEVMRvYCeZRa2/oYh60B60zGkph+bZMphCwx5GKy/mS
	bwUIepiFJZOnyMe48scKgA+9VqAul4dbnKLTqV0NIUJwnzWqsK/JzOKDm9wbzXrrYpla
	kqaA==
X-Gm-Message-State: APjAAAXteFS5hxjzOXeiZvQOesedX7yA2z1G5tQyL0XibQeuHtzWxXl0
	mk92Tnnltkohlxw7fV68Hg8qIQ5cwdw=
X-Google-Smtp-Source: APXvYqybXpc205TJ723aGKc4I7rd/tC8Ko7fL5ffaiKnY+oVP3iDFK0zp8j3yenkVXf9cCiNE6ZsNQ==
X-Received: by 2002:a62:460a:: with SMTP id t10mr56441228pfa.3.1558060772044; 
	Thu, 16 May 2019 19:39:32 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id w6sm6984152pge.30.2019.05.16.19.39.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 19:39:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 19:39:03 -0700
Message-Id: <20190517023924.1686-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517023924.1686-1-richard.henderson@linaro.org>
References: <20190517023924.1686-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v8 04/25] crypto: Do not fail for EINTR during
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
Cc: lvivier@redhat.com, berrange@redhat.com, armbru@redhat.com
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


