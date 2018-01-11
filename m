Received: from eggs.gnu.org ([2001:4830:134:3::10]:49533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkTe-00054O-1W
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:33:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkTa-0000jW-Si
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:33:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:20304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkTa-0000iT-NQ
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:33:30 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:03 +0100
Message-Id: <20180111213250.16511-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 04/51] qapi2texi: minor python code
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
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi2texi.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 92e2af2cd6..0a08fbaf7b 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -134,10 +134,9 @@ def texi_enum_value(value):
 def texi_member(member, suffix=3D''):
     """Format a table of members item for an object type member"""
     typ =3D member.type.doc_type()
-    return '@item @code{%s%s%s}%s%s\n' % (
-        member.name,
-        ': ' if typ else '',
-        typ if typ else '',
+    membertype =3D ': ' + typ if typ else ''
+    return '@item @code{%s%s}%s%s\n' % (
+        member.name, membertype,
         ' (optional)' if member.optional else '',
         suffix)
=20
--=20
2.16.0.rc1.1.gef27df75a1
