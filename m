Received: from eggs.gnu.org ([2001:4830:134:3::10]:56411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9MU-0002GN-Cf
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9MP-0000Yk-2z
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:36:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9MO-0000YJ-Sa
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:36:49 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:45 +0200
Message-Id: <20170822132255.23945-45-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 44/54] qapi2texi: add condition to variants
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
 scripts/qapi2texi.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 2c3e1d1a1c..49a54d41db 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -163,8 +163,9 @@ def texi_members(doc, what, base, variants, member_fu=
nc):
         items +=3D '@item The members of @code{%s}\n' % base.doc_type()
     if variants:
         for v in variants.variants:
-            when =3D ' when @code{%s} is @t{"%s"}' % (
-                variants.tag_member.name, v.name)
+            when =3D ' when @code{%s} is @t{"%s"}%s' % (
+                variants.tag_member.name, v.name,
+                ' (and @code{%s})' % v.ifcond if v.ifcond else '')
             if v.type.is_implicit():
                 assert not v.type.base and not v.type.variants
                 for m in v.type.local_members:
--=20
2.14.1.146.gd35faa819
