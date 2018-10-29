Received: from eggs.gnu.org ([2001:4830:134:3::10]:51252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gHDkX-00039i-Io
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 16:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gHDkU-0005xl-OA
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 16:02:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gHDkU-0005xQ-Hx
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 16:02:54 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 Oct 2018 21:02:48 +0100
Message-Id: <20181029200250.24029-2-kraxel@redhat.com>
In-Reply-To: <20181029200250.24029-1-kraxel@redhat.com>
References: <20181029200250.24029-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] usb: ohci: make num_ports to an unsinged
 integer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Li Qiang <liq3ea@gmail.com>

From: Li Qiang <liq3ea@gmail.com>

This can avoid setting OCHIState.num_ports to a negative num.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Message-id: 1540263618-18344-1-git-send-email-liq3ea@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-ohci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 66656a1133..c34cf5b73a 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -57,7 +57,7 @@ typedef struct {
     qemu_irq irq;
     MemoryRegion mem;
     AddressSpace *as;
-    int num_ports;
+    uint32_t num_ports;
     const char *name;
 
     QEMUTimer *eof_timer;
@@ -1850,7 +1850,7 @@ static USBBusOps ohci_bus_ops = {
 };
 
 static void usb_ohci_init(OHCIState *ohci, DeviceState *dev,
-                          int num_ports, dma_addr_t localmem_base,
+                          uint32_t num_ports, dma_addr_t localmem_base,
                           char *masterbus, uint32_t firstport,
                           AddressSpace *as, Error **errp)
 {
@@ -1860,7 +1860,7 @@ static void usb_ohci_init(OHCIState *ohci, DeviceState *dev,
     ohci->as = as;
 
     if (num_ports > OHCI_MAX_PORTS) {
-        error_setg(errp, "OHCI num-ports=%d is too big (limit is %d ports)",
+        error_setg(errp, "OHCI num-ports=%u is too big (limit is %u ports)",
                    num_ports, OHCI_MAX_PORTS);
         return;
     }
-- 
2.9.3
