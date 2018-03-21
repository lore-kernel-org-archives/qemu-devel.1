Received: from eggs.gnu.org ([2001:4830:134:3::10]:48374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycIK-000529-0V
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycIG-0007lK-QB
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:52:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42044 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycIG-0007l8-Lm
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:52:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 34103406DE12
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:52:36 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:51:29 +0100
Message-Id: <20180321115211.17937-8-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 07/49] qapi: mcgen() shouldn't indent # lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Skip preprocessor lines when adding indentation, since that would
likely result in invalid code.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index bc4ecd6c76..47efe79758 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1931,8 +1931,8 @@ def cgen(code, **kwds):
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
2.16.2.521.g9aa15f885a
