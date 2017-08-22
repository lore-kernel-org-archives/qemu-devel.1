Received: from eggs.gnu.org ([2001:4830:134:3::10]:54698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Hc-0006TJ-OE
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:31:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9HZ-0005wR-3D
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:31:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9HY-0005w4-Sb
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:31:48 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:15 +0200
Message-Id: <20170822132255.23945-15-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 14/54] qapi2texi: minor python code
 simplification
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi2texi.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index a317526e51..8b542f9fff 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -136,10 +136,9 @@ def texi_enum_value(value):
 def texi_member(member, suffix=3D''):
     """Format a table of members item for an object type member"""
     typ =3D member.type.doc_type()
-    return '@item @code{%s%s%s}%s%s\n' % (
-        member.name,
-        ': ' if typ else '',
-        typ if typ else '',
+    membertype =3D ': %s' % typ if typ else ''
+    return '@item @code{%s%s}%s%s\n' % (
+        member.name, membertype,
         ' (optional)' if member.optional else '',
         suffix)
=20
--=20
2.14.1.146.gd35faa819
