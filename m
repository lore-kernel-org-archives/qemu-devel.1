Received: from eggs.gnu.org ([2001:4830:134:3::10]:44373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fVcWG-0003Vs-8l
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fVcWF-0006Bb-F4
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:47:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38390 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fVcWF-0006BP-9g
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:47:27 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 20 Jun 2018 14:47:18 +0200
Message-Id: <20180620124719.16450-7-kraxel@redhat.com>
In-Reply-To: <20180620124719.16450-1-kraxel@redhat.com>
References: <20180620124719.16450-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 6/7] bochs-display: enable vgabios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seabios@seabios.org, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Add vgabios binary to pci rom bar.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
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
