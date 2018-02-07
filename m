Received: from eggs.gnu.org ([2001:4830:134:3::10]:59563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ejP1M-0001OX-I7
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:40:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ejP1K-0004jS-21
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:40:16 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50750 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ejP1J-0004iY-To
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:40:14 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 78FDC8A3DD
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 12:40:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 553F3AE7D0
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 12:40:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  7 Feb 2018 13:40:05 +0100
Message-Id: <20180207124009.12376-17-armbru@redhat.com>
In-Reply-To: <20180207124009.12376-1-armbru@redhat.com>
References: <20180207124009.12376-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/20] Include qapi/qmp/qnum.h exactly where
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

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180201111846.21846-16-armbru@redhat.com>
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
