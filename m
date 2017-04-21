Received: from eggs.gnu.org ([2001:4830:134:3::10]:54240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Xez-0002Q1-Cp
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Xew-0000mO-Ap
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d1Xew-0000m6-4M
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 218D08AE6E
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 12:27:33 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Fri, 21 Apr 2017 20:27:06 +0800
Message-Id: <20170421122710.15373-11-famz@redhat.com>
In-Reply-To: <20170421122710.15373-1-famz@redhat.com>
References: <20170421122710.15373-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 10/14] fdc: Make errp the last parameter of
 fdctrl_connect_drives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/block/fdc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index a328693..2e629b3 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2521,8 +2521,8 @@ static void fdctrl_result_timer(void *opaque)
 }
 
 /* Init functions */
-static void fdctrl_connect_drives(FDCtrl *fdctrl, Error **errp,
-                                  DeviceState *fdc_dev)
+static void fdctrl_connect_drives(FDCtrl *fdctrl, DeviceState *fdc_dev,
+                                  Error **errp)
 {
     unsigned int i;
     FDrive *drive;
@@ -2675,7 +2675,7 @@ static void fdctrl_realize_common(DeviceState *dev, FDCtrl *fdctrl,
     }
 
     floppy_bus_create(fdctrl, &fdctrl->bus, dev);
-    fdctrl_connect_drives(fdctrl, errp, dev);
+    fdctrl_connect_drives(fdctrl, dev, errp);
 }
 
 static const MemoryRegionPortio fdc_portio_list[] = {
-- 
2.9.3
