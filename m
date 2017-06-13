Received: from eggs.gnu.org ([2001:4830:134:3::10]:50785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKp4I-0004E9-J1
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKp4F-0000OZ-J6
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dKp4F-0000OO-9V
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:23 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 13 Jun 2017 13:53:01 -0300
Message-Id: <20170613165313.20954-4-ehabkost@redhat.com>
In-Reply-To: <20170613165313.20954-1-ehabkost@redhat.com>
References: <20170613165313.20954-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 03/15] Add qapi/error.h includes on files that
 will need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Some files will be changed by scripts to use macros defined in
qapi/error.h.  This patch adds the #include lines manually because it
would be harder to do it in the Coccinelle scripts.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qapi-types.py          | 1 +
 include/hw/audio/pcspk.h       | 1 +
 include/hw/isa/isa.h           | 1 +
 include/migration/vmstate.h    | 1 +
 target/s390x/cpu.h             | 1 +
 block/block-backend.c          | 1 +
 block/iscsi.c                  | 1 +
 bsd-user/elfload.c             | 1 +
 chardev/char-io.c              | 1 +
 hw/9pfs/xen-9p-backend.c       | 1 +
 hw/acpi/memory_hotplug.c       | 1 +
 hw/acpi/nvdimm.c               | 1 +
 hw/acpi/vmgenid.c              | 1 +
 hw/core/platform-bus.c         | 1 +
 hw/core/sysbus.c               | 1 +
 hw/display/vga-pci.c           | 1 +
 hw/i386/pc.c                   | 1 +
 hw/i386/pc_q35.c               | 1 +
 hw/ide/ich.c                   | 1 +
 hw/input/virtio-input-hid.c    | 1 +
 hw/intc/s390_flic_kvm.c        | 1 +
 hw/ipmi/ipmi.c                 | 1 +
 hw/isa/lpc_ich9.c              | 1 +
 hw/mips/mips_malta.c           | 1 +
 hw/misc/auxbus.c               | 1 +
 hw/misc/edu.c                  | 1 +
 hw/misc/pvpanic.c              | 1 +
 hw/net/e1000.c                 | 1 +
 hw/net/e1000e.c                | 1 +
 hw/net/eepro100.c              | 1 +
 hw/net/lance.c                 | 1 +
 hw/net/ne2000.c                | 1 +
 hw/net/pcnet-pci.c             | 1 +
 hw/net/rtl8139.c               | 1 +
 hw/net/spapr_llan.c            | 1 +
 hw/net/virtio-net.c            | 1 +
 hw/net/vmxnet3.c               | 1 +
 hw/pci-host/gpex.c             | 1 +
 hw/pci-host/xilinx-pcie.c      | 1 +
 hw/pci/pci.c                   | 1 +
 hw/pcmcia/pxa2xx.c             | 1 +
 hw/ppc/prep.c                  | 1 +
 hw/ppc/spapr_iommu.c           | 1 +
 hw/ppc/spapr_rtc.c             | 1 +
 hw/s390x/s390-skeys.c          | 1 +
 hw/timer/mc146818rtc.c         | 1 +
 hw/usb/hcd-ehci-pci.c          | 1 +
 hw/virtio/virtio-balloon.c     | 1 +
 hw/watchdog/watchdog.c         | 1 +
 hw/xen/xen_pvdev.c             | 1 +
 linux-user/elfload.c           | 1 +
 linux-user/uname.c             | 1 +
 migration/qemu-file-channel.c  | 1 +
 migration/ram.c                | 1 +
 numa.c                         | 1 +
 qom/container.c                | 1 +
 target/m68k/helper.c           | 1 +
 target/microblaze/translate.c  | 1 +
 target/mips/translate.c        | 1 +
 target/ppc/kvm.c               | 1 +
 target/s390x/kvm.c             | 1 +
 target/xtensa/helper.c         | 1 +
 tests/test-crypto-hash.c       | 1 +
 tests/test-io-channel-tls.c    | 1 +
 tests/test-qdev-global-props.c | 1 +
 ui/gtk.c                       | 1 +
 ui/spice-core.c                | 1 +
 util/qemu-config.c             | 1 +
 68 files changed, 68 insertions(+)

diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index b45e7b5634..814ac672be 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -287,6 +287,7 @@ h_comment = '''
 fdef.write(mcgen('''
 #include "qemu/osdep.h"
 #include "qapi/dealloc-visitor.h"
+#include "qapi/error.h"
 #include "%(prefix)sqapi-types.h"
 #include "%(prefix)sqapi-visit.h"
 ''',
diff --git a/include/hw/audio/pcspk.h b/include/hw/audio/pcspk.h
index 172afbf146..1a626d718d 100644
--- a/include/hw/audio/pcspk.h
+++ b/include/hw/audio/pcspk.h
@@ -25,6 +25,7 @@
 #ifndef HW_PCSPK_H
 #define HW_PCSPK_H
 
+#include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/isa/isa.h"
 
diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index c2fdd70cdc..f0574a04e2 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -3,6 +3,7 @@
 
 /* ISA bus */
 
+#include "qapi/error.h"
 #include "exec/memory.h"
 #include "exec/ioport.h"
 #include "hw/qdev.h"
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 8a3e9e6088..26ab616c8a 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -27,6 +27,7 @@
 #ifndef QEMU_VMSTATE_H
 #define QEMU_VMSTATE_H
 
+#include "qapi/error.h"
 #include "migration/qjson.h"
 
 typedef void SaveStateHandler(QEMUFile *f, void *opaque);
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index a4d31df2b5..c1aa087e8d 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -24,6 +24,7 @@
 #define S390X_CPU_H
 
 #include "qemu-common.h"
+#include "qapi/error.h"
 #include "cpu-qom.h"
 
 #define TARGET_LONG_BITS 64
diff --git a/block/block-backend.c b/block/block-backend.c
index 7d7f3697d1..7a885031e2 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "sysemu/block-backend.h"
 #include "block/block_int.h"
 #include "block/blockjob.h"
diff --git a/block/iscsi.c b/block/iscsi.c
index 5daa201181..9f1d94f7f1 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -24,6 +24,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 
 #include <poll.h>
 #include <math.h>
diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index 41a1309296..0d626a418a 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -1,6 +1,7 @@
 /* This is the Linux kernel elf-loading code, ported into user space */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 
 #include "qemu.h"
 #include "disas/disas.h"
diff --git a/chardev/char-io.c b/chardev/char-io.c
index f81052481a..a017af784d 100644
--- a/chardev/char-io.c
+++ b/chardev/char-io.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "chardev/char-io.h"
 
 typedef struct IOWatchPoll {
diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 922cc967be..6ab999d2ce 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 
 #include "hw/hw.h"
 #include "hw/9pfs/9p.h"
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 210073d283..f28c6766e5 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/pc-hotplug.h"
 #include "hw/mem/pc-dimm.h"
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 8e7d6ec034..c691a1de5b 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -27,6 +27,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/bios-linker-loader.h"
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index a32b847fe0..780637028e 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qmp-commands.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index 329ac670c0..e3d69b61f3 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -20,6 +20,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/platform-bus.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 5d0887f499..c6dfd9ae0c 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "monitor/monitor.h"
 #include "exec/address-spaces.h"
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index ac9a76499e..0f6a836b77 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -24,6 +24,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/hw.h"
 #include "ui/console.h"
 #include "hw/pci/pci.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5b8c6fbbea..742b5507e3 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/char/serial.h"
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 1523ef39e1..9179fb31de 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -28,6 +28,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/loader.h"
 #include "sysemu/arch_init.h"
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index 459916977e..092f16c2d7 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -61,6 +61,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/pci/msi.h"
 #include "hw/i386/pc.h"
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 46c038110c..8666234554 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -5,6 +5,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/iov.h"
 
 #include "hw/qdev.h"
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index b4c61d8300..7ee9b77399 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include <sys/ioctl.h>
diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index afafe1400f..a51cbca6f7 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/ipmi/ipmi.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index ac8416d42b..28c0fedb5d 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -28,6 +28,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 95cdabb2dd..4b6ccb575e 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index e4a7ba41de..3342b65f15 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -27,6 +27,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/log.h"
 #include "hw/misc/auxbus.h"
 #include "hw/i2c/i2c.h"
diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 01acacf142..eb814df82d 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
 #include "qemu/timer.h"
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 57da7f2199..5cd5a92614 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -13,6 +13,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qjson.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index f2e5072d27..4353f91cff 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -26,6 +26,7 @@
 
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "net/net.h"
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 6e234938db..664554f33c 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -34,6 +34,7 @@
 */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "net/net.h"
 #include "net/tap.h"
 #include "qemu/range.h"
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 4bf71f2d85..5e03c9fb24 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -41,6 +41,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "net/net.h"
diff --git a/hw/net/lance.c b/hw/net/lance.c
index 92b0c68274..7ac795d4b2 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -36,6 +36,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "qemu/timer.h"
diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
index 798d681e25..f8e86f5184 100644
--- a/hw/net/ne2000.c
+++ b/hw/net/ne2000.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "net/net.h"
diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index 0acf8a4879..e08aee92b1 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -28,6 +28,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/pci/pci.h"
 #include "net/net.h"
 #include "hw/loader.h"
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 671c7e48c6..36cd99e3fc 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -50,6 +50,7 @@
 
 /* For crc32 */
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include <zlib.h>
 
 #include "hw/hw.h"
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index d239e4bd7d..54ac4f4f44 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -25,6 +25,7 @@
  *
  */
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9a3d769aa2..3aa2af14e5 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/iov.h"
 #include "hw/virtio/virtio.h"
 #include "net/net.h"
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 4df31101ec..7ebb32e664 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -16,6 +16,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "net/net.h"
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index e2629ce70d..77f64b4ae7 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -29,6 +29,7 @@
  * http://www.firmware.org/1275/practice/imap/imap0_9d.pdf
  */
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/pci-host/gpex.h"
 
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index a968cea2af..c7ff5fb277 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci-host/xilinx-pcie.h"
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 98ccc27533..84d63728e1 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
diff --git a/hw/pcmcia/pxa2xx.c b/hw/pcmcia/pxa2xx.c
index 20c9c753d2..5833358f87 100644
--- a/hw/pcmcia/pxa2xx.c
+++ b/hw/pcmcia/pxa2xx.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/pcmcia.h"
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index d16646c95d..a917be6ca3 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -23,6 +23,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/timer/m48t59.h"
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 0341bc069d..d587772b9c 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -17,6 +17,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "qemu/log.h"
diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
index 00a4e4c717..7e250dcbaf 100644
--- a/hw/ppc/spapr_rtc.c
+++ b/hw/ppc/spapr_rtc.c
@@ -26,6 +26,7 @@
  *
  */
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "cpu.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 35e7f6316f..2db2f9c8a8 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/boards.h"
 #include "qmp-commands.h"
 #include "hw/s390x/storage-keys.h"
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 1b8d3d7d4c..4c1986b97f 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/bcd.h"
 #include "hw/hw.h"
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index 6dedcb8989..63491111e5 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -16,6 +16,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/usb/hcd-ehci.h"
 #include "qemu/range.h"
 
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a705e0ec55..f9939baa45 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -14,6 +14,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/iov.h"
 #include "qemu/timer.h"
 #include "qemu-common.h"
diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
index 0c5c9cde1c..2c3b2bb418 100644
--- a/hw/watchdog/watchdog.c
+++ b/hw/watchdog/watchdog.c
@@ -20,6 +20,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qemu/queue.h"
diff --git a/hw/xen/xen_pvdev.c b/hw/xen/xen_pvdev.c
index aed783e844..5048430177 100644
--- a/hw/xen/xen_pvdev.c
+++ b/hw/xen/xen_pvdev.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/log.h"
 #include "hw/qdev-core.h"
 #include "hw/xen/xen_backend.h"
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ce77317e09..b54bdffd8c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1,5 +1,6 @@
 /* This is the Linux kernel elf-loading code, ported into user space */
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include <sys/param.h>
 
 #include <sys/resource.h>
diff --git a/linux-user/uname.c b/linux-user/uname.c
index 313b79dbad..5199380d85 100644
--- a/linux-user/uname.c
+++ b/linux-user/uname.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 
 #include "qemu.h"
 //#include "qemu-common.h"
diff --git a/migration/qemu-file-channel.c b/migration/qemu-file-channel.c
index e202d73834..a597c5f948 100644
--- a/migration/qemu-file-channel.c
+++ b/migration/qemu-file-channel.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu-file-channel.h"
 #include "exec/cpu-common.h"
 #include "qemu-file.h"
diff --git a/migration/ram.c b/migration/ram.c
index 9ffd0a5479..b2ca242a3a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -26,6 +26,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include <zlib.h>
diff --git a/numa.c b/numa.c
index 65701cb6c8..2b5cb7b5c7 100644
--- a/numa.c
+++ b/numa.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "sysemu/numa.h"
 #include "exec/cpu-common.h"
 #include "exec/ramlist.h"
diff --git a/qom/container.c b/qom/container.c
index f6ccaf7ea7..2dbabd15ab 100644
--- a/qom/container.c
+++ b/qom/container.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qom/object.h"
 #include "qemu/module.h"
 
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index f750d3dbaa..ea1872cae5 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/gdbstub.h"
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 0bb609513c..83f6d96a71 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "cpu.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 559f8fed89..7dedfd6632 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -22,6 +22,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "cpu.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 51249ce79e..670edde79e 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -15,6 +15,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include <dirent.h>
 #include <sys/ioctl.h>
 #include <sys/vfs.h>
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index ba1e60f8a6..3383c49039 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -22,6 +22,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include <sys/ioctl.h>
 
 #include <linux/kvm.h>
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index bcd0b7738d..263990d621 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -26,6 +26,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/gdbstub.h"
diff --git a/tests/test-crypto-hash.c b/tests/test-crypto-hash.c
index 214a9f72c3..f58eeb4409 100644
--- a/tests/test-crypto-hash.c
+++ b/tests/test-crypto-hash.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 
 #include "crypto/init.h"
 #include "crypto/hash.h"
diff --git a/tests/test-io-channel-tls.c b/tests/test-io-channel-tls.c
index 8eaa208e1b..b55f5c81ff 100644
--- a/tests/test-io-channel-tls.c
+++ b/tests/test-io-channel-tls.c
@@ -22,6 +22,7 @@
 
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 
 #include "crypto-tls-x509-helpers.h"
 #include "io/channel-tls.h"
diff --git a/tests/test-qdev-global-props.c b/tests/test-qdev-global-props.c
index 48e5b7315f..d5bfcac37d 100644
--- a/tests/test-qdev-global-props.c
+++ b/tests/test-qdev-global-props.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 
 #include "hw/qdev.h"
 #include "qom/object.h"
diff --git a/ui/gtk.c b/ui/gtk.c
index 5bd87c265a..18c325f8d4 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -35,6 +35,7 @@
 #define LOCALEDIR "po"
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/cutils.h"
 
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 804abc5c0f..801e5c864a 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -16,6 +16,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include <spice.h>
 
 #include <netdb.h>
diff --git a/util/qemu-config.c b/util/qemu-config.c
index 405dd1a1d7..c74f15c42d 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
-- 
2.11.0.259.g40922b1
