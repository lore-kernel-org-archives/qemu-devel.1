Received: from eggs.gnu.org ([2001:4830:134:3::10]:58014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fRFRC-0007ws-EJ
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 07:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fRFRB-0001iB-JZ
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 07:20:10 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  8 Jun 2018 13:20:01 +0200
Message-Id: <20180608112001.14729-7-kraxel@redhat.com>
In-Reply-To: <20180608112001.14729-1-kraxel@redhat.com>
References: <20180608112001.14729-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v3 6/6] bochs-display: enable vgabios
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
 hw/display/bochs-display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index 1187d77576..12d8a66c6c 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -337,6 +337,7 @@ static void bochs_display_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_QEMU_VGA;
 
     k->realize   = bochs_display_realize;
+    k->romfile   = "vgabios-bochs-display.bin";
     k->exit      = bochs_display_exit;
     dc->vmsd     = &vmstate_bochs_display;
     dc->props    = bochs_display_properties;
-- 
2.9.3
