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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41835C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D742068D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EILE9744"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D742068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIAIp-0003fC-Ru
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9r3-00016y-Ob; Tue, 15 Sep 2020 08:14:37 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37086)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9r0-0008FJ-Ao; Tue, 15 Sep 2020 08:14:37 -0400
Received: by mail-pl1-x642.google.com with SMTP id u9so1238253plk.4;
 Tue, 15 Sep 2020 05:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yy3OwZAAIk6Dcs0xK9Qh35lWKWe9KAtCgjjpQmut8QA=;
 b=EILE9744Wv81LpGwwRoYb3IlShUNhAdbizZTdO+ngkpWfT4gRTc2JdQ3Ics4zEWVwk
 gfZhop7zrHIeeGo/ZI444Xt4cVhOFDdClvPQwy6ablSFivx3oNWTz26PikkDgKMSlYQX
 rgnnMDNkAQyWp4nhNua3fUHNrAj8AGVq7ziIhVAISPjLlcH8mRqB7P2Igkhog6Rr9CPi
 loMMAxBbu5XlFTV9pCLO/1xadlmyxLeuoopcjWtT1Sf7edtquuwFkdbZHZbUYbZ/r3RX
 NYH7tYbWibnNfcYRK6D99mLP14xVqD1sYCilxuD71vYiajAjjvbwG68RvTptDiHcvOBy
 8Wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yy3OwZAAIk6Dcs0xK9Qh35lWKWe9KAtCgjjpQmut8QA=;
 b=MwXlQdQ/naRqEBmryOMsodsomHPE7GTKcb6dcsyHeXgaq2iGwGAwpaVdAgsdQm8H8o
 vEQdvy9WYm1CfiTb2q+SAqTz6VgShY3JYNGKFeAXfVkEfSL3fJMWBg2PkgbDS4jT7q8g
 G2rv3RDr31Y9sQuv9NGngPJ8XPv93RuD80MFbofr+/dfGwo+3l6MKHA8/Xe5DUeHbNvU
 t5q/gzF+7i09nCjJC+7EWzy2sb1uRMo78pHKsesS9ZYFyT1Y8DeyxZoiUVIbgkE1Dgsy
 VT2X5e0OH7AmlBSEWNVXJndYPJk6dMdyKzlHcw2kNTCJPZ5HkS22zbdyTLRycKU97TXN
 GeJg==
X-Gm-Message-State: AOAM533MhHF1AoVJLCgW51SXWbJHhLYRRHG6094dDuWEm8x9n6FSZO2B
 kcxim70p4sWJ6PKAwoNaOVulPVTjTUlAq1G+S0A=
X-Google-Smtp-Source: ABdhPJzq9WcHKvGFpPCw51g1Mr+SwRAXhdn7dkgU3Kw6D47cV0/7HAePn/VHC8ZML65ghEu5JPlutg==
X-Received: by 2002:a17:90a:d3c2:: with SMTP id
 d2mr3866734pjw.112.1600172072003; 
 Tue, 15 Sep 2020 05:14:32 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 k28sm13683061pfh.196.2020.09.15.05.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 05:14:31 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 12/26] tests: Enable crypto tests under msys2/mingw
Date: Tue, 15 Sep 2020 20:13:04 +0800
Message-Id: <20200915121318.247-13-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915121318.247-1-luoyonggang@gmail.com>
References: <20200915121318.247-1-luoyonggang@gmail.com>
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
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
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
 tests/crypto-tls-psk-helpers.c   |   2 +-
 tests/crypto-tls-x509-helpers.c  | 106 ++++++++++++++++++++++++++++++-
 tests/crypto-tls-x509-helpers.h  |   9 ++-
 tests/test-crypto-tlscredsx509.c |  47 +++++++-------
 tests/test-crypto-tlssession.c   |  68 +++++++++++---------
 tests/test-io-channel-tls.c      |  51 ++++++++-------
 6 files changed, 204 insertions(+), 79 deletions(-)

diff --git a/tests/crypto-tls-psk-helpers.c b/tests/crypto-tls-psk-helpers.c
index 4f3bd446ad..58888d5537 100644
--- a/tests/crypto-tls-psk-helpers.c
+++ b/tests/crypto-tls-psk-helpers.c
@@ -46,7 +46,7 @@ void test_tls_psk_init(const char *pskfile)
 
 void test_tls_psk_cleanup(const char *pskfile)
 {
-    unlink(pskfile);
+    g_remove(pskfile);
 }
 
 #endif /* QCRYPTO_HAVE_TLS_TEST_SUPPORT */
diff --git a/tests/crypto-tls-x509-helpers.c b/tests/crypto-tls-x509-helpers.c
index 01b3daf358..1238983755 100644
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
+    g_remove(keyfile);
 }
 
 /*
@@ -501,8 +503,108 @@ void test_tls_discard_cert(QCryptoTLSTestCertReq *req)
     req->crt = NULL;
 
     if (getenv("QEMU_TEST_DEBUG_CERTS") == NULL) {
-        unlink(req->filename);
+        g_remove(req->filename);
     }
 }
 
+int qemu_link(const char *exist_path1, const char *new_path2)
+{
+#if defined(_WIN32)
+    g_autofree gchar *current_dir = g_get_current_dir();
+    g_autofree gchar *full_path = g_build_filename(current_dir, exist_path1, NULL);
+    return CreateSymbolicLinkA(
+        new_path2, full_path, 0 | SYMBOLIC_LINK_FLAG_ALLOW_UNPRIVILEGED_CREATE) ? 0 : -1;
+#else
+    return link(exist_path1, new_path2);
+#endif
+}
+
+#if defined(_WIN32)
+
+int qemu_socketpair(int family, int type, int protocol, int channel[2])
+{
+    struct addrinfo addr_data;
+    struct addrinfo *addr = NULL;
+    int sock_listener = -1;
+    int sock_client = -1;
+    int sock_server = -1;
+    int one = 1;
+
+    memset(&addr_data, 0, sizeof(addr_data));
+    addr_data.ai_family = AF_INET;
+    addr_data.ai_socktype = type;
+    addr_data.ai_protocol = protocol;
+    if (0 != getaddrinfo("127.0.0.1", "0", &addr_data, &addr)) {
+        goto error;
+    }
+
+    if (NULL == addr) {
+        goto error;
+    }
+
+    sock_listener = socket(addr->ai_family, addr->ai_socktype, addr->ai_protocol);
+    if (-1 == sock_listener) {
+        goto error;
+    }
+
+    if (-1 == setsockopt(sock_listener, SOL_SOCKET, SO_REUSEADDR, (const char *)&one, sizeof(one))) {
+        goto error;
+    }
+    if (-1 == bind(sock_listener, addr->ai_addr, addr->ai_addrlen)) {
+        goto error;
+    }
+    if (-1 == getsockname(sock_listener, addr->ai_addr, (int *)&(addr->ai_addrlen))) {
+        goto error;
+    }
+    if (-1 == listen(sock_listener, 1)) {
+        goto error;
+    }
+
+    sock_client = socket(addr->ai_family, addr->ai_socktype, addr->ai_protocol);
+
+    if (-1 == sock_client) {
+        goto error;
+    }
+
+    if (-1 == connect(sock_client, addr->ai_addr, addr->ai_addrlen)) {
+        goto error;
+    }
+
+    sock_server = accept(sock_listener, 0, 0);
+
+    if (-1 == sock_server) {
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
+
+#else
+
+int qemu_socketpair(int family, int type, int protocol, int recv[2])
+{
+    return socketpair(family, type, protocol, recv);
+}
+
+#endif
+
 #endif /* QCRYPTO_HAVE_TLS_TEST_SUPPORT */
diff --git a/tests/crypto-tls-x509-helpers.h b/tests/crypto-tls-x509-helpers.h
index 08efba4e19..6902d43af7 100644
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
 
@@ -127,6 +128,10 @@ void test_tls_cleanup(const char *keyfile);
 
 extern const ASN1_ARRAY_TYPE pkix_asn1_tab[];
 
+int qemu_link(const char *exist_path1, const char *new_path2);
+
+int qemu_socketpair(int family, int type, int protocol, int channel[2]);
+
 #endif /* QCRYPTO_HAVE_TLS_TEST_SUPPORT */
 
 #endif
diff --git a/tests/test-crypto-tlscredsx509.c b/tests/test-crypto-tlscredsx509.c
index f487349c32..620fbde1ca 100644
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
+    g_remove (CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
     if (data->isServer) {
-        unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
-        unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY);
+        g_remove (CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
+        g_remove (CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY);
     } else {
-        unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT);
-        unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY);
+        g_remove (CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT);
+        g_remove (CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY);
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
+    g_remove(CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
     if (data->isServer) {
-        unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
-        unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY);
+        g_remove(CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
+        g_remove(CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY);
     } else {
-        unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT);
-        unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY);
+        g_remove(CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT);
+        g_remove(CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY);
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
+    g_remove(WORKDIR "cacertchain-ctx.pem");
 
     test_tls_cleanup(KEYFILE);
     rmdir(WORKDIR);
diff --git a/tests/test-crypto-tlssession.c b/tests/test-crypto-tlssession.c
index 8b2453fa79..f726219593 100644
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
@@ -84,7 +89,7 @@ static void test_crypto_tls_session_psk(void)
     int ret;
 
     /* We'll use this for our fake client-server connection */
-    ret = socketpair(AF_UNIX, SOCK_STREAM, 0, channel);
+    ret = qemu_socketpair(AF_UNIX, SOCK_STREAM, 0, channel);
     g_assert(ret == 0);
 
     /*
@@ -238,7 +243,7 @@ static void test_crypto_tls_session_x509(const void *opaque)
     int ret;
 
     /* We'll use this for our fake client-server connection */
-    ret = socketpair(AF_UNIX, SOCK_STREAM, 0, channel);
+    ret = qemu_socketpair(AF_UNIX, SOCK_STREAM, 0, channel);
     g_assert(ret == 0);
 
     /*
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
+    g_remove(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
+    g_remove(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
+    g_remove(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY);
 
-    unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
-    unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT);
-    unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY);
+    g_remove(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
+    g_remove(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT);
+    g_remove(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY);
 
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
+    g_remove(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
+    g_remove(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
+    g_remove(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY);
 
-    unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
-    unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT);
-    unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY);
+    g_remove(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
+    g_remove(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT);
+    g_remove(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY);
 
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
+    g_remove(WORKDIR "cacertchain-sess.pem");
 
     test_tls_psk_cleanup(PSKFILE);
     test_tls_cleanup(KEYFILE);
-    rmdir(WORKDIR);
+    g_rmdir(WORKDIR);
 
     return ret == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
 }
diff --git a/tests/test-io-channel-tls.c b/tests/test-io-channel-tls.c
index ad7554c534..e858716192 100644
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
@@ -123,33 +127,33 @@ static void test_io_channel_tls(const void *opaque)
     GMainContext *mainloop;
 
     /* We'll use this for our fake client-server connection */
-    g_assert(socketpair(AF_UNIX, SOCK_STREAM, 0, channel) == 0);
+    g_assert(qemu_socketpair(AF_UNIX, SOCK_STREAM, 0, channel) == 0);
 
 #define CLIENT_CERT_DIR "tests/test-io-channel-tls-client/"
 #define SERVER_CERT_DIR "tests/test-io-channel-tls-server/"
-    mkdir(CLIENT_CERT_DIR, 0700);
-    mkdir(SERVER_CERT_DIR, 0700);
+    g_mkdir(CLIENT_CERT_DIR, 0700);
+    g_mkdir(SERVER_CERT_DIR, 0700);
 
-    unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
-    unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
-    unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY);
+    g_remove(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
+    g_remove(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
+    g_remove(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY);
 
-    unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
-    unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT);
-    unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY);
+    g_remove(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
+    g_remove(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT);
+    g_remove(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY);
 
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
+    g_remove(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
+    g_remove(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
+    g_remove(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY);
 
-    unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
-    unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT);
-    unlink(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY);
+    g_remove(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
+    g_remove(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT);
+    g_remove(CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY);
 
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
 
-- 
2.28.0.windows.1


