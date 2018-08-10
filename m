Received: from eggs.gnu.org ([2001:4830:134:3::10]:56807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fo7Nf-0005Th-1d
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fo7Nb-0008R8-P2
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:23:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43086 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fo7Nb-0008Qn-Jo
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:22:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2F8A581663D5
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 13:22:59 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 10 Aug 2018 15:22:36 +0200
Message-Id: <20180810132236.25908-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] qxl: drop unused generation variable
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/qxl.h | 1 -
 hw/display/qxl.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/display/qxl.h b/hw/display/qxl.h
index 089696ef62..6eacba080d 100644
--- a/hw/display/qxl.h
+++ b/hw/display/qxl.h
@@ -43,7 +43,6 @@ typedef struct PCIQXLDevice {
 
     enum qxl_mode      mode;
     uint32_t           cmdflags;
-    int                generation;
     uint32_t           revision;
 
     int32_t            num_memslots;
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 830c392c53..8e9135d9c6 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2057,7 +2057,6 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
 
     qemu_spice_display_init_common(&qxl->ssd);
     qxl->mode = QXL_MODE_UNDEFINED;
-    qxl->generation = 1;
     qxl->num_memslots = NUM_MEMSLOTS;
     qemu_mutex_init(&qxl->track_lock);
     qemu_mutex_init(&qxl->async_lock);
-- 
2.9.3
