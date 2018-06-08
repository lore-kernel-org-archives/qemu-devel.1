Received: from eggs.gnu.org ([2001:4830:134:3::10]:47798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUF-0002RV-4X
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUB-0001XC-P1
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58022 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fRLUB-0001Wi-JR
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:39 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Jun 2018 13:47:10 -0400
Message-Id: <20180608174733.4936-8-jsnow@redhat.com>
In-Reply-To: <20180608174733.4936-1-jsnow@redhat.com>
References: <20180608174733.4936-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/30] ahci: fix spacing damage on
 ahci_port_write
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

Churn.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180531222835.16558-5-jsnow@redhat.com
[Fix patchew/checkpatch nit. --js]
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 142 +++++++++++++++++++++++++++++-----------------------=
------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 1107a9b118..a19f46c301 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -279,85 +279,85 @@ static int ahci_cond_start_engines(AHCIDevice *ad)
     return 0;
 }
=20
-static void  ahci_port_write(AHCIState *s, int port, int offset, uint32_=
t val)
+static void ahci_port_write(AHCIState *s, int port, int offset, uint32_t=
 val)
 {
     AHCIPortRegs *pr =3D &s->dev[port].port_regs;
=20
     trace_ahci_port_write(s, port, offset, val);
     switch (offset) {
-        case PORT_LST_ADDR:
-            pr->lst_addr =3D val;
-            break;
-        case PORT_LST_ADDR_HI:
-            pr->lst_addr_hi =3D val;
-            break;
-        case PORT_FIS_ADDR:
-            pr->fis_addr =3D val;
-            break;
-        case PORT_FIS_ADDR_HI:
-            pr->fis_addr_hi =3D val;
-            break;
-        case PORT_IRQ_STAT:
-            pr->irq_stat &=3D ~val;
-            ahci_check_irq(s);
-            break;
-        case PORT_IRQ_MASK:
-            pr->irq_mask =3D val & 0xfdc000ff;
-            ahci_check_irq(s);
-            break;
-        case PORT_CMD:
-            /* Block any Read-only fields from being set;
-             * including LIST_ON and FIS_ON.
-             * The spec requires to set ICC bits to zero after the ICC c=
hange
-             * is done. We don't support ICC state changes, therefore al=
ways
-             * force the ICC bits to zero.
-             */
-            pr->cmd =3D (pr->cmd & PORT_CMD_RO_MASK) |
-                      (val & ~(PORT_CMD_RO_MASK|PORT_CMD_ICC_MASK));
+    case PORT_LST_ADDR:
+        pr->lst_addr =3D val;
+        break;
+    case PORT_LST_ADDR_HI:
+        pr->lst_addr_hi =3D val;
+        break;
+    case PORT_FIS_ADDR:
+        pr->fis_addr =3D val;
+        break;
+    case PORT_FIS_ADDR_HI:
+        pr->fis_addr_hi =3D val;
+        break;
+    case PORT_IRQ_STAT:
+        pr->irq_stat &=3D ~val;
+        ahci_check_irq(s);
+        break;
+    case PORT_IRQ_MASK:
+        pr->irq_mask =3D val & 0xfdc000ff;
+        ahci_check_irq(s);
+        break;
+    case PORT_CMD:
+        /* Block any Read-only fields from being set;
+         * including LIST_ON and FIS_ON.
+         * The spec requires to set ICC bits to zero after the ICC chang=
e
+         * is done. We don't support ICC state changes, therefore always
+         * force the ICC bits to zero.
+         */
+        pr->cmd =3D (pr->cmd & PORT_CMD_RO_MASK) |
+            (val & ~(PORT_CMD_RO_MASK | PORT_CMD_ICC_MASK));
=20
-            /* Check FIS RX and CLB engines */
-            ahci_cond_start_engines(&s->dev[port]);
+        /* Check FIS RX and CLB engines */
+        ahci_cond_start_engines(&s->dev[port]);
=20
-            /* XXX usually the FIS would be pending on the bus here and
-                   issuing deferred until the OS enables FIS receival.
-                   Instead, we only submit it once - which works in most
-                   cases, but is a hack. */
-            if ((pr->cmd & PORT_CMD_FIS_ON) &&
-                !s->dev[port].init_d2h_sent) {
-                ahci_init_d2h(&s->dev[port]);
-            }
+        /* XXX usually the FIS would be pending on the bus here and
+           issuing deferred until the OS enables FIS receival.
+           Instead, we only submit it once - which works in most
+           cases, but is a hack. */
+        if ((pr->cmd & PORT_CMD_FIS_ON) &&
+            !s->dev[port].init_d2h_sent) {
+            ahci_init_d2h(&s->dev[port]);
+        }
=20
-            check_cmd(s, port);
-            break;
-        case PORT_TFDATA:
-            /* Read Only. */
-            break;
-        case PORT_SIG:
-            /* Read Only */
-            break;
-        case PORT_SCR_STAT:
-            /* Read Only */
-            break;
-        case PORT_SCR_CTL:
-            if (((pr->scr_ctl & AHCI_SCR_SCTL_DET) =3D=3D 1) &&
-                ((val & AHCI_SCR_SCTL_DET) =3D=3D 0)) {
-                ahci_reset_port(s, port);
-            }
-            pr->scr_ctl =3D val;
-            break;
-        case PORT_SCR_ERR:
-            pr->scr_err &=3D ~val;
-            break;
-        case PORT_SCR_ACT:
-            /* RW1 */
-            pr->scr_act |=3D val;
-            break;
-        case PORT_CMD_ISSUE:
-            pr->cmd_issue |=3D val;
-            check_cmd(s, port);
-            break;
-        default:
-            break;
+        check_cmd(s, port);
+        break;
+    case PORT_TFDATA:
+        /* Read Only. */
+        break;
+    case PORT_SIG:
+        /* Read Only */
+        break;
+    case PORT_SCR_STAT:
+        /* Read Only */
+        break;
+    case PORT_SCR_CTL:
+        if (((pr->scr_ctl & AHCI_SCR_SCTL_DET) =3D=3D 1) &&
+            ((val & AHCI_SCR_SCTL_DET) =3D=3D 0)) {
+            ahci_reset_port(s, port);
+        }
+        pr->scr_ctl =3D val;
+        break;
+    case PORT_SCR_ERR:
+        pr->scr_err &=3D ~val;
+        break;
+    case PORT_SCR_ACT:
+        /* RW1 */
+        pr->scr_act |=3D val;
+        break;
+    case PORT_CMD_ISSUE:
+        pr->cmd_issue |=3D val;
+        check_cmd(s, port);
+        break;
+    default:
+        break;
     }
 }
=20
--=20
2.14.3
