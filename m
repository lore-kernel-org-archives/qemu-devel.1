Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E84C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:19:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE61D20881
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MV1an0vg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE61D20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52922 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQcxW-0003fZ-TW
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 15:19:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcv8-0002SE-Fb
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcv7-0006cz-HD
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:02 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQcv7-0006by-By
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:01 -0400
Received: by mail-pl1-x644.google.com with SMTP id r18so59138pls.13
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 12:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=VqY3mH4YRn0WtpmEi7qlWT5KRhdZPDg5AxBMBXlF56s=;
	b=MV1an0vg/aEqlkOwBdnA9NRpAfsJuH1ukbkckmaIgldQYs+e8INRbWBqaMeKoFt/RH
	H3WtchNWEb3bXwtdWHJi9JvqgmzvsuQ2a/YCoZgqQpj9N/izR4jldIXaXmdPivg1+qtg
	R09ts4LpJQrvvpj2FRSGAdmBO/VsmL/ni0IakBhLSLFPcXadNvVDohPmvo1e6FxBpYm+
	sI29s+bMRGnRVnsTckOg5sgSSywdrVRd+mvWhXDcULZ5uq0EVendavYO9AzYLCJclOy/
	7XJ0Zs24mUD597t8Ok3pUDInm8NRmJZyZKcjKeiut+5SQGbZ/exf2CsozEIh/5ho9TxH
	/zqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=VqY3mH4YRn0WtpmEi7qlWT5KRhdZPDg5AxBMBXlF56s=;
	b=rnZnGLZbU8sCUxS1cAaDvk8b1KABeIDgQk84u8vvDIujg94bDCpqjL1lN0VGDY1AQ/
	1AFFjcNUfLa5hJQMPHrk7g+Iucl7WKbZQtSXw7aSYZFu/7gBP60FUC2x7GqrziEJnJnE
	Uyehy1y/CbbJUnXBJ0Wxt/1qC9x5b9tVOl1BdJnq7ktXNmWp1v6zDkjX4QrBtpIB8kUW
	9l7ebeI+KJ5VeVrkTH3mD3SHuFNWBI3Waphh+e8FUQawi534Sh4NAG6G8YAhBDxngtvU
	mPNKU+2qylyEmKs+yUx5+r1XteWPHG99NuI4CXtaSbHgIH3KmMhEKluBEpc8bfcAmGuU
	oduA==
X-Gm-Message-State: APjAAAXGd+N4pzCN3vFeGGzzi3VxiZz3l6F7aJfCupenWjH7t8c2+58p
	6EYqwy3IrYkKzeQd1xgkwnQyzzaMMhk=
X-Google-Smtp-Source: APXvYqy/9kjNWrfKiRjJ2jkACGJwi/jjbI1W/q0zvF+tIyzE7Teewbnb+GYLZkbhUs1ZwILezt9J5A==
X-Received: by 2002:a17:902:5e1:: with SMTP id
	f88mr38615351plf.226.1557861420082; 
	Tue, 14 May 2019 12:17:00 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	o6sm18682982pfa.88.2019.05.14.12.16.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 12:16:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 12:16:32 -0700
Message-Id: <20190514191653.31488-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514191653.31488-1-richard.henderson@linaro.org>
References: <20190514191653.31488-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v7 03/24] crypto: Do not fail for EINTR during
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


