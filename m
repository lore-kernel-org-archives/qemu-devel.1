Received: from eggs.gnu.org ([2001:4830:134:3::10]:45840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d896Z-0008Po-PI
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:39:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d896U-0004Um-TR
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:39:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d896U-0004UV-KY
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:39:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 90C34461FE
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 17:39:17 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 May 2017 20:35:53 +0300
Message-Id: <20170509173559.31598-12-marcandre.lureau@redhat.com>
In-Reply-To: <20170509173559.31598-1-marcandre.lureau@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 11/17] object: use more specific property type
 names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Use the actual unsigned integer type name (this should't break since
property type aren't directly accessed from outside it seems).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 backends/cryptodev.c |  2 +-
 hw/pci-host/piix.c   |  8 ++++----
 hw/pci-host/q35.c    | 10 +++++-----
 hw/ppc/pnv.c         |  2 +-
 net/dump.c           |  2 +-
 net/filter-buffer.c  |  2 +-
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 832f056266..1764c179fe 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -222,7 +222,7 @@ cryptodev_backend_can_be_deleted(UserCreatable *uc, E=
rror **errp)
=20
 static void cryptodev_backend_instance_init(Object *obj)
 {
-    object_property_add(obj, "queues", "int",
+    object_property_add(obj, "queues", "uint32",
                           cryptodev_backend_get_queues,
                           cryptodev_backend_set_queues,
                           NULL, NULL, NULL);
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
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d4bcdb027f..a964354081 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1110,7 +1110,7 @@ static void powernv_machine_initfn(Object *obj)
=20
 static void powernv_machine_class_props_init(ObjectClass *oc)
 {
-    object_class_property_add(oc, "num-chips", "uint32_t",
+    object_class_property_add(oc, "num-chips", "uint32",
                               pnv_get_num_chips, pnv_set_num_chips,
                               NULL, NULL, NULL);
     object_class_property_set_description(oc, "num-chips",
diff --git a/net/dump.c b/net/dump.c
index 89a149b5dd..7f4d3fda52 100644
--- a/net/dump.c
+++ b/net/dump.c
@@ -325,7 +325,7 @@ static void filter_dump_instance_init(Object *obj)
=20
     nfds->maxlen =3D 65536;
=20
-    object_property_add(obj, "maxlen", "int", filter_dump_get_maxlen,
+    object_property_add(obj, "maxlen", "uint32", filter_dump_get_maxlen,
                         filter_dump_set_maxlen, NULL, NULL, NULL);
     object_property_add_str(obj, "file", file_dump_get_filename,
                             file_dump_set_filename, NULL);
diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index cc6bd94445..9ce96aaa35 100644
--- a/net/filter-buffer.c
+++ b/net/filter-buffer.c
@@ -191,7 +191,7 @@ out:
=20
 static void filter_buffer_init(Object *obj)
 {
-    object_property_add(obj, "interval", "int",
+    object_property_add(obj, "interval", "uint32",
                         filter_buffer_get_interval,
                         filter_buffer_set_interval, NULL, NULL, NULL);
 }
--=20
2.13.0.rc1.16.gd80b50c3f
