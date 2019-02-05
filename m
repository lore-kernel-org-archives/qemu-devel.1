Received: from eggs.gnu.org ([209.51.188.92]:42556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqyQq-0007N7-Ps
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqyQm-0006Fk-V4
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35989)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gqyQd-00068Q-Uf
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:12 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  5 Feb 2019 11:57:47 +0100
Message-Id: <20190205105758.4230-4-kraxel@redhat.com>
In-Reply-To: <20190205105758.4230-1-kraxel@redhat.com>
References: <20190205105758.4230-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 03/14] ui: listen for GDK_SMOOTH_SCROLL events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Sergio Lopez <slp@redhat.com>

From: Sergio Lopez <slp@redhat.com>

On Wayland, without grabbing focus, two-finger scrolling generates
GDK_SMOOTH_SCROLL events instead of GDK_SCROLL_*, so listen for them.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Message-id: 20190204120823.41333-1-slp@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index 5a584353bd..57af69b0c4 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2045,6 +2045,7 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
                           GDK_ENTER_NOTIFY_MASK |
                           GDK_LEAVE_NOTIFY_MASK |
                           GDK_SCROLL_MASK |
+                          GDK_SMOOTH_SCROLL_MASK |
                           GDK_KEY_PRESS_MASK);
     gtk_widget_set_can_focus(vc->gfx.drawing_area, TRUE);
 
-- 
2.9.3
