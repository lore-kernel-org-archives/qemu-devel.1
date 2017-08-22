Received: from eggs.gnu.org ([2001:4830:134:3::10]:55508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Ju-000087-JI
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Jp-0007MZ-25
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:34:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9Jo-0007ME-Sg
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:34:08 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:24 +0200
Message-Id: <20170822132255.23945-24-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 23/54] qapi-commands: add #if conditions to
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Wrap generated code with #if/#endif using the ifcond_decorator.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi-commands.py  | 2 ++
 tests/test-qmp-commands.c | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index 5eb96b2d95..db45415c41 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -228,6 +228,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
         self.defn =3D None
         self._regy =3D None
         self._visited_ret_types =3D None
+        self.if_members =3D ['decl', 'defn', '_regy']
=20
     def visit_begin(self, schema):
         self.decl =3D ''
@@ -240,6 +241,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
         self._regy =3D None
         self._visited_ret_types =3D None
=20
+    @ifcond_decorator
     def visit_command(self, name, info, arg_type, ret_type,
                       gen, success_response, boxed, ifcond):
         if not gen:
diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-commands.c
index 9b9a7ffee7..ad7b6e4e1d 100644
--- a/tests/test-qmp-commands.c
+++ b/tests/test-qmp-commands.c
@@ -10,11 +10,11 @@
=20
 static QmpCommandList qmp_commands;
=20
-/* #if defined(TEST_IF_CMD) */
+#if defined(TEST_IF_CMD)
 void qmp_TestIfCmd(TestIfStruct *foo, Error **errp)
 {
 }
-/* #endif */
+#endif
=20
 void qmp_user_def_cmd(Error **errp)
 {
--=20
2.14.1.146.gd35faa819
