Received: from eggs.gnu.org ([2001:4830:134:3::10]:42804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dB1BT-0000B4-Oa
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dB1BP-0000n7-NI
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:48:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dB1BP-0000ms-Hi
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:48:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D7B17F6B3
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 15:48:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 17 May 2017 17:47:52 +0200
Message-Id: <20170517154756.22079-6-quintela@redhat.com>
In-Reply-To: <20170517154756.22079-1-quintela@redhat.com>
References: <20170517154756.22079-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 5/9] migration: Move qjson.h to migration/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

It is only used for migration code.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/qjson.c                        | 2 +-
 {include/migration => migration}/qjson.h | 0
 migration/vmstate.c                      | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename {include/migration => migration}/qjson.h (100%)

diff --git a/migration/qjson.c b/migration/qjson.c
index f345904..9d7f6eb 100644
--- a/migration/qjson.c
+++ b/migration/qjson.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/qmp/qstring.h"
-#include "migration/qjson.h"
+#include "qjson.h"
 
 struct QJSON {
     QString *str;
diff --git a/include/migration/qjson.h b/migration/qjson.h
similarity index 100%
rename from include/migration/qjson.h
rename to migration/qjson.h
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 7b4a607..66c50ee 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -7,7 +7,7 @@
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
 #include "trace.h"
-#include "migration/qjson.h"
+#include "qjson.h"
 
 static void vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
                                     void *opaque, QJSON *vmdesc);
-- 
2.9.3
