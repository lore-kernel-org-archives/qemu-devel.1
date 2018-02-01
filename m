Received: from eggs.gnu.org ([2001:4830:134:3::10]:37958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehCtK-0006Kx-Vo
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:18:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehCtI-0004zs-Kq
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:18:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehCtI-0004yz-F5
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:18:52 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  1 Feb 2018 12:18:42 +0100
Message-Id: <20180201111846.21846-16-armbru@redhat.com>
In-Reply-To: <20180201111846.21846-1-armbru@redhat.com>
References: <20180201111846.21846-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 15/19] Include qapi/qmp/qnum.h exactly where
 needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, eblake@redhat.com, f4bug@amsat.org

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/check-qlit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/check-qlit.c b/tests/check-qlit.c
index f012885534..5d0f65b9c7 100644
--- a/tests/check-qlit.c
+++ b/tests/check-qlit.c
@@ -12,7 +12,6 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qlit.h"
-#include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
=20
 static QLitObject qlit =3D QLIT_QDICT(((QLitDictEntry[]) {
--=20
2.13.6
