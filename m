Return-Path: <SRS0=hUdw=VK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A651C742D7
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 14:35:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5923520838
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 14:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5923520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmJ7U-0004ix-Ly
	for qemu-devel@archiver.kernel.org; Sat, 13 Jul 2019 10:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46722)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hmJ6N-0000gt-L4
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 10:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hmJ6M-0007QV-If
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 10:34:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52130)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1hmJ6M-0007Px-Ay
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 10:34:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A00A03091782;
 Sat, 13 Jul 2019 14:34:13 +0000 (UTC)
Received: from localhost (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 905B460C67;
 Sat, 13 Jul 2019 14:34:04 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 13 Jul 2019 18:33:09 +0400
Message-Id: <20190713143311.17620-5-marcandre.lureau@redhat.com>
In-Reply-To: <20190713143311.17620-1-marcandre.lureau@redhat.com>
References: <20190713143311.17620-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Sat, 13 Jul 2019 14:34:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 4/6] tests: specify the address family when
 checking bind
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
Cc: Fam Zheng <fam@euphon.net>, berrange@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

getaddrinfo() may succeed with PF_UNSPEC, but fail when more specific.

(this allows to skip some tests that would fail under podman)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/socket-helpers.c | 17 +++++++++++++----
 tests/socket-helpers.h | 11 -----------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/tests/socket-helpers.c b/tests/socket-helpers.c
index 8112763f5b..19a51e887e 100644
--- a/tests/socket-helpers.c
+++ b/tests/socket-helpers.c
@@ -30,7 +30,16 @@
 # define EAI_ADDRFAMILY 0
 #endif
=20
-int socket_can_bind_connect(const char *hostname)
+/*
+ * @hostname: a DNS name or numeric IP address
+ *
+ * Check whether it is possible to bind & connect to ports
+ * on the DNS name or IP address @hostname. If an IP address
+ * is used, it must not be a wildcard address.
+ *
+ * Returns 0 on success, -1 on error with errno set
+ */
+static int socket_can_bind_connect(const char *hostname, int family)
 {
     int lfd =3D -1, cfd =3D -1, afd =3D -1;
     struct addrinfo ai, *res =3D NULL;
@@ -44,7 +53,7 @@ int socket_can_bind_connect(const char *hostname)
=20
     memset(&ai, 0, sizeof(ai));
     ai.ai_flags =3D AI_CANONNAME | AI_ADDRCONFIG;
-    ai.ai_family =3D AF_UNSPEC;
+    ai.ai_family =3D family;
     ai.ai_socktype =3D SOCK_STREAM;
=20
     /* lookup */
@@ -129,7 +138,7 @@ int socket_check_protocol_support(bool *has_ipv4, boo=
l *has_ipv6)
 {
     *has_ipv4 =3D *has_ipv6 =3D false;
=20
-    if (socket_can_bind_connect("127.0.0.1") < 0) {
+    if (socket_can_bind_connect("127.0.0.1", PF_INET) < 0) {
         if (errno !=3D EADDRNOTAVAIL) {
             return -1;
         }
@@ -137,7 +146,7 @@ int socket_check_protocol_support(bool *has_ipv4, boo=
l *has_ipv6)
         *has_ipv4 =3D true;
     }
=20
-    if (socket_can_bind_connect("::1") < 0) {
+    if (socket_can_bind_connect("::1", PF_INET6) < 0) {
         if (errno !=3D EADDRNOTAVAIL) {
             return -1;
         }
diff --git a/tests/socket-helpers.h b/tests/socket-helpers.h
index 9de0e6b151..512a004811 100644
--- a/tests/socket-helpers.h
+++ b/tests/socket-helpers.h
@@ -20,17 +20,6 @@
 #ifndef TESTS_SOCKET_HELPERS_H
 #define TESTS_SOCKET_HELPERS_H
=20
-/*
- * @hostname: a DNS name or numeric IP address
- *
- * Check whether it is possible to bind & connect to ports
- * on the DNS name or IP address @hostname. If an IP address
- * is used, it must not be a wildcard address.
- *
- * Returns 0 on success, -1 on error with errno set
- */
-int socket_can_bind_connect(const char *hostname);
-
 /*
  * @has_ipv4: set to true on return if IPv4 is available
  * @has_ipv6: set to true on return if IPv6 is available
--=20
2.22.0.428.g6d5b264208


