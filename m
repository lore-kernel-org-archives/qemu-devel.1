Received: from eggs.gnu.org ([2001:4830:134:3::10]:59852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVac7-0004dd-R4
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVac4-00043M-Ng
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:17:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gVac4-000433-I2
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:17:36 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat,  8 Dec 2018 15:15:50 +0400
Message-Id: <20181208111606.8505-12-marcandre.lureau@redhat.com>
In-Reply-To: <20181208111606.8505-1-marcandre.lureau@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 v7 11/27] qapi: pass long form enum to
 make_enum_members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This will allow to get rid of short form handling in a following
patch.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index fdc0fd69ef..557b413950 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1663,9 +1663,10 @@ class QAPISchema(object):
         self.the_empty_object_type =3D QAPISchemaObjectType(
             'q_empty', None, None, None, None, [], None)
         self._def_entity(self.the_empty_object_type)
-        qtype_values =3D self._make_enum_members(['none', 'qnull', 'qnum=
',
-                                                'qstring', 'qdict', 'qli=
st',
-                                                'qbool'])
+
+        qtypes =3D ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist'=
, 'qbool']
+        qtype_values =3D self._make_enum_members([{'name': n} for n in q=
types])
+
         self._def_entity(QAPISchemaEnumType('QType', None, None, None,
                                             qtype_values, 'QTYPE'))
=20
--=20
2.20.0.rc1
