Received: from eggs.gnu.org ([2001:4830:134:3::10]:50041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkUZ-0005qw-JY
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:34:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkUY-0001yO-Qh
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:34:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40769)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkUY-0001xw-KQ
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:34:30 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:08 +0100
Message-Id: <20180111213250.16511-10-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 09/51] qapi: mcgen() shouldn't indent # lines
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

Skip preprocessor lines when adding indentation, since that would
likely result in invalid code.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index ffb4fb58e0..3d33ed7d76 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1876,8 +1876,8 @@ def cgen(code, **kwds):
     if indent_level:
         indent =3D genindent(indent_level)
         # re.subn() lacks flags support before Python 2.7, use re.compil=
e()
-        raw =3D re.subn(re.compile(r'^.', re.MULTILINE),
-                      indent + r'\g<0>', raw)
+        raw =3D re.subn(re.compile(r'^(?!(#|$))', re.MULTILINE),
+                      indent, raw)
         raw =3D raw[0]
     return re.sub(re.escape(eatspace) + r' *', '', raw)
=20
--=20
2.16.0.rc1.1.gef27df75a1
