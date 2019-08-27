Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE15C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 14:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8DA0206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 14:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DA0206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2c6Y-0000WS-ST
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 10:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1i2c3h-0006lh-0L
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1i2c3f-0005EC-V1
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:02:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46064)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1i2c3f-0005De-PV
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:02:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3B8EF308FC22;
 Tue, 27 Aug 2019 14:02:50 +0000 (UTC)
Received: from localhost (ovpn-112-22.ams2.redhat.com [10.36.112.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 52E935D9C3;
 Tue, 27 Aug 2019 14:02:43 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 18:02:40 +0400
Message-Id: <20190827140241.20818-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 27 Aug 2019 14:02:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] build-sys: build ui-spice-app as a module
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
Cc: Laurent Vivier <lvivier@redhat.com>, peter.maydell@linaro.org,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reverts commit 45db1ac157 ("modules-test: ui-spice-app is not
built as module") and fixes commit d8aec9d9f1 ("display: add -display
spice-app launching a Spice client").

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/modules-test.c | 3 +++
 ui/Makefile.objs     | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/modules-test.c b/tests/modules-test.c
index f9de3afdb7..a8118e9042 100644
--- a/tests/modules-test.c
+++ b/tests/modules-test.c
@@ -52,6 +52,9 @@ int main(int argc, char *argv[])
 #endif
 #ifdef CONFIG_SDL
         "ui-", "sdl",
+#endif
+#if defined(CONFIG_SPICE) && defined(CONFIG_GIO)
+        "ui-", "spice-app",
 #endif
     };
     int i;
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index cc2bf5b180..ba39080edb 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -49,7 +49,9 @@ curses.mo-objs :=3D curses.o
 curses.mo-cflags :=3D $(CURSES_CFLAGS) $(ICONV_CFLAGS)
 curses.mo-libs :=3D $(CURSES_LIBS) $(ICONV_LIBS)
=20
-common-obj-$(call land,$(CONFIG_SPICE),$(CONFIG_GIO)) +=3D spice-app.mo
+ifeq ($(CONFIG_GIO)$(CONFIG_SPICE),yy)
+common-obj-$(if $(CONFIG_MODULES),m,y) +=3D spice-app.mo
+endif
 spice-app.mo-objs :=3D spice-app.o
 spice-app.mo-cflags :=3D $(GIO_CFLAGS)
 spice-app.mo-libs :=3D $(GIO_LIBS)
--=20
2.23.0


