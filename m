Received: from eggs.gnu.org ([2001:4830:134:3::10]:40378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6e-0000hu-3b
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6c-0007D2-Vk
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erU6c-0007Ag-O0
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:06 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 13:42:19 -0600
Message-Id: <20180301194245.29854-5-eblake@redhat.com>
In-Reply-To: <20180301194245.29854-1-eblake@redhat.com>
References: <20180301194245.29854-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/30] qapi: Rename variable holding the
 QAPISchemaGenFOOVisitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

From: Markus Armbruster <armbru@redhat.com>

Rename the variable holding the QAPISchemaGenFOOVisitor from gen to
vis, to avoid confusion in the next commit.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180211093607.27351-5-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi-commands.py   | 8 ++++----
 scripts/qapi-event.py      | 8 ++++----
 scripts/qapi-introspect.py | 8 ++++----
 scripts/qapi-types.py      | 8 ++++----
 scripts/qapi-visit.py      | 8 ++++----
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index 035a28acb2a..114c5ad276b 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -289,9 +289,9 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmd=
s);
                   prefix=3Dprefix, c_prefix=3Dc_name(prefix, protect=3DF=
alse)))

 schema =3D QAPISchema(input_file)
-gen =3D QAPISchemaGenCommandVisitor()
-schema.visit(gen)
-fdef.write(gen.defn)
-fdecl.write(gen.decl)
+vis =3D QAPISchemaGenCommandVisitor()
+schema.visit(vis)
+fdef.write(vis.defn)
+fdecl.write(vis.decl)

 close_output(fdef, fdecl)
diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
index 91874d84fbd..9de5c6748e4 100644
--- a/scripts/qapi-event.py
+++ b/scripts/qapi-event.py
@@ -201,9 +201,9 @@ fdecl.write(mcgen('''
 event_enum_name =3D c_name(prefix + 'QAPIEvent', protect=3DFalse)

 schema =3D QAPISchema(input_file)
-gen =3D QAPISchemaGenEventVisitor()
-schema.visit(gen)
-fdef.write(gen.defn)
-fdecl.write(gen.decl)
+vis =3D QAPISchemaGenEventVisitor()
+schema.visit(vis)
+fdef.write(vis.defn)
+fdecl.write(vis.decl)

 close_output(fdef, fdecl)
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index cc1c3cb7032..7a01a8f8f25 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -191,9 +191,9 @@ fdef.write(mcgen('''
                  prefix=3Dprefix))

 schema =3D QAPISchema(input_file)
-gen =3D QAPISchemaGenIntrospectVisitor(opt_unmask)
-schema.visit(gen)
-fdef.write(gen.defn)
-fdecl.write(gen.decl)
+vis =3D QAPISchemaGenIntrospectVisitor(opt_unmask)
+schema.visit(vis)
+fdef.write(vis.defn)
+fdecl.write(vis.decl)

 close_output(fdef, fdecl)
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index 766c7737d84..524d220ed75 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -271,9 +271,9 @@ fdecl.write(mcgen('''
 '''))

 schema =3D QAPISchema(input_file)
-gen =3D QAPISchemaGenTypeVisitor()
-schema.visit(gen)
-fdef.write(gen.defn)
-fdecl.write(gen.decl)
+vis =3D QAPISchemaGenTypeVisitor()
+schema.visit(vis)
+fdef.write(vis.defn)
+fdecl.write(vis.decl)

 close_output(fdef, fdecl)
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index 269227a38e0..0e78cf3bbb5 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -358,9 +358,9 @@ fdecl.write(mcgen('''
                   prefix=3Dprefix))

 schema =3D QAPISchema(input_file)
-gen =3D QAPISchemaGenVisitVisitor()
-schema.visit(gen)
-fdef.write(gen.defn)
-fdecl.write(gen.decl)
+vis =3D QAPISchemaGenVisitVisitor()
+schema.visit(vis)
+fdef.write(vis.defn)
+fdecl.write(vis.decl)

 close_output(fdef, fdecl)
--=20
2.14.3
