Received: from eggs.gnu.org ([2001:4830:134:3::10]:55188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e1vjD-0004j6-MB
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e1vjA-0002Vx-FV
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:41:51 -0400
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Tue, 10 Oct 2017 11:24:18 +0100
Message-ID: <20171010102418.13487-1-anthony.perard@citrix.com>
In-Reply-To: <20171009150231.GN2954@redhat.com>
References: <20171009150231.GN2954@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] ui/gtk: Fix deprecation of
 vte_terminal_copy_clipboard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, Gerd Hoffmann <kraxel@redhat.com>

vte_terminal_copy_clipboard() is deprecated in VTE 0.50.

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 ui/gtk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index 5bd87c265a..342e96fbe9 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1702,7 +1702,12 @@ static void gd_menu_copy(GtkMenuItem *item, void *opaque)
     GtkDisplayState *s = opaque;
     VirtualConsole *vc = gd_vc_find_current(s);
 
+#if VTE_CHECK_VERSION(0, 50, 0)
+    vte_terminal_copy_clipboard_format(VTE_TERMINAL(vc->vte.terminal),
+                                       VTE_FORMAT_TEXT);
+#else
     vte_terminal_copy_clipboard(VTE_TERMINAL(vc->vte.terminal));
+#endif
 }
 
 static void gd_vc_adjustment_changed(GtkAdjustment *adjustment, void *opaque)
-- 
Anthony PERARD
