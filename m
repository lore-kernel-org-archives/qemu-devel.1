Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05764C04AAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:47:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C149220815
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GeOn+gf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C149220815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40202 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRSuK-0003ZQ-0C
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 22:47:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmX-0005Q7-24
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmV-00022z-ON
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:36 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRSmV-00022F-IJ
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:35 -0400
Received: by mail-pf1-x441.google.com with SMTP id t87so2879746pfa.2
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 19:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=5b/CXXH1sN97+phvpOhnV9PZFWQssisrkaRTvx3pjYw=;
	b=GeOn+gf0VHGLYFReV/OeK2f3Yr5lwwS2w1Flkz5OpjwMU3JW0B8MBMvbLL0KJUfVZn
	RbGFtTgawCJlXEnGjIT/n1e0+onCer4jrUCdVw4Fk6tXmTTik9H0KrRd1WZUdhTf07Ax
	pW0ch3iJ65Zxa7rUCWhgAZ2mw8O4fsL6BECKhjEUyWCRBcZsgMIvSipYyob8dCyYXiZK
	AoQuc4pnt9VhTqHNXJcgC7/BS0kOjiBk3BZlmu7eNCz56KCqRJ1s2wCISjQCoVCjINU2
	hoqXniYG3s7G8zjV8Q+Ociw0vOH2NM4xYu/21/yArGuDOmUlWf89RgUiFEl1IZzXbkTa
	gxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=5b/CXXH1sN97+phvpOhnV9PZFWQssisrkaRTvx3pjYw=;
	b=DR2Dc76rJEGlwLqhevscBEP+n0L/uY9wwBmH/zvj/YEhmtpFyAVoCzpbhLtsdXFsDv
	vRrtbcstyj16Q74BtFY1WW31ACEjAba6j2nhPnJ4Gh+SyxLDCpRmUzdFLRTR+NPGpF00
	8hsp20KywdpQpFJUAFEBdkS3AjlNA6LrEaRY9wJojYbKzakwMDlilLzoIN0BBrk6yxEO
	XHOyA5DmhBK8aFPw+GsJMReGJiQNxGDPU4aZ/01v5u0q0PnWkSW8ojhB/Hl824IYN/ZR
	uinCY0QEMODUMetK7OmT2YfZ/+ZNkXMqMdjeql0wpT0FonOz/TuiaFuTv6fhODJl1ZvV
	vOjw==
X-Gm-Message-State: APjAAAXqG/RdMayiygjrcPheEWGKx6FxZHPI3ejq1lKKsMVBGmVi5P6j
	PM3WYV2spM451Lg8YF4hQD5aPYVji3s=
X-Google-Smtp-Source: APXvYqydwobHll0cuEP4oeuuri6G9c+6nMU3v3RFn4hwd00W0ocLawcS09urkSqnhl/qWk2DwOkgBQ==
X-Received: by 2002:a63:1820:: with SMTP id y32mr53536458pgl.287.1558060774259;
	Thu, 16 May 2019 19:39:34 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id w6sm6984152pge.30.2019.05.16.19.39.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 19:39:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 19:39:05 -0700
Message-Id: <20190517023924.1686-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517023924.1686-1-richard.henderson@linaro.org>
References: <20190517023924.1686-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v8 06/25] crypto: Use getrandom for
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

Prefer it to direct use of /dev/urandom.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
index 03e71ef7b6..4e43bf766b 100755
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


