Received: from eggs.gnu.org ([2001:4830:134:3::10]:47874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo8Gk-0005HH-5c
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo8Gj-00073I-73
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:42 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33828 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eo8Gj-00072o-0P
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:41 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 20 Feb 2018 14:47:23 +0100
Message-Id: <20180220134723.11776-13-kraxel@redhat.com>
In-Reply-To: <20180220134723.11776-1-kraxel@redhat.com>
References: <20180220134723.11776-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 12/12] ui: Reorder vte terminal packing to avoid
 gtk3 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

Fill the terminal box from right to left to avoid

Gtk-WARNING **: Allocating size to GtkScrollbar 0x55f6d54b0200 without
    calling gtk_widget_get_preferred_width/height(). How does the code
    know the size to allocate?

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Message-id: 902aaef8-d20e-0530-dea2-cdfe3db33ff3@web.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index ad4910c70d..ab646b70e1 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1952,8 +1952,8 @@ static GSList *gd_vc_vte_init(GtkDisplayState *s, VirtualConsole *vc,
     scrollbar = gtk_vscrollbar_new(vadjustment);
 #endif
 
-    gtk_box_pack_start(GTK_BOX(box), vc->vte.terminal, TRUE, TRUE, 0);
-    gtk_box_pack_start(GTK_BOX(box), scrollbar, FALSE, FALSE, 0);
+    gtk_box_pack_end(GTK_BOX(box), scrollbar, FALSE, FALSE, 0);
+    gtk_box_pack_end(GTK_BOX(box), vc->vte.terminal, TRUE, TRUE, 0);
 
     vc->vte.box = box;
     vc->vte.scrollbar = scrollbar;
-- 
2.9.3
