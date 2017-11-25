Received: from eggs.gnu.org ([2001:4830:134:3::10]:47747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eIcC5-0005Sf-KY
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 10:16:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eIcC4-00058F-Ck
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 10:16:37 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Sat, 25 Nov 2017 13:16:08 -0200
Message-Id: <20171125151610.20547-5-ehabkost@redhat.com>
In-Reply-To: <20171125151610.20547-1-ehabkost@redhat.com>
References: <20171125151610.20547-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/6] spapr: Allow only supported dynamic
 sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jgross@suse.com, Thomas Huth <thuth@redhat.com>, sstabellini@kernel.org, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

TYPE_SPAPR_PCI_HOST_BRIDGE is the only dynamic sysbus device not
rejected by ppc_spapr_reset(), so it can be the only entry on the
allowed list.

Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>
Cc: qemu-ppc@nongnu.org
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes series v1 -> v2:
* New patch added to series
---
 hw/ppc/spapr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 82040cc5d1..3c6d6f2cea 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3603,8 +3603,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "";
     mc->default_ram_size = 512 * M_BYTE;
     mc->kvm_type = spapr_kvm_type;
-    /*TODO: allow only sysbus devices that really work with this machine */
-    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SYS_BUS_DEVICE);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SPAPR_PCI_HOST_BRIDGE);
     mc->pci_allow_0_address = true;
     mc->get_hotplug_handler = spapr_get_hotplug_handler;
     hc->pre_plug = spapr_machine_device_pre_plug;
-- 
2.13.6
