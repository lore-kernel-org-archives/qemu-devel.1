Received: from eggs.gnu.org ([2001:4830:134:3::10]:50356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkV3-0006Ft-Ob
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkV3-0002K7-0I
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkV2-0002Jp-RT
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:00 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:13 +0100
Message-Id: <20180111213250.16511-15-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 14/51] qapi-event: add #if conditions to
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Wrap generated code with #if/#endif using the ifcond_decorator.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi-event.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
index dda496e824..bef301dfe9 100644
--- a/scripts/qapi-event.py
+++ b/scripts/qapi-event.py
@@ -152,6 +152,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
         self.decl =3D None
         self.defn =3D None
         self._event_names =3D None
+        self.if_members =3D ['decl', 'defn']
=20
     def visit_begin(self, schema):
         self.decl =3D ''
@@ -163,6 +164,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
         self.defn +=3D gen_enum_lookup(event_enum_name, self._event_name=
s)
         self._event_names =3D None
=20
+    @ifcond_decorator
     def visit_event(self, name, info, ifcond, arg_type, boxed):
         self.decl +=3D gen_event_send_decl(name, arg_type, boxed)
         self.defn +=3D gen_event_send(name, arg_type, boxed)
--=20
2.16.0.rc1.1.gef27df75a1
