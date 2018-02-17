Received: from eggs.gnu.org ([2001:4830:134:3::10]:53001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1en0dt-0001kB-TA
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 06:26:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1en0dq-0001VW-P0
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 06:26:57 -0500
Received: from mout.web.de ([217.72.192.78]:49739)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1en0dq-0001Ub-FK
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 06:26:54 -0500
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <902aaef8-d20e-0530-dea2-cdfe3db33ff3@web.de>
Date: Sat, 17 Feb 2018 12:26:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] ui: Reorder vte terminal packing to avoid gtk3
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Fill the terminal box from right to left to avoid

Gtk-WARNING **: Allocating size to GtkScrollbar 0x55f6d54b0200 without
    calling gtk_widget_get_preferred_width/height(). How does the code
    know the size to allocate?

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ui/gtk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 1537751afa..81f729316b 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1945,8 +1945,8 @@ static GSList *gd_vc_vte_init(GtkDisplayState *s, VirtualConsole *vc,
     scrollbar = gtk_vscrollbar_new(vadjustment);
 #endif
 
-    gtk_box_pack_start(GTK_BOX(box), vc->vte.terminal, TRUE, TRUE, 0);
-    gtk_box_pack_start(GTK_BOX(box), scrollbar, FALSE, FALSE, 0);
+    gtk_box_pack_end(GTK_BOX(box), scrollbar, FALSE, FALSE, 0);
+    gtk_box_pack_end(GTK_BOX(box), vc->vte.terminal, TRUE, TRUE, 0);
 
     vc->vte.box = box;
     vc->vte.scrollbar = scrollbar;
-- 
2.13.6
