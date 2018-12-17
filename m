Received: from eggs.gnu.org ([2001:4830:134:3::10]:48732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gYzhF-000066-BU
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 15:41:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gYzhC-0006o8-8b
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 15:41:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gYzhC-0006nH-3E
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 15:40:58 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Dec 2018 00:40:46 +0400
Message-Id: <20181217204046.14861-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qapi: fix flat union on uncovered branches
 conditionals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, thuth@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Default branches variant should use the member conditional.

This fixes compilation with --disable-replication.

Fixes: 335d10cd8e2c3bb6067804b095aaf6371fc1983e

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 8c2d97369e..d385a08270 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1460,7 +1460,7 @@ class QAPISchemaObjectTypeVariants(object):
             cases =3D set([v.name for v in self.variants])
             for m in self.tag_member.type.members:
                 if m.name not in cases:
-                    v =3D QAPISchemaObjectTypeVariant(m.name, 'q_empty')
+                    v =3D QAPISchemaObjectTypeVariant(m.name, 'q_empty',=
 m.ifcond)
                     v.set_owner(self.tag_member.owner)
                     self.variants.append(v)
         for v in self.variants:
--=20
2.20.0
