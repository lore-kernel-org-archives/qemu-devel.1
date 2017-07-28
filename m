Received: from eggs.gnu.org ([2001:4830:134:3::10]:32847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbE1f-0005Bs-Uu
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 18:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbE1d-0002Jx-Jc
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 18:46:32 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 28 Jul 2017 19:46:05 -0300
Message-Id: <20170728224608.3598-6-f4bug@amsat.org>
In-Reply-To: <20170728224608.3598-1-f4bug@amsat.org>
References: <20170728224608.3598-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 for 2.10 5/8] docs: fix broken paths to
 docs/devel/tracing.txt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

With the move of some docs/ to docs/devel/ on ac06724a71, no references were
updated.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 audio/trace-events              | 2 +-
 block/trace-events              | 2 +-
 chardev/trace-events            | 2 +-
 crypto/trace-events             | 2 +-
 hw/9pfs/trace-events            | 2 +-
 hw/acpi/trace-events            | 2 +-
 hw/alpha/trace-events           | 2 +-
 hw/arm/trace-events             | 2 +-
 hw/audio/trace-events           | 2 +-
 hw/block/dataplane/trace-events | 2 +-
 hw/block/trace-events           | 2 +-
 hw/char/trace-events            | 2 +-
 hw/display/trace-events         | 2 +-
 hw/dma/trace-events             | 2 +-
 hw/i386/trace-events            | 2 +-
 hw/input/trace-events           | 2 +-
 hw/intc/trace-events            | 2 +-
 hw/isa/trace-events             | 2 +-
 hw/mem/trace-events             | 2 +-
 hw/misc/trace-events            | 2 +-
 hw/net/trace-events             | 2 +-
 hw/nvram/trace-events           | 2 +-
 hw/pci/trace-events             | 2 +-
 hw/ppc/trace-events             | 2 +-
 hw/s390x/trace-events           | 2 +-
 hw/scsi/trace-events            | 2 +-
 hw/sd/trace-events              | 2 +-
 hw/sparc/trace-events           | 2 +-
 hw/timer/trace-events           | 2 +-
 hw/usb/trace-events             | 2 +-
 hw/vfio/trace-events            | 2 +-
 hw/virtio/trace-events          | 2 +-
 hw/xen/trace-events             | 2 +-
 io/trace-events                 | 2 +-
 linux-user/trace-events         | 2 +-
 migration/trace-events          | 2 +-
 net/trace-events                | 2 +-
 qom/trace-events                | 2 +-
 scripts/simpletrace.py          | 2 +-
 target/arm/trace-events         | 2 +-
 target/i386/trace-events        | 2 +-
 target/mips/trace-events        | 2 +-
 target/ppc/trace-events         | 2 +-
 target/s390x/trace-events       | 2 +-
 target/sparc/trace-events       | 2 +-
 ui/trace-events                 | 2 +-
 util/trace-events               | 2 +-
 47 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/audio/trace-events b/audio/trace-events
index 517359039e..122604287f 100644
--- a/audio/trace-events
+++ b/audio/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # audio/alsaaudio.c
 alsa_revents(int revents) "revents = %d"
diff --git a/block/trace-events b/block/trace-events
index 4a4df25323..8d10a82941 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # block.c
 bdrv_open_common(void *bs, const char *filename, int flags, const char *format_name) "bs %p filename \"%s\" flags %#x format_name \"%s\""
diff --git a/chardev/trace-events b/chardev/trace-events
index 822dde668b..d0e5f3bbc1 100644
--- a/chardev/trace-events
+++ b/chardev/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # chardev/wctablet.c
 wct_init(void) ""
diff --git a/crypto/trace-events b/crypto/trace-events
index dc6ddd30d6..e589990359 100644
--- a/crypto/trace-events
+++ b/crypto/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # crypto/tlscreds.c
 qcrypto_tls_creds_load_dh(void *creds, const char *filename) "TLS creds load DH creds=%p filename=%s"
diff --git a/hw/9pfs/trace-events b/hw/9pfs/trace-events
index fb4de3d465..08a4abf22e 100644
--- a/hw/9pfs/trace-events
+++ b/hw/9pfs/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/9pfs/virtio-9p.c
 v9fs_rerror(uint16_t tag, uint8_t id, int err) "tag %d id %d err %d"
diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
index c379607a3e..e3b41e9df4 100644
--- a/hw/acpi/trace-events
+++ b/hw/acpi/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/acpi/memory_hotplug.c
 mhp_acpi_invalid_slot_selected(uint32_t slot) "0x%"PRIx32
diff --git a/hw/alpha/trace-events b/hw/alpha/trace-events
index e44ff01a09..46024cca0b 100644
--- a/hw/alpha/trace-events
+++ b/hw/alpha/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/alpha/pci.c
 alpha_pci_iack_write(void) ""
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index d5f33a2a03..193063ed99 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/arm/virt-acpi-build.c
 virt_acpi_setup(void) "No fw cfg or ACPI disabled. Bailing out."
diff --git a/hw/audio/trace-events b/hw/audio/trace-events
index 3210386e86..47e2ed53d7 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/audio/cs4231.c
 cs4231_mem_readl_dreg(uint32_t reg, uint32_t ret) "read dreg %d: 0x%02x"
diff --git a/hw/block/dataplane/trace-events b/hw/block/dataplane/trace-events
index e07673ab1f..1a7ea277b0 100644
--- a/hw/block/dataplane/trace-events
+++ b/hw/block/dataplane/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/block/dataplane/virtio-blk.c
 virtio_blk_data_plane_start(void *s) "dataplane %p"
diff --git a/hw/block/trace-events b/hw/block/trace-events
index c332c01ea8..cb6767b3ee 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/block/virtio-blk.c
 virtio_blk_req_complete(void *vdev, void *req, int status) "vdev %p req %p status %d"
diff --git a/hw/char/trace-events b/hw/char/trace-events
index daf4ee470a..eeb1a0a527 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/char/virtio-serial-bus.c
 virtio_serial_send_control_event(unsigned int port, uint16_t event, uint16_t value) "port %u, event %u, value %u"
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 3e896d2e3f..02d03a9ccc 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/display/jazz_led.c
 jazz_led_read(uint64_t addr, uint8_t val) "read addr=0x%"PRIx64": 0x%x"
diff --git a/hw/dma/trace-events b/hw/dma/trace-events
index 22878dfdb6..40e9688325 100644
--- a/hw/dma/trace-events
+++ b/hw/dma/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/dma/rc4030.c
 jazzio_read(uint64_t addr, uint32_t ret) "read reg[0x%"PRIx64"] = 0x%x"
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 42d8a7e27a..d43b4b6cd3 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/i386/x86-iommu.c
 x86_iommu_iec_notify(bool global, uint32_t index, uint32_t mask) "Notify IEC invalidation: global=%d index=%" PRIu32 " mask=%" PRIu32
diff --git a/hw/input/trace-events b/hw/input/trace-events
index 5a87818b49..e1c8780771 100644
--- a/hw/input/trace-events
+++ b/hw/input/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/input/ps2.c
 ps2_put_keycode(void *opaque, int keycode) "%p keycode %d"
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index c586714d89..1788dda197 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/intc/apic_common.c
 cpu_set_apic_base(uint64_t val) "%016"PRIx64
diff --git a/hw/isa/trace-events b/hw/isa/trace-events
index 9faca41a97..254500a3f6 100644
--- a/hw/isa/trace-events
+++ b/hw/isa/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/isa/pc87312.c
 pc87312_io_read(uint32_t addr, uint32_t val) "read addr=%x val=%x"
diff --git a/hw/mem/trace-events b/hw/mem/trace-events
index 323c3c10d5..e150dcc497 100644
--- a/hw/mem/trace-events
+++ b/hw/mem/trace-events
@@ -1,4 +1,4 @@
-# See docs/trace-events.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/mem/pc-dimm.c
 mhp_pc_dimm_assigned_slot(int slot) "%d"
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 28b8cd1c2e..56ee4fb5f6 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/misc/eccmemctl.c
 ecc_mem_writel_mer(uint32_t val) "Write memory enable %08x"
diff --git a/hw/net/trace-events b/hw/net/trace-events
index c71480535e..2535d5b0b8 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/net/lance.c
 lance_mem_readw(uint64_t addr, uint32_t ret) "addr=%"PRIx64"val=0x%04x"
diff --git a/hw/nvram/trace-events b/hw/nvram/trace-events
index 1f1e05ab69..f9a778d152 100644
--- a/hw/nvram/trace-events
+++ b/hw/nvram/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/nvram/ds1225y.c
 nvram_read(uint32_t addr, uint32_t ret) "read addr %d: 0x%02x"
diff --git a/hw/pci/trace-events b/hw/pci/trace-events
index 83c8f5ace7..2f0da76733 100644
--- a/hw/pci/trace-events
+++ b/hw/pci/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/pci/pci.c
 pci_update_mappings_del(void *d, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "d=%p %02x:%02x.%x %d,%#"PRIx64"+%#"PRIx64
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 0f7d9be4ef..0501b88477 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/ppc/spapr_pci.c
 spapr_pci_msi(const char *msg, uint32_t ca) "%s (cfg=%x)"
diff --git a/hw/s390x/trace-events b/hw/s390x/trace-events
index f07e974678..5086cd9ad9 100644
--- a/hw/s390x/trace-events
+++ b/hw/s390x/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/s390x/css.c
 css_enable_facility(const char *facility) "CSS: enable %s"
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index 4a2e5d66df..652a815e77 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/scsi/scsi-bus.c
 scsi_req_alloc(int target, int lun, int tag) "target %d lun %d tag %d"
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index b17e7ba442..42ebc2d0d8 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/sd/milkymist-memcard.c
 milkymist_memcard_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
diff --git a/hw/sparc/trace-events b/hw/sparc/trace-events
index 30fb0373e7..efd765cbe6 100644
--- a/hw/sparc/trace-events
+++ b/hw/sparc/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/sparc/sun4m.c
 sun4m_cpu_interrupt(unsigned int level) "Set CPU IRQ %d"
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index fd8196be66..62c4e0dc75 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/timer/slavio_timer.c
 slavio_timer_get_out(uint64_t limit, uint32_t counthigh, uint32_t count) "limit %"PRIx64" count %x%08x"
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index 0c323d4cac..f74cbd5bcd 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/usb/core.c
 usb_packet_state_change(int bus, const char *port, int ep, void *p, const char *o, const char *n) "bus %d, port %s, ep %d, packet %p, state %s -> %s"
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 2561c6d31a..f7f891439a 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/vfio/pci.c
 vfio_intx_interrupt(const char *name, char line) " (%s) Pin %c"
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index e24d8fa997..012bbaa694 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # hw/virtio/virtio.c
 virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned out_num) "elem %p size %zd in_num %u out_num %u"
diff --git a/hw/xen/trace-events b/hw/xen/trace-events
index 5615dce2c1..bff4f2319b 100644
--- a/hw/xen/trace-events
+++ b/hw/xen/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # include/hw/xen/xen_common.h
 xen_default_ioreq_server(void) ""
diff --git a/io/trace-events b/io/trace-events
index ff993bef45..3d233698d0 100644
--- a/io/trace-events
+++ b/io/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # io/task.c
 qio_task_new(void *task, void *source, void *func, void *opaque) "Task new task=%p source=%p func=%p opaque=%p"
diff --git a/linux-user/trace-events b/linux-user/trace-events
index fc71f91ccb..80ad957dfd 100644
--- a/linux-user/trace-events
+++ b/linux-user/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # linux-user/signal.c
 user_setup_frame(void *env, uint64_t frame_addr) "env=%p frame_addr=%"PRIx64
diff --git a/migration/trace-events b/migration/trace-events
index cb2c4b5b40..a7d546b289 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # migration/savevm.c
 qemu_loadvm_state_section(unsigned int section_type) "%d"
diff --git a/net/trace-events b/net/trace-events
index 247e5c04db..201813941d 100644
--- a/net/trace-events
+++ b/net/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # net/vhost-user.c
 vhost_user_event(const char *chr, int event) "chr: %s got event: %d"
diff --git a/qom/trace-events b/qom/trace-events
index 97db357207..5d86fbf019 100644
--- a/qom/trace-events
+++ b/qom/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # qom/object.c
 object_dynamic_cast_assert(const char *type, const char *target, const char *file, int line, const char *func) "%s->%s (%s:%d:%s)"
diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index f1be6e419a..2a977e2ab9 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -7,7 +7,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2.  See
 # the COPYING file in the top-level directory.
 #
-# For help see docs/tracing.txt
+# For help see docs/devel/tracing.txt
 
 import struct
 import re
diff --git a/target/arm/trace-events b/target/arm/trace-events
index e21c84fc6f..c4fcda59b4 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # target/arm/helper.c
 arm_gt_recalc(int timer, int irqstate, uint64_t nexttick) "gt recalc: timer %d irqstate %d next tick %" PRIx64
diff --git a/target/i386/trace-events b/target/i386/trace-events
index de6a1cf0cb..3153fd4454 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # target/i386/kvm.c
 kvm_x86_fixup_msi_error(uint32_t gsi) "VT-d failed to remap interrupt for GSI %" PRIu32
diff --git a/target/mips/trace-events b/target/mips/trace-events
index 43824089b3..05eafd7870 100644
--- a/target/mips/trace-events
+++ b/target/mips/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # target/mips/translate.c
 mips_translate_c0(const char *instr, const char *rn, int reg, int sel) "%s %s (reg %d sel %d)"
diff --git a/target/ppc/trace-events b/target/ppc/trace-events
index b666156114..35ee898566 100644
--- a/target/ppc/trace-events
+++ b/target/ppc/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # target/ppc/kvm.c
 kvm_failed_spr_set(int str, const char *msg) "Warning: Unable to set SPR %d to KVM: %s"
diff --git a/target/s390x/trace-events b/target/s390x/trace-events
index 1574033e31..852a248d66 100644
--- a/target/s390x/trace-events
+++ b/target/s390x/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # target/s390x/mmu_helper.c
 get_skeys_nonzero(int rc) "SKEY: Call to get_skeys unexpectedly returned %d"
diff --git a/target/sparc/trace-events b/target/sparc/trace-events
index 8df178a347..8d1ed1b913 100644
--- a/target/sparc/trace-events
+++ b/target/sparc/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # target/sparc/mmu_helper.c
 mmu_helper_dfault(uint64_t address, uint64_t context, int mmu_idx, uint32_t tl) "DFAULT at %"PRIx64" context %"PRIx64" mmu_idx=%d tl=%d"
diff --git a/ui/trace-events b/ui/trace-events
index 19ce5f85f6..34c2213700 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # ui/console.c
 console_gfx_new(void) ""
diff --git a/util/trace-events b/util/trace-events
index fa540c620b..025499f83f 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.txt for syntax documentation.
 
 # util/aio-posix.c
 run_poll_handlers_begin(void *ctx, int64_t max_ns) "ctx %p max_ns %"PRId64
-- 
2.13.3
