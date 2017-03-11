Received: from eggs.gnu.org ([2001:4830:134:3::10]:58486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmgzF-0001lE-V2
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmgzE-0002LX-Vr
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cmgzE-0002L6-Nh
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:08 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 11 Mar 2017 17:22:37 +0400
Message-Id: <20170311132256.22951-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170311132256.22951-1-marcandre.lureau@redhat.com>
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/21] pci-host: use more specific type names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anderson@redhat.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Use the actual unsigned integer type name (this should't break since
property type aren't directly accessed from outside).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/pci-host/piix.c |  8 ++++----
 hw/pci-host/q35.c  | 10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index f9218aa952..9aed6225bf 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -279,19 +279,19 @@ static void i440fx_pcihost_initfn(Object *obj)
     memory_region_init_io(&s->data_mem, obj, &pci_host_data_le_ops, s,
                           "pci-conf-data", 4);
=20
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "int",
+    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
                         i440fx_pcihost_get_pci_hole_start,
                         NULL, NULL, NULL, NULL);
=20
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "int",
+    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "uint32",
                         i440fx_pcihost_get_pci_hole_end,
                         NULL, NULL, NULL, NULL);
=20
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "int",
+    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "uint64",
                         i440fx_pcihost_get_pci_hole64_start,
                         NULL, NULL, NULL, NULL);
=20
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "int",
+    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "uint64",
                         i440fx_pcihost_get_pci_hole64_end,
                         NULL, NULL, NULL, NULL);
 }
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 344f77b10c..5438be8253 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -176,23 +176,23 @@ static void q35_host_initfn(Object *obj)
     qdev_prop_set_uint32(DEVICE(&s->mch), "addr", PCI_DEVFN(0, 0));
     qdev_prop_set_bit(DEVICE(&s->mch), "multifunction", false);
=20
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "int",
+    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
                         q35_host_get_pci_hole_start,
                         NULL, NULL, NULL, NULL);
=20
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "int",
+    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "uint32",
                         q35_host_get_pci_hole_end,
                         NULL, NULL, NULL, NULL);
=20
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "int",
+    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "uint64",
                         q35_host_get_pci_hole64_start,
                         NULL, NULL, NULL, NULL);
=20
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "int",
+    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "uint64",
                         q35_host_get_pci_hole64_end,
                         NULL, NULL, NULL, NULL);
=20
-    object_property_add(obj, PCIE_HOST_MCFG_SIZE, "int",
+    object_property_add(obj, PCIE_HOST_MCFG_SIZE, "uint32",
                         q35_host_get_mmcfg_size,
                         NULL, NULL, NULL, NULL);
=20
--=20
2.12.0.191.gc5d8de91d
