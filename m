Received: from eggs.gnu.org ([2001:4830:134:3::10]:51839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7EF-0000ws-Cm
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7EB-0001Yl-Ct
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:13:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cw7EB-0001YV-7O
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:13:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F6EA7D0C1
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 13:13:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  6 Apr 2017 15:13:22 +0200
Message-Id: <20170406131326.2418-2-quintela@redhat.com>
In-Reply-To: <20170406131326.2418-1-quintela@redhat.com>
References: <20170406131326.2418-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] qdev: qdev_hotplug is really a bool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/core/qdev.c         | 4 ++--
 include/hw/qdev-core.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 1e7fb33..6fa46b5 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -39,7 +39,7 @@
 #include "qapi-event.h"
 #include "migration/migration.h"
 
-int qdev_hotplug = 0;
+bool qdev_hotplug = false;
 static bool qdev_hot_added = false;
 static bool qdev_hot_removed = false;
 
@@ -385,7 +385,7 @@ void qdev_machine_creation_done(void)
      * ok, initial machine setup is done, starting from now we can
      * only create hotpluggable devices
      */
-    qdev_hotplug = 1;
+    qdev_hotplug = true;
 }
 
 bool qdev_machine_modified(void)
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index b44b476..a96a913 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -386,7 +386,7 @@ Object *qdev_get_machine(void);
 /* FIXME: make this a link<> */
 void qdev_set_parent_bus(DeviceState *dev, BusState *bus);
 
-extern int qdev_hotplug;
+extern bool qdev_hotplug;
 
 char *qdev_get_dev_path(DeviceState *dev);
 
-- 
2.9.3
