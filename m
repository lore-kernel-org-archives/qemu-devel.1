Received: from eggs.gnu.org ([2001:4830:134:3::10]:54890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9I3-0006w0-T0
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Hy-0006Fc-2Y
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:32:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9Hx-0006F1-S5
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:32:13 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:43 +0200
Message-Id: <20170822132255.23945-43-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 42/54] qapi2texi: add 'If:' condition to
 enum values
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
 scripts/qapi2texi.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 3a923ce438..8959cb0cdf 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -130,7 +130,9 @@ def texi_body(doc):
=20
 def texi_enum_value(value):
     """Format a table of members item for an enumeration value"""
-    return '@item @code{%s}\n' % value.name
+    return '@item @code{%s}%s\n' % (
+        value.name,
+        '\n@b{If:} @code{%s}\n' % value.ifcond if value.ifcond else '')
=20
 def texi_member(member, suffix=3D''):
     """Format a table of members item for an object type member"""
--=20
2.14.1.146.gd35faa819
