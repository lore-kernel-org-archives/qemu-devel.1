Received: from eggs.gnu.org ([2001:4830:134:3::10]:58324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORE-00088b-4e
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORB-0007IT-2f
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40922 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fbORA-0007H9-Uz
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7833C401EF2A
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 10:58:04 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  6 Jul 2018 12:57:31 +0200
Message-Id: <20180706105753.26700-6-marcandre.lureau@redhat.com>
In-Reply-To: <20180706105753.26700-1-marcandre.lureau@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 05/27] qapi: include osdep.h in type headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Now that the schema can be configured, it is crucial that all types
are configured the same. Make sure config-host.h is included, so
build-sys tracks the dependency and rebuilds the types, by including
osdep.h first.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/types.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index fd7808103c..91f87d0b8f 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -201,6 +201,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisi=
tor):
 ''',
                                       types=3Dtypes, visit=3Dvisit))
         self._genh.preamble_add(mcgen('''
+#include "qemu/osdep.h"
 #include "qapi/qapi-builtin-types.h"
 '''))
=20
--=20
2.18.0.rc1
