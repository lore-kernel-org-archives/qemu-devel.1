Received: from eggs.gnu.org ([2001:4830:134:3::10]:45035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNITA-0004Ex-0a
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNIT7-0002Bo-Ob
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dNIT7-0002AR-Cf
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 588C385550
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 12:41:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 20 Jun 2017 14:40:41 +0200
Message-Id: <1497962468-22936-15-git-send-email-armbru@redhat.com>
In-Reply-To: <1497962468-22936-1-git-send-email-armbru@redhat.com>
References: <1497962468-22936-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 14/41] object: use more specific property
 type names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Use the actual unsigned integer type name.

The type name change impacts the following externally visible area:

* vl.c's machine_help_func() puts it in help for -machine NAME,help.

* QMP command qom-list exposes it in ObjectPropertyInfo member @type.

* QMP command device-list-properties exposes it in DevicePropertyInfo
  member @type.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20170607163635.17635-15-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 backends/cryptodev.c |  2 +-
 hw/pci-host/piix.c   |  8 ++++----
 hw/pci-host/q35.c    | 10 +++++-----
 hw/ppc/pnv.c         |  2 +-
 net/dump.c           |  2 +-
 net/filter-buffer.c  |  2 +-
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 832f056..1764c17 100644
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
index 4ce201e..a2c1033 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -273,19 +273,19 @@ static void i440fx_pcihost_initfn(Object *obj)
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
index e8a04d3..c2f2af5 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -175,23 +175,23 @@ static void q35_host_initfn(Object *obj)
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
+    object_property_add(obj, PCIE_HOST_MCFG_SIZE, "uint64",
                         q35_host_get_mmcfg_size,
                         NULL, NULL, NULL, NULL);
=20
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 89b6801..a4cd733 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1111,7 +1111,7 @@ static void powernv_machine_initfn(Object *obj)
=20
 static void powernv_machine_class_props_init(ObjectClass *oc)
 {
-    object_class_property_add(oc, "num-chips", "uint32_t",
+    object_class_property_add(oc, "num-chips", "uint32",
                               pnv_get_num_chips, pnv_set_num_chips,
                               NULL, NULL, NULL);
     object_class_property_set_description(oc, "num-chips",
diff --git a/net/dump.c b/net/dump.c
index 442eb53..15df9a4 100644
--- a/net/dump.c
+++ b/net/dump.c
@@ -328,7 +328,7 @@ static void filter_dump_instance_init(Object *obj)
=20
     nfds->maxlen =3D 65536;
=20
-    object_property_add(obj, "maxlen", "int", filter_dump_get_maxlen,
+    object_property_add(obj, "maxlen", "uint32", filter_dump_get_maxlen,
                         filter_dump_set_maxlen, NULL, NULL, NULL);
     object_property_add_str(obj, "file", file_dump_get_filename,
                             file_dump_set_filename, NULL);
diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index cc6bd94..9ce96aa 100644
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
2.7.5
