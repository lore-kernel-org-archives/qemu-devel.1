Received: from eggs.gnu.org ([2001:4830:134:3::10]:56406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPp-00059K-R1
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPn-0007LB-7n
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjPm-0007J4-Sb
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:39 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:27 +0300
Message-Id: <1533815202-11967-15-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 14/29] vmsvga: Setup interrupt pin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, habkost@redhat.com, kraxel@redhat.com, Leonid Shatz <leonid.shatz@oracle.com>, Liran Alon <liran.alon@oracle.com>

From: Leonid Shatz <leonid.shatz@oracle.com>

This is necessary in order for device to raise interrupts.
Future patches will add functionality to device which will
need this ability.

Signed-off-by: Leonid Shatz <leonid.shatz@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 91f990544e14..eae3f1455445 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1447,6 +1447,7 @@ static void pci_vmsvga_realize(PCIDevice *dev, Error **errp)
     dev->config[PCI_CACHE_LINE_SIZE] = 0x08;
     dev->config[PCI_LATENCY_TIMER] = 0x40;
     dev->config[PCI_INTERRUPT_LINE] = 0xff;          /* End */
+    dev->config[PCI_INTERRUPT_PIN] = 1;  /* interrupt pin A */
 
     memory_region_init_io(&s->io_bar, NULL, &vmsvga_io_ops, &s->chip,
                           "vmsvga-io", 0x10);
-- 
1.9.1
