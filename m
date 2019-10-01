Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72554ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D1C205F4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D1C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFIDh-0002aZ-FM
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 09:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iFIAm-00005s-Id
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iFIAl-0000NO-L4
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:26:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45700)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iFIAl-0000Mj-Fj
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:26:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B5CA320FD;
 Tue,  1 Oct 2019 13:26:34 +0000 (UTC)
Received: from localhost (ovpn-112-22.ams2.redhat.com [10.36.112.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 664B560619;
 Tue,  1 Oct 2019 13:26:30 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] tests: skip serial test on windows
Date: Tue,  1 Oct 2019 17:26:08 +0400
Message-Id: <20191001132609.23184-3-marcandre.lureau@redhat.com>
In-Reply-To: <20191001132609.23184-1-marcandre.lureau@redhat.com>
References: <20191001132609.23184-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Tue, 01 Oct 2019 13:26:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: pbonzini@redhat.com, berrange@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 sw@weilnetz.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Serial test is currently hard-coded to /dev/null.

On Windows, serial chardev expect a COM: device, which may not be
availble.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-char.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index d62de1b088..45e42af290 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -1103,7 +1103,7 @@ static void char_socket_server_two_clients_test(gco=
nstpointer opaque)
 }
=20
=20
-#ifdef HAVE_CHARDEV_SERIAL
+#if defined(HAVE_CHARDEV_SERIAL) && !defined(WIN32)
 static void char_serial_test(void)
 {
     QemuOpts *opts;
@@ -1460,7 +1460,7 @@ int main(int argc, char **argv)
 #endif
=20
     g_test_add_func("/char/udp", char_udp_test);
-#ifdef HAVE_CHARDEV_SERIAL
+#if defined(HAVE_CHARDEV_SERIAL) && !defined(WIN32)
     g_test_add_func("/char/serial", char_serial_test);
 #endif
     g_test_add_func("/char/hotswap", char_hotswap_test);
--=20
2.23.0


