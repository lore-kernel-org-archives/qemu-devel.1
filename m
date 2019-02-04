Received: from eggs.gnu.org ([209.51.188.92]:35356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1gqdAF-0001Lb-DJ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 07:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1gqdAE-0008VK-Nn
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 07:15:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1gqdAE-0008RY-Bl
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 07:15:50 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E9688E5AE
	for <qemu-devel@nongnu.org>; Mon,  4 Feb 2019 12:08:47 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
Date: Mon,  4 Feb 2019 13:08:23 +0100
Message-Id: <20190204120823.41333-1-slp@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] ui: listen for GDK_SMOOTH_SCROLL events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, Sergio Lopez <slp@redhat.com>

On Wayland, without grabbing focus, two-finger scrolling generates
GDK_SMOOTH_SCROLL events instead of GDK_SCROLL_*, so listen for them.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 ui/gtk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index 87c0e33d2a..77bd19025d 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2043,6 +2043,7 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, V=
irtualConsole *vc,
                           GDK_ENTER_NOTIFY_MASK |
                           GDK_LEAVE_NOTIFY_MASK |
                           GDK_SCROLL_MASK |
+                          GDK_SMOOTH_SCROLL_MASK |
                           GDK_KEY_PRESS_MASK);
     gtk_widget_set_can_focus(vc->gfx.drawing_area, TRUE);
=20
--=20
2.20.1
