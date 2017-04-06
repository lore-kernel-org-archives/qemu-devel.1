Received: from eggs.gnu.org ([2001:4830:134:3::10]:51838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7EF-0000wt-Cq
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7ED-0001ZW-K6
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:13:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cw7ED-0001Z8-EZ
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:13:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 994AA8E678
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 13:13:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  6 Apr 2017 15:13:23 +0200
Message-Id: <20170406131326.2418-3-quintela@redhat.com>
In-Reply-To: <20170406131326.2418-1-quintela@redhat.com>
References: <20170406131326.2418-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] qdev: Export qdev_hot_removed
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

I need to move qdev_unplug to qdev-monitor in the following patch, and
it needs access to this variable.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/core/qdev.c         | 2 +-
 include/hw/qdev-core.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 6fa46b5..c26cf84 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -41,7 +41,7 @@
 
 bool qdev_hotplug = false;
 static bool qdev_hot_added = false;
-static bool qdev_hot_removed = false;
+bool qdev_hot_removed = false;
 
 const VMStateDescription *qdev_get_vmsd(DeviceState *dev)
 {
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index a96a913..f09b6b7 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -387,6 +387,7 @@ Object *qdev_get_machine(void);
 void qdev_set_parent_bus(DeviceState *dev, BusState *bus);
 
 extern bool qdev_hotplug;
+extern bool qdev_hot_removed;
 
 char *qdev_get_dev_path(DeviceState *dev);
 
-- 
2.9.3
