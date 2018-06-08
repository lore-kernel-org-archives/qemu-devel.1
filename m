Received: from eggs.gnu.org ([2001:4830:134:3::10]:47821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUF-0002Rd-9E
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUE-0001aH-5I
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58038 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fRLUD-0001Zy-WB
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:42 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Jun 2018 13:47:19 -0400
Message-Id: <20180608174733.4936-17-jsnow@redhat.com>
In-Reply-To: <20180608174733.4936-1-jsnow@redhat.com>
References: <20180608174733.4936-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/30] ahci: fix spacing damage on ahci_mem_write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180531222835.16558-14-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index b31eb84aaa..51c3e96c80 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -469,37 +469,36 @@ static void ahci_mem_write(void *opaque, hwaddr add=
r,
=20
     if (addr < AHCI_GENERIC_HOST_CONTROL_REGS_MAX_ADDR) {
         switch (addr) {
-            case HOST_CAP: /* R/WO, RO */
-                /* FIXME handle R/WO */
-                break;
-            case HOST_CTL: /* R/W */
-                if (val & HOST_CTL_RESET) {
-                    ahci_reset(s);
-                } else {
-                    s->control_regs.ghc =3D (val & 0x3) | HOST_CTL_AHCI_=
EN;
-                    ahci_check_irq(s);
-                }
-                break;
-            case HOST_IRQ_STAT: /* R/WC, RO */
-                s->control_regs.irqstatus &=3D ~val;
+        case HOST_CAP: /* R/WO, RO */
+            /* FIXME handle R/WO */
+            break;
+        case HOST_CTL: /* R/W */
+            if (val & HOST_CTL_RESET) {
+                ahci_reset(s);
+            } else {
+                s->control_regs.ghc =3D (val & 0x3) | HOST_CTL_AHCI_EN;
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
+            s->control_regs.irqstatus &=3D ~val;
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
     } else if ((addr >=3D AHCI_PORT_REGS_START_ADDR) &&
                (addr < (AHCI_PORT_REGS_START_ADDR +
-                (s->ports * AHCI_PORT_ADDR_OFFSET_LEN)))) {
+                        (s->ports * AHCI_PORT_ADDR_OFFSET_LEN)))) {
         ahci_port_write(s, (addr - AHCI_PORT_REGS_START_ADDR) >> 7,
                         addr & AHCI_PORT_ADDR_OFFSET_MASK, val);
     }
-
 }
=20
 static const MemoryRegionOps ahci_mem_ops =3D {
--=20
2.14.3
