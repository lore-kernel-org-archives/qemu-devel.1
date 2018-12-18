Received: from eggs.gnu.org ([2001:4830:134:3::10]:55933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZCJy-000613-Uu
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:09:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZCJy-0008J4-3C
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:09:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZCJx-0008FO-Pk
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:09:49 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 200D476233
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 10:09:49 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 18 Dec 2018 11:09:41 +0100
Message-Id: <20181218100941.25267-8-armbru@redhat.com>
In-Reply-To: <20181218100941.25267-1-armbru@redhat.com>
References: <20181218100941.25267-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/7] qapi: fix flat union on uncovered branches
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Default branches variant should use the member conditional.

This fixes compilation with --disable-replication.

Fixes: 335d10cd8e2c3bb6067804b095aaf6371fc1983e

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20181217204046.14861-1-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Long line wrapped]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 8c2d97369e..c89edc0cb0 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1460,7 +1460,8 @@ class QAPISchemaObjectTypeVariants(object):
             cases =3D set([v.name for v in self.variants])
             for m in self.tag_member.type.members:
                 if m.name not in cases:
-                    v =3D QAPISchemaObjectTypeVariant(m.name, 'q_empty')
+                    v =3D QAPISchemaObjectTypeVariant(m.name, 'q_empty',
+                                                    m.ifcond)
                     v.set_owner(self.tag_member.owner)
                     self.variants.append(v)
         for v in self.variants:
--=20
2.17.2
