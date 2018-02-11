Received: from eggs.gnu.org ([2001:4830:134:3::10]:54092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3e-00072i-Mr
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3Y-0006Lv-44
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44346 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eko3X-0006Ha-GP
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:19 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun, 11 Feb 2018 10:35:40 +0100
Message-Id: <20180211093607.27351-3-armbru@redhat.com>
In-Reply-To: <20180211093607.27351-1-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 02/29] qapi: Streamline boilerplate comment
 generation
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

Every generator has separate boilerplate for .h and .c, and their
differences are boring.  All of them repeat the license note.

Reduce the repetition as follows.  Move common text like the license
note to common open_output(), next to the existing common text there.
For each generator, replace the two separate descriptions by a single
one.

While there, emit an "automatically generated" note into generated
documentation, too.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi-commands.py        | 26 +++-----------------------
 scripts/qapi-event.py           | 26 +++-----------------------
 scripts/qapi-introspect.py      | 21 ++-------------------
 scripts/qapi-types.py           | 26 +++-----------------------
 scripts/qapi-visit.py           | 26 +++-----------------------
 scripts/qapi.py                 | 31 ++++++++++++++++++-------------
 scripts/qapi2texi.py            |  3 ++-
 tests/qapi-schema/doc-good.texi |  3 ++-
 8 files changed, 36 insertions(+), 126 deletions(-)

diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index f89d748ba4..8e8da7c796 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -255,38 +255,18 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor=
):
=20
 (input_file, output_dir, do_c, do_h, prefix, opts) =3D parse_command_lin=
e()
=20
-c_comment =3D '''
-/*
- * schema-defined QMP->QAPI command dispatch
+blurb =3D '''
+ * Schema-defined QAPI/QMP commands
  *
  * Copyright IBM, Corp. 2011
  *
  * Authors:
  *  Anthony Liguori   <aliguori@us.ibm.com>
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
- * See the COPYING.LIB file in the top-level directory.
- *
- */
-'''
-h_comment =3D '''
-/*
- * schema-defined QAPI function prototypes
- *
- * Copyright IBM, Corp. 2011
- *
- * Authors:
- *  Anthony Liguori   <aliguori@us.ibm.com>
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
- * See the COPYING.LIB file in the top-level directory.
- *
- */
 '''
=20
 (fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
                             'qmp-marshal.c', 'qmp-commands.h',
-                            c_comment, h_comment)
+                            blurb)
=20
 fdef.write(mcgen('''
=20
diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
index c710968dc2..2b7d720c08 100644
--- a/scripts/qapi-event.py
+++ b/scripts/qapi-event.py
@@ -171,38 +171,18 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
=20
 (input_file, output_dir, do_c, do_h, prefix, dummy) =3D parse_command_li=
ne()
=20
-c_comment =3D '''
-/*
- * schema-defined QAPI event functions
+blurb =3D '''
+ * Schema-defined QAPI/QMP events
  *
  * Copyright (c) 2014 Wenchao Xia
  *
  * Authors:
  *  Wenchao Xia   <wenchaoqemu@gmail.com>
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
- * See the COPYING.LIB file in the top-level directory.
- *
- */
-'''
-h_comment =3D '''
-/*
- * schema-defined QAPI event functions
- *
- * Copyright (c) 2014 Wenchao Xia
- *
- * Authors:
- *  Wenchao Xia  <wenchaoqemu@gmail.com>
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
- * See the COPYING.LIB file in the top-level directory.
- *
- */
 '''
=20
 (fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
                             'qapi-event.c', 'qapi-event.h',
-                            c_comment, h_comment)
+                            blurb)
=20
 fdef.write(mcgen('''
 #include "qemu/osdep.h"
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 032bcea491..83da2bdb94 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -176,32 +176,15 @@ for o, a in opts:
     if o in ('-u', '--unmask-non-abi-names'):
         opt_unmask =3D True
=20
-c_comment =3D '''
-/*
+blurb =3D '''
  * QAPI/QMP schema introspection
  *
  * Copyright (C) 2015 Red Hat, Inc.
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
- * See the COPYING.LIB file in the top-level directory.
- *
- */
-'''
-h_comment =3D '''
-/*
- * QAPI/QMP schema introspection
- *
- * Copyright (C) 2015 Red Hat, Inc.
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
- * See the COPYING.LIB file in the top-level directory.
- *
- */
 '''
=20
 (fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
                             'qmp-introspect.c', 'qmp-introspect.h',
-                            c_comment, h_comment)
+                            blurb)
=20
 fdef.write(mcgen('''
 #include "qemu/osdep.h"
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index 7e3051dbb9..86afc57f92 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -250,39 +250,19 @@ for o, a in opts:
     if o in ('-b', '--builtins'):
         do_builtins =3D True
=20
-c_comment =3D '''
-/*
- * deallocation functions for schema-defined QAPI types
+blurb =3D '''
+ * Schema-defined QAPI types
  *
  * Copyright IBM, Corp. 2011
  *
  * Authors:
  *  Anthony Liguori   <aliguori@us.ibm.com>
  *  Michael Roth      <mdroth@linux.vnet.ibm.com>
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
- * See the COPYING.LIB file in the top-level directory.
- *
- */
-'''
-h_comment =3D '''
-/*
- * schema-defined QAPI types
- *
- * Copyright IBM, Corp. 2011
- *
- * Authors:
- *  Anthony Liguori   <aliguori@us.ibm.com>
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
- * See the COPYING.LIB file in the top-level directory.
- *
- */
 '''
=20
 (fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
                             'qapi-types.c', 'qapi-types.h',
-                            c_comment, h_comment)
+                            blurb)
=20
 fdef.write(mcgen('''
 #include "qemu/osdep.h"
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index bc2b8b581a..0a367072fb 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -334,38 +334,18 @@ for o, a in opts:
     if o in ('-b', '--builtins'):
         do_builtins =3D True
=20
-c_comment =3D '''
-/*
- * schema-defined QAPI visitor functions
+blurb =3D '''
+ * Schema-defined QAPI visitors
  *
  * Copyright IBM, Corp. 2011
  *
  * Authors:
  *  Anthony Liguori   <aliguori@us.ibm.com>
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
- * See the COPYING.LIB file in the top-level directory.
- *
- */
-'''
-h_comment =3D '''
-/*
- * schema-defined QAPI visitor functions
- *
- * Copyright IBM, Corp. 2011
- *
- * Authors:
- *  Anthony Liguori   <aliguori@us.ibm.com>
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
- * See the COPYING.LIB file in the top-level directory.
- *
- */
 '''
=20
 (fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
                             'qapi-visit.c', 'qapi-visit.h',
-                            c_comment, h_comment)
+                            blurb)
=20
 fdef.write(mcgen('''
 #include "qemu/osdep.h"
diff --git a/scripts/qapi.py b/scripts/qapi.py
index 58f995b07f..2e5a1ce6a8 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1985,11 +1985,21 @@ def parse_command_line(extra_options=3D'', extra_=
long_options=3D[]):
 #
=20
=20
-def open_output(output_dir, do_c, do_h, prefix, c_file, h_file,
-                c_comment, h_comment):
+def open_output(output_dir, do_c, do_h, prefix, c_file, h_file, blurb):
     guard =3D guardname(prefix + h_file)
     c_file =3D output_dir + prefix + c_file
     h_file =3D output_dir + prefix + h_file
+    comment =3D mcgen('''/* AUTOMATICALLY GENERATED, DO NOT MODIFY */
+
+/*
+%(blurb)s
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
+ * See the COPYING.LIB file in the top-level directory.
+ */
+
+''',
+                    blurb=3Dblurb.strip('\n'))
=20
     if output_dir:
         try:
@@ -2007,27 +2017,22 @@ def open_output(output_dir, do_c, do_h, prefix, c=
_file, h_file,
     fdef =3D maybe_open(do_c, c_file, 'w')
     fdecl =3D maybe_open(do_h, h_file, 'w')
=20
-    fdef.write(mcgen('''
-/* AUTOMATICALLY GENERATED, DO NOT MODIFY */
-%(comment)s
-''',
-                     comment=3Dc_comment))
-
+    fdef.write(comment)
+    fdecl.write(comment)
     fdecl.write(mcgen('''
-/* AUTOMATICALLY GENERATED, DO NOT MODIFY */
-%(comment)s
 #ifndef %(guard)s
 #define %(guard)s
=20
 ''',
-                      comment=3Dh_comment, guard=3Dguard))
+                      guard=3Dguard))
=20
     return (fdef, fdecl)
=20
=20
 def close_output(fdef, fdecl):
-    fdecl.write('''
+    fdecl.write(mcgen('''
+
 #endif
-''')
+'''))
     fdecl.close()
     fdef.close()
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index bf1c57b2e2..8a604d86a6 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -283,7 +283,8 @@ def main(argv):
         print("%s: need pragma 'doc-required' "
                "to generate documentation" % argv[0], file=3Dsys.stderr)
         sys.exit(1)
-    print(texi_schema(schema))
+    print('@c AUTOMATICALLY GENERATED, DO NOT MODIFY\n')
+    print(texi_schema(schema), end=3D'')
=20
=20
 if __name__ =3D=3D '__main__':
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good=
.texi
index 1778312581..0aed2300a5 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -1,3 +1,5 @@
+@c AUTOMATICALLY GENERATED, DO NOT MODIFY
+
 @section Section
=20
 @subsection Subsection
@@ -231,4 +233,3 @@ If you're bored enough to read this, go see a video o=
f boxed cats
=20
 @end deftypefn
=20
-
--=20
2.13.6
