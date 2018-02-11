Received: from eggs.gnu.org ([2001:4830:134:3::10]:53964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3Z-00070L-64
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3W-0006JU-D7
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53996 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eko3W-0006HT-3U
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:18 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun, 11 Feb 2018 10:35:42 +0100
Message-Id: <20180211093607.27351-5-armbru@redhat.com>
In-Reply-To: <20180211093607.27351-1-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 04/29] qapi: Rename variable holding the
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
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com

Rename the variable holding the QAPISchemaGenFOOVisitor from gen to
vis, to avoid confusion in the next commit.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi-commands.py   | 8 ++++----
 scripts/qapi-event.py      | 8 ++++----
 scripts/qapi-introspect.py | 8 ++++----
 scripts/qapi-types.py      | 8 ++++----
 scripts/qapi-visit.py      | 8 ++++----
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index 84a980d882..c3aa52fce1 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -291,9 +291,9 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
                   prefix=prefix, c_prefix=c_name(prefix, protect=False)))
 
 schema = QAPISchema(input_file)
-gen = QAPISchemaGenCommandVisitor()
-schema.visit(gen)
-fdef.write(gen.defn)
-fdecl.write(gen.decl)
+vis = QAPISchemaGenCommandVisitor()
+schema.visit(vis)
+fdef.write(vis.defn)
+fdecl.write(vis.decl)
 
 close_output(fdef, fdecl)
diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
index 0a098803e2..edb9ddb650 100644
--- a/scripts/qapi-event.py
+++ b/scripts/qapi-event.py
@@ -203,9 +203,9 @@ fdecl.write(mcgen('''
 event_enum_name = c_name(prefix + 'QAPIEvent', protect=False)
 
 schema = QAPISchema(input_file)
-gen = QAPISchemaGenEventVisitor()
-schema.visit(gen)
-fdef.write(gen.defn)
-fdecl.write(gen.decl)
+vis = QAPISchemaGenEventVisitor()
+schema.visit(vis)
+fdef.write(vis.defn)
+fdecl.write(vis.decl)
 
 close_output(fdef, fdecl)
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index bd9253a172..ebe8706f41 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -193,9 +193,9 @@ fdef.write(mcgen('''
                  prefix=prefix))
 
 schema = QAPISchema(input_file)
-gen = QAPISchemaGenIntrospectVisitor(opt_unmask)
-schema.visit(gen)
-fdef.write(gen.defn)
-fdecl.write(gen.decl)
+vis = QAPISchemaGenIntrospectVisitor(opt_unmask)
+schema.visit(vis)
+fdef.write(vis.defn)
+fdecl.write(vis.decl)
 
 close_output(fdef, fdecl)
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index 1103dbda2d..4db8424da1 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -273,9 +273,9 @@ fdecl.write(mcgen('''
 '''))
 
 schema = QAPISchema(input_file)
-gen = QAPISchemaGenTypeVisitor()
-schema.visit(gen)
-fdef.write(gen.defn)
-fdecl.write(gen.decl)
+vis = QAPISchemaGenTypeVisitor()
+schema.visit(vis)
+fdef.write(vis.defn)
+fdecl.write(vis.decl)
 
 close_output(fdef, fdecl)
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index e56b3c1256..3c1a0e2544 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -360,9 +360,9 @@ fdecl.write(mcgen('''
                   prefix=prefix))
 
 schema = QAPISchema(input_file)
-gen = QAPISchemaGenVisitVisitor()
-schema.visit(gen)
-fdef.write(gen.defn)
-fdecl.write(gen.decl)
+vis = QAPISchemaGenVisitVisitor()
+schema.visit(vis)
+fdef.write(vis.defn)
+fdecl.write(vis.decl)
 
 close_output(fdef, fdecl)
-- 
2.13.6
