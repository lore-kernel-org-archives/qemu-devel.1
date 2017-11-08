Received: from eggs.gnu.org ([2001:4830:134:3::10]:34887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZMh-0000d4-Te
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:02:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZMe-0003eU-PM
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:02:35 -0500
Received: from mail-sn1nam01on0053.outbound.protection.outlook.com
	([104.47.32.53]:24078
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eCZMe-0003e4-Ib
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:02:32 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 8 Nov 2017 14:58:18 -0800
Message-ID: <038502fbe4a4cf8bca7cc7b50104478e1c821647.1510181732.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1510181732.git.alistair.francis@xilinx.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 30/45] hw/pci*: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_=
report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_re=
port("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report=
("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("=
\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1=
"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\=
2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2)=
;|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|=
Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig=
}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}'=
 \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Some lines where then manually tweaked to pass checkpatch.

A trailing '.' was removed in hw/pci/pci.c

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
---
V2:
 - Split hw patch into individual directories

 hw/pci-host/bonito.c |  6 +++---
 hw/pci/pci.c         | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 2ebeab5d90..6f2e589bee 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -38,7 +38,7 @@
  */
=20
 #include "qemu/osdep.h"
-
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "hw/i386/pc.h"
@@ -449,8 +449,8 @@ static uint32_t bonito_sbridge_pciaddr(void *opaque, hw=
addr addr)
     regno =3D (cfgaddr & BONITO_PCICONF_REG_MASK) >> BONITO_PCICONF_REG_OF=
FSET;
=20
     if (idsel =3D=3D 0) {
-        fprintf(stderr, "error in bonito pci config address " TARGET_FMT_p=
lx
-            ",pcimap_cfg=3D%x\n", addr, s->regs[BONITO_PCIMAP_CFG]);
+        error_report("error in bonito pci config address " TARGET_FMT_plx
+            ",pcimap_cfg=3D%x", addr, s->regs[BONITO_PCIMAP_CFG]);
         exit(1);
     }
     pciaddr =3D PCI_ADDR(pci_bus_num(phb->bus), devno, funno, regno);
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 5ed3c8dca4..948d4e04ee 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -525,8 +525,8 @@ static int get_pci_irq_state(QEMUFile *f, void *pv, siz=
e_t size,
     for (i =3D 0; i < PCI_NUM_PINS; ++i) {
         irq_state[i] =3D qemu_get_be32(f);
         if (irq_state[i] !=3D 0x1 && irq_state[i] !=3D 0) {
-            fprintf(stderr, "irq state %d: must be 0 or 1.\n",
-                    irq_state[i]);
+            error_report("irq state %d: must be 0 or 1",
+                         irq_state[i]);
             return -EINVAL;
         }
     }
@@ -688,7 +688,7 @@ static PCIBus *pci_get_bus_devfn(int *devfnp, PCIBus *r=
oot,
     unsigned slot;
=20
     if (!root) {
-        fprintf(stderr, "No primary PCI bus\n");
+        error_report("No primary PCI bus");
         return NULL;
     }
=20
@@ -704,7 +704,7 @@ static PCIBus *pci_get_bus_devfn(int *devfnp, PCIBus *r=
oot,
     }
=20
     if (dom !=3D 0) {
-        fprintf(stderr, "No support for non-zero PCI domains\n");
+        error_report("No support for non-zero PCI domains");
         return NULL;
     }
=20
@@ -1128,8 +1128,8 @@ void pci_register_bar(PCIDevice *pci_dev, int region_=
num,
     assert(region_num >=3D 0);
     assert(region_num < PCI_NUM_REGIONS);
     if (size & (size-1)) {
-        fprintf(stderr, "ERROR: PCI region size must be pow2 "
-                    "type=3D0x%x, size=3D0x%"FMT_PCIBUS"\n", type, size);
+        error_report("ERROR: PCI region size must be pow2 "
+                    "type=3D0x%x, size=3D0x%"FMT_PCIBUS"", type, size);
         exit(1);
     }
=20
--=20
2.14.1
