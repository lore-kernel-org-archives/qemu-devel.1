Received: from eggs.gnu.org ([2001:4830:134:3::10]:53919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dnPJA-0000OA-76
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dnPJ8-00005v-Ij
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:14:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dnPJ8-00005h-9s
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:14:54 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 31 Aug 2017 14:14:25 +0100
Message-Id: <20170831131425.3953-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170831131425.3953-1-marcandre.lureau@redhat.com>
References: <20170831131425.3953-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] .dir-locals.el: add json schema to
 auto-mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

The json schema is more friendly to python-mode since it doesn't
follow strictly json (comments to start with).

All schema files add file variables to set the python mode, but most
tests didn't. This will cover all json files now.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi-schema.json                        | 1 -
 qapi/block-core.json                    | 2 --
 qapi/block.json                         | 2 --
 qapi/common.json                        | 2 --
 qapi/crypto.json                        | 3 ---
 qapi/event.json                         | 2 --
 qapi/introspect.json                    | 1 -
 qapi/rocker.json                        | 2 --
 qapi/trace.json                         | 1 -
 .dir-locals.el                          | 4 +++-
 qga/qapi-schema.json                    | 2 --
 tests/qapi-schema/doc-good.json         | 1 -
 tests/qapi-schema/qapi-schema-test.json | 2 --
 13 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 802ea53d00..232fafeb65 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1,4 +1,3 @@
-# -*- Mode: Python -*-
 ##
 # =3D Introduction
 #
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 833c602150..5bd14554aa 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1,5 +1,3 @@
-# -*- Mode: Python -*-
-
 ##
 # =3D=3D QAPI block core definitions (vm unrelated)
 ##
diff --git a/qapi/block.json b/qapi/block.json
index 414b61bde7..979906625d 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -1,5 +1,3 @@
-# -*- Mode: Python -*-
-
 ##
 # =3D QAPI block definitions
 ##
diff --git a/qapi/common.json b/qapi/common.json
index 8355d5a2f3..25a9fdcbfd 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -1,5 +1,3 @@
-# -*- Mode: Python -*-
-
 ##
 # =3D QAPI common definitions
 ##
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 6b6fde367a..9ec7777603 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -1,6 +1,3 @@
-# -*- Mode: Python -*-
-#
-
 ##
 # =3D QAPI crypto definitions
 ##
diff --git a/qapi/event.json b/qapi/event.json
index 6d22b025cc..6f15ec1542 100644
--- a/qapi/event.json
+++ b/qapi/event.json
@@ -1,5 +1,3 @@
-# -*- Mode: Python -*-
-
 ##
 # =3D Other events
 ##
diff --git a/qapi/introspect.json b/qapi/introspect.json
index cf77ff0669..83eaed3e43 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -1,4 +1,3 @@
-# -*- Mode: Python -*-
 #
 # QAPI/QMP introspection
 #
diff --git a/qapi/rocker.json b/qapi/rocker.json
index 3587661161..0026c7fd59 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -1,5 +1,3 @@
-# -*- Mode: Python -*-
-
 ##
 # =3D Rocker switch device
 ##
diff --git a/qapi/trace.json b/qapi/trace.json
index de6588d9f7..679b1e298a 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -1,4 +1,3 @@
-# -*- mode: python -*-
 #
 # Copyright (C) 2011-2016 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
 #
diff --git a/.dir-locals.el b/.dir-locals.el
index 13ec483765..46a6c73ed1 100644
--- a/.dir-locals.el
+++ b/.dir-locals.el
@@ -2,6 +2,8 @@
             (indent-tabs-mode . nil)))
  (nil . ((eval . (setq auto-mode-alist (append
                                         '(("Makefile.*" . makefile-gmake=
-mode)
-                                          ("\\.mak\\'" . makefile-gmake-=
mode))
+                                          ("\\.mak\\'" . makefile-gmake-=
mode)
+                                          ;; json schema is not pure jso=
n
+                                          ("\\.json\\'" . python-mode))
                                         auto-mode-alist))))
       ))
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 90a0c8602b..757bb42521 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1,5 +1,3 @@
-# *-*- Mode: Python -*-*
-
 ##
 #
 # General note concerning the use of guest agent interfaces:
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good=
.json
index cfdc0a8a81..4a34eaf3d1 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -1,4 +1,3 @@
-# -*- Mode: Python -*-
 # Positive QAPI doc comment tests
=20
 { 'pragma': { 'doc-required': true } }
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index c72dbd8050..6e5635ef66 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -1,5 +1,3 @@
-# *-*- Mode: Python -*-*
-
 # This file is a stress test of supported qapi constructs that must
 # parse and compile correctly.
=20
--=20
2.14.1.146.gd35faa819
