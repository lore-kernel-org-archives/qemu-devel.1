Received: from eggs.gnu.org ([2001:4830:134:3::10]:60869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjRQ-0000Ef-K9
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:17:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjRL-0003n2-CB
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:17:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gJjRC-0003gq-0G
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:17:23 -0500
Date: Mon, 5 Nov 2018 13:17:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181105181353.39804-32-mst@redhat.com>
References: <20181105181353.39804-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181105181353.39804-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 31/33] piix: use TYPE_FOO constants than string
 constats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Qiang <liq3ea@gmail.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Li Qiang <liq3ea@gmail.com>

Make them more QOMConventional.
Cc:qemu-trivial@nongnu.org

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-host/piix.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index b5ded1a806..761a8158d7 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -95,6 +95,9 @@ typedef struct PIIX3State {
 #define I440FX_PCI_DEVICE(obj) \
     OBJECT_CHECK(PCII440FXState, (obj), TYPE_I440FX_PCI_DEVICE)
=20
+#define TYPE_PIIX3_DEVICE "PIIX3"
+#define TYPE_PIIX3_XEN_DEVICE "PIIX3-xen"
+
 struct PCII440FXState {
     /*< private >*/
     PCIDevice parent_obj;
@@ -424,13 +427,13 @@ PCIBus *i440fx_init(const char *host_type, const ch=
ar *pci_type,
      * These additional routes can be discovered through ACPI. */
     if (xen_enabled()) {
         PCIDevice *pci_dev =3D pci_create_simple_multifunction(b,
-                             -1, true, "PIIX3-xen");
+                             -1, true, TYPE_PIIX3_XEN_DEVICE);
         piix3 =3D PIIX3_PCI_DEVICE(pci_dev);
         pci_bus_irqs(b, xen_piix3_set_irq, xen_pci_slot_get_pirq,
                 piix3, XEN_PIIX_NUM_PIRQS);
     } else {
         PCIDevice *pci_dev =3D pci_create_simple_multifunction(b,
-                             -1, true, "PIIX3");
+                             -1, true, TYPE_PIIX3_DEVICE);
         piix3 =3D PIIX3_PCI_DEVICE(pci_dev);
         pci_bus_irqs(b, piix3_set_irq, pci_slot_get_pirq, piix3,
                 PIIX_NUM_PIRQS);
@@ -748,7 +751,7 @@ static void piix3_class_init(ObjectClass *klass, void=
 *data)
 }
=20
 static const TypeInfo piix3_info =3D {
-    .name          =3D "PIIX3",
+    .name          =3D TYPE_PIIX3_DEVICE,
     .parent        =3D TYPE_PIIX3_PCI_DEVICE,
     .class_init    =3D piix3_class_init,
 };
@@ -761,7 +764,7 @@ static void piix3_xen_class_init(ObjectClass *klass, =
void *data)
 };
=20
 static const TypeInfo piix3_xen_info =3D {
-    .name          =3D "PIIX3-xen",
+    .name          =3D TYPE_PIIX3_XEN_DEVICE,
     .parent        =3D TYPE_PIIX3_PCI_DEVICE,
     .class_init    =3D piix3_xen_class_init,
 };
--=20
MST
