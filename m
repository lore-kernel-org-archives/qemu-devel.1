Received: from eggs.gnu.org ([2001:4830:134:3::10]:56128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dal23-0005nZ-Ea
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dal20-0004cl-56
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:48:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dal1z-0004cR-Vt
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:48:56 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 27 Jul 2017 17:41:13 +0200
Message-Id: <20170727154126.11339-14-marcandre.lureau@redhat.com>
In-Reply-To: <20170727154126.11339-1-marcandre.lureau@redhat.com>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 13/26] qapi2texi: add 'If:' condition to enum
 values
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
index bfb8cd7c52..340a55c30d 100755
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
2.14.0.rc0.1.g40ca67566
