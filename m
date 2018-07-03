Received: from eggs.gnu.org ([2001:4830:134:3::10]:44121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSVA-0000yJ-4G
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSV6-0000Nm-Tv
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:06:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47962 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faSV6-0000NL-P0
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:06:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4172DDFEB
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:06:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 23:06:04 +0200
Message-Id: <20180703210613.25619-6-armbru@redhat.com>
In-Reply-To: <20180703210613.25619-1-armbru@redhat.com>
References: <20180703210613.25619-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/14] qapi: mcgen() shouldn't indent # lines
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

Skip preprocessor lines when adding indentation, since that would
likely result in invalid code.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180703155648.11933-6-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
2.17.1
