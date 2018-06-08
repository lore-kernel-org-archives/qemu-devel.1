Received: from eggs.gnu.org ([2001:4830:134:3::10]:58019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fRFRC-0007xC-NY
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 07:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fRFRB-0001iX-KG
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 07:20:10 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  8 Jun 2018 13:20:00 +0200
Message-Id: <20180608112001.14729-6-kraxel@redhat.com>
In-Reply-To: <20180608112001.14729-1-kraxel@redhat.com>
References: <20180608112001.14729-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v3 5/6] ramfb: enable vgabios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?L=C3=A1szl=C3=B3=20=C3=89rsek?= <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

---
 hw/display/ramfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 258783fe3b..477316a14d 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -88,6 +88,7 @@ RAMFBState *ramfb_setup(Error **errp)
 
     s = g_new0(RAMFBState, 1);
 
+    rom_add_vga("vgabios-ramfb.bin");
     fw_cfg_add_file_callback(fw_cfg, "etc/ramfb",
                              NULL, ramfb_fw_cfg_write, s,
                              &s->cfg, sizeof(s->cfg), false);
-- 
2.9.3
