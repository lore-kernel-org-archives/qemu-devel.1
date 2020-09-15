Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C3DC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:16:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D1E20809
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7OksgTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D1E20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEZV-0002hC-F8
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEWq-0008Og-UP; Tue, 15 Sep 2020 13:14:04 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEWb-0002hJ-79; Tue, 15 Sep 2020 13:13:51 -0400
Received: by mail-pl1-x642.google.com with SMTP id m15so1680304pls.8;
 Tue, 15 Sep 2020 10:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1gV36UyFTTlxX7DXEu6PxeSpMxMsQkvp2T6CJZpr6M4=;
 b=F7OksgTpm4xikeAB6pUn0PKhkCG1HYdBdaPXKdxbUb99SsWP4jE7yUnm4N67Nfolxu
 JbnM7OtH/HNST9v+c+mU5emhsHYPY2idp6MImPtiAScrrS1oSxrRhyNlVEHkVUzvJUBz
 COFbfRD7pW7v9KL+9+YpsKkk++OINsCn2e4ogCGafz4WuO7GZP9gp2CQ3egJqGBEyouj
 txGslQk36y6WyU4mhKUfRosYnWXLfyyO355KkJdZx61a07BA/MQqnspLuxe3+1+sgE0t
 hDI7+pZzRZZ1KE7IfQOvnRTNPYuJYh052TOGRGNIG9NpGiOpx88PV4zRk2ZSPEWAkDTZ
 Q/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1gV36UyFTTlxX7DXEu6PxeSpMxMsQkvp2T6CJZpr6M4=;
 b=bA6CGkWTEXYmwjPrMSnQS680i+vgIKkgGnQXl96m2PJnSHLIJeRWtLprKvc9ohiHZo
 qH6tfLhM3EGd0rDqVF2NThAfMCkif9VRNZrk+wG6g+zbRT5A08LNTt91eDhvubnr8wPK
 KNvEXfJBHFjugVc9QKKNyuCFPlHMVq0/198q9uk2re0XuFnxGWpVUlpknxPVwSKY7/24
 ZJPh7Idcy4tQUu9TLSB49gdapQg82anbQvvIveeZV+nRfEo0L4/oiJTPOza7RhZVH4t/
 2BqxT+AvhMp9soGnBQy+FC5I67IFPkUUOwAkKz3dTA9Wpvs8WeAd4TsGSdABWkBjyQFZ
 yPqQ==
X-Gm-Message-State: AOAM5312WVUubuVOVte2HZV6dDyKhUMQqEVuvIslNenqjyvhBgoi75kf
 9DNrYrINJ0AfZAzy1gou4tgfulJzFGpJ8S5z5S4=
X-Google-Smtp-Source: ABdhPJwV6SF6ayVlN/bS2iA+A1VgY8x4f0Zl2KkFnmb7Te9lvBJ+8x9LG6RqMfZlP5CYAS7F+xSgyw==
X-Received: by 2002:a17:90a:cf07:: with SMTP id
 h7mr344735pju.142.1600190026608; 
 Tue, 15 Sep 2020 10:13:46 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id j14sm124046pjz.21.2020.09.15.10.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 10:13:45 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 12/26] tests: Enable crypto tests under msys2/mingw
Date: Wed, 16 Sep 2020 01:12:20 +0800
Message-Id: <20200915171234.236-13-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915171234.236-1-luoyonggang@gmail.com>
References: <20200915171234.236-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes following tests on msys2/mingw
'test-crypto-tlscredsx509'
test-crypto-tlssession'
'test-io-channel-tls'

These tests are failure with:
ERROR test-crypto-tlscredsx509 - missing test plan
ERROR test-crypto-tlssession - missing test plan
ERROR test-io-channel-tls - missing test plan

Because on win32 those test case are all disabled in the header

Add qemu_socket_pair for cross platform support
Convert file system handling functions to glib
Add qemu_link function instead posix only link function.
Use send ad recv from qemu that convert Windows Socks error to errno properly.
Use g_remove instead unlink
Use g_mkdir instead mkdir

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/osdep.h             |  1 +
 include/sysemu/os-win32.h        |  5 +++
 tests/crypto-tls-psk-helpers.c   |  4 +-
 tests/crypto-tls-x509-helpers.c  |  6 ++-
 tests/crypto-tls-x509-helpers.h  |  5 ++-
 tests/test-crypto-tlscredsx509.c | 47 +++++++++++---------
 tests/test-crypto-tlssession.c   | 64 +++++++++++++++------------
 tests/test-io-channel-tls.c      | 49 +++++++++++---------
 util/osdep.c                     | 16 +++++++
 util/oslib-win32.c               | 76 ++++++++++++++++++++++++++++++++
 10 files changed, 197 insertions(+), 76 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index e80fddd1e8..dd4c63e4b6 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -499,6 +499,7 @@ int qemu_mprotect_none(void *addr, size_t size);
 
 int qemu_open(const char *name, int flags, ...);
 int qemu_close(int fd);
+int qemu_link(const char *exist_path1, const char *new_path2);
 int qemu_unlink(const char *name);
 #ifndef _WIN32
 int qemu_dup(int fd);
diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
index 3ac8a53bac..8863833f67 100644
--- a/include/sysemu/os-win32.h
+++ b/include/sysemu/os-win32.h
@@ -194,4 +194,9 @@ ssize_t qemu_recv_wrap(int sockfd, void *buf, size_t len, int flags);
 ssize_t qemu_recvfrom_wrap(int sockfd, void *buf, size_t len, int flags,
                            struct sockaddr *addr, socklen_t *addrlen);
 
+#undef socketpair
+#define socketpair qemu_socketpair
+int qemu_socketpair(int family, int type, int protocol, int channel[2]);
+
+
 #endif
diff --git a/tests/crypto-tls-psk-helpers.c b/tests/crypto-tls-psk-helpers.c
index 11ae26368c..6f82bfceb2 100644
--- a/tests/crypto-tls-psk-helpers.c
+++ b/tests/crypto-tls-psk-helpers.c
@@ -26,6 +26,8 @@
 #include "crypto-tls-psk-helpers.h"
 #include "qemu/sockets.h"
 
+#include <glib/gstdio.h>
+
 #ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT
 
 void test_tls_psk_init(const char *pskfile)
@@ -44,7 +46,7 @@ void test_tls_psk_init(const char *pskfile)
 
 void test_tls_psk_cleanup(const char *pskfile)
 {
-    unlink(pskfile);
+    qemu_unlink(pskfile);
 }
 
 #endif /* QCRYPTO_HAVE_TLS_TEST_SUPPORT */
diff --git a/tests/crypto-tls-x509-helpers.c b/tests/crypto-tls-x509-helpers.c
index 01b3daf358..051f045657 100644
--- a/tests/crypto-tls-x509-helpers.c
+++ b/tests/crypto-tls-x509-helpers.c
@@ -23,6 +23,8 @@
 #include "crypto-tls-x509-helpers.h"
 #include "crypto/init.h"
 #include "qemu/sockets.h"
+#include <glib.h>
+#include <glib/gstdio.h>
 
 #ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT
 
@@ -133,7 +135,7 @@ void test_tls_init(const char *keyfile)
 void test_tls_cleanup(const char *keyfile)
 {
     asn1_delete_structure(&pkix_asn1);
-    unlink(keyfile);
+    qemu_unlink(keyfile);
 }
 
 /*
@@ -501,7 +503,7 @@ void test_tls_discard_cert(QCryptoTLSTestCertReq *req)
     req->crt = NULL;
 
     if (getenv("QEMU_TEST_DEBUG_CERTS") == NULL) {
-        unlink(req->filename);
+        qemu_unlink(req->filename);
     }
 }
 
diff --git a/tests/crypto-tls-x509-helpers.h b/tests/crypto-tls-x509-helpers.h
index 08efba4e19..0856934a70 100644
--- a/tests/crypto-tls-x509-helpers.h
+++ b/tests/crypto-tls-x509-helpers.h
@@ -24,8 +24,9 @@
 #include <gnutls/gnutls.h>
 #include <gnutls/x509.h>
 
-#if !(defined WIN32) && \
-    defined(CONFIG_TASN1)
+#include "qemu/osdep.h"
+
+#if defined(CONFIG_TASN1)
 # define QCRYPTO_HAVE_TLS_TEST_SUPPORT
 #endif
 
diff --git a/tests/test-crypto-tlscredsx509.c b/tests/test-crypto-tlscredsx509.c
index f487349c32..62d5d2defd 100644
--- a/tests/test-crypto-tlscredsx509.c
+++ b/tests/test-crypto-tlscredsx509.c
@@ -25,6 +25,9 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 
+#include <glib.h>
+#include <glib/gstdio.h>
+
 #ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT
 
 #define WORKDIR "tests/test-crypto-tlscredsx509-work/"
@@ -77,34 +80,34 @@ static void test_tls_creds(const void *opaque)
     QCryptoTLSCreds *creds;
 
 #define CERT_DIR "tests/test-crypto-tlscredsx509-certs/"
-    mkdir(CERT_DIR, 0700);
+    g_mkdir_with_parents(CERT_DIR, 0700);
 
-    unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
+    qemu_unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
     if (data->isServer) {
-        unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
-        unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY);
+        qemu_unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
+        qemu_unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY);
     } else {
-        unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT);
-        unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY);
+        qemu_unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT);
+        qemu_unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY);
     }
 
-    if (access(data->cacrt, R_OK) == 0) {
-        g_assert(link(data->cacrt,
+    if (g_access(data->cacrt, R_OK) == 0) {
+        g_assert(qemu_link(data->cacrt,
                       CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT) == 0);
     }
     if (data->isServer) {
-        if (access(data->crt, R_OK) == 0) {
-            g_assert(link(data->crt,
+        if (g_access(data->crt, R_OK) == 0) {
+            g_assert(qemu_link(data->crt,
                           CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT) == 0);
         }
-        g_assert(link(KEYFILE,
+        g_assert(qemu_link(KEYFILE,
                       CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY) == 0);
     } else {
-        if (access(data->crt, R_OK) == 0) {
-            g_assert(link(data->crt,
+        if (g_access(data->crt, R_OK) == 0) {
+            g_assert(qemu_link(data->crt,
                           CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT) == 0);
         }
-        g_assert(link(KEYFILE,
+        g_assert(qemu_link(KEYFILE,
                       CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY) == 0);
     }
 
@@ -121,15 +124,15 @@ static void test_tls_creds(const void *opaque)
         g_assert(creds != NULL);
     }
 
-    unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
+    qemu_unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
     if (data->isServer) {
-        unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
-        unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY);
+        qemu_unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
+        qemu_unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY);
     } else {
-        unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT);
-        unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY);
+        qemu_unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT);
+        qemu_unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY);
     }
-    rmdir(CERT_DIR);
+    g_rmdir(CERT_DIR);
     if (creds) {
         object_unparent(OBJECT(creds));
     }
@@ -143,7 +146,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     g_setenv("GNUTLS_FORCE_FIPS_MODE", "2", 1);
 
-    mkdir(WORKDIR, 0700);
+    g_mkdir_with_parents(WORKDIR, 0700);
 
     test_tls_init(KEYFILE);
 
@@ -699,7 +702,7 @@ int main(int argc, char **argv)
     test_tls_discard_cert(&cacertlevel2areq);
     test_tls_discard_cert(&servercertlevel3areq);
     test_tls_discard_cert(&clientcertlevel2breq);
-    unlink(WORKDIR "cacertchain-ctx.pem");
+    qemu_unlink(WORKDIR "cacertchain-ctx.pem");
 
     test_tls_cleanup(KEYFILE);
     rmdir(WORKDIR);
diff --git a/tests/test-crypto-tlssession.c b/tests/test-crypto-tlssession.c
index 8b2453fa79..0fcd0789f1 100644
--- a/tests/test-crypto-tlssession.c
+++ b/tests/test-crypto-tlssession.c
@@ -28,9 +28,13 @@
 #include "qom/object_interfaces.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "qemu/main-loop.h"
 #include "qemu/sockets.h"
 #include "authz/list.h"
 
+#include <glib.h>
+#include <glib/gstdio.h>
+
 #ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT
 
 #define WORKDIR "tests/test-crypto-tlssession-work/"
@@ -40,15 +44,16 @@
 static ssize_t testWrite(const char *buf, size_t len, void *opaque)
 {
     int *fd = opaque;
-
-    return write(*fd, buf, len);
+    int written = send(*fd, buf, len, 0);
+    return written;
 }
 
 static ssize_t testRead(char *buf, size_t len, void *opaque)
 {
     int *fd = opaque;
 
-    return read(*fd, buf, len);
+    int readed = recv(*fd, buf, len, 0);
+    return readed;
 }
 
 static QCryptoTLSCreds *test_tls_creds_psk_create(
@@ -251,29 +256,29 @@ static void test_crypto_tls_session_x509(const void *opaque)
 
 #define CLIENT_CERT_DIR "tests/test-crypto-tlssession-client/"
 #define SERVER_CERT_DIR "tests/test-crypto-tlssession-server/"
-    mkdir(CLIENT_CERT_DIR, 0700);
-    mkdir(SERVER_CERT_DIR, 0700);
+    g_mkdir_with_parents(CLIENT_CERT_DIR, 0700);
+    g_mkdir_with_parents(SERVER_CERT_DIR, 0700);
 
-    unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
-    unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
-    unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY);
+    qemu_unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
+    qemu_unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
+    qemu_unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY);
 
-    unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
-    unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT);
-    unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY);
+    qemu_unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
+    qemu_unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT);
+    qemu_unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY);
 
-    g_assert(link(data->servercacrt,
+    g_assert(qemu_link(data->servercacrt,
                   SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT) == 0);
-    g_assert(link(data->servercrt,
+    g_assert(qemu_link(data->servercrt,
                   SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT) == 0);
-    g_assert(link(KEYFILE,
+    g_assert(qemu_link(KEYFILE,
                   SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY) == 0);
 
-    g_assert(link(data->clientcacrt,
+    g_assert(qemu_link(data->clientcacrt,
                   CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT) == 0);
-    g_assert(link(data->clientcrt,
+    g_assert(qemu_link(data->clientcrt,
                   CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT) == 0);
-    g_assert(link(KEYFILE,
+    g_assert(qemu_link(KEYFILE,
                   CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY) == 0);
 
     clientCreds = test_tls_creds_x509_create(
@@ -369,16 +374,16 @@ static void test_crypto_tls_session_x509(const void *opaque)
         g_assert(!data->expectClientFail);
     }
 
-    unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
-    unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
-    unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY);
+    qemu_unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
+    qemu_unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
+    qemu_unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY);
 
-    unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
-    unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT);
-    unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY);
+    qemu_unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
+    qemu_unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT);
+    qemu_unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY);
 
-    rmdir(CLIENT_CERT_DIR);
-    rmdir(SERVER_CERT_DIR);
+    g_rmdir(CLIENT_CERT_DIR);
+    g_rmdir(SERVER_CERT_DIR);
 
     object_unparent(OBJECT(serverCreds));
     object_unparent(OBJECT(clientCreds));
@@ -397,10 +402,13 @@ int main(int argc, char **argv)
     int ret;
 
     module_call_init(MODULE_INIT_QOM);
+    qemu_init_main_loop(&error_abort);
+    socket_init();
+
     g_test_init(&argc, &argv, NULL);
     g_setenv("GNUTLS_FORCE_FIPS_MODE", "2", 1);
 
-    mkdir(WORKDIR, 0700);
+    g_mkdir_with_parents(WORKDIR, 0700);
 
     test_tls_init(KEYFILE);
     test_tls_psk_init(PSKFILE);
@@ -640,11 +648,11 @@ int main(int argc, char **argv)
     test_tls_discard_cert(&cacertlevel2areq);
     test_tls_discard_cert(&servercertlevel3areq);
     test_tls_discard_cert(&clientcertlevel2breq);
-    unlink(WORKDIR "cacertchain-sess.pem");
+    qemu_unlink(WORKDIR "cacertchain-sess.pem");
 
     test_tls_psk_cleanup(PSKFILE);
     test_tls_cleanup(KEYFILE);
-    rmdir(WORKDIR);
+    g_rmdir(WORKDIR);
 
     return ret == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
 }
diff --git a/tests/test-io-channel-tls.c b/tests/test-io-channel-tls.c
index ad7554c534..851dbb26e3 100644
--- a/tests/test-io-channel-tls.c
+++ b/tests/test-io-channel-tls.c
@@ -31,9 +31,13 @@
 #include "crypto/tlscredsx509.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "qemu/main-loop.h"
 #include "authz/list.h"
 #include "qom/object_interfaces.h"
 
+#include <glib.h>
+#include <glib/gstdio.h>
+
 #ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT
 
 #define WORKDIR "tests/test-io-channel-tls-work/"
@@ -127,29 +131,29 @@ static void test_io_channel_tls(const void *opaque)
 
 #define CLIENT_CERT_DIR "tests/test-io-channel-tls-client/"
 #define SERVER_CERT_DIR "tests/test-io-channel-tls-server/"
-    mkdir(CLIENT_CERT_DIR, 0700);
-    mkdir(SERVER_CERT_DIR, 0700);
+    g_mkdir(CLIENT_CERT_DIR, 0700);
+    g_mkdir(SERVER_CERT_DIR, 0700);
 
-    unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
-    unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
-    unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY);
+    qemu_unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
+    qemu_unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
+    qemu_unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY);
 
-    unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
-    unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT);
-    unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY);
+    qemu_unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
+    qemu_unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT);
+    qemu_unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY);
 
-    g_assert(link(data->servercacrt,
+    g_assert(qemu_link(data->servercacrt,
                   SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT) == 0);
-    g_assert(link(data->servercrt,
+    g_assert(qemu_link(data->servercrt,
                   SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT) == 0);
-    g_assert(link(KEYFILE,
+    g_assert(qemu_link(KEYFILE,
                   SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY) == 0);
 
-    g_assert(link(data->clientcacrt,
+    g_assert(qemu_link(data->clientcacrt,
                   CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT) == 0);
-    g_assert(link(data->clientcrt,
+    g_assert(qemu_link(data->clientcrt,
                   CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT) == 0);
-    g_assert(link(KEYFILE,
+    g_assert(qemu_link(KEYFILE,
                   CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY) == 0);
 
     clientCreds = test_tls_creds_create(
@@ -238,13 +242,13 @@ static void test_io_channel_tls(const void *opaque)
                                  QIO_CHANNEL(serverChanTLS));
     qio_channel_test_validate(test);
 
-    unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
-    unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
-    unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY);
+    qemu_unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
+    qemu_unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
+    qemu_unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY);
 
-    unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
-    unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT);
-    unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY);
+    qemu_unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
+    qemu_unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT);
+    qemu_unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY);
 
     rmdir(CLIENT_CERT_DIR);
     rmdir(SERVER_CERT_DIR);
@@ -272,10 +276,13 @@ int main(int argc, char **argv)
     g_assert(qcrypto_init(NULL) == 0);
 
     module_call_init(MODULE_INIT_QOM);
+    qemu_init_main_loop(&error_abort);
+    socket_init();
+
     g_test_init(&argc, &argv, NULL);
     g_setenv("GNUTLS_FORCE_FIPS_MODE", "2", 1);
 
-    mkdir(WORKDIR, 0700);
+    g_mkdir(WORKDIR, 0700);
 
     test_tls_init(KEYFILE);
 
diff --git a/util/osdep.c b/util/osdep.c
index 4829c07ff6..3d6f827cd6 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -370,6 +370,22 @@ int qemu_close(int fd)
     return close(fd);
 }
 
+/*
+ * Create a symbolic link file from new_path2 to exist_path1
+ */
+int qemu_link(const char *exist_path1, const char *new_path2)
+{
+#if defined(_WIN32)
+    g_autofree gchar *current_dir = g_get_current_dir();
+    g_autofree gchar *full_path = g_build_filename(
+        current_dir, exist_path1, NULL);
+    return CreateSymbolicLinkA(new_path2, full_path,
+        0 | SYMBOLIC_LINK_FLAG_ALLOW_UNPRIVILEGED_CREATE) ? 0 : -1;
+#else
+    return link(exist_path1, new_path2);
+#endif
+}
+
 /*
  * Delete a file from the filesystem, unless the filename is /dev/fdset/...
  *
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index f2fa9a3549..5fedd1194a 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -839,3 +839,79 @@ size_t qemu_get_host_physmem(void)
     }
     return 0;
 }
+
+int qemu_socketpair(int family, int type, int protocol, int channel[2])
+{
+    struct addrinfo addr_data;
+    struct addrinfo *addr = NULL;
+    int sock_listener = -1;
+    int sock_client = -1;
+    int sock_server = -1;
+
+    memset(&addr_data, 0, sizeof(addr_data));
+    addr_data.ai_family = AF_INET;
+    addr_data.ai_socktype = type;
+    addr_data.ai_protocol = protocol;
+    if (getaddrinfo("127.0.0.1", "0", &addr_data, &addr) < 0) {
+        goto error;
+    }
+
+    if (NULL == addr) {
+        goto error;
+    }
+
+    sock_listener = socket(addr->ai_family,
+        addr->ai_socktype, addr->ai_protocol);
+    if (sock_listener < 0) {
+        goto error;
+    }
+
+    if (bind(sock_listener, addr->ai_addr, addr->ai_addrlen) < 0) {
+        goto error;
+    }
+    if (getsockname(sock_listener,
+        addr->ai_addr, (int *)&(addr->ai_addrlen)) < 0) {
+        goto error;
+    }
+    if (listen(sock_listener, 1) < 0) {
+        goto error;
+    }
+
+    sock_client = socket(addr->ai_family,
+        addr->ai_socktype, addr->ai_protocol);
+
+    if (sock_client < 0) {
+        goto error;
+    }
+
+    if (connect(sock_client, addr->ai_addr, addr->ai_addrlen) < 0) {
+        goto error;
+    }
+
+    sock_server = accept(sock_listener, 0, 0);
+
+    if (sock_server < 0) {
+        goto error;
+    }
+
+    closesocket(sock_listener);
+
+    channel[0] = sock_client;
+    channel[1] = sock_server;
+    return 0;
+
+error:
+    if (-1 != sock_server) {
+        closesocket(sock_server);
+    }
+    if (-1 != sock_client) {
+        closesocket(sock_client);
+    }
+    if (-1 != sock_listener) {
+        closesocket(sock_listener);
+    }
+    if (NULL != addr) {
+        freeaddrinfo(addr);
+    }
+    return -1;
+}
-- 
2.28.0.windows.1


