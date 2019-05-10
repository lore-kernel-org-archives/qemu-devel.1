Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14A4C04AB3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:30:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA3C2182B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XxvdoYnu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA3C2182B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35044 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOuMN-00022y-13
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 21:30:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHl-0006JE-6z
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHj-00014r-Hm
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:17 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOuHj-0000wf-9W
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:15 -0400
Received: by mail-pg1-x544.google.com with SMTP id t187so2110959pgb.13
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 18:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=BFNXO+CSJUIyB4vBsJmwl02buO19GtyllxlmqyS+gn0=;
	b=XxvdoYnu/rv+yVFaQhy06prW9DgtX1zofcjIsKgTv4Vg+lbuzWn/7KYvh+qt7Ev5aY
	7uN1GvLgirtJ0T87KDGPIhqKAVUecvVj0EHZoP/zDM2+tM73IlWJ8IO4BMxtFwP4FIBi
	7wGbn2eJ5t/eeZ8N+PXxbk+c7lMD9al9Roa81UagbADYK8qlvBtlnYYhKiuv64yIypXj
	kHU7eX4G5sxjJLhevNWYE9I02jJHtifpWeiZQ5v8V7DZxoAogbvPAmj4X87Eh8rxduQ1
	bBGc1PFXifsGZtbaYRHPLo/r5DYJNDMPrU3P2SnWPZN3fNRfL66MQgz3la9ZfT1y5H+T
	FZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=BFNXO+CSJUIyB4vBsJmwl02buO19GtyllxlmqyS+gn0=;
	b=P/IaUWn5ev0gDn7ofDw/Nsqh27lYTuqRwUGsqYls1m1J6y2GagxFIAYYzX94H8cZ4T
	akf2S9HvE4Ung6D8PULeV8v/3QvIsyYJZabM0G735HNCWf1j4v8ibLIaxUlcUTbxgkMP
	jXmk4g77AkWaK0e1ZCeqAtqCB87ji9sNLTyrmiVv0rSIqK/8kn5SulArDkljFx1TIyt3
	FBGqoCdi94NIV0vFRDNu6bX3LKk+GFbIV9t6T9dYDs2UnZj+jOzAIpfZSjR5063+E3rd
	EmYlDPKSp04nhkpUyfVXrNKPY8gzGt1ZgTbHyNm355R0lvDyYBtVrPSSlu8EFAZWnM0/
	iU1Q==
X-Gm-Message-State: APjAAAWRv6DISxWH1iVKQ3Adamls/H9kDH7cPQy2mkc3iAGWeKF7LnZb
	4tZGJEN0CRZ0dBn975DzdtB8iy8EgnA=
X-Google-Smtp-Source: APXvYqzRJmbHJJXTgSh6D+CDba/eqXWEuAgshJkccQFhqRb2ez8M6nDv+5Ua77YWJrV0Rb9A767GWg==
X-Received: by 2002:a62:582:: with SMTP id 124mr9913664pff.209.1557451508029; 
	Thu, 09 May 2019 18:25:08 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	n18sm8252700pfi.48.2019.05.09.18.25.07 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 18:25:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 18:24:40 -0700
Message-Id: <20190510012458.22706-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510012458.22706-1-richard.henderson@linaro.org>
References: <20190510012458.22706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v5 06/24] crypto: Use getrandom for
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

Prefer it to direct use of /dev/urandom.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: If getrandom is not present, fall back on /dev/(u)random.
---
 crypto/random-platform.c | 37 ++++++++++++++++++++++++++++++++-----
 configure                | 18 +++++++++++++++++-
 2 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/crypto/random-platform.c b/crypto/random-platform.c
index 6df40744c7..cb3ca1bc09 100644
--- a/crypto/random-platform.c
+++ b/crypto/random-platform.c
@@ -27,7 +27,11 @@
 #include <wincrypt.h>
 static HCRYPTPROV hCryptProv;
 #else
-static int fd; /* a file handle to either /dev/urandom or /dev/random */
+# ifdef CONFIG_GETRANDOM
+#  include <sys/random.h>
+# endif
+/* This is -1 for getrandom(), or a file handle for /dev/{u,}random.  */
+static int fd;
 #endif
 
 int qcrypto_random_init(Error **errp)
@@ -40,15 +44,20 @@ int qcrypto_random_init(Error **errp)
         return -1;
     }
 #else
-    /* TBD perhaps also add support for BSD getentropy / Linux
-     * getrandom syscalls directly */
+# ifdef CONFIG_GETRANDOM
+    if (getrandom(NULL, 0, 0) == 0) {
+        /* Use getrandom() */
+        fd = -1;
+        return 0;
+    }
+    /* Fall through to /dev/urandom case.  */
+# endif
     fd = open("/dev/urandom", O_RDONLY | O_CLOEXEC);
     if (fd == -1 && errno == ENOENT) {
         fd = open("/dev/random", O_RDONLY | O_CLOEXEC);
     }
-
     if (fd < 0) {
-        error_setg(errp, "No /dev/urandom or /dev/random found");
+        error_setg_errno(errp, errno, "No /dev/urandom or /dev/random");
         return -1;
     }
 #endif
@@ -66,6 +75,24 @@ int qcrypto_random_bytes(uint8_t *buf G_GNUC_UNUSED,
         return -1;
     }
 #else
+# ifdef CONFIG_GETRANDOM
+    if (likely(fd < 0)) {
+        while (1) {
+            ssize_t got = getrandom(buf, buflen, 0);
+            if (likely(got == buflen)) {
+                return 0;
+            }
+            if (got >= 0) {
+                buflen -= got;
+                buf += got;
+            } else if (errno != EINTR) {
+                error_setg_errno(errp, errno, "getrandom");
+                return -1;
+            }
+        }
+    }
+    /* Fall through to /dev/urandom case.  */
+# endif
     while (1) {
         ssize_t got = read(fd, buf, buflen);
         if (likely(got == buflen)) {
diff --git a/configure b/configure
index 68b34a93eb..346f89ea6c 100755
--- a/configure
+++ b/configure
@@ -5815,6 +5815,20 @@ if compile_prog "" "" ; then
     have_utmpx=yes
 fi
 
+##########################################
+# check for getrandom()
+
+have_getrandom=no
+cat > $TMPC << EOF
+#include <sys/random.h>
+int main(void) {
+    return getrandom(0, 0, GRND_NONBLOCK);
+}
+EOF
+if compile_prog "" "" ; then
+    have_getrandom=yes
+fi
+
 ##########################################
 # checks for sanitizers
 
@@ -7202,7 +7216,9 @@ fi
 if test "$have_utmpx" = "yes" ; then
   echo "HAVE_UTMPX=y" >> $config_host_mak
 fi
-
+if test "$have_getrandom" = "yes" ; then
+  echo "CONFIG_GETRANDOM=y" >> $config_host_mak
+fi
 if test "$ivshmem" = "yes" ; then
   echo "CONFIG_IVSHMEM=y" >> $config_host_mak
 fi
-- 
2.17.1


