Received: from eggs.gnu.org ([2001:4830:134:3::10]:58580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7g0I-0007RB-7M
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 08:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7g0F-0002Ti-Ip
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 08:11:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g7g0F-0002TE-Cf
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 08:11:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91F693002958
	for <qemu-devel@nongnu.org>; Wed,  3 Oct 2018 12:11:42 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  3 Oct 2018 14:11:38 +0200
Message-Id: <20181003121138.22037-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] gtk: fix uninitialized variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

zoom_to_fit is never initialized to false, Coverity complains
(not sure why GCC does not).

Fixes: e8b1386ea1719525a1a92df03377764703fe8c64
Cc: kraxel@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
2.17.1
