Received: from eggs.gnu.org ([209.51.188.92]:48384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxe0-0005uM-Em
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:18:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxWB-0003SL-75
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:10:40 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 11 Jan 2019 15:08:47 +0100
Message-Id: <20190111140857.4211-6-philmd@redhat.com>
In-Reply-To: <20190111140857.4211-1-philmd@redhat.com>
References: <20190111140857.4211-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 05/15] hw/nvram/fw_cfg: Remove various typedefs
 from "qemu/typedefs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-arm@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Ben Warren <ben@skyportsystems.com>

There are only three files requiring these typedefs, let them
include "hw/nvram/fw_cfg.h" directly to simplify "qemu/typedefs.h".

To clean "qemu/typedefs.h", move the forward declarations
to "hw/nvram/fw_cfg.h".

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/acpi/vmgenid.h | 1 +
 include/hw/arm/virt.h     | 1 +
 include/hw/mem/nvdimm.h   | 1 +
 include/hw/nvram/fw_cfg.h | 8 +++++++-
 include/qemu/typedefs.h   | 4 ----
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
index 38586ecbdf..be53de38f1 100644
--- a/include/hw/acpi/vmgenid.h
+++ b/include/hw/acpi/vmgenid.h
@@ -3,6 +3,7 @@
=20
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/qdev.h"
+#include "hw/nvram/fw_cfg.h"
 #include "qemu/uuid.h"
=20
 #define VMGENID_DEVICE           "vmgenid"
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 4cc57a7ef6..fef632dcf5 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -35,6 +35,7 @@
 #include "qemu/notify.h"
 #include "hw/boards.h"
 #include "hw/arm/arm.h"
+#include "hw/nvram/fw_cfg.h"
 #include "sysemu/kvm.h"
 #include "hw/intc/arm_gicv3_common.h"
=20
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index c5c9b3c7f8..51d3a52c4b 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -24,6 +24,7 @@
 #define QEMU_NVDIMM_H
=20
 #include "hw/mem/pc-dimm.h"
+#include "hw/nvram/fw_cfg.h"
 #include "hw/acpi/bios-linker-loader.h"
=20
 #define NVDIMM_DEBUG 0
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index f5a6895a74..244ed78afa 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -14,7 +14,9 @@
 #define FW_CFG_IO(obj)  OBJECT_CHECK(FWCfgIoState,  (obj), TYPE_FW_CFG_I=
O)
 #define FW_CFG_MEM(obj) OBJECT_CHECK(FWCfgMemState, (obj), TYPE_FW_CFG_M=
EM)
=20
-typedef struct fw_cfg_file FWCfgFile;
+typedef struct FWCfgState FWCfgState;
+typedef struct FWCfgIoState FWCfgIoState;
+typedef struct FWCfgMemState FWCfgMemState;
=20
 #define FW_CFG_ORDER_OVERRIDE_VGA    70
 #define FW_CFG_ORDER_OVERRIDE_NIC    80
@@ -24,6 +26,8 @@ typedef struct fw_cfg_file FWCfgFile;
 void fw_cfg_set_order_override(FWCfgState *fw_cfg, int order);
 void fw_cfg_reset_order_override(FWCfgState *fw_cfg);
=20
+typedef struct fw_cfg_file FWCfgFile;
+
 typedef struct FWCfgFiles {
     uint32_t  count;
     FWCfgFile f[];
@@ -34,6 +38,8 @@ typedef struct fw_cfg_dma_access FWCfgDmaAccess;
 typedef void (*FWCfgCallback)(void *opaque);
 typedef void (*FWCfgWriteCallback)(void *opaque, off_t start, size_t len=
);
=20
+typedef struct FWCfgEntry FWCfgEntry;
+
 struct FWCfgState {
     /*< private >*/
     SysBusDevice parent_obj;
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 3a5ca74bd3..1c294c296c 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -31,10 +31,6 @@ typedef struct DriveInfo DriveInfo;
 typedef struct Error Error;
 typedef struct EventNotifier EventNotifier;
 typedef struct FlatView FlatView;
-typedef struct FWCfgEntry FWCfgEntry;
-typedef struct FWCfgIoState FWCfgIoState;
-typedef struct FWCfgMemState FWCfgMemState;
-typedef struct FWCfgState FWCfgState;
 typedef struct HCIInfo HCIInfo;
 typedef struct HVFX86EmulatorState HVFX86EmulatorState;
 typedef struct I2CBus I2CBus;
--=20
2.17.2
