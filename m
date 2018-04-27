Received: from eggs.gnu.org ([2001:4830:134:3::10]:58930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzZS-0000rm-B5
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzZO-0001nS-UK
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:21:37 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:20:38 +1000
Message-Id: <20180427092126.24812-2-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/49] uninorth: trivial style fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This makes sure we keep patchew/checkpatch happy during the remainder of =
this
patchset.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci-host/uninorth.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 66991da975..710818e355 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -272,7 +272,6 @@ PCIBus *pci_pmac_u3_init(qemu_irq *pic,
     UNINState *d;
=20
     /* Uninorth AGP bus */
-
     dev =3D qdev_create(NULL, TYPE_U3_AGP_HOST_BRIDGE);
     qdev_init_nofail(dev);
     s =3D SYS_BUS_DEVICE(dev);
@@ -302,16 +301,23 @@ PCIBus *pci_pmac_u3_init(qemu_irq *pic,
=20
 static void unin_main_pci_host_realize(PCIDevice *d, Error **errp)
 {
-    d->config[0x0C] =3D 0x08; // cache_line_size
-    d->config[0x0D] =3D 0x10; // latency_timer
-    d->config[0x34] =3D 0x00; // capabilities_pointer
+    /* cache_line_size */
+    d->config[0x0C] =3D 0x08;
+    /* latency_timer */
+    d->config[0x0D] =3D 0x10;
+    /* capabilities_pointer */
+    d->config[0x34] =3D 0x00;
 }
=20
 static void unin_agp_pci_host_realize(PCIDevice *d, Error **errp)
 {
-    d->config[0x0C] =3D 0x08; // cache_line_size
-    d->config[0x0D] =3D 0x10; // latency_timer
-    //    d->config[0x34] =3D 0x80; // capabilities_pointer
+    /* cache_line_size */
+    d->config[0x0C] =3D 0x08;
+    /* latency_timer */
+    d->config[0x0D] =3D 0x10;
+    /* capabilities_pointer
+    d->config[0x34] =3D 0x80; */
+
     /*
      * Set kMacRISCPCIAddressSelect (0x48) register to indicate PCI
      * memory space with base 0x80000000, size 0x10000000 for Apple's
@@ -333,9 +339,12 @@ static void u3_agp_pci_host_realize(PCIDevice *d, Er=
ror **errp)
=20
 static void unin_internal_pci_host_realize(PCIDevice *d, Error **errp)
 {
-    d->config[0x0C] =3D 0x08; // cache_line_size
-    d->config[0x0D] =3D 0x10; // latency_timer
-    d->config[0x34] =3D 0x00; // capabilities_pointer
+    /* cache_line_size */
+    d->config[0x0C] =3D 0x08;
+    /* latency_timer */
+    d->config[0x0D] =3D 0x10;
+    /* capabilities_pointer */
+    d->config[0x34] =3D 0x00;
 }
=20
 static void unin_main_pci_host_class_init(ObjectClass *klass, void *data=
)
--=20
2.14.3
