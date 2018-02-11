Received: from eggs.gnu.org ([2001:4830:134:3::10]:53998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3a-00070Y-CH
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3W-0006Jf-CM
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53992 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eko3W-0006HY-3S
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:18 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun, 11 Feb 2018 10:35:41 +0100
Message-Id: <20180211093607.27351-4-armbru@redhat.com>
In-Reply-To: <20180211093607.27351-1-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 03/29] qapi: Generate up-to-date copyright
 notice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com

Each generator carries a copyright notice for the generator itself,
and another one for the files it generates.  Only the former have been
updated along the way, the latter have not, and are all out of date.

Fix by copying the generator's copyright notice to the generated files
instead.  Note that the fix doesn't copy the "Authors:" part; the
generated files' outdated Authors list goes away without replacement.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi-commands.py   | 34 +++++++++++++++-------------------
 scripts/qapi-event.py      | 32 ++++++++++++++------------------
 scripts/qapi-introspect.py | 25 ++++++++++++-------------
 scripts/qapi-types.py      | 32 ++++++++++++++------------------
 scripts/qapi-visit.py      | 34 +++++++++++++++-------------------
 scripts/qapi.py            |  7 +++++--
 6 files changed, 75 insertions(+), 89 deletions(-)

diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index 8e8da7c796..84a980d882 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -1,16 +1,17 @@
-#
-# QAPI command marshaller generator
-#
-# Copyright IBM, Corp. 2011
-# Copyright (C) 2014-2016 Red Hat, Inc.
-#
-# Authors:
-#  Anthony Liguori <aliguori@us.ibm.com>
-#  Michael Roth    <mdroth@linux.vnet.ibm.com>
-#  Markus Armbruster <armbru@redhat.com>
-#
-# This work is licensed under the terms of the GNU GPL, version 2.
-# See the COPYING file in the top-level directory.
+"""
+QAPI command marshaller generator
+
+Copyright IBM, Corp. 2011
+Copyright (C) 2014-2018 Red Hat, Inc.
+
+Authors:
+ Anthony Liguori <aliguori@us.ibm.com>
+ Michael Roth <mdroth@linux.vnet.ibm.com>
+ Markus Armbruster <armbru@redhat.com>
+
+This work is licensed under the terms of the GNU GPL, version 2.
+See the COPYING file in the top-level directory.
+"""
=20
 from qapi import *
=20
@@ -257,16 +258,11 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor=
):
=20
 blurb =3D '''
  * Schema-defined QAPI/QMP commands
- *
- * Copyright IBM, Corp. 2011
- *
- * Authors:
- *  Anthony Liguori   <aliguori@us.ibm.com>
 '''
=20
 (fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
                             'qmp-marshal.c', 'qmp-commands.h',
-                            blurb)
+                            blurb, __doc__)
=20
 fdef.write(mcgen('''
=20
diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
index 2b7d720c08..0a098803e2 100644
--- a/scripts/qapi-event.py
+++ b/scripts/qapi-event.py
@@ -1,15 +1,16 @@
-#
-# QAPI event generator
-#
-# Copyright (c) 2014 Wenchao Xia
-# Copyright (c) 2015-2016 Red Hat Inc.
-#
-# Authors:
-#  Wenchao Xia <wenchaoqemu@gmail.com>
-#  Markus Armbruster <armbru@redhat.com>
-#
-# This work is licensed under the terms of the GNU GPL, version 2.
-# See the COPYING file in the top-level directory.
+"""
+QAPI event generator
+
+Copyright (c) 2014 Wenchao Xia
+Copyright (c) 2015-2018 Red Hat Inc.
+
+Authors:
+ Wenchao Xia <wenchaoqemu@gmail.com>
+ Markus Armbruster <armbru@redhat.com>
+
+This work is licensed under the terms of the GNU GPL, version 2.
+See the COPYING file in the top-level directory.
+"""
=20
 from qapi import *
=20
@@ -173,16 +174,11 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
=20
 blurb =3D '''
  * Schema-defined QAPI/QMP events
- *
- * Copyright (c) 2014 Wenchao Xia
- *
- * Authors:
- *  Wenchao Xia   <wenchaoqemu@gmail.com>
 '''
=20
 (fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
                             'qapi-event.c', 'qapi-event.h',
-                            blurb)
+                            blurb, __doc__)
=20
 fdef.write(mcgen('''
 #include "qemu/osdep.h"
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 83da2bdb94..bd9253a172 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -1,13 +1,14 @@
-#
-# QAPI introspection generator
-#
-# Copyright (C) 2015-2016 Red Hat, Inc.
-#
-# Authors:
-#  Markus Armbruster <armbru@redhat.com>
-#
-# This work is licensed under the terms of the GNU GPL, version 2.
-# See the COPYING file in the top-level directory.
+"""
+QAPI introspection generator
+
+Copyright (C) 2015-2018 Red Hat, Inc.
+
+Authors:
+ Markus Armbruster <armbru@redhat.com>
+
+This work is licensed under the terms of the GNU GPL, version 2.
+See the COPYING file in the top-level directory.
+"""
=20
 from qapi import *
=20
@@ -178,13 +179,11 @@ for o, a in opts:
=20
 blurb =3D '''
  * QAPI/QMP schema introspection
- *
- * Copyright (C) 2015 Red Hat, Inc.
 '''
=20
 (fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
                             'qmp-introspect.c', 'qmp-introspect.h',
-                            blurb)
+                            blurb, __doc__)
=20
 fdef.write(mcgen('''
 #include "qemu/osdep.h"
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index 86afc57f92..1103dbda2d 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -1,15 +1,17 @@
-#
-# QAPI types generator
-#
-# Copyright IBM, Corp. 2011
-# Copyright (c) 2013-2016 Red Hat Inc.
-#
-# Authors:
-#  Anthony Liguori <aliguori@us.ibm.com>
-#  Markus Armbruster <armbru@redhat.com>
-#
-# This work is licensed under the terms of the GNU GPL, version 2.
+"""
+QAPI types generator
+
+Copyright IBM, Corp. 2011
+Copyright (c) 2013-2018 Red Hat Inc.
+
+Authors:
+ Anthony Liguori <aliguori@us.ibm.com>
+ Michael Roth <mdroth@linux.vnet.ibm.com>
+ Markus Armbruster <armbru@redhat.com>
+
+This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
+"""
=20
 from qapi import *
=20
@@ -252,17 +254,11 @@ for o, a in opts:
=20
 blurb =3D '''
  * Schema-defined QAPI types
- *
- * Copyright IBM, Corp. 2011
- *
- * Authors:
- *  Anthony Liguori   <aliguori@us.ibm.com>
- *  Michael Roth      <mdroth@linux.vnet.ibm.com>
 '''
=20
 (fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
                             'qapi-types.c', 'qapi-types.h',
-                            blurb)
+                            blurb, __doc__)
=20
 fdef.write(mcgen('''
 #include "qemu/osdep.h"
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index 0a367072fb..e56b3c1256 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -1,16 +1,17 @@
-#
-# QAPI visitor generator
-#
-# Copyright IBM, Corp. 2011
-# Copyright (C) 2014-2016 Red Hat, Inc.
-#
-# Authors:
-#  Anthony Liguori <aliguori@us.ibm.com>
-#  Michael Roth    <mdroth@linux.vnet.ibm.com>
-#  Markus Armbruster <armbru@redhat.com>
-#
-# This work is licensed under the terms of the GNU GPL, version 2.
-# See the COPYING file in the top-level directory.
+"""
+QAPI visitor generator
+
+Copyright IBM, Corp. 2011
+Copyright (C) 2014-2018 Red Hat, Inc.
+
+Authors:
+ Anthony Liguori <aliguori@us.ibm.com>
+ Michael Roth    <mdroth@linux.vnet.ibm.com>
+ Markus Armbruster <armbru@redhat.com>
+
+This work is licensed under the terms of the GNU GPL, version 2.
+See the COPYING file in the top-level directory.
+"""
=20
 from qapi import *
=20
@@ -336,16 +337,11 @@ for o, a in opts:
=20
 blurb =3D '''
  * Schema-defined QAPI visitors
- *
- * Copyright IBM, Corp. 2011
- *
- * Authors:
- *  Anthony Liguori   <aliguori@us.ibm.com>
 '''
=20
 (fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
                             'qapi-visit.c', 'qapi-visit.h',
-                            blurb)
+                            blurb, __doc__)
=20
 fdef.write(mcgen('''
 #include "qemu/osdep.h"
diff --git a/scripts/qapi.py b/scripts/qapi.py
index 2e5a1ce6a8..26c45cee34 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1985,21 +1985,24 @@ def parse_command_line(extra_options=3D'', extra_=
long_options=3D[]):
 #
=20
=20
-def open_output(output_dir, do_c, do_h, prefix, c_file, h_file, blurb):
+def open_output(output_dir, do_c, do_h, prefix, c_file, h_file, blurb, d=
oc):
     guard =3D guardname(prefix + h_file)
     c_file =3D output_dir + prefix + c_file
     h_file =3D output_dir + prefix + h_file
+    copyright =3D '\n * '.join(re.findall(r'^Copyright .*', doc, re.MULT=
ILINE))
     comment =3D mcgen('''/* AUTOMATICALLY GENERATED, DO NOT MODIFY */
=20
 /*
 %(blurb)s
  *
+ * %(copyright)s
+ *
  * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
  * See the COPYING.LIB file in the top-level directory.
  */
=20
 ''',
-                    blurb=3Dblurb.strip('\n'))
+                    blurb=3Dblurb.strip('\n'), copyright=3Dcopyright)
=20
     if output_dir:
         try:
--=20
2.13.6
