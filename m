Received: from eggs.gnu.org ([2001:4830:134:3::10]:53752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g8QQw-0003L9-9x
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g8QQo-0007nF-GN
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:46:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g8QQn-0007m7-OV
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:46:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0103A81103
	for <qemu-devel@nongnu.org>; Fri,  5 Oct 2018 13:46:12 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  5 Oct 2018 15:46:08 +0200
Message-Id: <20181005134608.1251-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] qxl: check qxl_phys2virt return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Fixes: CID 1395986
Fixes: 979f7ef8966bc4495a710ed9e4af42098f92ee79
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/qxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 747986478f..bbf14fb42f 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -290,7 +290,7 @@ static void qxl_spice_monitors_config_async(PCIQXLDevice *qxl, int replay)
     }
 
     cfg = qxl_phys2virt(qxl, qxl->guest_monitors_config, MEMSLOT_GROUP_GUEST);
-    if (cfg->count == 1) {
+    if (cfg != NULL && cfg->count == 1) {
         qxl->guest_primary.resized = 1;
         qxl->guest_head0_width  = cfg->heads[0].width;
         qxl->guest_head0_height = cfg->heads[0].height;
-- 
2.9.3
