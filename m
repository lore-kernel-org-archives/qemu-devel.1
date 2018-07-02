Received: from eggs.gnu.org ([2001:4830:134:3::10]:59208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa0yD-0004bM-AY
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa0yC-0006Gc-IU
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:42:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fa0yC-0006Fz-Ct
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:42:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A066A307D86D
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 15:42:27 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  2 Jul 2018 17:42:21 +0200
Message-Id: <20180702154222.3130-7-kraxel@redhat.com>
In-Reply-To: <20180702154222.3130-1-kraxel@redhat.com>
References: <20180702154222.3130-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 6/7] bochs-display: enable vgabios
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
