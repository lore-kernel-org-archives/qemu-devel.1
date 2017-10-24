Received: from eggs.gnu.org ([2001:4830:134:3::10]:53174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1e78eU-0005oA-C2
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 19:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1e78eT-0000Wh-CP
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 19:30:30 -0400
Received: from smtp8.web4u.cz ([81.91.87.88]:42740 helo=mx-8.mail.web4u.cz)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pisa@cmp.felk.cvut.cz>)
	id 1e78eT-0000Vn-5K
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 19:30:29 -0400
From: pisa@cmp.felk.cvut.cz
Date: Wed, 25 Oct 2017 01:29:45 +0200
Message-Id: <2edc282892a5572f90cc0c839eac5608da670cf3.1508885974.git.pisa@cmp.felk.cvut.cz>
In-Reply-To: <7df70170550e3a10152a3571012f507dd035ba7c.1508885974.git.pisa@cmp.felk.cvut.cz>
References: <7df70170550e3a10152a3571012f507dd035ba7c.1508885974.git.pisa@cmp.felk.cvut.cz>
In-Reply-To: <cover.1508885974.git.pisa@cmp.felk.cvut.cz>
References: <cover.1508885974.git.pisa@cmp.felk.cvut.cz>
Subject: [Qemu-devel] [PATCH 5/6] Minor clean-up of can_pcm3680_pci.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Konrad Frederic <fred.konrad@greensocs.com>, Deniz Eren <deniz.eren@icloud.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marek Vasut <marex@denx.de>, Jan Kiszka <jan.kiszka@siemens.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>

From: Deniz Eren <deniz.eren@icloud.com>

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
---
 hw/can/can_pcm3680_pci.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/can/can_pcm3680_pci.c b/hw/can/can_pcm3680_pci.c
index bc6b164ea7..692aab6ab8 100644
--- a/hw/can/can_pcm3680_pci.c
+++ b/hw/can/can_pcm3680_pci.c
@@ -255,8 +255,7 @@ static void pcm3680i_pci_exit(PCIDevice *pci_dev)
     qemu_unregister_reset(pcm3680i_pci_reset, d);
 
     /*
-     * regions d->s5920_io, d->sja_io and d->xilinx_io
-     * are destroyed by QOM now
+     * region d->sja_io is destroyed by QOM now
      */
     /* memory_region_destroy(&d->sja_io[0]); */
     /* memory_region_destroy(&d->sja_io[1]); */
@@ -308,8 +307,8 @@ static void pcm3680i_pci_class_init(ObjectClass *klass, void *data)
     k->device_id = PCM3680i_PCI_DEVICE_ID1;
     k->revision = 0x00;
     k->class_id = 0x000c09;
-    k->subsystem_vendor_id = 0x13fe;
-    k->subsystem_id = 0xc002;
+    k->subsystem_vendor_id = PCM3680i_PCI_VENDOR_ID1;
+    k->subsystem_id = PCM3680i_PCI_DEVICE_ID1;
     dc->desc = "Pcm3680i PCICANx";
     dc->props = pcm3680i_pci_properties;
     dc->vmsd = &vmstate_pcm3680i_pci;
-- 
2.11.0
