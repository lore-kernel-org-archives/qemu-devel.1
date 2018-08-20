Received: from eggs.gnu.org ([2001:4830:134:3::10]:57701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1froDJ-0008EG-49
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1froDF-000591-TB
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:43:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33128 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1froDF-0004vE-H6
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:43:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5661406E81C
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 17:43:26 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 20 Aug 2018 19:43:10 +0200
Message-Id: <20180820174310.17450-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] editorconfig: set emacs mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Some time ago, I proposed to use an (eval) in .dir-locals.el to set
the mode for all json files and Makefile. Unfortunately, this isn't
safe, and emacs will prompt the user, which isn't very friendly.

Fortunately, editorconfig provides a special config key which does
allow to set the emacs mode. Set the emacs mode for JSON, GLSL and
extra makefiles that are not yet covered. Drop modeline from JSON
files.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/block-core.json                    |  2 --
 qapi/block.json                         |  2 --
 qapi/char.json                          |  3 ---
 qapi/common.json                        |  2 --
 qapi/crypto.json                        |  3 ---
 qapi/introspect.json                    |  2 --
 qapi/job.json                           |  2 --
 qapi/migration.json                     |  3 ---
 qapi/misc.json                          |  3 ---
 qapi/net.json                           |  3 ---
 qapi/qapi-schema.json                   |  1 -
 qapi/rocker.json                        |  2 --
 qapi/run-state.json                     |  3 ---
 qapi/sockets.json                       |  2 --
 qapi/tpm.json                           |  3 ---
 qapi/transaction.json                   |  3 ---
 qapi/ui.json                            |  3 ---
 .editorconfig                           | 13 +++++++++++++
 Makefile.target                         |  2 --
 docs/interop/firmware.json              |  2 --
 qga/qapi-schema.json                    |  2 --
 tests/qapi-schema/doc-good.json         |  1 -
 tests/qapi-schema/qapi-schema-test.json |  2 --
 23 files changed, 13 insertions(+), 51 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4c7a37afdc..b1fb7ddf40 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1,5 +1,3 @@
-# -*- Mode: Python -*-
-
 ##
 # =3D=3D Block core (VM unrelated)
 ##
diff --git a/qapi/block.json b/qapi/block.json
index 11f01f28ef..953e7de564 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -1,5 +1,3 @@
-# -*- Mode: Python -*-
-
 ##
 # =3D Block devices
 ##
diff --git a/qapi/char.json b/qapi/char.json
index b7b2a05766..955d52aa01 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -1,6 +1,3 @@
-# -*- Mode: Python -*-
-#
-
 ##
 # =3D Character devices
 ##
diff --git a/qapi/common.json b/qapi/common.json
index c367adc4b6..236e5b3a0d 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -1,5 +1,3 @@
-# -*- Mode: Python -*-
-
 ##
 # =3D Common data types
 ##
diff --git a/qapi/crypto.json b/qapi/crypto.json
index a51b434412..9720f145ff 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -1,6 +1,3 @@
-# -*- Mode: Python -*-
-#
-
 ##
 # =3D Cryptography
 ##
diff --git a/qapi/introspect.json b/qapi/introspect.json
index 137b39b992..e602a916f1 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -1,5 +1,3 @@
-# -*- Mode: Python -*-
-#
 # Copyright (C) 2015 Red Hat, Inc.
 #
 # Authors:
diff --git a/qapi/job.json b/qapi/job.json
index a121b615fb..5e60f04bae 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -1,5 +1,3 @@
-# -*- Mode: Python -*-
-
 ##
 # =3D=3D Background jobs
 ##
diff --git a/qapi/migration.json b/qapi/migration.json
index 186e8a7303..3f96dfd5f5 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1,6 +1,3 @@
-# -*- Mode: Python -*-
-#
-
 ##
 # =3D Migration
 ##
diff --git a/qapi/misc.json b/qapi/misc.json
index d450cfef21..a985d64739 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1,6 +1,3 @@
-# -*- Mode: Python -*-
-#
-
 ##
 # =3D Miscellanea
 ##
diff --git a/qapi/net.json b/qapi/net.json
index c86f351161..74ab3fe34e 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -1,6 +1,3 @@
-# -*- Mode: Python -*-
-#
-
 ##
 # =3D Net devices
 ##
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 65b6dc2f6f..980c998173 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -1,4 +1,3 @@
-# -*- Mode: Python -*-
 ##
 # =3D Introduction
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
diff --git a/qapi/run-state.json b/qapi/run-state.json
index 332e44897b..14c88da0a9 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -1,6 +1,3 @@
-# -*- Mode: Python -*-
-#
-
 ##
 # =3D VM run state
 ##
diff --git a/qapi/sockets.json b/qapi/sockets.json
index fc81d8d5e8..e83667c5c5 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -1,5 +1,3 @@
-# -*- Mode: Python -*-
-
 ##
 # =3D Socket data types
 ##
diff --git a/qapi/tpm.json b/qapi/tpm.json
index d50deef5e9..2a33556b22 100644
--- a/qapi/tpm.json
+++ b/qapi/tpm.json
@@ -1,6 +1,3 @@
-# -*- Mode: Python -*-
-#
-
 ##
 # =3D TPM (trusted platform module) devices
 ##
diff --git a/qapi/transaction.json b/qapi/transaction.json
index d7e4274550..ec74f88288 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -1,6 +1,3 @@
-# -*- Mode: Python -*-
-#
-
 ##
 # =3D Transactions
 ##
diff --git a/qapi/ui.json b/qapi/ui.json
index 4ca91bb45a..03d0a19da3 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1,6 +1,3 @@
-# -*- Mode: Python -*-
-#
-
 ##
 # =3D Remote desktop
 ##
diff --git a/.editorconfig b/.editorconfig
index b2022e391a..683c543be3 100644
--- a/.editorconfig
+++ b/.editorconfig
@@ -6,10 +6,23 @@ end_of_line =3D lf
 insert_final_newline =3D true
 charset =3D utf-8
=20
+[*.mak]
+indent_style =3D tab
+indent_size =3D 8
+file_type_emacs =3D makefile
+
 [Makefile*]
 indent_style =3D tab
 indent_size =3D 8
+file_type_emacs =3D makefile
=20
 [*.{c,h}]
 indent_style =3D space
 indent_size =3D 4
+
+[*.{vert,frag}]
+file_type_emacs =3D glsl
+
+[*.json]
+indent_style =3D space
+file_type_emacs =3D python
diff --git a/Makefile.target b/Makefile.target
index 4d56298bbf..75bae962cd 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -1,5 +1,3 @@
-# -*- Mode: makefile -*-
-
 BUILD_DIR?=3D$(CURDIR)/..
=20
 include ../config-host.mak
diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 28f9bc1591..a2b798118f 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -1,5 +1,3 @@
-# -*- Mode: Python -*-
-#
 # Copyright (C) 2018 Red Hat, Inc.
 #
 # Authors:
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index dfbc4a5e32..447cea7701 100644
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
index 984cd8ed06..2de41344ff 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -1,4 +1,3 @@
-# -*- Mode: Python -*-
 # Positive QAPI doc comment tests
=20
 { 'pragma': { 'doc-required': true } }
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index 11aa4c8f8d..765c30c9db 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -1,5 +1,3 @@
-# *-*- Mode: Python -*-*
-
 # This file is a stress test of supported qapi constructs that must
 # parse and compile correctly.
=20
--=20
2.18.0.547.g1d89318c48
