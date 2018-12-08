Received: from eggs.gnu.org ([2001:4830:134:3::10]:60062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVacj-0005Dv-6P
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:18:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVaci-0004N9-HT
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:18:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gVaci-0004LU-9u
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:18:16 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat,  8 Dec 2018 15:15:56 +0400
Message-Id: <20181208111606.8505-18-marcandre.lureau@redhat.com>
In-Reply-To: <20181208111606.8505-1-marcandre.lureau@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 v7 17/27] qapi: simplify
 make_enum_members()
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

The function only receives the dictionary form of enum expressions
now, so we can make it shorter.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index fd622313cb..44020779dd 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1714,16 +1714,7 @@ class QAPISchema(object):
                                             qtype_values, 'QTYPE'))
=20
     def _make_enum_members(self, values):
-        enum =3D []
-        for v in values:
-            if isinstance(v, dict):
-                name =3D v['name']
-                ifcond =3D v.get('if')
-            else:
-                name =3D v
-                ifcond =3D None
-            enum.append(QAPISchemaMember(name, ifcond))
-        return enum
+        return [QAPISchemaMember(v['name'], v.get('if')) for v in values=
]
=20
     def _make_implicit_enum_type(self, name, info, ifcond, values):
         # See also QAPISchemaObjectTypeMember._pretty_owner()
--=20
2.20.0.rc1
