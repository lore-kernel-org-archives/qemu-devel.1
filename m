Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678D0C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:26:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 312CF206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MO9ov4iC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312CF206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50098 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWsK-0001sh-E0
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:26:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWOr-0008Ln-AP
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWCB-00083L-Mj
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:37 -0400
Received: from mail-yw1-xc2d.google.com ([2607:f8b0:4864:20::c2d]:44154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTWCB-000831-Fw
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:35 -0400
Received: by mail-yw1-xc2d.google.com with SMTP id e74so1231708ywe.11
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 11:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=C5yUHyNINPBjASzQcl4pblPDsyyBX7i3Ae47r1N2nnw=;
	b=MO9ov4iCjqTqWRSLRa+MMwhyhfNR8J5CBshBSM5RXUHwcsALhRWX98E3nGvBo9ftIR
	pzkUS6p6DRHN0OOGS1rjffopEnc3uPbHnrmQuZn/lu/HFcK6fdkKn1CP4lWTtvsP8ISb
	nDOn25cLJMB9WWompAIarJ8XnHwuxKggFDnkRCMmrz9o6q/hrToATasb3VxYRz8choc8
	G4EYHNBIyQ+5f1oDNWsAjJAw6yt7vSijU6jmdEi6nvw7EtG8GWYC2zFkGICS9cXI4B2g
	UrmI9Hfn+0F0aUZyE2ZndPZuAlhuDw2twcABIgo3wWssj/BsoPyW3kVr3dXMBtks+Yay
	y45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=C5yUHyNINPBjASzQcl4pblPDsyyBX7i3Ae47r1N2nnw=;
	b=rD2uCK3OSdzIw0PggGYZl6yH0MzY2QeFmrx2P62X9i2rP5N+4STxmgGZvk1NV2cj3n
	Lw/0tHkqnPN/ECYponP+xSfs2iKun/WTg5LDS74ib0xi8wA9UBwHg+ckY3H916+/uEDu
	jgrc0VNFkTj0O+pPX82pReUF20R8di2s4LuD5fljxTbyjYVFg+P693X1CEch/lcP62jy
	/u6lOQCsI2UlvcVuot/VjmFe0hn1e+51LeWRvP1dxjGUGHVJMW2NOCQSAh1jWl37oWus
	TGc5j9kxQEaGd0xDfl2W030W45riGc+sTVluwv5HxVa3dbpkxXbAXQ+z1uz2/DfveTIJ
	1/dg==
X-Gm-Message-State: APjAAAXLpiFCsIPk4EbPZ20BtzHwc1A1lVqNtIwpKZEeEdWuBc9zbeoT
	nZqIwf+tGNi7uBeAN7fV3HwJewJ6JCI=
X-Google-Smtp-Source: APXvYqwhdJetAXM6PCwdhzYNSGRxZVmZip0OVj2tBq2ddChQuUScEheq1Sx2eurnFoxGCBRzcweWRA==
X-Received: by 2002:a81:7246:: with SMTP id n67mr15937514ywc.423.1558550554455;
	Wed, 22 May 2019 11:42:34 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id
	206sm1299445ywq.74.2019.05.22.11.42.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 11:42:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 14:42:07 -0400
Message-Id: <20190522184226.17871-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522184226.17871-1-richard.henderson@linaro.org>
References: <20190522184226.17871-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c2d
Subject: [Qemu-devel] [PULL 06/25] crypto: Use getrandom for
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
Cc: peter.maydell@linaro.org
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
index 54fa78c4dc..f3526a5bca 100755
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
 
@@ -7204,7 +7218,9 @@ fi
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


