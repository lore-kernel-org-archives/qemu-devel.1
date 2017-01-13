Received: from eggs.gnu.org ([2001:4830:134:3::10]:59759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS33G-0003QO-Th
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS33G-0006Xf-1U
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cS33F-0006X9-RX
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:57 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 01C25C04B925
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 14:41:58 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jan 2017 15:41:26 +0100
Message-Id: <20170113144135.5150-13-marcandre.lureau@redhat.com>
In-Reply-To: <20170113144135.5150-1-marcandre.lureau@redhat.com>
References: <20170113144135.5150-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 12/21] qapi.py: fix line break before binary
 operator pep8
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

Python code style accepts both form, but pep8 complains. Better to clean
up the single warning for now, so new errors stand out more easily.

Fix scripts/qapi.py:1539:21: W503 line break before binary operator

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 1483ec09f5..3d5f9e1eaf 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1535,8 +1535,8 @@ def c_name(name, protect=3DTrue):
     # namespace pollution:
     polluted_words =3D set(['unix', 'errno', 'mips', 'sparc'])
     name =3D name.translate(c_name_trans)
-    if protect and (name in c89_words | c99_words | c11_words | gcc_word=
s
-                    | cpp_words | polluted_words):
+    if protect and (name in c89_words | c99_words | c11_words | gcc_word=
s |
+                    cpp_words | polluted_words):
         return "q_" + name
     return name
=20
--=20
2.11.0
