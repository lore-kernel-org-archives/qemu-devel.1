Received: from eggs.gnu.org ([2001:4830:134:3::10]:51649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQoN9-0000mZ-QW
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 02:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQoN7-0002p4-V8
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 02:26:11 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  7 Jun 2018 08:25:44 +0200
Message-Id: <20180607062559.16127-5-armbru@redhat.com>
In-Reply-To: <20180607062559.16127-1-armbru@redhat.com>
References: <20180607062559.16127-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 04/19] fixup block: Add block-specific
 QDict header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, eblake@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/block/qdict.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/block/qdict.h b/include/block/qdict.h
index 825e096a72..71c037afba 100644
--- a/include/block/qdict.h
+++ b/include/block/qdict.h
@@ -1,7 +1,7 @@
 /*
  * Special QDict functions used by the block layer
  *
- * Copyright (c) 2018 Red Hat, Inc.
+ * Copyright (c) 2013-2018 Red Hat, Inc.
  *
  * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
@@ -11,9 +11,6 @@
 #define BLOCK_QDICT_H
 
 #include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qobject.h"
-#include "qapi/error.h"
-
 
 void qdict_copy_default(QDict *dst, QDict *src, const char *key);
 void qdict_set_default_str(QDict *dst, const char *key, const char *val);
-- 
2.17.1
