Received: from eggs.gnu.org ([2001:4830:134:3::10]:51875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6Ja-0003UZ-Kj
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JG-0008JY-OK
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:15 -0400
Received: from [185.30.24.106] (port=13518
	helo=hotspot.internet-for-guests.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JF-0008DE-Bo
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:02 -0400
Date: Tue, 23 Oct 2018 19:41:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181023234112.188140-27-mst@redhat.com>
References: <20181023234112.188140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181023234112.188140-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 26/28] piix: use TYPE_FOO constants than string
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
index 82421a86e3..731190d92d 100644
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
