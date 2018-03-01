Received: from eggs.gnu.org ([2001:4830:134:3::10]:40372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6d-0000hg-Pc
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6b-00079i-RJ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erU6b-00077I-IE
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:05 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 13:42:18 -0600
Message-Id: <20180301194245.29854-4-eblake@redhat.com>
In-Reply-To: <20180301194245.29854-1-eblake@redhat.com>
References: <20180301194245.29854-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/30] qapi: Generate up-to-date copyright notice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

From: Markus Armbruster <armbru@redhat.com>

Each generator carries a copyright notice for the generator itself,
and another one for the files it generates.  Only the former have been
updated along the way, the latter have not, and are all out of date.

Fix by copying the generator's copyright notice to the generated files
instead.  Note that the fix doesn't copy the "Authors:" part; the
generated files' outdated Authors list goes away without replacement.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180211093607.27351-4-armbru@redhat.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
[eblake: Flatten each 'blurb' to one line]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi.py            |  7 +++++--
 scripts/qapi-commands.py   | 38 ++++++++++++++++----------------------
 scripts/qapi-event.py      | 36 +++++++++++++++---------------------
 scripts/qapi-introspect.py | 29 +++++++++++++----------------
 scripts/qapi-types.py      | 36 +++++++++++++++---------------------
 scripts/qapi-visit.py      | 38 ++++++++++++++++----------------------
 6 files changed, 80 insertions(+), 104 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 2e5a1ce6a8f..d2695cd8d60 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1985,21 +1985,24 @@ def parse_command_line(extra_options=3D'', extra_=
long_options=3D[]):
 #


-def open_output(output_dir, do_c, do_h, prefix, c_file, h_file, blurb):
+def open_output(output_dir, do_c, do_h, prefix, c_file, h_file, blurb, d=
oc):
     guard =3D guardname(prefix + h_file)
     c_file =3D output_dir + prefix + c_file
     h_file =3D output_dir + prefix + h_file
+    copyright =3D '\n * '.join(re.findall(r'^Copyright .*', doc, re.MULT=
ILINE))
     comment =3D mcgen('''/* AUTOMATICALLY GENERATED, DO NOT MODIFY */

 /*
 %(blurb)s
+ *
+ * %(copyright)s
  *
  * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
  * See the COPYING.LIB file in the top-level directory.
  */

 ''',
-                    blurb=3Dblurb.strip('\n'))
+                    blurb=3Dblurb, copyright=3Dcopyright)

     if output_dir:
         try:
diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index 8e8da7c7962..035a28acb2a 100644
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

 from qapi import *

@@ -255,18 +256,11 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor=
):

 (input_file, output_dir, do_c, do_h, prefix, opts) =3D parse_command_lin=
e()

-blurb =3D '''
- * Schema-defined QAPI/QMP commands
- *
- * Copyright IBM, Corp. 2011
- *
- * Authors:
- *  Anthony Liguori   <aliguori@us.ibm.com>
-'''
+blurb =3D ' * Schema-defined QAPI/QMP commands'

 (fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
                             'qmp-marshal.c', 'qmp-commands.h',
-                            blurb)
+                            blurb, __doc__)

 fdef.write(mcgen('''

diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
index 2b7d720c08f..91874d84fbd 100644
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

 from qapi import *

@@ -171,18 +172,11 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):

 (input_file, output_dir, do_c, do_h, prefix, dummy) =3D parse_command_li=
ne()

-blurb =3D '''
- * Schema-defined QAPI/QMP events
- *
- * Copyright (c) 2014 Wenchao Xia
- *
- * Authors:
- *  Wenchao Xia   <wenchaoqemu@gmail.com>
-'''
+blurb =3D ' * Schema-defined QAPI/QMP events'

 (fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
                             'qapi-event.c', 'qapi-event.h',
-                            blurb)
+                            blurb, __doc__)

 fdef.write(mcgen('''
 #include "qemu/osdep.h"
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 83da2bdb942..cc1c3cb7032 100644
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

 from qapi import *

@@ -176,15 +177,11 @@ for o, a in opts:
     if o in ('-u', '--unmask-non-abi-names'):
         opt_unmask =3D True

-blurb =3D '''
- * QAPI/QMP schema introspection
- *
- * Copyright (C) 2015 Red Hat, Inc.
-'''
+blurb =3D ' * QAPI/QMP schema introspection'

 (fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
                             'qmp-introspect.c', 'qmp-introspect.h',
-                            blurb)
+                            blurb, __doc__)

 fdef.write(mcgen('''
 #include "qemu/osdep.h"
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index 86afc57f923..766c7737d84 100644
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

 from qapi import *

@@ -250,19 +252,11 @@ for o, a in opts:
     if o in ('-b', '--builtins'):
         do_builtins =3D True

-blurb =3D '''
- * Schema-defined QAPI types
- *
- * Copyright IBM, Corp. 2011
- *
- * Authors:
- *  Anthony Liguori   <aliguori@us.ibm.com>
- *  Michael Roth      <mdroth@linux.vnet.ibm.com>
-'''
+blurb =3D ' * Schema-defined QAPI types'

 (fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
                             'qapi-types.c', 'qapi-types.h',
-                            blurb)
+                            blurb, __doc__)

 fdef.write(mcgen('''
 #include "qemu/osdep.h"
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index 0a367072fbc..269227a38e0 100644
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

 from qapi import *

@@ -334,18 +335,11 @@ for o, a in opts:
     if o in ('-b', '--builtins'):
         do_builtins =3D True

-blurb =3D '''
- * Schema-defined QAPI visitors
- *
- * Copyright IBM, Corp. 2011
- *
- * Authors:
- *  Anthony Liguori   <aliguori@us.ibm.com>
-'''
+blurb =3D ' * Schema-defined QAPI visitors'

 (fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
                             'qapi-visit.c', 'qapi-visit.h',
-                            blurb)
+                            blurb, __doc__)

 fdef.write(mcgen('''
 #include "qemu/osdep.h"
--=20
2.14.3
