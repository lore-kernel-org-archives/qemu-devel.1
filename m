Received: from eggs.gnu.org ([2001:4830:134:3::10]:59537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVaaw-0003nd-Ls
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:16:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVaaw-0003eN-2Z
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:16:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gVaav-0003e8-Sp
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:16:26 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat,  8 Dec 2018 15:15:40 +0400
Message-Id: <20181208111606.8505-2-marcandre.lureau@redhat.com>
In-Reply-To: <20181208111606.8505-1-marcandre.lureau@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 v7 01/27] qapi: make sure osdep.h is
 included in type headers
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

Now that the schema can be configured, it is crucial that all types
are configured the same. Make sure config-host.h is included, by
checking osdep.h inclusion. The build-sys tracks the dependency and
rebuilds the types if the configuration changed.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/types.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index fd7808103c..3bb9cb6d47 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -201,6 +201,9 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisi=
tor):
 ''',
                                       types=3Dtypes, visit=3Dvisit))
         self._genh.preamble_add(mcgen('''
+#ifndef QEMU_OSDEP_H
+#error Please include osdep.h first!
+#endif
 #include "qapi/qapi-builtin-types.h"
 '''))
=20
--=20
2.20.0.rc1
