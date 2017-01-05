Received: from eggs.gnu.org ([2001:4830:134:3::10]:43742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1cPHGG-0002Ao-H6
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 18:15:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1cPHGF-0007b6-Kw
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 18:15:56 -0500
Received: from smtp7.web4u.cz ([81.91.87.87]:57190 helo=mx-8.mail.web4u.cz)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pisa@cmp.felk.cvut.cz>)
	id 1cPHGF-0007av-Dg
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 18:15:55 -0500
From: pisa@cmp.felk.cvut.cz
Date: Fri,  6 Jan 2017 00:11:27 +0100
Message-Id: <39c4f076e685ca79703213a6ee36e11a922e6af6.1483655894.git.pisa@cmp.felk.cvut.cz>
In-Reply-To: <cover.1483655893.git.pisa@cmp.felk.cvut.cz>
References: <cover.1483655893.git.pisa@cmp.felk.cvut.cz>
In-Reply-To: <cover.1483655893.git.pisa@cmp.felk.cvut.cz>
References: <cover.1483655893.git.pisa@cmp.felk.cvut.cz>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Konrad Frederic <fred.konrad@greensocs.com>, Deniz Eren <deniz.eren@icloud.com>, Oliver Hartkopp <socketcan@hartkopp.net>

From: Deniz Eren <deniz.eren@icloud.com>

---
 hw/can/can_pcm3680_pci.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/can/can_pcm3680_pci.c b/hw/can/can_pcm3680_pci.c
index 9d8d3f7..1134960 100644
--- a/hw/can/can_pcm3680_pci.c
+++ b/hw/can/can_pcm3680_pci.c
@@ -249,8 +249,7 @@ static void pcm3680i_pci_exit(PCIDevice *pci_dev)
     qemu_unregister_reset(pcm3680i_pci_reset, d);
 
     /*
-     * regions d->s5920_io, d->sja_io and d->xilinx_io
-     * are destroyed by QOM now
+     * region d->sja_io is destroyed by QOM now
      */
     /* memory_region_destroy(&d->sja_io[0]); */
     /* memory_region_destroy(&d->sja_io[1]); */
@@ -300,8 +299,8 @@ static void pcm3680i_pci_class_init(ObjectClass *klass, void *data)
     k->device_id = PCM3680i_PCI_DEVICE_ID1;
     k->revision = 0x00;
     k->class_id = 0x000c09;
-    k->subsystem_vendor_id = 0x13fe;
-    k->subsystem_id = 0xc002;
+    k->subsystem_vendor_id = PCM3680i_PCI_VENDOR_ID1;
+    k->subsystem_id = PCM3680i_PCI_DEVICE_ID1;
 //  k->is_bridge = 0;
 //  k->is_express = 0;
     dc->desc = "Pcm3680i PCICANx";
-- 
1.9.1
