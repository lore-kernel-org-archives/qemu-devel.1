Received: from eggs.gnu.org ([2001:4830:134:3::10]:58318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fYDQO-0003Lz-OR
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fYDQN-00035y-KI
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:36:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55568 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fYDQN-00035Y-Fg
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:36:07 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 27 Jun 2018 18:35:42 +0200
Message-Id: <20180627163551.31610-7-marcandre.lureau@redhat.com>
In-Reply-To: <20180627163551.31610-1-marcandre.lureau@redhat.com>
References: <20180627163551.31610-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 06/15] qapi: mcgen() shouldn't indent # lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, eblake@redhat.com, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Skip preprocessor lines when adding indentation, since that would
likely result in invalid code.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index feae646e09..1b56065a80 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1941,8 +1941,8 @@ def cgen(code, **kwds):
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
2.18.0.rc1
