Received: from eggs.gnu.org ([2001:4830:134:3::10]:45943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XD1-0003Qo-FC
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XD0-0007sT-IT
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d1XD0-0007s2-CH
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 431B1DB009
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 11:58:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 21 Apr 2017 13:56:36 +0200
Message-Id: <20170421115646.15544-56-quintela@redhat.com>
In-Reply-To: <20170421115646.15544-1-quintela@redhat.com>
References: <20170421115646.15544-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 55/65] qdev: qdev_hotplug is really a bool
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
Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
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
=20
-int qdev_hotplug =3D 0;
+bool qdev_hotplug =3D false;
 static bool qdev_hot_added =3D false;
 static bool qdev_hot_removed =3D false;
=20
@@ -385,7 +385,7 @@ void qdev_machine_creation_done(void)
      * ok, initial machine setup is done, starting from now we can
      * only create hotpluggable devices
      */
-    qdev_hotplug =3D 1;
+    qdev_hotplug =3D true;
 }
=20
 bool qdev_machine_modified(void)
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index b44b476..a96a913 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -386,7 +386,7 @@ Object *qdev_get_machine(void);
 /* FIXME: make this a link<> */
 void qdev_set_parent_bus(DeviceState *dev, BusState *bus);
=20
-extern int qdev_hotplug;
+extern bool qdev_hotplug;
=20
 char *qdev_get_dev_path(DeviceState *dev);
=20
--=20
2.9.3
