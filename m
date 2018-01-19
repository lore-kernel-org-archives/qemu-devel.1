Received: from eggs.gnu.org ([2001:4830:134:3::10]:46093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecZdm-0006hn-GE
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:35:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecZdi-0007EI-Gw
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:35:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ecZdi-0007Di-B8
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:35:38 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 19 Jan 2018 14:33:37 -0200
Message-Id: <20180119163345.10649-12-ehabkost@redhat.com>
In-Reply-To: <20180119163345.10649-1-ehabkost@redhat.com>
References: <20180119163345.10649-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL v2 11/19] q35: Allow only supported dynamic
 sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.a@redhat.com>

The only user-creatable sysbus devices in qemu-system-x86_64 are
amd-iommu, intel-iommu, and xen-backend.  xen-backend is handled
by xen_set_dynamic_sysbus(), so we only need to add amd-iommu and
intel-iommu.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.a@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20171125151610.20547-7-ehabkost@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc_q35.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 0505730a99..ed3a0b8ff7 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -42,6 +42,8 @@
 #include "exec/address-spaces.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/ich9.h"
+#include "hw/i386/amd_iommu.h"
+#include "hw/i386/intel_iommu.h"
 #include "hw/smbios/smbios.h"
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci.h"
@@ -299,8 +301,8 @@ static void pc_q35_machine_options(MachineClass *m)
     m->default_machine_opts = "firmware=bios-256k.bin";
     m->default_display = "std";
     m->no_floppy = 1;
-    /*TODO: allow only sysbus devices that really work with this machine */
-    machine_class_allow_dynamic_sysbus_dev(m, TYPE_SYS_BUS_DEVICE);
+    machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
+    machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
     m->max_cpus = 288;
 }
 
-- 
2.14.3
