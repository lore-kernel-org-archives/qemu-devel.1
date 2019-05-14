Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20468C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDA9820843
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdsxC1VL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA9820843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52977 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQd0O-0006c2-5h
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 15:22:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvB-0002Tj-1F
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvA-0006ia-1i
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:05 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQcv9-0006he-Rj
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:03 -0400
Received: by mail-pl1-x644.google.com with SMTP id g9so76437plm.6
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 12:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=b42dIpKHYcMh2o6M7wOruwcfvv0uPGu8hN7+qTRYDSE=;
	b=jdsxC1VLgN0tfRuYsyqcgMMtnFn2rns0MUdiBSUqil1G9BwSYYcgE9X0mSutSFdIzZ
	OgCpj90j3LSCTIC8PPXvmW5sgeRNBuMmkKN6g6Tvs3PzVpHhFLP/Nf2eeoc+QiRn+vEZ
	0b9j/yPzyXkO5D+FXBeB47fJnYIcKBg5IuZtLZhZNeMmdkrdhf1TnyqBa2qDOD8tpCoo
	l3DaHuKthgZcE8YW4rFWzcaT+oXmB3CV5Ymgp2LwhOrd5jAWxQMx46W8J6r2dQPq1r/i
	9ZZyW6ImIkpLyUobMXaiTea3ms5JlEEzTikN2AD2nX/Fshsqf42bz1kxTS1Pb8ohAJLH
	cw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=b42dIpKHYcMh2o6M7wOruwcfvv0uPGu8hN7+qTRYDSE=;
	b=CMhqueF3xYnmrlwcpW7f4hpUGLHc5nP5vu0SmFhBfoZWiT5nlkfWb7lkadUTsg7n9Y
	caAKdEpqkLS7S+XHn8uzG8g9dr36xE5nysfw4v/MrBRCMP9XceUv6KHQYQoym4HhlgWv
	/mPsc49ZS580tSR9xBJCKEYlHhLKZsPCsr0z6sKuRak3ft3tCSIf2SQMj23YNYjwXP3e
	2dNLZnh0pG0SJYgJ2HnbUZEzTXwp5R4BafNgDTbCrfFZ+udSdM60WUu6A8QXsQd8W7px
	Z5bV/sjDWXYWPneFjZ9g2pLeOJ9jrB11S3/11ypM+a8feyFFdRPBN92Ul6nL6AFm36Dk
	oy+Q==
X-Gm-Message-State: APjAAAWSM5eMMHMXnqMKB/SxGuACtBjSOrlBnafy+NEVBgueAgbI7iWD
	h6leYPI0+kGGQJfww8V5s4lZz3iX+H8=
X-Google-Smtp-Source: APXvYqxqRNErjpvvAyv64X88A8NWe2ktf2bxLriqArW4jTReZcawkkbYLZEQyiNCiLeekTgK90GonQ==
X-Received: by 2002:a17:902:868e:: with SMTP id
	g14mr40284422plo.183.1557861422596; 
	Tue, 14 May 2019 12:17:02 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	o6sm18682982pfa.88.2019.05.14.12.17.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 12:17:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 12:16:34 -0700
Message-Id: <20190514191653.31488-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514191653.31488-1-richard.henderson@linaro.org>
References: <20190514191653.31488-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v7 05/24] crypto: Use getrandom for
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
index 8999698bc2..9ecec9c494 100755
--- a/configure
+++ b/configure
@@ -5802,6 +5802,20 @@ if compile_prog "" "" ; then
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
 
@@ -7189,7 +7203,9 @@ fi
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


