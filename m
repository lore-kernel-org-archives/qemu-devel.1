Received: from eggs.gnu.org ([2001:4830:134:3::10]:34533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOW3z-0000rs-Ak
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOW3y-0004FL-DW
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:28:55 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 31 May 2018 18:28:32 -0400
Message-Id: <20180531222835.16558-14-jsnow@redhat.com>
In-Reply-To: <20180531222835.16558-1-jsnow@redhat.com>
References: <20180531222835.16558-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 13/16] ahci: fix spacing damage on
 ahci_mem_write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: f4bug@amsat.org, John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 5e902c6615..568e6b848a 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -469,37 +469,36 @@ static void ahci_mem_write(void *opaque, hwaddr addr,
 
     if (addr < AHCI_GENERIC_HOST_CONTROL_REGS_MAX_ADDR) {
         switch (addr) {
-            case HOST_CAP: /* R/WO, RO */
-                /* FIXME handle R/WO */
-                break;
-            case HOST_CTL: /* R/W */
-                if (val & HOST_CTL_RESET) {
-                    ahci_reset(s);
-                } else {
-                    s->control_regs.ghc = (val & 0x3) | HOST_CTL_AHCI_EN;
-                    ahci_check_irq(s);
-                }
-                break;
-            case HOST_IRQ_STAT: /* R/WC, RO */
-                s->control_regs.irqstatus &= ~val;
+        case HOST_CAP: /* R/WO, RO */
+            /* FIXME handle R/WO */
+            break;
+        case HOST_CTL: /* R/W */
+            if (val & HOST_CTL_RESET) {
+                ahci_reset(s);
+            } else {
+                s->control_regs.ghc = (val & 0x3) | HOST_CTL_AHCI_EN;
                 ahci_check_irq(s);
-                break;
-            case HOST_PORTS_IMPL: /* R/WO, RO */
-                /* FIXME handle R/WO */
-                break;
-            case HOST_VERSION: /* RO */
-                /* FIXME report write? */
-                break;
-            default:
-                trace_ahci_mem_write_unknown(s, size, addr, val);
+            }
+            break;
+        case HOST_IRQ_STAT: /* R/WC, RO */
+            s->control_regs.irqstatus &= ~val;
+            ahci_check_irq(s);
+            break;
+        case HOST_PORTS_IMPL: /* R/WO, RO */
+            /* FIXME handle R/WO */
+            break;
+        case HOST_VERSION: /* RO */
+            /* FIXME report write? */
+            break;
+        default:
+            trace_ahci_mem_write_unknown(s, size, addr, val);
         }
     } else if ((addr >= AHCI_PORT_REGS_START_ADDR) &&
                (addr < (AHCI_PORT_REGS_START_ADDR +
-                (s->ports * AHCI_PORT_ADDR_OFFSET_LEN)))) {
+                        (s->ports * AHCI_PORT_ADDR_OFFSET_LEN)))) {
         ahci_port_write(s, (addr - AHCI_PORT_REGS_START_ADDR) >> 7,
                         addr & AHCI_PORT_ADDR_OFFSET_MASK, val);
     }
-
 }
 
 static const MemoryRegionOps ahci_mem_ops = {
-- 
2.14.3
