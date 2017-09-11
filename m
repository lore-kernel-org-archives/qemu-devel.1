Received: from eggs.gnu.org ([2001:4830:134:3::10]:42779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMYJ-00054O-2n
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:06:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMYF-00068x-3t
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:06:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1drMYE-00068W-UJ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:06:51 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Sep 2017 13:05:41 +0200
Message-Id: <20170911110623.24981-9-marcandre.lureau@redhat.com>
In-Reply-To: <20170911110623.24981-1-marcandre.lureau@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 08/50] qapi: mcgen() shouldn't indent # lines
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

Skip preprocessor lines when adding indentation, since that would
likely result in invalid code.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index f2b5a7e131..2a8e60e975 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1862,7 +1862,7 @@ def cgen(code, **kwds):
     if indent_level:
         indent =3D genindent(indent_level)
         # re.subn() lacks flags support before Python 2.7, use re.compil=
e()
-        raw =3D re.subn(re.compile(r'^.', re.MULTILINE),
+        raw =3D re.subn(re.compile(r'^[^#\n].', re.MULTILINE),
                       indent + r'\g<0>', raw)
         raw =3D raw[0]
     return re.sub(re.escape(eatspace) + r' *', '', raw)
--=20
2.14.1.146.gd35faa819
