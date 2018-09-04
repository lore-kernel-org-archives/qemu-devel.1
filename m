Received: from eggs.gnu.org ([2001:4830:134:3::10]:59102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fx5NA-00007d-1m
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 03:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fx5N5-0005OK-He
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 03:03:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44744 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1fx5N5-0005JW-85
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 03:03:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5F85940216E6
	for <qemu-devel@nongnu.org>; Tue,  4 Sep 2018 07:03:26 +0000 (UTC)
From: Peter Krempa <pkrempa@redhat.com>
Date: Tue,  4 Sep 2018 09:03:10 +0200
Message-Id: <1f7db2e27758f26d4c10f7a8ed1d8232635f6909.1536044449.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qapi: Add vim magic modelines for qapi
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Krempa <pkrempa@redhat.com>

The files have a json suffix but look terrible with json syntax
hilighting enabled. Add a magic modeline for vim to switch to python
file format for hilighting similarly to the emacs modeline already
present.

Signed-off-by: Peter Krempa <pkrempa@redhat.com>
---
 qapi/block-core.json  | 1 +
 qapi/block.json       | 1 +
 qapi/char.json        | 1 +
 qapi/common.json      | 1 +
 qapi/crypto.json      | 1 +
 qapi/introspect.json  | 1 +
 qapi/job.json         | 1 +
 qapi/migration.json   | 1 +
 qapi/misc.json        | 1 +
 qapi/net.json         | 1 +
 qapi/qapi-schema.json | 1 +
 qapi/rocker.json      | 1 +
 qapi/run-state.json   | 1 +
 qapi/sockets.json     | 1 +
 qapi/tpm.json         | 1 +
 qapi/trace.json       | 1 +
 qapi/transaction.json | 1 +
 qapi/ui.json          | 1 +
 18 files changed, 18 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4c7a37afdc..e75bc8dd03 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: ft=3Dpython

 ##
 # =3D=3D Block core (VM unrelated)
diff --git a/qapi/block.json b/qapi/block.json
index 11f01f28ef..f94ab0c09f 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: ft=3Dpython

 ##
 # =3D Block devices
diff --git a/qapi/char.json b/qapi/char.json
index b7b2a05766..d167f74699 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: ft=3Dpython
 #

 ##
diff --git a/qapi/common.json b/qapi/common.json
index c367adc4b6..5a3a71a5bf 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: ft=3Dpython

 ##
 # =3D Common data types
diff --git a/qapi/crypto.json b/qapi/crypto.json
index a51b434412..6ccb97079b 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: ft=3Dpython
 #

 ##
diff --git a/qapi/introspect.json b/qapi/introspect.json
index 3d22166b2b..ff6fb9fe52 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: ft=3Dpython
 #
 # Copyright (C) 2015 Red Hat, Inc.
 #
diff --git a/qapi/job.json b/qapi/job.json
index a121b615fb..ddef257f7e 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: ft=3Dpython

 ##
 # =3D=3D Background jobs
diff --git a/qapi/migration.json b/qapi/migration.json
index f62d3f9a4b..17b0e00252 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: ft=3Dpython
 #

 ##
diff --git a/qapi/misc.json b/qapi/misc.json
index d450cfef21..2f04983517 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: ft=3Dpython
 #

 ##
diff --git a/qapi/net.json b/qapi/net.json
index c86f351161..e736e1a26b 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: ft=3Dpython
 #

 ##
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 65b6dc2f6f..09d745bdcf 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: ft=3Dpython
 ##
 # =3D Introduction
 #
diff --git a/qapi/rocker.json b/qapi/rocker.json
index 3587661161..8e3486592b 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: ft=3Dpython

 ##
 # =3D Rocker switch device
diff --git a/qapi/run-state.json b/qapi/run-state.json
index 332e44897b..704a330a6c 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: ft=3Dpython
 #

 ##
diff --git a/qapi/sockets.json b/qapi/sockets.json
index fc81d8d5e8..b335b6b872 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: ft=3Dpython

 ##
 # =3D Socket data types
diff --git a/qapi/tpm.json b/qapi/tpm.json
index d50deef5e9..ae7953cb04 100644
--- a/qapi/tpm.json
+++ b/qapi/tpm.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: ft=3Dpython
 #

 ##
diff --git a/qapi/trace.json b/qapi/trace.json
index 799b254a18..e5ffbad800 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -1,4 +1,5 @@
 # -*- mode: python -*-
+# vim: ft=3Dpython
 #
 # Copyright (C) 2011-2016 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
 #
diff --git a/qapi/transaction.json b/qapi/transaction.json
index d7e4274550..588112383a 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: ft=3Dpython
 #

 ##
diff --git a/qapi/ui.json b/qapi/ui.json
index 4ca91bb45a..918ab84a5a 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: ft=3Dpython
 #

 ##
--=20
2.17.1
