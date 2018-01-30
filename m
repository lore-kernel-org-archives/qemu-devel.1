Received: from eggs.gnu.org ([2001:4830:134:3::10]:59426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egT3L-000477-IV
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egT3H-0000Zz-GT
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egT3H-0000Z7-Af
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D7F672664
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 10:22:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 49D8C6A03A
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 10:22:06 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 30 Jan 2018 11:21:58 +0100
Message-Id: <20180130102202.28519-15-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-1-armbru@redhat.com>
References: <20180130102202.28519-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 14/18] Include qapi/qmp/qnum.h exactly where
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
 
 static QLitObject qlit = QLIT_QDICT(((QLitDictEntry[]) {
-- 
2.13.6
