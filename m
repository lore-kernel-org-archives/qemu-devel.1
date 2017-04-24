Received: from eggs.gnu.org ([2001:4830:134:3::10]:53629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d2YOs-0003zV-1A
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d2YOp-0006xH-Iy
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d2YOp-0006wg-DE
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5ED7CC059742
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 07:27:06 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 24 Apr 2017 09:26:56 +0200
Message-Id: <1493018820-23445-12-git-send-email-armbru@redhat.com>
In-Reply-To: <1493018820-23445-1-git-send-email-armbru@redhat.com>
References: <1493018820-23445-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 11/15] fdc: Make errp the last parameter of
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
Cc: Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170421122710.15373-11-famz@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
2.7.4
