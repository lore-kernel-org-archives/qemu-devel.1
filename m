Received: from eggs.gnu.org ([2001:4830:134:3::10]:40164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g7wIO-0003Ml-8S
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 01:35:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g7wIG-0001ML-MQ
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 01:35:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g7wI7-0001Br-IE
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 01:35:18 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 140893082E24
	for <qemu-devel@nongnu.org>; Thu,  4 Oct 2018 05:35:12 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 Oct 2018 07:35:07 +0200
Message-Id: <20181004053507.19883-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] gtk: initialize zoom_to_fit
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

Fixes: CID 1395988
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 3ddb5fe162..ec935fff90 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2136,7 +2136,7 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
                               QemuConsole *con, int idx,
                               GSList *group, GtkWidget *view_menu)
 {
-    bool zoom_to_fit;
+    bool zoom_to_fit = false;
 
     vc->label = qemu_console_get_label(con);
     vc->s = s;
-- 
2.9.3
