Received: from eggs.gnu.org ([2001:4830:134:3::10]:56717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fWO38-0000pv-D5
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fWO36-0000K3-Fv
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:32:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59540 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fWO36-0000Jk-CO
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:32:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 014EA4023336
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 15:32:32 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 22 Jun 2018 17:32:19 +0200
Message-Id: <20180622153228.23594-2-armbru@redhat.com>
In-Reply-To: <20180622153228.23594-1-armbru@redhat.com>
References: <20180622153228.23594-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/10] qapi/visit: remove useless prefix argument
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180321115211.17937-2-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/visit.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 5d72d8936c..3c5ea1289e 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -293,7 +293,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVis=
itor):
 #include "qapi/qmp/qerror.h"
 #include "%(visit)s.h"
 ''',
-                                      visit=3Dvisit, prefix=3Dself._pref=
ix))
+                                      visit=3Dvisit))
         self._genh.preamble_add(mcgen('''
 #include "qapi/qapi-builtin-visit.h"
 #include "%(types)s.h"
--=20
2.17.1
