Received: from eggs.gnu.org ([2001:4830:134:3::10]:53906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZHyI-00056o-RX
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:11:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZHyH-0001y3-O3
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:11:50 -0500
Date: Tue, 18 Dec 2018 11:11:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218161008.3882-9-mst@redhat.com>
References: <20181218161008.3882-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181218161008.3882-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 08/30] hw/smbios: Move to the hw/firmware/
 subdirectory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Corey Minyard <minyard@acm.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

SMBIOS is just another firmware interface used by some QEMU models.
We will later introduce more firmware interfaces in this subdirectory.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/{smbios =3D> firmware}/smbios.h | 0
 hw/arm/virt.c                            | 2 +-
 hw/i386/pc.c                             | 2 +-
 hw/i386/pc_piix.c                        | 2 +-
 hw/i386/pc_q35.c                         | 2 +-
 hw/smbios/smbios-stub.c                  | 2 +-
 hw/smbios/smbios.c                       | 2 +-
 hw/smbios/smbios_type_38.c               | 2 +-
 tests/bios-tables-test.c                 | 2 +-
 vl.c                                     | 2 +-
 MAINTAINERS                              | 2 +-
 11 files changed, 10 insertions(+), 10 deletions(-)
 rename include/hw/{smbios =3D> firmware}/smbios.h (100%)

diff --git a/include/hw/smbios/smbios.h b/include/hw/firmware/smbios.h
similarity index 100%
rename from include/hw/smbios/smbios.h
rename to include/hw/firmware/smbios.h
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 5b678237b7..c2641e56ea 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -55,7 +55,7 @@
 #include "hw/intc/arm_gic.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "kvm_arm.h"
-#include "hw/smbios/smbios.h"
+#include "hw/firmware/smbios.h"
 #include "qapi/visitor.h"
 #include "standard-headers/linux/input.h"
 #include "hw/arm/smmuv3.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 115bc2825c..470cc5daf9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -37,7 +37,7 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/timer/hpet.h"
-#include "hw/smbios/smbios.h"
+#include "hw/firmware/smbios.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "multiboot.h"
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 6981cfa740..e000c7511a 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -30,7 +30,7 @@
 #include "hw/i386/pc.h"
 #include "hw/i386/apic.h"
 #include "hw/display/ramfb.h"
-#include "hw/smbios/smbios.h"
+#include "hw/firmware/smbios.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_ids.h"
 #include "hw/usb.h"
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 58459bdab5..8836d21485 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -47,7 +47,7 @@
 #include "hw/i386/amd_iommu.h"
 #include "hw/i386/intel_iommu.h"
 #include "hw/display/ramfb.h"
-#include "hw/smbios/smbios.h"
+#include "hw/firmware/smbios.h"
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci.h"
 #include "hw/usb.h"
diff --git a/hw/smbios/smbios-stub.c b/hw/smbios/smbios-stub.c
index d3a385441a..64e5ba93ec 100644
--- a/hw/smbios/smbios-stub.c
+++ b/hw/smbios/smbios-stub.c
@@ -23,7 +23,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
-#include "hw/smbios/smbios.h"
+#include "hw/firmware/smbios.h"
=20
 void smbios_entry_add(QemuOpts *opts, Error **errp)
 {
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 4bff9b5ea4..818be8a838 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -24,7 +24,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/uuid.h"
 #include "sysemu/cpus.h"
-#include "hw/smbios/smbios.h"
+#include "hw/firmware/smbios.h"
 #include "hw/loader.h"
 #include "exec/cpu-common.h"
 #include "smbios_build.h"
diff --git a/hw/smbios/smbios_type_38.c b/hw/smbios/smbios_type_38.c
index a1ad28d059..0c08f282de 100644
--- a/hw/smbios/smbios_type_38.c
+++ b/hw/smbios/smbios_type_38.c
@@ -9,7 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/ipmi/ipmi.h"
-#include "hw/smbios/smbios.h"
+#include "hw/firmware/smbios.h"
 #include "qemu/error-report.h"
 #include "smbios_build.h"
=20
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index d661d9be62..dfa74a5bec 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include <glib/gstdio.h>
 #include "qemu-common.h"
-#include "hw/smbios/smbios.h"
+#include "hw/firmware/smbios.h"
 #include "qemu/bitmap.h"
 #include "acpi-utils.h"
 #include "boot-sector.h"
diff --git a/vl.c b/vl.c
index 2a8b2ee16d..522f0131f4 100644
--- a/vl.c
+++ b/vl.c
@@ -61,7 +61,7 @@ int main(int argc, char **argv)
 #include "hw/display/vga.h"
 #include "hw/bt.h"
 #include "sysemu/watchdog.h"
-#include "hw/smbios/smbios.h"
+#include "hw/firmware/smbios.h"
 #include "hw/acpi/acpi.h"
 #include "hw/xen/xen.h"
 #include "hw/qdev.h"
diff --git a/MAINTAINERS b/MAINTAINERS
index 83c127f0d6..5d83b59542 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1260,7 +1260,7 @@ M: Michael S. Tsirkin <mst@redhat.com>
 M: Igor Mammedov <imammedo@redhat.com>
 S: Supported
 F: include/hw/acpi/*
-F: include/hw/smbios/*
+F: include/hw/firmware/smbios.h
 F: hw/mem/*
 F: hw/acpi/*
 F: hw/smbios/*
--=20
MST
