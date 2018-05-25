Received: from eggs.gnu.org ([2001:4830:134:3::10]:52540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fMMYN-0006PP-Lh
	for qemu-devel@nongnu.org; Fri, 25 May 2018 19:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fMMYL-00082U-H9
	for qemu-devel@nongnu.org; Fri, 25 May 2018 19:55:23 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 25 May 2018 19:55:06 -0400
Message-Id: <20180525235509.11282-14-jsnow@redhat.com>
In-Reply-To: <20180525235509.11282-1-jsnow@redhat.com>
References: <20180525235509.11282-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 13/16] ahci: fix spacing damage on
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
Cc: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index ea68950952..9225c4559f 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -465,37 +465,36 @@ static void ahci_mem_write(void *opaque, hwaddr addr,
 
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
