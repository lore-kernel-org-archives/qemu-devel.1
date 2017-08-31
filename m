Received: from eggs.gnu.org ([2001:4830:134:3::10]:53920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dnPJA-0000OB-7B
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dnPJ6-00005G-6y
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:14:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21355)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dnPJ6-000055-0g
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:14:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1BC21267CD
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 13:14:51 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 31 Aug 2017 14:14:24 +0100
Message-Id: <20170831131425.3953-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] .dir-locals.el: add makefiles to auto-mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

QEMU uses non-conventional makefile filenames. Ease the life of emacs
developpers a bit by appending to the auto-mode-alist.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 .dir-locals.el      | 7 ++++++-
 Makefile.target     | 2 --
 trace/Makefile.objs | 2 --
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/.dir-locals.el b/.dir-locals.el
index 3ac0cfc6f0..13ec483765 100644
--- a/.dir-locals.el
+++ b/.dir-locals.el
@@ -1,2 +1,7 @@
 ((c-mode . ((c-file-style . "stroustrup")
-	    (indent-tabs-mode . nil))))
+            (indent-tabs-mode . nil)))
+ (nil . ((eval . (setq auto-mode-alist (append
+                                        '(("Makefile.*" . makefile-gmake=
-mode)
+                                          ("\\.mak\\'" . makefile-gmake-=
mode))
+                                        auto-mode-alist))))
+      ))
diff --git a/Makefile.target b/Makefile.target
index 7f42c45db8..159602c83c 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -1,5 +1,3 @@
-# -*- Mode: makefile -*-
-
 BUILD_DIR?=3D$(CURDIR)/..
=20
 include ../config-host.mak
diff --git a/trace/Makefile.objs b/trace/Makefile.objs
index afd571c3ec..d1f1e646e5 100644
--- a/trace/Makefile.objs
+++ b/trace/Makefile.objs
@@ -1,5 +1,3 @@
-# -*- mode: makefile -*-
-
 $(BUILD_DIR)/trace-events-all: $(trace-events-files)
 	$(call quiet-command,cat $^ > $@)
=20
--=20
2.14.1.146.gd35faa819
