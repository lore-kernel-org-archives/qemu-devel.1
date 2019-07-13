Return-Path: <SRS0=hUdw=VK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848D8C742A7
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 14:35:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61E7620838
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 14:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E7620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmJ7F-0003Ua-KE
	for qemu-devel@archiver.kernel.org; Sat, 13 Jul 2019 10:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46830)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hmJ6m-000277-RR
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 10:34:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hmJ6l-0007nK-Qf
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 10:34:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33996)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1hmJ6l-0007mE-HO
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 10:34:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DC80F3082E57;
 Sat, 13 Jul 2019 14:34:38 +0000 (UTC)
Received: from localhost (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CF83196E5;
 Sat, 13 Jul 2019 14:34:30 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 13 Jul 2019 18:33:11 +0400
Message-Id: <20190713143311.17620-7-marcandre.lureau@redhat.com>
In-Reply-To: <20190713143311.17620-1-marcandre.lureau@redhat.com>
References: <20190713143311.17620-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Sat, 13 Jul 2019 14:34:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 6/6] test: skip tests if
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
Cc: Fam Zheng <fam@euphon.net>, berrange@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Skip the tests if socket_check_protocol_support() failed, but do run
g_test_run() to keep TAP harness happy.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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
2.22.0.428.g6d5b264208


