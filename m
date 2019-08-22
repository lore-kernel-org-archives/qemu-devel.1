Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6EFC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 13:54:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FED922CE3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 13:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FED922CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0nXa-0004gk-AQ
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 09:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1i0nS2-0006fX-Ky
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:48:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1i0nRy-0006PR-EN
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:48:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33086)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1i0nRw-0006Ns-FL
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:48:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 08B6D7F75D;
 Thu, 22 Aug 2019 13:48:23 +0000 (UTC)
Received: from localhost (ovpn-116-85.phx2.redhat.com [10.3.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8E865DAAD;
 Thu, 22 Aug 2019 13:48:19 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 17:47:25 +0400
Message-Id: <20190822134725.32479-7-marcandre.lureau@redhat.com>
In-Reply-To: <20190822134725.32479-1-marcandre.lureau@redhat.com>
References: <20190822134725.32479-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Thu, 22 Aug 2019 13:48:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 6/6] test: skip tests if
 socket_check_protocol_support() failed
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Skip the tests if socket_check_protocol_support() failed, but do run
g_test_run() to keep TAP harness happy.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/test-char.c              | 4 +++-
 tests/test-io-channel-socket.c | 4 +++-
 tests/test-util-sockets.c      | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index 2dde620afc..b56e43c1eb 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -1365,7 +1365,8 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
=20
     if (socket_check_protocol_support(&has_ipv4, &has_ipv6) < 0) {
-        return -1;
+        g_printerr("socket_check_protocol_support() failed\n");
+        goto end;
     }
=20
     module_call_init(MODULE_INIT_QOM);
@@ -1465,5 +1466,6 @@ int main(int argc, char **argv)
     g_test_add_func("/char/hotswap", char_hotswap_test);
     g_test_add_func("/char/websocket", char_websock_test);
=20
+end:
     return g_test_run();
 }
diff --git a/tests/test-io-channel-socket.c b/tests/test-io-channel-socke=
t.c
index d2053c464c..d172f3070f 100644
--- a/tests/test-io-channel-socket.c
+++ b/tests/test-io-channel-socket.c
@@ -566,7 +566,8 @@ int main(int argc, char **argv)
      * with either IPv4 or IPv6 disabled.
      */
     if (socket_check_protocol_support(&has_ipv4, &has_ipv6) < 0) {
-        return 1;
+        g_printerr("socket_check_protocol_support() failed\n");
+        goto end;
     }
=20
     if (has_ipv4) {
@@ -595,5 +596,6 @@ int main(int argc, char **argv)
                     test_io_channel_unix_listen_cleanup);
 #endif /* _WIN32 */
=20
+end:
     return g_test_run();
 }
diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
index f1ebffee5a..e2a3a8a093 100644
--- a/tests/test-util-sockets.c
+++ b/tests/test-util-sockets.c
@@ -242,7 +242,8 @@ int main(int argc, char **argv)
      * with either IPv4 or IPv6 disabled.
      */
     if (socket_check_protocol_support(&has_ipv4, &has_ipv6) < 0) {
-        return 1;
+        g_printerr("socket_check_protocol_support() failed\n");
+        goto end;
     }
=20
     if (has_ipv4) {
@@ -264,5 +265,6 @@ int main(int argc, char **argv)
                         test_socket_fd_pass_num_nocli);
     }
=20
+end:
     return g_test_run();
 }
--=20
2.23.0


