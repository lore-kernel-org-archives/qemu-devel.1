Received: from eggs.gnu.org ([2001:4830:134:3::10]:47505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1db14r-0001bN-Kz
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:57:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1db14U-00077V-OK
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:56:57 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:34552 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1db14S-00071x-7v
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:56:34 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 28 Jul 2017 11:55:47 +0300
Message-Id: <20170728085547.13947-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] trace-events: print 0x before hex numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

To make logs more readable prefix all hex values with '0x' mark.
This is needed for consistency too, as a lot of hex values are already
prefixed with '0x'. Also, bring all hex outputs to the common form -
use '%#', not '0x%'.

This patch is done by two commands:
find . -name trace-events | \
 xargs sed -i 's/%\([-+ *.0-9]*\([hljztL]\|ll\|hh\)\?\(x\|X\|"\s*PRIx\)\)/%#\1/g'
find . -name trace-events | xargs sed -i 's/0x%#/%#/g'

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Hi all!

It is hard to read logs, when there are hex and dec numbers in one line, when
hex number doesn't contain any letters and don't have '0x' prefix. Hope I'm
not alone who is not comfortable with it, so, what about a patch like this?
May be regexp's should be improved but, I think, the common idea is clear.

 accel/kvm/trace-events    |   8 +-
 accel/tcg/trace-events    |   8 +-
 block/trace-events        |  22 ++---
 chardev/trace-events      |   2 +-
 hw/acpi/trace-events      |  54 +++++------
 hw/audio/trace-events     |  12 +--
 hw/char/trace-events      |  50 +++++-----
 hw/display/trace-events   |  92 +++++++++---------
 hw/dma/trace-events       |  36 +++----
 hw/i386/trace-events      | 160 ++++++++++++++++----------------
 hw/i386/xen/trace-events  |   4 +-
 hw/input/trace-events     |   4 +-
 hw/intc/trace-events      | 192 +++++++++++++++++++-------------------
 hw/isa/trace-events       |  12 +--
 hw/mem/trace-events       |   2 +-
 hw/misc/trace-events      |  88 +++++++++---------
 hw/net/trace-events       | 214 +++++++++++++++++++++---------------------
 hw/nvram/trace-events     |   6 +-
 hw/pci/trace-events       |   8 +-
 hw/ppc/trace-events       | 126 ++++++++++++-------------
 hw/s390x/trace-events     |  20 ++--
 hw/scsi/trace-events      | 232 +++++++++++++++++++++++-----------------------
 hw/sd/trace-events        |   4 +-
 hw/timer/trace-events     |  50 +++++-----
 hw/usb/trace-events       | 196 +++++++++++++++++++--------------------
 hw/vfio/trace-events      | 102 ++++++++++----------
 hw/virtio/trace-events    |   6 +-
 hw/xen/trace-events       |   4 +-
 linux-user/trace-events   |  10 +-
 migration/trace-events    |  46 ++++-----
 nbd/trace-events          |  32 +++----
 net/trace-events          |   4 +-
 target/arm/trace-events   |  10 +-
 target/s390x/trace-events |   6 +-
 target/sparc/trace-events |  30 +++---
 trace-events              |   6 +-
 ui/trace-events           |  16 ++--
 util/trace-events         |   2 +-
 38 files changed, 938 insertions(+), 938 deletions(-)

diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index f89ba5578d..1ecc9a058e 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -1,11 +1,11 @@
 # Trace events for debugging and performance instrumentation
 
 # kvm-all.c
-kvm_ioctl(int type, void *arg) "type 0x%x, arg %p"
-kvm_vm_ioctl(int type, void *arg) "type 0x%x, arg %p"
-kvm_vcpu_ioctl(int cpu_index, int type, void *arg) "cpu_index %d, type 0x%x, arg %p"
+kvm_ioctl(int type, void *arg) "type %#x, arg %p"
+kvm_vm_ioctl(int type, void *arg) "type %#x, arg %p"
+kvm_vcpu_ioctl(int cpu_index, int type, void *arg) "cpu_index %d, type %#x, arg %p"
 kvm_run_exit(int cpu_index, uint32_t reason) "cpu_index %d, reason %d"
-kvm_device_ioctl(int fd, int type, void *arg) "dev fd %d, type 0x%x, arg %p"
+kvm_device_ioctl(int fd, int type, void *arg) "dev fd %d, type %#x, arg %p"
 kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to retrieve ONEREG %" PRIu64 " from KVM: %s"
 kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable to set ONEREG %" PRIu64 " to KVM: %s"
 kvm_irqchip_commit_routes(void) ""
diff --git a/accel/tcg/trace-events b/accel/tcg/trace-events
index 2de8359670..6b7af24728 100644
--- a/accel/tcg/trace-events
+++ b/accel/tcg/trace-events
@@ -2,9 +2,9 @@
 
 # TCG related tracing (mostly disabled by default)
 # cpu-exec.c
-disable exec_tb(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
-disable exec_tb_nocache(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
-disable exec_tb_exit(void *last_tb, unsigned int flags) "tb:%p flags=%x"
+disable exec_tb(void *tb, uintptr_t pc) "tb:%p pc=%#"PRIxPTR
+disable exec_tb_nocache(void *tb, uintptr_t pc) "tb:%p pc=%#"PRIxPTR
+disable exec_tb_exit(void *last_tb, unsigned int flags) "tb:%p flags=%#x"
 
 # translate-all.c
-translate_block(void *tb, uintptr_t pc, uint8_t *tb_code) "tb:%p, pc:0x%"PRIxPTR", tb_code:%p"
+translate_block(void *tb, uintptr_t pc, uint8_t *tb_code) "tb:%p, pc:%#"PRIxPTR", tb_code:%p"
diff --git a/block/trace-events b/block/trace-events
index 4a4df25323..1d3ae601f7 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -5,8 +5,8 @@ bdrv_open_common(void *bs, const char *filename, int flags, const char *format_n
 bdrv_lock_medium(void *bs, bool locked) "bs %p locked %d"
 
 # block/block-backend.c
-blk_co_preadv(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %u flags %x"
-blk_co_pwritev(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %u flags %x"
+blk_co_preadv(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %u flags %#x"
+blk_co_pwritev(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %u flags %#x"
 
 # block/io.c
 bdrv_co_readv(void *bs, int64_t sector_num, int nb_sector) "bs %p sector_num %"PRId64" nb_sectors %d"
@@ -54,19 +54,19 @@ paio_submit_co(int64_t offset, int count, int type) "offset %"PRId64" count %d t
 paio_submit(void *acb, void *opaque, int64_t offset, int count, int type) "acb %p opaque %p offset %"PRId64" count %d type %d"
 
 # block/qcow2.c
-qcow2_writev_start_req(void *co, int64_t offset, int bytes) "co %p offset %" PRIx64 " bytes %d"
+qcow2_writev_start_req(void *co, int64_t offset, int bytes) "co %p offset %#" PRIx64 " bytes %d"
 qcow2_writev_done_req(void *co, int ret) "co %p ret %d"
 qcow2_writev_start_part(void *co) "co %p"
 qcow2_writev_done_part(void *co, int cur_bytes) "co %p cur_bytes %d"
-qcow2_writev_data(void *co, uint64_t offset) "co %p offset %" PRIx64
-qcow2_pwrite_zeroes_start_req(void *co, int64_t offset, int count) "co %p offset %" PRIx64 " count %d"
-qcow2_pwrite_zeroes(void *co, int64_t offset, int count) "co %p offset %" PRIx64 " count %d"
+qcow2_writev_data(void *co, uint64_t offset) "co %p offset %#" PRIx64
+qcow2_pwrite_zeroes_start_req(void *co, int64_t offset, int count) "co %p offset %#" PRIx64 " count %d"
+qcow2_pwrite_zeroes(void *co, int64_t offset, int count) "co %p offset %#" PRIx64 " count %d"
 
 # block/qcow2-cluster.c
-qcow2_alloc_clusters_offset(void *co, uint64_t offset, int bytes) "co %p offset %" PRIx64 " bytes %d"
-qcow2_handle_copied(void *co, uint64_t guest_offset, uint64_t host_offset, uint64_t bytes) "co %p guest_offset %" PRIx64 " host_offset %" PRIx64 " bytes %" PRIx64
-qcow2_handle_alloc(void *co, uint64_t guest_offset, uint64_t host_offset, uint64_t bytes) "co %p guest_offset %" PRIx64 " host_offset %" PRIx64 " bytes %" PRIx64
-qcow2_do_alloc_clusters_offset(void *co, uint64_t guest_offset, uint64_t host_offset, int nb_clusters) "co %p guest_offset %" PRIx64 " host_offset %" PRIx64 " nb_clusters %d"
+qcow2_alloc_clusters_offset(void *co, uint64_t offset, int bytes) "co %p offset %#" PRIx64 " bytes %d"
+qcow2_handle_copied(void *co, uint64_t guest_offset, uint64_t host_offset, uint64_t bytes) "co %p guest_offset %#" PRIx64 " host_offset %#" PRIx64 " bytes %#" PRIx64
+qcow2_handle_alloc(void *co, uint64_t guest_offset, uint64_t host_offset, uint64_t bytes) "co %p guest_offset %#" PRIx64 " host_offset %#" PRIx64 " bytes %#" PRIx64
+qcow2_do_alloc_clusters_offset(void *co, uint64_t guest_offset, uint64_t host_offset, int nb_clusters) "co %p guest_offset %#" PRIx64 " host_offset %#" PRIx64 " nb_clusters %d"
 qcow2_cluster_alloc_phys(void *co) "co %p"
 qcow2_cluster_link_l2(void *co, int nb_clusters) "co %p nb_clusters %d"
 
@@ -77,7 +77,7 @@ qcow2_l2_allocate_write_l1(void *bs, int l1_index) "bs %p l1_index %d"
 qcow2_l2_allocate_done(void *bs, int l1_index, int ret) "bs %p l1_index %d ret %d"
 
 # block/qcow2-cache.c
-qcow2_cache_get(void *co, int c, uint64_t offset, bool read_from_disk) "co %p is_l2_cache %d offset %" PRIx64 " read_from_disk %d"
+qcow2_cache_get(void *co, int c, uint64_t offset, bool read_from_disk) "co %p is_l2_cache %d offset %#" PRIx64 " read_from_disk %d"
 qcow2_cache_get_replace_entry(void *co, int c, int i) "co %p is_l2_cache %d index %d"
 qcow2_cache_get_read(void *co, int c, int i) "co %p is_l2_cache %d index %d"
 qcow2_cache_get_done(void *co, int c, int i) "co %p is_l2_cache %d index %d"
diff --git a/chardev/trace-events b/chardev/trace-events
index 822dde668b..b5966ab431 100644
--- a/chardev/trace-events
+++ b/chardev/trace-events
@@ -5,7 +5,7 @@ wct_init(void) ""
 wct_cmd_re(void) ""
 wct_cmd_st(void) ""
 wct_cmd_sp(void) ""
-wct_cmd_ts(int input) "0x%02x"
+wct_cmd_ts(int input) "%#02x"
 wct_cmd_other(const char *cmd) "%s"
 wct_speed(int speed) "%d"
 
diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
index c379607a3e..afcce7f598 100644
--- a/hw/acpi/trace-events
+++ b/hw/acpi/trace-events
@@ -1,32 +1,32 @@
 # See docs/tracing.txt for syntax documentation.
 
 # hw/acpi/memory_hotplug.c
-mhp_acpi_invalid_slot_selected(uint32_t slot) "0x%"PRIx32
-mhp_acpi_ejecting_invalid_slot(uint32_t slot) "0x%"PRIx32
-mhp_acpi_read_addr_lo(uint32_t slot, uint32_t addr) "slot[0x%"PRIx32"] addr lo: 0x%"PRIx32
-mhp_acpi_read_addr_hi(uint32_t slot, uint32_t addr) "slot[0x%"PRIx32"] addr hi: 0x%"PRIx32
-mhp_acpi_read_size_lo(uint32_t slot, uint32_t size) "slot[0x%"PRIx32"] size lo: 0x%"PRIx32
-mhp_acpi_read_size_hi(uint32_t slot, uint32_t size) "slot[0x%"PRIx32"] size hi: 0x%"PRIx32
-mhp_acpi_read_pxm(uint32_t slot, uint32_t pxm) "slot[0x%"PRIx32"] proximity: 0x%"PRIx32
-mhp_acpi_read_flags(uint32_t slot, uint32_t flags) "slot[0x%"PRIx32"] flags: 0x%"PRIx32
-mhp_acpi_write_slot(uint32_t slot) "set active slot: 0x%"PRIx32
-mhp_acpi_write_ost_ev(uint32_t slot, uint32_t ev) "slot[0x%"PRIx32"] OST EVENT: 0x%"PRIx32
-mhp_acpi_write_ost_status(uint32_t slot, uint32_t st) "slot[0x%"PRIx32"] OST STATUS: 0x%"PRIx32
-mhp_acpi_clear_insert_evt(uint32_t slot) "slot[0x%"PRIx32"] clear insert event"
-mhp_acpi_clear_remove_evt(uint32_t slot) "slot[0x%"PRIx32"] clear remove event"
-mhp_acpi_pc_dimm_deleted(uint32_t slot) "slot[0x%"PRIx32"] pc-dimm deleted"
-mhp_acpi_pc_dimm_delete_failed(uint32_t slot) "slot[0x%"PRIx32"] pc-dimm delete failed"
+mhp_acpi_invalid_slot_selected(uint32_t slot) "%#"PRIx32
+mhp_acpi_ejecting_invalid_slot(uint32_t slot) "%#"PRIx32
+mhp_acpi_read_addr_lo(uint32_t slot, uint32_t addr) "slot[%#"PRIx32"] addr lo: %#"PRIx32
+mhp_acpi_read_addr_hi(uint32_t slot, uint32_t addr) "slot[%#"PRIx32"] addr hi: %#"PRIx32
+mhp_acpi_read_size_lo(uint32_t slot, uint32_t size) "slot[%#"PRIx32"] size lo: %#"PRIx32
+mhp_acpi_read_size_hi(uint32_t slot, uint32_t size) "slot[%#"PRIx32"] size hi: %#"PRIx32
+mhp_acpi_read_pxm(uint32_t slot, uint32_t pxm) "slot[%#"PRIx32"] proximity: %#"PRIx32
+mhp_acpi_read_flags(uint32_t slot, uint32_t flags) "slot[%#"PRIx32"] flags: %#"PRIx32
+mhp_acpi_write_slot(uint32_t slot) "set active slot: %#"PRIx32
+mhp_acpi_write_ost_ev(uint32_t slot, uint32_t ev) "slot[%#"PRIx32"] OST EVENT: %#"PRIx32
+mhp_acpi_write_ost_status(uint32_t slot, uint32_t st) "slot[%#"PRIx32"] OST STATUS: %#"PRIx32
+mhp_acpi_clear_insert_evt(uint32_t slot) "slot[%#"PRIx32"] clear insert event"
+mhp_acpi_clear_remove_evt(uint32_t slot) "slot[%#"PRIx32"] clear remove event"
+mhp_acpi_pc_dimm_deleted(uint32_t slot) "slot[%#"PRIx32"] pc-dimm deleted"
+mhp_acpi_pc_dimm_delete_failed(uint32_t slot) "slot[%#"PRIx32"] pc-dimm delete failed"
 
 # hw/acpi/cpu.c
-cpuhp_acpi_invalid_idx_selected(uint32_t idx) "0x%"PRIx32
-cpuhp_acpi_read_flags(uint32_t idx, uint8_t flags) "idx[0x%"PRIx32"] flags: 0x%"PRIx8
-cpuhp_acpi_write_idx(uint32_t idx) "set active cpu idx: 0x%"PRIx32
-cpuhp_acpi_write_cmd(uint32_t idx, uint8_t cmd) "idx[0x%"PRIx32"] cmd: 0x%"PRIx8
-cpuhp_acpi_read_cmd_data(uint32_t idx, uint32_t data) "idx[0x%"PRIx32"] data: 0x%"PRIx32
-cpuhp_acpi_cpu_has_events(uint32_t idx, bool ins, bool rm) "idx[0x%"PRIx32"] inserting: %d, removing: %d"
-cpuhp_acpi_clear_inserting_evt(uint32_t idx) "idx[0x%"PRIx32"]"
-cpuhp_acpi_clear_remove_evt(uint32_t idx) "idx[0x%"PRIx32"]"
-cpuhp_acpi_ejecting_invalid_cpu(uint32_t idx) "0x%"PRIx32
-cpuhp_acpi_ejecting_cpu(uint32_t idx) "0x%"PRIx32
-cpuhp_acpi_write_ost_ev(uint32_t slot, uint32_t ev) "idx[0x%"PRIx32"] OST EVENT: 0x%"PRIx32
-cpuhp_acpi_write_ost_status(uint32_t slot, uint32_t st) "idx[0x%"PRIx32"] OST STATUS: 0x%"PRIx32
+cpuhp_acpi_invalid_idx_selected(uint32_t idx) "%#"PRIx32
+cpuhp_acpi_read_flags(uint32_t idx, uint8_t flags) "idx[%#"PRIx32"] flags: %#"PRIx8
+cpuhp_acpi_write_idx(uint32_t idx) "set active cpu idx: %#"PRIx32
+cpuhp_acpi_write_cmd(uint32_t idx, uint8_t cmd) "idx[%#"PRIx32"] cmd: %#"PRIx8
+cpuhp_acpi_read_cmd_data(uint32_t idx, uint32_t data) "idx[%#"PRIx32"] data: %#"PRIx32
+cpuhp_acpi_cpu_has_events(uint32_t idx, bool ins, bool rm) "idx[%#"PRIx32"] inserting: %d, removing: %d"
+cpuhp_acpi_clear_inserting_evt(uint32_t idx) "idx[%#"PRIx32"]"
+cpuhp_acpi_clear_remove_evt(uint32_t idx) "idx[%#"PRIx32"]"
+cpuhp_acpi_ejecting_invalid_cpu(uint32_t idx) "%#"PRIx32
+cpuhp_acpi_ejecting_cpu(uint32_t idx) "%#"PRIx32
+cpuhp_acpi_write_ost_ev(uint32_t slot, uint32_t ev) "idx[%#"PRIx32"] OST EVENT: %#"PRIx32
+cpuhp_acpi_write_ost_status(uint32_t slot, uint32_t st) "idx[%#"PRIx32"] OST STATUS: %#"PRIx32
diff --git a/hw/audio/trace-events b/hw/audio/trace-events
index 3210386e86..a73373daf5 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -1,14 +1,14 @@
 # See docs/tracing.txt for syntax documentation.
 
 # hw/audio/cs4231.c
-cs4231_mem_readl_dreg(uint32_t reg, uint32_t ret) "read dreg %d: 0x%02x"
-cs4231_mem_readl_reg(uint32_t reg, uint32_t ret) "read reg %d: 0x%08x"
-cs4231_mem_writel_reg(uint32_t reg, uint32_t old, uint32_t val) "write reg %d: 0x%08x -> 0x%08x"
-cs4231_mem_writel_dreg(uint32_t reg, uint32_t old, uint32_t val) "write dreg %d: 0x%02x -> 0x%02x"
+cs4231_mem_readl_dreg(uint32_t reg, uint32_t ret) "read dreg %d: %#02x"
+cs4231_mem_readl_reg(uint32_t reg, uint32_t ret) "read reg %d: %#08x"
+cs4231_mem_writel_reg(uint32_t reg, uint32_t old, uint32_t val) "write reg %d: %#08x -> %#08x"
+cs4231_mem_writel_dreg(uint32_t reg, uint32_t old, uint32_t val) "write dreg %d: %#02x -> %#02x"
 
 # hw/audio/milkymist-ac97.c
-milkymist_ac97_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_ac97_memory_write(uint32_t addr, uint32_t value) "addr %08x value %08x"
+milkymist_ac97_memory_read(uint32_t addr, uint32_t value) "addr %#08x value %#08x"
+milkymist_ac97_memory_write(uint32_t addr, uint32_t value) "addr %#08x value %#08x"
 milkymist_ac97_pulse_irq_crrequest(void) "Pulse IRQ CR request"
 milkymist_ac97_pulse_irq_crreply(void) "Pulse IRQ CR reply"
 milkymist_ac97_pulse_irq_dmaw(void) "Pulse IRQ DMA write"
diff --git a/hw/char/trace-events b/hw/char/trace-events
index daf4ee470a..d6f7e2259b 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -13,55 +13,55 @@ virtio_console_chr_event(unsigned int port, int event) "port %u, event %d"
 
 # hw/char/grlib_apbuart.c
 grlib_apbuart_event(int event) "event:%d"
-grlib_apbuart_writel_unknown(uint64_t addr, uint32_t value) "addr 0x%"PRIx64" value 0x%x"
-grlib_apbuart_readl_unknown(uint64_t addr) "addr 0x%"PRIx64
+grlib_apbuart_writel_unknown(uint64_t addr, uint32_t value) "addr %#"PRIx64" value %#x"
+grlib_apbuart_readl_unknown(uint64_t addr) "addr %#"PRIx64
 
 # hw/char/lm32_juart.c
-lm32_juart_get_jtx(uint32_t value) "jtx 0x%08x"
-lm32_juart_set_jtx(uint32_t value) "jtx 0x%08x"
-lm32_juart_get_jrx(uint32_t value) "jrx 0x%08x"
-lm32_juart_set_jrx(uint32_t value) "jrx 0x%08x"
+lm32_juart_get_jtx(uint32_t value) "jtx %#08x"
+lm32_juart_set_jtx(uint32_t value) "jtx %#08x"
+lm32_juart_get_jrx(uint32_t value) "jrx %#08x"
+lm32_juart_set_jrx(uint32_t value) "jrx %#08x"
 
 # hw/char/lm32_uart.c
-lm32_uart_memory_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
-lm32_uart_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+lm32_uart_memory_write(uint32_t addr, uint32_t value) "addr %#08x value %#08x"
+lm32_uart_memory_read(uint32_t addr, uint32_t value) "addr %#08x value %#08x"
 lm32_uart_irq_state(int level) "irq state %d"
 
 # hw/char/milkymist-uart.c
-milkymist_uart_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_uart_memory_write(uint32_t addr, uint32_t value) "addr %08x value %08x"
+milkymist_uart_memory_read(uint32_t addr, uint32_t value) "addr %#08x value %#08x"
+milkymist_uart_memory_write(uint32_t addr, uint32_t value) "addr %#08x value %#08x"
 milkymist_uart_raise_irq(void) "Raise IRQ"
 milkymist_uart_lower_irq(void) "Lower IRQ"
 
 # hw/char/escc.c
-escc_put_queue(char channel, int b) "channel %c put: 0x%02x"
-escc_get_queue(char channel, int val) "channel %c get 0x%02x"
+escc_put_queue(char channel, int b) "channel %c put: %#02x"
+escc_get_queue(char channel, int val) "channel %c get %#02x"
 escc_update_irq(int irq) "IRQ = %d"
 escc_update_parameters(char channel, int speed, int parity, int data_bits, int stop_bits) "channel %c: speed=%d parity=%c data=%d stop=%d"
-escc_mem_writeb_ctrl(char channel, uint32_t reg, uint32_t val) "Write channel %c, reg[%d] = %2.2x"
+escc_mem_writeb_ctrl(char channel, uint32_t reg, uint32_t val) "Write channel %c, reg[%d] = %#2.2x"
 escc_mem_writeb_data(char channel, uint32_t val) "Write channel %c, ch %d"
-escc_mem_readb_ctrl(char channel, uint32_t reg, uint8_t val) "Read channel %c, reg[%d] = %2.2x"
+escc_mem_readb_ctrl(char channel, uint32_t reg, uint8_t val) "Read channel %c, reg[%d] = %#2.2x"
 escc_mem_readb_data(char channel, uint32_t ret) "Read channel %c, ch %d"
 escc_serial_receive_byte(char channel, int ch) "channel %c put ch %d"
-escc_sunkbd_event_in(int ch, const char *name, int down) "QKeyCode 0x%2.2x [%s], down %d"
-escc_sunkbd_event_out(int ch) "Translated keycode 0x%2.2x"
+escc_sunkbd_event_in(int ch, const char *name, int down) "QKeyCode %#2.2x [%s], down %d"
+escc_sunkbd_event_out(int ch) "Translated keycode %#2.2x"
 escc_kbd_command(int val) "Command %d"
-escc_sunmouse_event(int dx, int dy, int buttons_state) "dx=%d dy=%d buttons=%01x"
+escc_sunmouse_event(int dx, int dy, int buttons_state) "dx=%d dy=%d buttons=%#01x"
 
 # hw/char/pl011.c
 pl011_irq_state(int level) "irq state %d"
-pl011_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+pl011_read(uint32_t addr, uint32_t value) "addr %#08x value %#08x"
 pl011_read_fifo(int read_count) "FIFO read, read_count now %d"
-pl011_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
-pl011_can_receive(uint32_t lcr, int read_count, int r) "LCR %08x read_count %d returning %d"
-pl011_put_fifo(uint32_t c, int read_count) "new char 0x%x read_count now %d"
+pl011_write(uint32_t addr, uint32_t value) "addr %#08x value %#08x"
+pl011_can_receive(uint32_t lcr, int read_count, int r) "LCR %#08x read_count %d returning %d"
+pl011_put_fifo(uint32_t c, int read_count) "new char %#x read_count now %d"
 pl011_put_fifo_full(void) "FIFO now full, RXFF set"
 
 # hw/char/cmsdk_apb_uart.c
-cmsdk_apb_uart_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB UART read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
-cmsdk_apb_uart_write(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB UART write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
+cmsdk_apb_uart_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB UART read: offset %#" PRIx64 " data %#" PRIx64 " size %u"
+cmsdk_apb_uart_write(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB UART write: offset %#" PRIx64 " data %#" PRIx64 " size %u"
 cmsdk_apb_uart_reset(void) "CMSDK APB UART: reset"
-cmsdk_apb_uart_receive(uint8_t c) "CMSDK APB UART: got character 0x%x from backend"
+cmsdk_apb_uart_receive(uint8_t c) "CMSDK APB UART: got character %#x from backend"
 cmsdk_apb_uart_tx_pending(void) "CMSDK APB UART: character send to backend pending"
-cmsdk_apb_uart_tx(uint8_t c) "CMSDK APB UART: character 0x%x sent to backend"
+cmsdk_apb_uart_tx(uint8_t c) "CMSDK APB UART: character %#x sent to backend"
 cmsdk_apb_uart_set_params(int speed) "CMSDK APB UART: params set to %d 8N1"
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 3e896d2e3f..1473097965 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -1,62 +1,62 @@
 # See docs/tracing.txt for syntax documentation.
 
 # hw/display/jazz_led.c
-jazz_led_read(uint64_t addr, uint8_t val) "read addr=0x%"PRIx64": 0x%x"
-jazz_led_write(uint64_t addr, uint8_t new) "write addr=0x%"PRIx64": 0x%x"
+jazz_led_read(uint64_t addr, uint8_t val) "read addr=%#"PRIx64": %#x"
+jazz_led_write(uint64_t addr, uint8_t new) "write addr=%#"PRIx64": %#x"
 
 # hw/display/xenfb.c
 xenfb_mouse_event(void *opaque, int dx, int dy, int dz, int button_state, int abs_pointer_wanted) "%p x %d y %d z %d bs %#x abs %d"
 xenfb_input_connected(void *xendev, int abs_pointer_wanted) "%p abs %d"
 
 # hw/display/g364fb.c
-g364fb_read(uint64_t addr, uint32_t val) "read addr=0x%"PRIx64": 0x%x"
-g364fb_write(uint64_t addr, uint32_t new) "write addr=0x%"PRIx64": 0x%x"
+g364fb_read(uint64_t addr, uint32_t val) "read addr=%#"PRIx64": %#x"
+g364fb_write(uint64_t addr, uint32_t new) "write addr=%#"PRIx64": %#x"
 
 # hw/display/milkymist-tmu2.c
-milkymist_tmu2_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_tmu2_memory_write(uint32_t addr, uint32_t value) "addr %08x value %08x"
+milkymist_tmu2_memory_read(uint32_t addr, uint32_t value) "addr %#08x value %#08x"
+milkymist_tmu2_memory_write(uint32_t addr, uint32_t value) "addr %#08x value %#08x"
 milkymist_tmu2_start(void) "Start TMU"
 milkymist_tmu2_pulse_irq(void) "Pulse IRQ"
 
 # hw/display/milkymist-vgafb.c
-milkymist_vgafb_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_vgafb_memory_write(uint32_t addr, uint32_t value) "addr %08x value %08x"
+milkymist_vgafb_memory_read(uint32_t addr, uint32_t value) "addr %#08x value %#08x"
+milkymist_vgafb_memory_write(uint32_t addr, uint32_t value) "addr %#08x value %#08x"
 
 # hw/display/vmware_vga.c
-vmware_value_read(uint32_t index, uint32_t value) "index %d, value 0x%x"
-vmware_value_write(uint32_t index, uint32_t value) "index %d, value 0x%x"
-vmware_palette_read(uint32_t index, uint32_t value) "index %d, value 0x%x"
-vmware_palette_write(uint32_t index, uint32_t value) "index %d, value 0x%x"
-vmware_scratch_read(uint32_t index, uint32_t value) "index %d, value 0x%x"
-vmware_scratch_write(uint32_t index, uint32_t value) "index %d, value 0x%x"
+vmware_value_read(uint32_t index, uint32_t value) "index %d, value %#x"
+vmware_value_write(uint32_t index, uint32_t value) "index %d, value %#x"
+vmware_palette_read(uint32_t index, uint32_t value) "index %d, value %#x"
+vmware_palette_write(uint32_t index, uint32_t value) "index %d, value %#x"
+vmware_scratch_read(uint32_t index, uint32_t value) "index %d, value %#x"
+vmware_scratch_write(uint32_t index, uint32_t value) "index %d, value %#x"
 vmware_setmode(uint32_t w, uint32_t h, uint32_t bpp) "%dx%d @ %d bpp"
 
 # hw/display/virtio-gpu.c
 virtio_gpu_features(bool virgl) "virgl %d"
 virtio_gpu_cmd_get_display_info(void) ""
-virtio_gpu_cmd_set_scanout(uint32_t id, uint32_t res, uint32_t w, uint32_t h, uint32_t x, uint32_t y) "id %d, res 0x%x, w %d, h %d, x %d, y %d"
-virtio_gpu_cmd_res_create_2d(uint32_t res, uint32_t fmt, uint32_t w, uint32_t h) "res 0x%x, fmt 0x%x, w %d, h %d"
-virtio_gpu_cmd_res_create_3d(uint32_t res, uint32_t fmt, uint32_t w, uint32_t h, uint32_t d) "res 0x%x, fmt 0x%x, w %d, h %d, d %d"
-virtio_gpu_cmd_res_unref(uint32_t res) "res 0x%x"
-virtio_gpu_cmd_res_back_attach(uint32_t res) "res 0x%x"
-virtio_gpu_cmd_res_back_detach(uint32_t res) "res 0x%x"
-virtio_gpu_cmd_res_xfer_toh_2d(uint32_t res) "res 0x%x"
-virtio_gpu_cmd_res_xfer_toh_3d(uint32_t res) "res 0x%x"
-virtio_gpu_cmd_res_xfer_fromh_3d(uint32_t res) "res 0x%x"
-virtio_gpu_cmd_res_flush(uint32_t res, uint32_t w, uint32_t h, uint32_t x, uint32_t y) "res 0x%x, w %d, h %d, x %d, y %d"
-virtio_gpu_cmd_ctx_create(uint32_t ctx, const char *name) "ctx 0x%x, name %s"
-virtio_gpu_cmd_ctx_destroy(uint32_t ctx) "ctx 0x%x"
-virtio_gpu_cmd_ctx_res_attach(uint32_t ctx, uint32_t res) "ctx 0x%x, res 0x%x"
-virtio_gpu_cmd_ctx_res_detach(uint32_t ctx, uint32_t res) "ctx 0x%x, res 0x%x"
-virtio_gpu_cmd_ctx_submit(uint32_t ctx, uint32_t size) "ctx 0x%x, size %d"
-virtio_gpu_update_cursor(uint32_t scanout, uint32_t x, uint32_t y, const char *type, uint32_t res) "scanout %d, x %d, y %d, %s, res 0x%x"
-virtio_gpu_fence_ctrl(uint64_t fence, uint32_t type) "fence 0x%" PRIx64 ", type 0x%x"
-virtio_gpu_fence_resp(uint64_t fence) "fence 0x%" PRIx64
+virtio_gpu_cmd_set_scanout(uint32_t id, uint32_t res, uint32_t w, uint32_t h, uint32_t x, uint32_t y) "id %d, res %#x, w %d, h %d, x %d, y %d"
+virtio_gpu_cmd_res_create_2d(uint32_t res, uint32_t fmt, uint32_t w, uint32_t h) "res %#x, fmt %#x, w %d, h %d"
+virtio_gpu_cmd_res_create_3d(uint32_t res, uint32_t fmt, uint32_t w, uint32_t h, uint32_t d) "res %#x, fmt %#x, w %d, h %d, d %d"
+virtio_gpu_cmd_res_unref(uint32_t res) "res %#x"
+virtio_gpu_cmd_res_back_attach(uint32_t res) "res %#x"
+virtio_gpu_cmd_res_back_detach(uint32_t res) "res %#x"
+virtio_gpu_cmd_res_xfer_toh_2d(uint32_t res) "res %#x"
+virtio_gpu_cmd_res_xfer_toh_3d(uint32_t res) "res %#x"
+virtio_gpu_cmd_res_xfer_fromh_3d(uint32_t res) "res %#x"
+virtio_gpu_cmd_res_flush(uint32_t res, uint32_t w, uint32_t h, uint32_t x, uint32_t y) "res %#x, w %d, h %d, x %d, y %d"
+virtio_gpu_cmd_ctx_create(uint32_t ctx, const char *name) "ctx %#x, name %s"
+virtio_gpu_cmd_ctx_destroy(uint32_t ctx) "ctx %#x"
+virtio_gpu_cmd_ctx_res_attach(uint32_t ctx, uint32_t res) "ctx %#x, res %#x"
+virtio_gpu_cmd_ctx_res_detach(uint32_t ctx, uint32_t res) "ctx %#x, res %#x"
+virtio_gpu_cmd_ctx_submit(uint32_t ctx, uint32_t size) "ctx %#x, size %d"
+virtio_gpu_update_cursor(uint32_t scanout, uint32_t x, uint32_t y, const char *type, uint32_t res) "scanout %d, x %d, y %d, %s, res %#x"
+virtio_gpu_fence_ctrl(uint64_t fence, uint32_t type) "fence %#" PRIx64 ", type %#x"
+virtio_gpu_fence_resp(uint64_t fence) "fence %#" PRIx64
 
 # hw/display/qxl.c
 disable qxl_interface_set_mm_time(int qid, uint32_t mm_time) "%d %d"
 disable qxl_io_write_vga(int qid, const char *mode, uint32_t addr, uint32_t val) "%d %s addr=%u val=%u"
-qxl_create_guest_primary(int qid, uint32_t width, uint32_t height, uint64_t mem, uint32_t format, uint32_t position) "%d %ux%u mem=%" PRIx64 " %u,%u"
+qxl_create_guest_primary(int qid, uint32_t width, uint32_t height, uint64_t mem, uint32_t format, uint32_t position) "%d %ux%u mem=%#" PRIx64 " %u,%u"
 qxl_create_guest_primary_rest(int qid, int32_t stride, uint32_t type, uint32_t flags) "%d %d,%d,%d"
 qxl_destroy_primary(int qid) "%d"
 qxl_enter_vga_mode(int qid) "%d"
@@ -73,9 +73,9 @@ qxl_interface_update_area_complete_schedule_bh(int qid, uint32_t num_dirty) "%d
 qxl_io_destroy_primary_ignored(int qid, const char *mode) "%d %s"
 qxl_io_log(int qid, const uint8_t *log_buf) "%d %s"
 qxl_io_read_unexpected(int qid) "%d"
-qxl_io_unexpected_vga_mode(int qid, uint64_t addr, uint64_t val, const char *desc) "%d 0x%"PRIx64"=%"PRIu64" (%s)"
+qxl_io_unexpected_vga_mode(int qid, uint64_t addr, uint64_t val, const char *desc) "%d %#"PRIx64"=%"PRIu64" (%s)"
 qxl_io_write(int qid, const char *mode, uint64_t addr, const char *aname, uint64_t val, unsigned size, int async) "%d %s addr=%"PRIu64 " (%s) val=%"PRIu64" size=%u async=%d"
-qxl_memslot_add_guest(int qid, uint32_t slot_id, uint64_t guest_start, uint64_t guest_end) "%d %u: guest phys 0x%"PRIx64 " - 0x%" PRIx64
+qxl_memslot_add_guest(int qid, uint32_t slot_id, uint64_t guest_start, uint64_t guest_end) "%d %u: guest phys %#"PRIx64 " - %#" PRIx64
 qxl_post_load(int qid, const char *mode) "%d %s"
 qxl_pre_load(int qid) "%d"
 qxl_pre_save(int qid) "%d"
@@ -89,7 +89,7 @@ qxl_ring_cursor_req_notification(int qid) "%d"
 qxl_ring_res_push(int qid, const char *mode, uint32_t surface_count, uint32_t free_res, void *last_release, const char *notify) "%d %s s#=%d res#=%d last=%p notify=%s"
 qxl_ring_res_push_rest(int qid, uint32_t ring_has, uint32_t ring_size, uint32_t prod, uint32_t cons) "%d ring %d/%d [%d,%d]"
 qxl_ring_res_put(int qid, uint32_t free_res) "%d #res=%d"
-qxl_set_mode(int qid, int modenr, uint32_t x_res, uint32_t y_res, uint32_t bits, uint64_t devmem) "%d mode=%d [ x=%d y=%d @ bpp=%d devmem=0x%" PRIx64 " ]"
+qxl_set_mode(int qid, int modenr, uint32_t x_res, uint32_t y_res, uint32_t bits, uint64_t devmem) "%d mode=%d [ x=%d y=%d @ bpp=%d devmem=%#" PRIx64 " ]"
 qxl_soft_reset(int qid) "%d"
 qxl_spice_destroy_surfaces_complete(int qid) "%d"
 qxl_spice_destroy_surfaces(int qid, int async) "%d async=%d"
@@ -104,12 +104,12 @@ qxl_spice_reset_image_cache(int qid) "%d"
 qxl_spice_reset_memslots(int qid) "%d"
 qxl_spice_update_area(int qid, uint32_t surface_id, uint32_t left, uint32_t right, uint32_t top, uint32_t bottom) "%d sid=%d [%d,%d,%d,%d]"
 qxl_spice_update_area_rest(int qid, uint32_t num_dirty_rects, uint32_t clear_dirty_region) "%d #d=%d clear=%d"
-qxl_surfaces_dirty(int qid, uint64_t offset, uint64_t size) "%d offset=0x%"PRIx64" size=0x%"PRIx64
+qxl_surfaces_dirty(int qid, uint64_t offset, uint64_t size) "%d offset=%#"PRIx64" size=%#"PRIx64
 qxl_send_events(int qid, uint32_t events) "%d %d"
 qxl_send_events_vm_stopped(int qid, uint32_t events) "%d %d"
 qxl_set_guest_bug(int qid) "%d"
 qxl_interrupt_client_monitors_config(int qid, int num_heads, void *heads) "%d %d %p"
-qxl_client_monitors_config_unsupported_by_guest(int qid, uint32_t int_mask, void *client_monitors_config) "%d %X %p"
+qxl_client_monitors_config_unsupported_by_guest(int qid, uint32_t int_mask, void *client_monitors_config) "%d %#X %p"
 qxl_client_monitors_config_unsupported_by_device(int qid, int revision) "%d revision=%d"
 qxl_client_monitors_config_capped(int qid, int requested, int limit) "%d %d %d"
 qxl_client_monitors_config_crc(int qid, unsigned size, uint32_t crc32) "%d %u %u"
@@ -121,13 +121,13 @@ qxl_render_guest_primary_resized(int32_t width, int32_t height, int32_t stride,
 qxl_render_update_area_done(void *cookie) "%p"
 
 # hw/display/vga.c
-vga_std_read_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
-vga_std_write_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
-vga_vbe_read(uint32_t index, uint32_t val) "index 0x%x, val 0x%x"
-vga_vbe_write(uint32_t index, uint32_t val) "index 0x%x, val 0x%x"
+vga_std_read_io(uint32_t addr, uint32_t val) "addr %#x, val %#x"
+vga_std_write_io(uint32_t addr, uint32_t val) "addr %#x, val %#x"
+vga_vbe_read(uint32_t index, uint32_t val) "index %#x, val %#x"
+vga_vbe_write(uint32_t index, uint32_t val) "index %#x, val %#x"
 
 # hw/display/cirrus_vga.c
-vga_cirrus_read_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
-vga_cirrus_write_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
-vga_cirrus_read_blt(uint32_t offset, uint32_t val) "offset 0x%x, val 0x%x"
-vga_cirrus_write_blt(uint32_t offset, uint32_t val) "offset 0x%x, val 0x%x"
+vga_cirrus_read_io(uint32_t addr, uint32_t val) "addr %#x, val %#x"
+vga_cirrus_write_io(uint32_t addr, uint32_t val) "addr %#x, val %#x"
+vga_cirrus_read_blt(uint32_t offset, uint32_t val) "offset %#x, val %#x"
+vga_cirrus_write_blt(uint32_t offset, uint32_t val) "offset %#x, val %#x"
diff --git a/hw/dma/trace-events b/hw/dma/trace-events
index 22878dfdb6..d8b883e6ce 100644
--- a/hw/dma/trace-events
+++ b/hw/dma/trace-events
@@ -1,32 +1,32 @@
 # See docs/tracing.txt for syntax documentation.
 
 # hw/dma/rc4030.c
-jazzio_read(uint64_t addr, uint32_t ret) "read reg[0x%"PRIx64"] = 0x%x"
-jazzio_write(uint64_t addr, uint32_t val) "write reg[0x%"PRIx64"] = 0x%x"
-rc4030_read(uint64_t addr, uint32_t ret) "read reg[0x%"PRIx64"] = 0x%x"
-rc4030_write(uint64_t addr, uint32_t val) "write reg[0x%"PRIx64"] = 0x%x"
+jazzio_read(uint64_t addr, uint32_t ret) "read reg[%#"PRIx64"] = %#x"
+jazzio_write(uint64_t addr, uint32_t val) "write reg[%#"PRIx64"] = %#x"
+rc4030_read(uint64_t addr, uint32_t ret) "read reg[%#"PRIx64"] = %#x"
+rc4030_write(uint64_t addr, uint32_t val) "write reg[%#"PRIx64"] = %#x"
 
 # hw/dma/sparc32_dma.c
-ledma_memory_read(uint64_t addr) "DMA read addr 0x%"PRIx64
-ledma_memory_write(uint64_t addr) "DMA write addr 0x%"PRIx64
+ledma_memory_read(uint64_t addr) "DMA read addr %#"PRIx64
+ledma_memory_write(uint64_t addr) "DMA write addr %#"PRIx64
 sparc32_dma_set_irq_raise(void) "Raise IRQ"
 sparc32_dma_set_irq_lower(void) "Lower IRQ"
-espdma_memory_read(uint32_t addr) "DMA read addr 0x%08x"
-espdma_memory_write(uint32_t addr) "DMA write addr 0x%08x"
-sparc32_dma_mem_readl(uint64_t addr, uint32_t ret) "read dmareg %"PRIx64": 0x%08x"
-sparc32_dma_mem_writel(uint64_t addr, uint32_t old, uint32_t val) "write dmareg %"PRIx64": 0x%08x -> 0x%08x"
+espdma_memory_read(uint32_t addr) "DMA read addr %#08x"
+espdma_memory_write(uint32_t addr) "DMA write addr %#08x"
+sparc32_dma_mem_readl(uint64_t addr, uint32_t ret) "read dmareg %#"PRIx64": %#08x"
+sparc32_dma_mem_writel(uint64_t addr, uint32_t old, uint32_t val) "write dmareg %#"PRIx64": %#08x -> %#08x"
 sparc32_dma_enable_raise(void) "Raise DMA enable"
 sparc32_dma_enable_lower(void) "Lower DMA enable"
 
 # hw/dma/sun4m_iommu.c
-sun4m_iommu_mem_readl(uint64_t addr, uint32_t ret) "read reg[%"PRIx64"] = %x"
-sun4m_iommu_mem_writel(uint64_t addr, uint32_t val) "write reg[%"PRIx64"] = %x"
-sun4m_iommu_mem_writel_ctrl(uint64_t iostart) "iostart = %"PRIx64
-sun4m_iommu_mem_writel_tlbflush(uint32_t val) "tlb flush %x"
-sun4m_iommu_mem_writel_pgflush(uint32_t val) "page flush %x"
-sun4m_iommu_page_get_flags(uint64_t pa, uint64_t iopte, uint32_t ret) "get flags addr %"PRIx64" => pte %"PRIx64", *pte = %x"
-sun4m_iommu_translate_pa(uint64_t addr, uint64_t pa, uint32_t iopte) "xlate dva %"PRIx64" => pa %"PRIx64" iopte = %x"
-sun4m_iommu_bad_addr(uint64_t addr) "bad addr %"PRIx64
+sun4m_iommu_mem_readl(uint64_t addr, uint32_t ret) "read reg[%#"PRIx64"] = %#x"
+sun4m_iommu_mem_writel(uint64_t addr, uint32_t val) "write reg[%#"PRIx64"] = %#x"
+sun4m_iommu_mem_writel_ctrl(uint64_t iostart) "iostart = %#"PRIx64
+sun4m_iommu_mem_writel_tlbflush(uint32_t val) "tlb flush %#x"
+sun4m_iommu_mem_writel_pgflush(uint32_t val) "page flush %#x"
+sun4m_iommu_page_get_flags(uint64_t pa, uint64_t iopte, uint32_t ret) "get flags addr %#"PRIx64" => pte %#"PRIx64", *pte = %#x"
+sun4m_iommu_translate_pa(uint64_t addr, uint64_t pa, uint32_t iopte) "xlate dva %#"PRIx64" => pa %#"PRIx64" iopte = %#x"
+sun4m_iommu_bad_addr(uint64_t addr) "bad addr %#"PRIx64
 
 # hw/dma/i8257.c
 i8257_unregistered_dma(int nchan, int dma_pos, int dma_len) "unregistered DMA channel used nchan=%d dma_pos=%d dma_len=%d"
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 42d8a7e27a..2479a0000f 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -4,112 +4,112 @@
 x86_iommu_iec_notify(bool global, uint32_t index, uint32_t mask) "Notify IEC invalidation: global=%d index=%" PRIu32 " mask=%" PRIu32
 
 # hw/i386/intel_iommu.c
-vtd_inv_desc(const char *type, uint64_t hi, uint64_t lo) "invalidate desc type %s high 0x%"PRIx64" low 0x%"PRIx64
-vtd_inv_desc_invalid(uint64_t hi, uint64_t lo) "invalid inv desc hi 0x%"PRIx64" lo 0x%"PRIx64
-vtd_inv_desc_cc_domain(uint16_t domain) "context invalidate domain 0x%"PRIx16
+vtd_inv_desc(const char *type, uint64_t hi, uint64_t lo) "invalidate desc type %s high %#"PRIx64" low %#"PRIx64
+vtd_inv_desc_invalid(uint64_t hi, uint64_t lo) "invalid inv desc hi %#"PRIx64" lo %#"PRIx64
+vtd_inv_desc_cc_domain(uint16_t domain) "context invalidate domain %#"PRIx16
 vtd_inv_desc_cc_global(void) "context invalidate globally"
-vtd_inv_desc_cc_device(uint8_t bus, uint8_t dev, uint8_t fn) "context invalidate device %02"PRIx8":%02"PRIx8".%02"PRIx8
-vtd_inv_desc_cc_devices(uint16_t sid, uint16_t fmask) "context invalidate devices sid 0x%"PRIx16" fmask 0x%"PRIx16
-vtd_inv_desc_cc_invalid(uint64_t hi, uint64_t lo) "invalid context-cache desc hi 0x%"PRIx64" lo 0x%"PRIx64
+vtd_inv_desc_cc_device(uint8_t bus, uint8_t dev, uint8_t fn) "context invalidate device %#02"PRIx8":%#02"PRIx8".%#02"PRIx8
+vtd_inv_desc_cc_devices(uint16_t sid, uint16_t fmask) "context invalidate devices sid %#"PRIx16" fmask %#"PRIx16
+vtd_inv_desc_cc_invalid(uint64_t hi, uint64_t lo) "invalid context-cache desc hi %#"PRIx64" lo %#"PRIx64
 vtd_inv_desc_iotlb_global(void) "iotlb invalidate global"
-vtd_inv_desc_iotlb_domain(uint16_t domain) "iotlb invalidate whole domain 0x%"PRIx16
-vtd_inv_desc_iotlb_pages(uint16_t domain, uint64_t addr, uint8_t mask) "iotlb invalidate domain 0x%"PRIx16" addr 0x%"PRIx64" mask 0x%"PRIx8
-vtd_inv_desc_iotlb_invalid(uint64_t hi, uint64_t lo) "invalid iotlb desc hi 0x%"PRIx64" lo 0x%"PRIx64
-vtd_inv_desc_wait_sw(uint64_t addr, uint32_t data) "wait invalidate status write addr 0x%"PRIx64" data 0x%"PRIx32
+vtd_inv_desc_iotlb_domain(uint16_t domain) "iotlb invalidate whole domain %#"PRIx16
+vtd_inv_desc_iotlb_pages(uint16_t domain, uint64_t addr, uint8_t mask) "iotlb invalidate domain %#"PRIx16" addr %#"PRIx64" mask %#"PRIx8
+vtd_inv_desc_iotlb_invalid(uint64_t hi, uint64_t lo) "invalid iotlb desc hi %#"PRIx64" lo %#"PRIx64
+vtd_inv_desc_wait_sw(uint64_t addr, uint32_t data) "wait invalidate status write addr %#"PRIx64" data %#"PRIx32
 vtd_inv_desc_wait_irq(const char *msg) "%s"
-vtd_inv_desc_wait_invalid(uint64_t hi, uint64_t lo) "invalid wait desc hi 0x%"PRIx64" lo 0x%"PRIx64
-vtd_inv_desc_wait_write_fail(uint64_t hi, uint64_t lo) "write fail for wait desc hi 0x%"PRIx64" lo 0x%"PRIx64
-vtd_inv_desc_iec(uint32_t granularity, uint32_t index, uint32_t mask) "granularity 0x%"PRIx32" index 0x%"PRIx32" mask 0x%"PRIx32
+vtd_inv_desc_wait_invalid(uint64_t hi, uint64_t lo) "invalid wait desc hi %#"PRIx64" lo %#"PRIx64
+vtd_inv_desc_wait_write_fail(uint64_t hi, uint64_t lo) "write fail for wait desc hi %#"PRIx64" lo %#"PRIx64
+vtd_inv_desc_iec(uint32_t granularity, uint32_t index, uint32_t mask) "granularity %#"PRIx32" index %#"PRIx32" mask %#"PRIx32
 vtd_inv_qi_enable(bool enable) "enabled %d"
-vtd_inv_qi_setup(uint64_t addr, int size) "addr 0x%"PRIx64" size %d"
+vtd_inv_qi_setup(uint64_t addr, int size) "addr %#"PRIx64" size %d"
 vtd_inv_qi_head(uint16_t head) "read head %d"
 vtd_inv_qi_tail(uint16_t head) "write tail %d"
 vtd_inv_qi_fetch(void) ""
 vtd_context_cache_reset(void) ""
 vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
-vtd_re_invalid(uint64_t hi, uint64_t lo) "invalid root entry hi 0x%"PRIx64" lo 0x%"PRIx64
+vtd_re_invalid(uint64_t hi, uint64_t lo) "invalid root entry hi %#"PRIx64" lo %#"PRIx64
 vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu8" devfn %"PRIu8" not present"
-vtd_ce_invalid(uint64_t hi, uint64_t lo) "invalid context entry hi 0x%"PRIx64" lo 0x%"PRIx64
-vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page hit sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
-vtd_iotlb_page_update(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page update sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
-vtd_iotlb_cc_hit(uint8_t bus, uint8_t devfn, uint64_t high, uint64_t low, uint32_t gen) "IOTLB context hit bus 0x%"PRIx8" devfn 0x%"PRIx8" high 0x%"PRIx64" low 0x%"PRIx64" gen %"PRIu32
-vtd_iotlb_cc_update(uint8_t bus, uint8_t devfn, uint64_t high, uint64_t low, uint32_t gen1, uint32_t gen2) "IOTLB context update bus 0x%"PRIx8" devfn 0x%"PRIx8" high 0x%"PRIx64" low 0x%"PRIx64" gen %"PRIu32" -> gen %"PRIu32
+vtd_ce_invalid(uint64_t hi, uint64_t lo) "invalid context entry hi %#"PRIx64" lo %#"PRIx64
+vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page hit sid %#"PRIx16" iova %#"PRIx64" slpte %#"PRIx64" domain %#"PRIx16
+vtd_iotlb_page_update(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page update sid %#"PRIx16" iova %#"PRIx64" slpte %#"PRIx64" domain %#"PRIx16
+vtd_iotlb_cc_hit(uint8_t bus, uint8_t devfn, uint64_t high, uint64_t low, uint32_t gen) "IOTLB context hit bus %#"PRIx8" devfn %#"PRIx8" high %#"PRIx64" low %#"PRIx64" gen %"PRIu32
+vtd_iotlb_cc_update(uint8_t bus, uint8_t devfn, uint64_t high, uint64_t low, uint32_t gen1, uint32_t gen2) "IOTLB context update bus %#"PRIx8" devfn %#"PRIx8" high %#"PRIx64" low %#"PRIx64" gen %"PRIu32" -> gen %"PRIu32
 vtd_iotlb_reset(const char *reason) "IOTLB reset (reason: %s)"
 vtd_fault_disabled(void) "Fault processing disabled for context entry"
-vtd_replay_ce_valid(uint8_t bus, uint8_t dev, uint8_t fn, uint16_t domain, uint64_t hi, uint64_t lo) "replay valid context device %02"PRIx8":%02"PRIx8".%02"PRIx8" domain 0x%"PRIx16" hi 0x%"PRIx64" lo 0x%"PRIx64
-vtd_replay_ce_invalid(uint8_t bus, uint8_t dev, uint8_t fn) "replay invalid context device %02"PRIx8":%02"PRIx8".%02"PRIx8
-vtd_page_walk_level(uint64_t addr, uint32_t level, uint64_t start, uint64_t end) "walk (base=0x%"PRIx64", level=%"PRIu32") iova range 0x%"PRIx64" - 0x%"PRIx64
-vtd_page_walk_one(uint32_t level, uint64_t iova, uint64_t gpa, uint64_t mask, int perm) "detected page level 0x%"PRIx32" iova 0x%"PRIx64" -> gpa 0x%"PRIx64" mask 0x%"PRIx64" perm %d"
-vtd_page_walk_skip_read(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to unable to read"
-vtd_page_walk_skip_perm(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to perm empty"
-vtd_page_walk_skip_reserve(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to rsrv set"
-vtd_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, bool on) "Device %02x:%02x.%x switching address space (iommu enabled=%d)"
-vtd_as_unmap_whole(uint8_t bus, uint8_t slot, uint8_t fn, uint64_t iova, uint64_t size) "Device %02x:%02x.%x start 0x%"PRIx64" size 0x%"PRIx64
-vtd_translate_pt(uint16_t sid, uint64_t addr) "source id 0x%"PRIu16", iova 0x%"PRIx64
+vtd_replay_ce_valid(uint8_t bus, uint8_t dev, uint8_t fn, uint16_t domain, uint64_t hi, uint64_t lo) "replay valid context device %#02"PRIx8":%#02"PRIx8".%#02"PRIx8" domain %#"PRIx16" hi %#"PRIx64" lo %#"PRIx64
+vtd_replay_ce_invalid(uint8_t bus, uint8_t dev, uint8_t fn) "replay invalid context device %#02"PRIx8":%#02"PRIx8".%#02"PRIx8
+vtd_page_walk_level(uint64_t addr, uint32_t level, uint64_t start, uint64_t end) "walk (base=%#"PRIx64", level=%"PRIu32") iova range %#"PRIx64" - %#"PRIx64
+vtd_page_walk_one(uint32_t level, uint64_t iova, uint64_t gpa, uint64_t mask, int perm) "detected page level %#"PRIx32" iova %#"PRIx64" -> gpa %#"PRIx64" mask %#"PRIx64" perm %d"
+vtd_page_walk_skip_read(uint64_t iova, uint64_t next) "Page walk skip iova %#"PRIx64" - %#"PRIx64" due to unable to read"
+vtd_page_walk_skip_perm(uint64_t iova, uint64_t next) "Page walk skip iova %#"PRIx64" - %#"PRIx64" due to perm empty"
+vtd_page_walk_skip_reserve(uint64_t iova, uint64_t next) "Page walk skip iova %#"PRIx64" - %#"PRIx64" due to rsrv set"
+vtd_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, bool on) "Device %#02x:%#02x.%#x switching address space (iommu enabled=%d)"
+vtd_as_unmap_whole(uint8_t bus, uint8_t slot, uint8_t fn, uint64_t iova, uint64_t size) "Device %#02x:%#02x.%#x start %#"PRIx64" size %#"PRIx64
+vtd_translate_pt(uint16_t sid, uint64_t addr) "source id 0x%"PRIu16", iova %#"PRIx64
 vtd_pt_enable_fast_path(uint16_t sid, bool success) "sid 0x%"PRIu16" %d"
-vtd_irq_generate(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" data 0x%"PRIx64
-vtd_reg_read(uint64_t addr, uint64_t size) "addr 0x%"PRIx64" size 0x%"PRIx64
-vtd_reg_write(uint64_t addr, uint64_t size, uint64_t val) "addr 0x%"PRIx64" size 0x%"PRIx64" value 0x%"PRIx64
-vtd_reg_dmar_root(uint64_t addr, bool extended) "addr 0x%"PRIx64" extended %d"
-vtd_reg_ir_root(uint64_t addr, uint32_t size) "addr 0x%"PRIx64" size 0x%"PRIx32
-vtd_reg_write_gcmd(uint32_t status, uint32_t val) "status 0x%"PRIx32" value 0x%"PRIx32
-vtd_reg_write_fectl(uint32_t value) "value 0x%"PRIx32
-vtd_reg_write_iectl(uint32_t value) "value 0x%"PRIx32
+vtd_irq_generate(uint64_t addr, uint64_t data) "addr %#"PRIx64" data %#"PRIx64
+vtd_reg_read(uint64_t addr, uint64_t size) "addr %#"PRIx64" size %#"PRIx64
+vtd_reg_write(uint64_t addr, uint64_t size, uint64_t val) "addr %#"PRIx64" size %#"PRIx64" value %#"PRIx64
+vtd_reg_dmar_root(uint64_t addr, bool extended) "addr %#"PRIx64" extended %d"
+vtd_reg_ir_root(uint64_t addr, uint32_t size) "addr %#"PRIx64" size %#"PRIx32
+vtd_reg_write_gcmd(uint32_t status, uint32_t val) "status %#"PRIx32" value %#"PRIx32
+vtd_reg_write_fectl(uint32_t value) "value %#"PRIx32
+vtd_reg_write_iectl(uint32_t value) "value %#"PRIx32
 vtd_reg_ics_clear_ip(void) ""
-vtd_dmar_translate(uint8_t bus, uint8_t slot, uint8_t func, uint64_t iova, uint64_t gpa, uint64_t mask) "dev %02x:%02x.%02x iova 0x%"PRIx64" -> gpa 0x%"PRIx64" mask 0x%"PRIx64
+vtd_dmar_translate(uint8_t bus, uint8_t slot, uint8_t func, uint64_t iova, uint64_t gpa, uint64_t mask) "dev %#02x:%#02x.%#02x iova %#"PRIx64" -> gpa %#"PRIx64" mask %#"PRIx64
 vtd_dmar_enable(bool en) "enable %d"
-vtd_dmar_fault(uint16_t sid, int fault, uint64_t addr, bool is_write) "sid 0x%"PRIx16" fault %d addr 0x%"PRIx64" write %d"
+vtd_dmar_fault(uint16_t sid, int fault, uint64_t addr, bool is_write) "sid %#"PRIx16" fault %d addr %#"PRIx64" write %d"
 vtd_ir_enable(bool en) "enable %d"
-vtd_ir_irte_get(int index, uint64_t lo, uint64_t hi) "index %d low 0x%"PRIx64" high 0x%"PRIx64
-vtd_ir_remap(int index, int tri, int vec, int deliver, uint32_t dest, int dest_mode) "index %d trigger %d vector %d deliver %d dest 0x%"PRIx32" mode %d"
+vtd_ir_irte_get(int index, uint64_t lo, uint64_t hi) "index %d low %#"PRIx64" high %#"PRIx64
+vtd_ir_remap(int index, int tri, int vec, int deliver, uint32_t dest, int dest_mode) "index %d trigger %d vector %d deliver %d dest %#"PRIx32" mode %d"
 vtd_ir_remap_type(const char *type) "%s"
-vtd_ir_remap_msi(uint64_t addr, uint64_t data, uint64_t addr2, uint64_t data2) "(addr 0x%"PRIx64", data 0x%"PRIx64") -> (addr 0x%"PRIx64", data 0x%"PRIx64")"
-vtd_ir_remap_msi_req(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" data 0x%"PRIx64
+vtd_ir_remap_msi(uint64_t addr, uint64_t data, uint64_t addr2, uint64_t data2) "(addr %#"PRIx64", data %#"PRIx64") -> (addr %#"PRIx64", data %#"PRIx64")"
+vtd_ir_remap_msi_req(uint64_t addr, uint64_t data) "addr %#"PRIx64" data %#"PRIx64
 vtd_fsts_ppf(bool set) "FSTS PPF bit set to %d"
 vtd_fsts_clear_ip(void) ""
-vtd_frr_new(int index, uint64_t hi, uint64_t lo) "index %d high 0x%"PRIx64" low 0x%"PRIx64
+vtd_frr_new(int index, uint64_t hi, uint64_t lo) "index %d high %#"PRIx64" low %#"PRIx64
 vtd_err(const char *str) "%s"
-vtd_err_dmar_iova_overflow(uint64_t iova) "iova 0x%"PRIx64
-vtd_err_dmar_slpte_read_error(uint64_t iova, int level) "iova 0x%"PRIx64" level %d"
-vtd_err_dmar_slpte_perm_error(uint64_t iova, int level, uint64_t slpte, bool is_write) "iova 0x%"PRIx64" level %d slpte 0x%"PRIx64" write %d"
-vtd_err_dmar_slpte_resv_error(uint64_t iova, int level, uint64_t slpte) "iova 0x%"PRIx64" level %d slpte 0x%"PRIx64
-vtd_err_dmar_translate(uint8_t bus, uint8_t slot, uint8_t func, uint64_t iova) "dev %02x:%02x.%02x iova 0x%"PRIx64
-vtd_warn_invalid_qi_tail(uint16_t tail) "tail 0x%"PRIx16
-vtd_err_qi_disable(uint16_t head, uint16_t tail, int type) "head 0x%"PRIx16" tail 0x%"PRIx16" last_desc_type %d"
-vtd_err_qi_tail(uint16_t tail, uint16_t size) "tail 0x%"PRIx16" size 0x%"PRIx16
-vtd_err_irte(int index, uint64_t lo, uint64_t hi) "index %d low 0x%"PRIx64" high 0x%"PRIx64
-vtd_err_irte_sid(int index, uint16_t req, uint16_t target) "index %d SVT_ALL sid 0x%"PRIx16" (should be: 0x%"PRIx16")"
-vtd_err_irte_sid_bus(int index, uint8_t bus, uint8_t min, uint8_t max) "index %d SVT_BUS bus 0x%"PRIx8" (should be: 0x%"PRIx8"-0x%"PRIx8")"
+vtd_err_dmar_iova_overflow(uint64_t iova) "iova %#"PRIx64
+vtd_err_dmar_slpte_read_error(uint64_t iova, int level) "iova %#"PRIx64" level %d"
+vtd_err_dmar_slpte_perm_error(uint64_t iova, int level, uint64_t slpte, bool is_write) "iova %#"PRIx64" level %d slpte %#"PRIx64" write %d"
+vtd_err_dmar_slpte_resv_error(uint64_t iova, int level, uint64_t slpte) "iova %#"PRIx64" level %d slpte %#"PRIx64
+vtd_err_dmar_translate(uint8_t bus, uint8_t slot, uint8_t func, uint64_t iova) "dev %#02x:%#02x.%#02x iova %#"PRIx64
+vtd_warn_invalid_qi_tail(uint16_t tail) "tail %#"PRIx16
+vtd_err_qi_disable(uint16_t head, uint16_t tail, int type) "head %#"PRIx16" tail %#"PRIx16" last_desc_type %d"
+vtd_err_qi_tail(uint16_t tail, uint16_t size) "tail %#"PRIx16" size %#"PRIx16
+vtd_err_irte(int index, uint64_t lo, uint64_t hi) "index %d low %#"PRIx64" high %#"PRIx64
+vtd_err_irte_sid(int index, uint16_t req, uint16_t target) "index %d SVT_ALL sid %#"PRIx16" (should be: %#"PRIx16")"
+vtd_err_irte_sid_bus(int index, uint8_t bus, uint8_t min, uint8_t max) "index %d SVT_BUS bus %#"PRIx8" (should be: %#"PRIx8"-%#"PRIx8")"
 vtd_err_irte_svt(int index, int type) "index %d SVT type %d"
-vtd_err_ir_msi_invalid(uint16_t sid, uint64_t addr, uint64_t data) "sid 0x%"PRIx16" addr 0x%"PRIx64" data 0x%"PRIx64
-vtd_warn_ir_vector(uint16_t sid, int index, int vec, int target) "sid 0x%"PRIx16" index %d vec %d (should be: %d)"
-vtd_warn_ir_trigger(uint16_t sid, int index, int trig, int target) "sid 0x%"PRIx16" index %d trigger %d (should be: %d)"
+vtd_err_ir_msi_invalid(uint16_t sid, uint64_t addr, uint64_t data) "sid %#"PRIx16" addr %#"PRIx64" data %#"PRIx64
+vtd_warn_ir_vector(uint16_t sid, int index, int vec, int target) "sid %#"PRIx16" index %d vec %d (should be: %d)"
+vtd_warn_ir_trigger(uint16_t sid, int index, int trig, int target) "sid %#"PRIx16" index %d trigger %d (should be: %d)"
 
 # hw/i386/amd_iommu.c
-amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32
-amdvi_cache_update(uint16_t domid, uint8_t bus, uint8_t slot, uint8_t func, uint64_t gpa, uint64_t txaddr) " update iotlb domid 0x%"PRIx16" devid: %02x:%02x.%x gpa 0x%"PRIx64" hpa 0x%"PRIx64
-amdvi_completion_wait_fail(uint64_t addr) "error: fail to write at address 0x%"PRIx64
-amdvi_mmio_write(const char *reg, uint64_t addr, unsigned size, uint64_t val, uint64_t offset) "%s write addr 0x%"PRIx64", size %u, val 0x%"PRIx64", offset 0x%"PRIx64
-amdvi_mmio_read(const char *reg, uint64_t addr, unsigned size, uint64_t offset) "%s read addr 0x%"PRIx64", size %u offset 0x%"PRIx64
-amdvi_mmio_read_invalid(int max, uint64_t addr, unsigned size) "error: addr outside region (max 0x%x): read addr 0x%" PRIx64 ", size %u"
-amdvi_command_error(uint64_t status) "error: Executing commands with command buffer disabled 0x%"PRIx64
-amdvi_command_read_fail(uint64_t addr, uint32_t head) "error: fail to access memory at 0x%"PRIx64" + 0x%"PRIx32
-amdvi_command_exec(uint32_t head, uint32_t tail, uint64_t buf) "command buffer head at 0x%"PRIx32" command buffer tail at 0x%"PRIx32" command buffer base at 0x%"PRIx64
-amdvi_unhandled_command(uint8_t type) "unhandled command 0x%"PRIx8
+amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr %#"PRIx64" +  offset %#"PRIx32
+amdvi_cache_update(uint16_t domid, uint8_t bus, uint8_t slot, uint8_t func, uint64_t gpa, uint64_t txaddr) " update iotlb domid %#"PRIx16" devid: %#02x:%#02x.%#x gpa %#"PRIx64" hpa %#"PRIx64
+amdvi_completion_wait_fail(uint64_t addr) "error: fail to write at address %#"PRIx64
+amdvi_mmio_write(const char *reg, uint64_t addr, unsigned size, uint64_t val, uint64_t offset) "%s write addr %#"PRIx64", size %u, val %#"PRIx64", offset %#"PRIx64
+amdvi_mmio_read(const char *reg, uint64_t addr, unsigned size, uint64_t offset) "%s read addr %#"PRIx64", size %u offset %#"PRIx64
+amdvi_mmio_read_invalid(int max, uint64_t addr, unsigned size) "error: addr outside region (max %#x): read addr %#" PRIx64 ", size %u"
+amdvi_command_error(uint64_t status) "error: Executing commands with command buffer disabled %#"PRIx64
+amdvi_command_read_fail(uint64_t addr, uint32_t head) "error: fail to access memory at %#"PRIx64" + %#"PRIx32
+amdvi_command_exec(uint32_t head, uint32_t tail, uint64_t buf) "command buffer head at %#"PRIx32" command buffer tail at %#"PRIx32" command buffer base at %#"PRIx64
+amdvi_unhandled_command(uint8_t type) "unhandled command %#"PRIx8
 amdvi_intr_inval(void) "Interrupt table invalidated"
 amdvi_iotlb_inval(void) "IOTLB pages invalidated"
 amdvi_prefetch_pages(void) "Pre-fetch of AMD-Vi pages requested"
-amdvi_pages_inval(uint16_t domid) "AMD-Vi pages for domain 0x%"PRIx16 " invalidated"
+amdvi_pages_inval(uint16_t domid) "AMD-Vi pages for domain %#"PRIx16 " invalidated"
 amdvi_all_inval(void) "Invalidation of all AMD-Vi cache requested "
 amdvi_ppr_exec(void) "Execution of PPR queue requested "
-amdvi_devtab_inval(uint8_t bus, uint8_t slot, uint8_t func) "device table entry for devid: %02x:%02x.%x invalidated"
-amdvi_completion_wait(uint64_t addr, uint64_t data) "completion wait requested with store address 0x%"PRIx64" and store data 0x%"PRIx64
-amdvi_control_status(uint64_t val) "MMIO_STATUS state 0x%"PRIx64
+amdvi_devtab_inval(uint8_t bus, uint8_t slot, uint8_t func) "device table entry for devid: %#02x:%#02x.%#x invalidated"
+amdvi_completion_wait(uint64_t addr, uint64_t data) "completion wait requested with store address %#"PRIx64" and store data %#"PRIx64
+amdvi_control_status(uint64_t val) "MMIO_STATUS state %#"PRIx64
 amdvi_iotlb_reset(void) "IOTLB exceed size limit - reset "
-amdvi_dte_get_fail(uint64_t addr, uint32_t offset) "error: failed to access Device Entry devtab 0x%"PRIx64" offset 0x%"PRIx32
-amdvi_invalid_dte(uint64_t addr) "PTE entry at 0x%"PRIx64" is invalid "
-amdvi_get_pte_hwerror(uint64_t addr) "hardware error eccessing PTE at addr 0x%"PRIx64
-amdvi_mode_invalid(uint8_t level, uint64_t addr)"error: translation level 0x%"PRIx8" translating addr 0x%"PRIx64
-amdvi_page_fault(uint64_t addr) "error: page fault accessing guest physical address 0x%"PRIx64
-amdvi_iotlb_hit(uint8_t bus, uint8_t slot, uint8_t func, uint64_t addr, uint64_t txaddr) "hit iotlb devid %02x:%02x.%x gpa 0x%"PRIx64" hpa 0x%"PRIx64
-amdvi_translation_result(uint8_t bus, uint8_t slot, uint8_t func, uint64_t addr, uint64_t txaddr) "devid: %02x:%02x.%x gpa 0x%"PRIx64" hpa 0x%"PRIx64
+amdvi_dte_get_fail(uint64_t addr, uint32_t offset) "error: failed to access Device Entry devtab %#"PRIx64" offset %#"PRIx32
+amdvi_invalid_dte(uint64_t addr) "PTE entry at %#"PRIx64" is invalid "
+amdvi_get_pte_hwerror(uint64_t addr) "hardware error eccessing PTE at addr %#"PRIx64
+amdvi_mode_invalid(uint8_t level, uint64_t addr)"error: translation level %#"PRIx8" translating addr %#"PRIx64
+amdvi_page_fault(uint64_t addr) "error: page fault accessing guest physical address %#"PRIx64
+amdvi_iotlb_hit(uint8_t bus, uint8_t slot, uint8_t func, uint64_t addr, uint64_t txaddr) "hit iotlb devid %#02x:%#02x.%#x gpa %#"PRIx64" hpa %#"PRIx64
+amdvi_translation_result(uint8_t bus, uint8_t slot, uint8_t func, uint64_t addr, uint64_t txaddr) "devid: %#02x:%#02x.%#x gpa %#"PRIx64" hpa %#"PRIx64
diff --git a/hw/i386/xen/trace-events b/hw/i386/xen/trace-events
index 547438db13..4411600e04 100644
--- a/hw/i386/xen/trace-events
+++ b/hw/i386/xen/trace-events
@@ -2,8 +2,8 @@
 xen_platform_log(char *s) "xen platform: %s"
 
 # hw/i386/xen/xen_pvdevice.c
-xen_pv_mmio_read(uint64_t addr) "WARNING: read from Xen PV Device MMIO space (address %"PRIx64")"
-xen_pv_mmio_write(uint64_t addr) "WARNING: write to Xen PV Device MMIO space (address %"PRIx64")"
+xen_pv_mmio_read(uint64_t addr) "WARNING: read from Xen PV Device MMIO space (address %#"PRIx64")"
+xen_pv_mmio_write(uint64_t addr) "WARNING: write to Xen PV Device MMIO space (address %#"PRIx64")"
 
 # xen-hvm.c
 xen_ram_alloc(unsigned long ram_addr, unsigned long size) "requested: %#lx, size %#lx"
diff --git a/hw/input/trace-events b/hw/input/trace-events
index 5a87818b49..a2315dc17b 100644
--- a/hw/input/trace-events
+++ b/hw/input/trace-events
@@ -16,8 +16,8 @@ ps2_kbd_init(void *s) "%p"
 ps2_mouse_init(void *s) "%p"
 
 # hw/input/milkymist-softusb.c
-milkymist_softusb_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_softusb_memory_write(uint32_t addr, uint32_t value) "addr %08x value %08x"
+milkymist_softusb_memory_read(uint32_t addr, uint32_t value) "addr %#08x value %#08x"
+milkymist_softusb_memory_write(uint32_t addr, uint32_t value) "addr %#08x value %#08x"
 milkymist_softusb_mevt(uint8_t m) "m %d"
 milkymist_softusb_kevt(uint8_t m) "m %d"
 milkymist_softusb_pulse_irq(void) "Pulse IRQ"
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index c586714d89..bb9c4cb3ff 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -1,8 +1,8 @@
 # See docs/tracing.txt for syntax documentation.
 
 # hw/intc/apic_common.c
-cpu_set_apic_base(uint64_t val) "%016"PRIx64
-cpu_get_apic_base(uint64_t val) "%016"PRIx64
+cpu_set_apic_base(uint64_t val) "%#016"PRIx64
+cpu_get_apic_base(uint64_t val) "%#016"PRIx64
 # coalescing
 apic_report_irq_delivered(int apic_irq_delivered) "coalescing %d"
 apic_reset_irq_delivered(int apic_irq_delivered) "old coalescing %d"
@@ -11,45 +11,45 @@ apic_get_irq_delivered(int apic_irq_delivered) "returning coalescing %d"
 # hw/intc/apic.c
 apic_local_deliver(int vector, uint32_t lvt) "vector %d delivery mode %d"
 apic_deliver_irq(uint8_t dest, uint8_t dest_mode, uint8_t delivery_mode, uint8_t vector_num, uint8_t trigger_mode) "dest %d dest_mode %d delivery_mode %d vector %d trigger_mode %d"
-apic_mem_readl(uint64_t addr, uint32_t val)  "%"PRIx64" = %08x"
-apic_mem_writel(uint64_t addr, uint32_t val) "%"PRIx64" = %08x"
+apic_mem_readl(uint64_t addr, uint32_t val)  "%#"PRIx64" = %#08x"
+apic_mem_writel(uint64_t addr, uint32_t val) "%#"PRIx64" = %#08x"
 
 # hw/intc/ioapic.c
 ioapic_set_remote_irr(int n) "set remote irr for pin %d"
 ioapic_clear_remote_irr(int n, int vector) "clear remote irr for pin %d vector %d"
 ioapic_eoi_broadcast(int vector) "EOI broadcast for vector %d"
-ioapic_mem_read(uint8_t addr, uint8_t size, uint32_t val) "ioapic mem read addr 0x%"PRIx8" size 0x%"PRIx8" retval 0x%"PRIx32
-ioapic_mem_write(uint8_t addr, uint8_t size, uint32_t val) "ioapic mem write addr 0x%"PRIx8" size 0x%"PRIx8" val 0x%"PRIx32
+ioapic_mem_read(uint8_t addr, uint8_t size, uint32_t val) "ioapic mem read addr %#"PRIx8" size %#"PRIx8" retval %#"PRIx32
+ioapic_mem_write(uint8_t addr, uint8_t size, uint32_t val) "ioapic mem write addr %#"PRIx8" size %#"PRIx8" val %#"PRIx32
 
 # hw/intc/slavio_intctl.c
-slavio_intctl_mem_readl(uint32_t cpu, uint64_t addr, uint32_t ret) "read cpu %d reg 0x%"PRIx64" = %x"
-slavio_intctl_mem_writel(uint32_t cpu, uint64_t addr, uint32_t val) "write cpu %d reg 0x%"PRIx64" = %x"
-slavio_intctl_mem_writel_clear(uint32_t cpu, uint32_t val, uint32_t intreg_pending) "Cleared cpu %d irq mask %x, curmask %x"
-slavio_intctl_mem_writel_set(uint32_t cpu, uint32_t val, uint32_t intreg_pending) "Set cpu %d irq mask %x, curmask %x"
-slavio_intctlm_mem_readl(uint64_t addr, uint32_t ret) "read system reg 0x%"PRIx64" = %x"
-slavio_intctlm_mem_writel(uint64_t addr, uint32_t val) "write system reg 0x%"PRIx64" = %x"
-slavio_intctlm_mem_writel_enable(uint32_t val, uint32_t intregm_disabled) "Enabled master irq mask %x, curmask %x"
-slavio_intctlm_mem_writel_disable(uint32_t val, uint32_t intregm_disabled) "Disabled master irq mask %x, curmask %x"
+slavio_intctl_mem_readl(uint32_t cpu, uint64_t addr, uint32_t ret) "read cpu %d reg %#"PRIx64" = %#x"
+slavio_intctl_mem_writel(uint32_t cpu, uint64_t addr, uint32_t val) "write cpu %d reg %#"PRIx64" = %#x"
+slavio_intctl_mem_writel_clear(uint32_t cpu, uint32_t val, uint32_t intreg_pending) "Cleared cpu %d irq mask %#x, curmask %#x"
+slavio_intctl_mem_writel_set(uint32_t cpu, uint32_t val, uint32_t intreg_pending) "Set cpu %d irq mask %#x, curmask %#x"
+slavio_intctlm_mem_readl(uint64_t addr, uint32_t ret) "read system reg %#"PRIx64" = %#x"
+slavio_intctlm_mem_writel(uint64_t addr, uint32_t val) "write system reg %#"PRIx64" = %#x"
+slavio_intctlm_mem_writel_enable(uint32_t val, uint32_t intregm_disabled) "Enabled master irq mask %#x, curmask %#x"
+slavio_intctlm_mem_writel_disable(uint32_t val, uint32_t intregm_disabled) "Disabled master irq mask %#x, curmask %#x"
 slavio_intctlm_mem_writel_target(uint32_t cpu) "Set master irq cpu %d"
-slavio_check_interrupts(uint32_t pending, uint32_t intregm_disabled) "pending %x disabled %x"
+slavio_check_interrupts(uint32_t pending, uint32_t intregm_disabled) "pending %#x disabled %#x"
 slavio_set_irq(uint32_t target_cpu, int irq, uint32_t pil, int level) "Set cpu %d irq %d -> pil %d level %d"
 slavio_set_timer_irq_cpu(int cpu, int level) "Set cpu %d local timer level %d"
 
 # hw/intc/grlib_irqmp.c
-grlib_irqmp_check_irqs(uint32_t pend, uint32_t force, uint32_t mask, uint32_t lvl1, uint32_t lvl2) "pend:0x%04x force:0x%04x mask:0x%04x lvl1:0x%04x lvl0:0x%04x"
+grlib_irqmp_check_irqs(uint32_t pend, uint32_t force, uint32_t mask, uint32_t lvl1, uint32_t lvl2) "pend:%#04x force:%#04x mask:%#04x lvl1:%#04x lvl0:%#04x"
 grlib_irqmp_ack(int intno) "interrupt:%d"
 grlib_irqmp_set_irq(int irq) "Raise CPU IRQ %d"
-grlib_irqmp_readl_unknown(uint64_t addr) "addr 0x%"PRIx64
-grlib_irqmp_writel_unknown(uint64_t addr, uint32_t value) "addr 0x%"PRIx64" value 0x%x"
+grlib_irqmp_readl_unknown(uint64_t addr) "addr %#"PRIx64
+grlib_irqmp_writel_unknown(uint64_t addr, uint32_t value) "addr %#"PRIx64" value %#x"
 
 # hw/intc/lm32_pic.c
 lm32_pic_raise_irq(void) "Raise CPU interrupt"
 lm32_pic_lower_irq(void) "Lower CPU interrupt"
 lm32_pic_interrupt(int irq, int level) "Set IRQ%d %d"
-lm32_pic_set_im(uint32_t im) "im 0x%08x"
-lm32_pic_set_ip(uint32_t ip) "ip 0x%08x"
-lm32_pic_get_im(uint32_t im) "im 0x%08x"
-lm32_pic_get_ip(uint32_t ip) "ip 0x%08x"
+lm32_pic_set_im(uint32_t im) "im %#08x"
+lm32_pic_set_ip(uint32_t ip) "ip %#08x"
+lm32_pic_get_im(uint32_t im) "im %#08x"
+lm32_pic_get_ip(uint32_t ip) "ip %#08x"
 
 # hw/intc/xics.c
 xics_icp_check_ipi(int server, uint8_t mfrr) "CPU %d can take IPI mfrr=%#x"
@@ -74,97 +74,97 @@ flic_no_device_api(int err) "flic: no Device Contral API support %d"
 flic_reset_failed(int err) "flic: reset failed %d"
 
 # hw/intc/s390_flic.c
-qemu_s390_airq_suppressed(uint8_t type, uint8_t isc) "flic: adapter I/O interrupt suppressed (type %x isc %x)"
-qemu_s390_suppress_airq(uint8_t isc, const char *from, const char *to) "flic: for isc %x, suppress airq by modifying ais mode from %s to %s"
+qemu_s390_airq_suppressed(uint8_t type, uint8_t isc) "flic: adapter I/O interrupt suppressed (type %#x isc %#x)"
+qemu_s390_suppress_airq(uint8_t isc, const char *from, const char *to) "flic: for isc %#x, suppress airq by modifying ais mode from %s to %s"
 
 # hw/intc/aspeed_vic.c
 aspeed_vic_set_irq(int irq, int level) "Enabling IRQ %d: %d"
 aspeed_vic_update_fiq(int flags) "Raising FIQ: %d"
 aspeed_vic_update_irq(int flags) "Raising IRQ: %d"
-aspeed_vic_read(uint64_t offset, unsigned size, uint32_t value) "From 0x%" PRIx64 " of size %u: 0x%" PRIx32
-aspeed_vic_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
+aspeed_vic_read(uint64_t offset, unsigned size, uint32_t value) "From %#" PRIx64 " of size %u: %#" PRIx32
+aspeed_vic_write(uint64_t offset, unsigned size, uint32_t data) "To %#" PRIx64 " of size %u: %#" PRIx32
 
 # hw/intc/arm_gic.c
 gic_enable_irq(int irq) "irq %d enabled"
 gic_disable_irq(int irq) "irq %d disabled"
-gic_set_irq(int irq, int level, int cpumask, int target) "irq %d level %d cpumask 0x%x target 0x%x"
+gic_set_irq(int irq, int level, int cpumask, int target) "irq %d level %d cpumask %#x target %#x"
 gic_update_bestirq(int cpu, int irq, int prio, int priority_mask, int running_priority) "cpu %d irq %d priority %d cpu priority mask %d cpu running priority %d"
 gic_update_set_irq(int cpu, const char *name, int level) "cpu[%d]: %s = %d"
 gic_acknowledge_irq(int cpu, int irq) "cpu %d acknowledged irq %d"
 
 # hw/intc/arm_gicv3_cpuif.c
-gicv3_icc_pmr_read(uint32_t cpu, uint64_t val) "GICv3 ICC_PMR read cpu %x value 0x%" PRIx64
-gicv3_icc_pmr_write(uint32_t cpu, uint64_t val) "GICv3 ICC_PMR write cpu %x value 0x%" PRIx64
-gicv3_icc_bpr_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICC_BPR%d read cpu %x value 0x%" PRIx64
-gicv3_icc_bpr_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICC_BPR%d write cpu %x value 0x%" PRIx64
-gicv3_icc_ap_read(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICC_AP%dR%d read cpu %x value 0x%" PRIx64
-gicv3_icc_ap_write(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICC_AP%dR%d write cpu %x value 0x%" PRIx64
-gicv3_icc_igrpen_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICC_IGRPEN%d read cpu %x value 0x%" PRIx64
-gicv3_icc_igrpen_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICC_IGRPEN%d write cpu %x value 0x%" PRIx64
-gicv3_icc_igrpen1_el3_read(uint32_t cpu, uint64_t val) "GICv3 ICC_IGRPEN1_EL3 read cpu %x value 0x%" PRIx64
-gicv3_icc_igrpen1_el3_write(uint32_t cpu, uint64_t val) "GICv3 ICC_IGRPEN1_EL3 write cpu %x value 0x%" PRIx64
-gicv3_icc_ctlr_read(uint32_t cpu, uint64_t val) "GICv3 ICC_CTLR read cpu %x value 0x%" PRIx64
-gicv3_icc_ctlr_write(uint32_t cpu, uint64_t val) "GICv3 ICC_CTLR write cpu %x value 0x%" PRIx64
-gicv3_icc_ctlr_el3_read(uint32_t cpu, uint64_t val) "GICv3 ICC_CTLR_EL3 read cpu %x value 0x%" PRIx64
-gicv3_icc_ctlr_el3_write(uint32_t cpu, uint64_t val) "GICv3 ICC_CTLR_EL3 write cpu %x value 0x%" PRIx64
-gicv3_cpuif_update(uint32_t cpuid, int irq, int grp, int prio) "GICv3 CPU i/f %x HPPI update: irq %d group %d prio %d"
-gicv3_cpuif_set_irqs(uint32_t cpuid, int fiqlevel, int irqlevel) "GICv3 CPU i/f %x HPPI update: setting FIQ %d IRQ %d"
-gicv3_icc_generate_sgi(uint32_t cpuid, int irq, int irm, uint32_t aff, uint32_t targetlist) "GICv3 CPU i/f %x generating SGI %d IRM %d target affinity 0x%xxx targetlist 0x%x"
-gicv3_icc_iar0_read(uint32_t cpu, uint64_t val) "GICv3 ICC_IAR0 read cpu %x value 0x%" PRIx64
-gicv3_icc_iar1_read(uint32_t cpu, uint64_t val) "GICv3 ICC_IAR1 read cpu %x value 0x%" PRIx64
-gicv3_icc_eoir_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICC_EOIR%d write cpu %x value 0x%" PRIx64
-gicv3_icc_hppir0_read(uint32_t cpu, uint64_t val) "GICv3 ICC_HPPIR0 read cpu %x value 0x%" PRIx64
-gicv3_icc_hppir1_read(uint32_t cpu, uint64_t val) "GICv3 ICC_HPPIR1 read cpu %x value 0x%" PRIx64
-gicv3_icc_dir_write(uint32_t cpu, uint64_t val) "GICv3 ICC_DIR write cpu %x value 0x%" PRIx64
-gicv3_icc_rpr_read(uint32_t cpu, uint64_t val) "GICv3 ICC_RPR read cpu %x value 0x%" PRIx64
-gicv3_ich_ap_read(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_AP%dR%d read cpu %x value 0x%" PRIx64
-gicv3_ich_ap_write(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_AP%dR%d write cpu %x value 0x%" PRIx64
-gicv3_ich_hcr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_HCR_EL2 read cpu %x value 0x%" PRIx64
-gicv3_ich_hcr_write(uint32_t cpu, uint64_t val) "GICv3 ICH_HCR_EL2 write cpu %x value 0x%" PRIx64
-gicv3_ich_vmcr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_VMCR_EL2 read cpu %x value 0x%" PRIx64
-gicv3_ich_vmcr_write(uint32_t cpu, uint64_t val) "GICv3 ICH_VMCR_EL2 write cpu %x value 0x%" PRIx64
-gicv3_ich_lr_read(int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_LR%d_EL2 read cpu %x value 0x%" PRIx64
-gicv3_ich_lr32_read(int regno, uint32_t cpu, uint32_t val) "GICv3 ICH_LR%d read cpu %x value 0x%" PRIx32
-gicv3_ich_lrc_read(int regno, uint32_t cpu, uint32_t val) "GICv3 ICH_LRC%d read cpu %x value 0x%" PRIx32
-gicv3_ich_lr_write(int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_LR%d_EL2 write cpu %x value 0x%" PRIx64
-gicv3_ich_lr32_write(int regno, uint32_t cpu, uint32_t val) "GICv3 ICH_LR%d write cpu %x value 0x%" PRIx32
-gicv3_ich_lrc_write(int regno, uint32_t cpu, uint32_t val) "GICv3 ICH_LRC%d write cpu %x value 0x%" PRIx32
-gicv3_ich_vtr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_VTR read cpu %x value 0x%" PRIx64
-gicv3_ich_misr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_MISR read cpu %x value 0x%" PRIx64
-gicv3_ich_eisr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_EISR read cpu %x value 0x%" PRIx64
-gicv3_ich_elrsr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_ELRSR read cpu %x value 0x%" PRIx64
-gicv3_icv_ap_read(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICV_AP%dR%d read cpu %x value 0x%" PRIx64
-gicv3_icv_ap_write(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICV_AP%dR%d write cpu %x value 0x%" PRIx64
-gicv3_icv_bpr_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_BPR%d read cpu %x value 0x%" PRIx64
-gicv3_icv_bpr_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_BPR%d write cpu %x value 0x%" PRIx64
-gicv3_icv_pmr_read(uint32_t cpu, uint64_t val) "GICv3 ICV_PMR read cpu %x value 0x%" PRIx64
-gicv3_icv_pmr_write(uint32_t cpu, uint64_t val) "GICv3 ICV_PMR write cpu %x value 0x%" PRIx64
-gicv3_icv_igrpen_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_IGRPEN%d read cpu %x value 0x%" PRIx64
-gicv3_icv_igrpen_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_IGRPEN%d write cpu %x value 0x%" PRIx64
-gicv3_icv_ctlr_read(uint32_t cpu, uint64_t val) "GICv3 ICV_CTLR read cpu %x value 0x%" PRIx64
-gicv3_icv_ctlr_write(uint32_t cpu, uint64_t val) "GICv3 ICV_CTLR write cpu %x value 0x%" PRIx64
-gicv3_icv_rpr_read(uint32_t cpu, uint64_t val) "GICv3 ICV_RPR read cpu %x value 0x%" PRIx64
-gicv3_icv_hppir_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_HPPIR%d read cpu %x value 0x%" PRIx64
-gicv3_icv_dir_write(uint32_t cpu, uint64_t val) "GICv3 ICV_DIR write cpu %x value 0x%" PRIx64
-gicv3_icv_iar_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_IAR%d read cpu %x value 0x%" PRIx64
-gicv3_icv_eoir_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_EOIR%d write cpu %x value 0x%" PRIx64
-gicv3_cpuif_virt_update(uint32_t cpuid, int idx) "GICv3 CPU i/f %x virt HPPI update LR index %d"
-gicv3_cpuif_virt_set_irqs(uint32_t cpuid, int fiqlevel, int irqlevel, int maintlevel) "GICv3 CPU i/f %x virt HPPI update: setting FIQ %d IRQ %d maintenance-irq %d"
+gicv3_icc_pmr_read(uint32_t cpu, uint64_t val) "GICv3 ICC_PMR read cpu %#x value %#" PRIx64
+gicv3_icc_pmr_write(uint32_t cpu, uint64_t val) "GICv3 ICC_PMR write cpu %#x value %#" PRIx64
+gicv3_icc_bpr_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICC_BPR%d read cpu %#x value %#" PRIx64
+gicv3_icc_bpr_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICC_BPR%d write cpu %#x value %#" PRIx64
+gicv3_icc_ap_read(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICC_AP%dR%d read cpu %#x value %#" PRIx64
+gicv3_icc_ap_write(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICC_AP%dR%d write cpu %#x value %#" PRIx64
+gicv3_icc_igrpen_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICC_IGRPEN%d read cpu %#x value %#" PRIx64
+gicv3_icc_igrpen_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICC_IGRPEN%d write cpu %#x value %#" PRIx64
+gicv3_icc_igrpen1_el3_read(uint32_t cpu, uint64_t val) "GICv3 ICC_IGRPEN1_EL3 read cpu %#x value %#" PRIx64
+gicv3_icc_igrpen1_el3_write(uint32_t cpu, uint64_t val) "GICv3 ICC_IGRPEN1_EL3 write cpu %#x value %#" PRIx64
+gicv3_icc_ctlr_read(uint32_t cpu, uint64_t val) "GICv3 ICC_CTLR read cpu %#x value %#" PRIx64
+gicv3_icc_ctlr_write(uint32_t cpu, uint64_t val) "GICv3 ICC_CTLR write cpu %#x value %#" PRIx64
+gicv3_icc_ctlr_el3_read(uint32_t cpu, uint64_t val) "GICv3 ICC_CTLR_EL3 read cpu %#x value %#" PRIx64
+gicv3_icc_ctlr_el3_write(uint32_t cpu, uint64_t val) "GICv3 ICC_CTLR_EL3 write cpu %#x value %#" PRIx64
+gicv3_cpuif_update(uint32_t cpuid, int irq, int grp, int prio) "GICv3 CPU i/f %#x HPPI update: irq %d group %d prio %d"
+gicv3_cpuif_set_irqs(uint32_t cpuid, int fiqlevel, int irqlevel) "GICv3 CPU i/f %#x HPPI update: setting FIQ %d IRQ %d"
+gicv3_icc_generate_sgi(uint32_t cpuid, int irq, int irm, uint32_t aff, uint32_t targetlist) "GICv3 CPU i/f %#x generating SGI %d IRM %d target affinity %#xxx targetlist %#x"
+gicv3_icc_iar0_read(uint32_t cpu, uint64_t val) "GICv3 ICC_IAR0 read cpu %#x value %#" PRIx64
+gicv3_icc_iar1_read(uint32_t cpu, uint64_t val) "GICv3 ICC_IAR1 read cpu %#x value %#" PRIx64
+gicv3_icc_eoir_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICC_EOIR%d write cpu %#x value %#" PRIx64
+gicv3_icc_hppir0_read(uint32_t cpu, uint64_t val) "GICv3 ICC_HPPIR0 read cpu %#x value %#" PRIx64
+gicv3_icc_hppir1_read(uint32_t cpu, uint64_t val) "GICv3 ICC_HPPIR1 read cpu %#x value %#" PRIx64
+gicv3_icc_dir_write(uint32_t cpu, uint64_t val) "GICv3 ICC_DIR write cpu %#x value %#" PRIx64
+gicv3_icc_rpr_read(uint32_t cpu, uint64_t val) "GICv3 ICC_RPR read cpu %#x value %#" PRIx64
+gicv3_ich_ap_read(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_AP%dR%d read cpu %#x value %#" PRIx64
+gicv3_ich_ap_write(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_AP%dR%d write cpu %#x value %#" PRIx64
+gicv3_ich_hcr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_HCR_EL2 read cpu %#x value %#" PRIx64
+gicv3_ich_hcr_write(uint32_t cpu, uint64_t val) "GICv3 ICH_HCR_EL2 write cpu %#x value %#" PRIx64
+gicv3_ich_vmcr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_VMCR_EL2 read cpu %#x value %#" PRIx64
+gicv3_ich_vmcr_write(uint32_t cpu, uint64_t val) "GICv3 ICH_VMCR_EL2 write cpu %#x value %#" PRIx64
+gicv3_ich_lr_read(int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_LR%d_EL2 read cpu %#x value %#" PRIx64
+gicv3_ich_lr32_read(int regno, uint32_t cpu, uint32_t val) "GICv3 ICH_LR%d read cpu %#x value %#" PRIx32
+gicv3_ich_lrc_read(int regno, uint32_t cpu, uint32_t val) "GICv3 ICH_LRC%d read cpu %#x value %#" PRIx32
+gicv3_ich_lr_write(int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_LR%d_EL2 write cpu %#x value %#" PRIx64
+gicv3_ich_lr32_write(int regno, uint32_t cpu, uint32_t val) "GICv3 ICH_LR%d write cpu %#x value %#" PRIx32
+gicv3_ich_lrc_write(int regno, uint32_t cpu, uint32_t val) "GICv3 ICH_LRC%d write cpu %#x value %#" PRIx32
+gicv3_ich_vtr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_VTR read cpu %#x value %#" PRIx64
+gicv3_ich_misr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_MISR read cpu %#x value %#" PRIx64
+gicv3_ich_eisr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_EISR read cpu %#x value %#" PRIx64
+gicv3_ich_elrsr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_ELRSR read cpu %#x value %#" PRIx64
+gicv3_icv_ap_read(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICV_AP%dR%d read cpu %#x value %#" PRIx64
+gicv3_icv_ap_write(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICV_AP%dR%d write cpu %#x value %#" PRIx64
+gicv3_icv_bpr_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_BPR%d read cpu %#x value %#" PRIx64
+gicv3_icv_bpr_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_BPR%d write cpu %#x value %#" PRIx64
+gicv3_icv_pmr_read(uint32_t cpu, uint64_t val) "GICv3 ICV_PMR read cpu %#x value %#" PRIx64
+gicv3_icv_pmr_write(uint32_t cpu, uint64_t val) "GICv3 ICV_PMR write cpu %#x value %#" PRIx64
+gicv3_icv_igrpen_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_IGRPEN%d read cpu %#x value %#" PRIx64
+gicv3_icv_igrpen_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_IGRPEN%d write cpu %#x value %#" PRIx64
+gicv3_icv_ctlr_read(uint32_t cpu, uint64_t val) "GICv3 ICV_CTLR read cpu %#x value %#" PRIx64
+gicv3_icv_ctlr_write(uint32_t cpu, uint64_t val) "GICv3 ICV_CTLR write cpu %#x value %#" PRIx64
+gicv3_icv_rpr_read(uint32_t cpu, uint64_t val) "GICv3 ICV_RPR read cpu %#x value %#" PRIx64
+gicv3_icv_hppir_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_HPPIR%d read cpu %#x value %#" PRIx64
+gicv3_icv_dir_write(uint32_t cpu, uint64_t val) "GICv3 ICV_DIR write cpu %#x value %#" PRIx64
+gicv3_icv_iar_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_IAR%d read cpu %#x value %#" PRIx64
+gicv3_icv_eoir_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_EOIR%d write cpu %#x value %#" PRIx64
+gicv3_cpuif_virt_update(uint32_t cpuid, int idx) "GICv3 CPU i/f %#x virt HPPI update LR index %d"
+gicv3_cpuif_virt_set_irqs(uint32_t cpuid, int fiqlevel, int irqlevel, int maintlevel) "GICv3 CPU i/f %#x virt HPPI update: setting FIQ %d IRQ %d maintenance-irq %d"
 
 # hw/intc/arm_gicv3_dist.c
-gicv3_dist_read(uint64_t offset, uint64_t data, unsigned size, bool secure) "GICv3 distributor read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u secure %d"
-gicv3_dist_badread(uint64_t offset, unsigned size, bool secure) "GICv3 distributor read: offset 0x%" PRIx64 " size %u secure %d: error"
-gicv3_dist_write(uint64_t offset, uint64_t data, unsigned size, bool secure) "GICv3 distributor write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u secure %d"
-gicv3_dist_badwrite(uint64_t offset, uint64_t data, unsigned size, bool secure) "GICv3 distributor write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u secure %d: error"
+gicv3_dist_read(uint64_t offset, uint64_t data, unsigned size, bool secure) "GICv3 distributor read: offset %#" PRIx64 " data %#" PRIx64 " size %u secure %d"
+gicv3_dist_badread(uint64_t offset, unsigned size, bool secure) "GICv3 distributor read: offset %#" PRIx64 " size %u secure %d: error"
+gicv3_dist_write(uint64_t offset, uint64_t data, unsigned size, bool secure) "GICv3 distributor write: offset %#" PRIx64 " data %#" PRIx64 " size %u secure %d"
+gicv3_dist_badwrite(uint64_t offset, uint64_t data, unsigned size, bool secure) "GICv3 distributor write: offset %#" PRIx64 " data %#" PRIx64 " size %u secure %d: error"
 gicv3_dist_set_irq(int irq, int level) "GICv3 distributor interrupt %d level changed to %d"
 
 # hw/intc/arm_gicv3_redist.c
-gicv3_redist_read(uint32_t cpu, uint64_t offset, uint64_t data, unsigned size, bool secure) "GICv3 redistributor %x read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u secure %d"
-gicv3_redist_badread(uint32_t cpu, uint64_t offset, unsigned size, bool secure) "GICv3 redistributor %x read: offset 0x%" PRIx64 " size %u secure %d: error"
-gicv3_redist_write(uint32_t cpu, uint64_t offset, uint64_t data, unsigned size, bool secure) "GICv3 redistributor %x write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u secure %d"
-gicv3_redist_badwrite(uint32_t cpu, uint64_t offset, uint64_t data, unsigned size, bool secure) "GICv3 redistributor %x write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u secure %d: error"
-gicv3_redist_set_irq(uint32_t cpu, int irq, int level) "GICv3 redistributor %x interrupt %d level changed to %d"
-gicv3_redist_send_sgi(uint32_t cpu, int irq) "GICv3 redistributor %x pending SGI %d"
+gicv3_redist_read(uint32_t cpu, uint64_t offset, uint64_t data, unsigned size, bool secure) "GICv3 redistributor %#x read: offset %#" PRIx64 " data %#" PRIx64 " size %u secure %d"
+gicv3_redist_badread(uint32_t cpu, uint64_t offset, unsigned size, bool secure) "GICv3 redistributor %#x read: offset %#" PRIx64 " size %u secure %d: error"
+gicv3_redist_write(uint32_t cpu, uint64_t offset, uint64_t data, unsigned size, bool secure) "GICv3 redistributor %#x write: offset %#" PRIx64 " data %#" PRIx64 " size %u secure %d"
+gicv3_redist_badwrite(uint32_t cpu, uint64_t offset, uint64_t data, unsigned size, bool secure) "GICv3 redistributor %#x write: offset %#" PRIx64 " data %#" PRIx64 " size %u secure %d: error"
+gicv3_redist_set_irq(uint32_t cpu, int irq, int level) "GICv3 redistributor %#x interrupt %d level changed to %d"
+gicv3_redist_send_sgi(uint32_t cpu, int irq) "GICv3 redistributor %#x pending SGI %d"
 
 # hw/intc/armv7m_nvic.c
 nvic_recompute_state(int vectpending, int exception_prio) "NVIC state recomputed: vectpending %d exception_prio %d"
@@ -178,5 +178,5 @@ nvic_set_pending_level(int irq) "NVIC set pending: irq %d higher prio than vectp
 nvic_acknowledge_irq(int irq, int prio) "NVIC acknowledge IRQ: %d now active (prio %d)"
 nvic_complete_irq(int irq) "NVIC complete IRQ %d"
 nvic_set_irq_level(int irq, int level) "NVIC external irq %d level set to %d"
-nvic_sysreg_read(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
-nvic_sysreg_write(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
+nvic_sysreg_read(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg read addr %#" PRIx64 " data %#" PRIx32 " size %u"
+nvic_sysreg_write(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg write addr %#" PRIx64 " data %#" PRIx32 " size %u"
diff --git a/hw/isa/trace-events b/hw/isa/trace-events
index 9faca41a97..e3f8cca8ab 100644
--- a/hw/isa/trace-events
+++ b/hw/isa/trace-events
@@ -1,9 +1,9 @@
 # See docs/tracing.txt for syntax documentation.
 
 # hw/isa/pc87312.c
-pc87312_io_read(uint32_t addr, uint32_t val) "read addr=%x val=%x"
-pc87312_io_write(uint32_t addr, uint32_t val) "write addr=%x val=%x"
-pc87312_info_floppy(uint32_t base) "base 0x%x"
-pc87312_info_ide(uint32_t base) "base 0x%x"
-pc87312_info_parallel(uint32_t base, uint32_t irq) "base 0x%x, irq %u"
-pc87312_info_serial(int n, uint32_t base, uint32_t irq) "id=%d, base 0x%x, irq %u"
+pc87312_io_read(uint32_t addr, uint32_t val) "read addr=%#x val=%#x"
+pc87312_io_write(uint32_t addr, uint32_t val) "write addr=%#x val=%#x"
+pc87312_info_floppy(uint32_t base) "base %#x"
+pc87312_info_ide(uint32_t base) "base %#x"
+pc87312_info_parallel(uint32_t base, uint32_t irq) "base %#x, irq %u"
+pc87312_info_serial(int n, uint32_t base, uint32_t irq) "id=%d, base %#x, irq %u"
diff --git a/hw/mem/trace-events b/hw/mem/trace-events
index 323c3c10d5..6706893979 100644
--- a/hw/mem/trace-events
+++ b/hw/mem/trace-events
@@ -2,4 +2,4 @@
 
 # hw/mem/pc-dimm.c
 mhp_pc_dimm_assigned_slot(int slot) "%d"
-mhp_pc_dimm_assigned_address(uint64_t addr) "0x%"PRIx64
+mhp_pc_dimm_assigned_address(uint64_t addr) "%#"PRIx64
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 28b8cd1c2e..c5e6978f65 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -1,63 +1,63 @@
 # See docs/tracing.txt for syntax documentation.
 
 # hw/misc/eccmemctl.c
-ecc_mem_writel_mer(uint32_t val) "Write memory enable %08x"
-ecc_mem_writel_mdr(uint32_t val) "Write memory delay %08x"
-ecc_mem_writel_mfsr(uint32_t val) "Write memory fault status %08x"
-ecc_mem_writel_vcr(uint32_t val) "Write slot configuration %08x"
-ecc_mem_writel_dr(uint32_t val) "Write diagnostic %08x"
-ecc_mem_writel_ecr0(uint32_t val) "Write event count 1 %08x"
-ecc_mem_writel_ecr1(uint32_t val) "Write event count 2 %08x"
-ecc_mem_readl_mer(uint32_t ret) "Read memory enable %08x"
-ecc_mem_readl_mdr(uint32_t ret) "Read memory delay %08x"
-ecc_mem_readl_mfsr(uint32_t ret) "Read memory fault status %08x"
-ecc_mem_readl_vcr(uint32_t ret) "Read slot configuration %08x"
-ecc_mem_readl_mfar0(uint32_t ret) "Read memory fault address 0 %08x"
-ecc_mem_readl_mfar1(uint32_t ret) "Read memory fault address 1 %08x"
-ecc_mem_readl_dr(uint32_t ret) "Read diagnostic %08x"
-ecc_mem_readl_ecr0(uint32_t ret) "Read event count 1 %08x"
-ecc_mem_readl_ecr1(uint32_t ret) "Read event count 2 %08x"
-ecc_diag_mem_writeb(uint64_t addr, uint32_t val) "Write diagnostic %"PRId64" = %02x"
-ecc_diag_mem_readb(uint64_t addr, uint32_t ret) "Read diagnostic %"PRId64"= %02x"
+ecc_mem_writel_mer(uint32_t val) "Write memory enable %#08x"
+ecc_mem_writel_mdr(uint32_t val) "Write memory delay %#08x"
+ecc_mem_writel_mfsr(uint32_t val) "Write memory fault status %#08x"
+ecc_mem_writel_vcr(uint32_t val) "Write slot configuration %#08x"
+ecc_mem_writel_dr(uint32_t val) "Write diagnostic %#08x"
+ecc_mem_writel_ecr0(uint32_t val) "Write event count 1 %#08x"
+ecc_mem_writel_ecr1(uint32_t val) "Write event count 2 %#08x"
+ecc_mem_readl_mer(uint32_t ret) "Read memory enable %#08x"
+ecc_mem_readl_mdr(uint32_t ret) "Read memory delay %#08x"
+ecc_mem_readl_mfsr(uint32_t ret) "Read memory fault status %#08x"
+ecc_mem_readl_vcr(uint32_t ret) "Read slot configuration %#08x"
+ecc_mem_readl_mfar0(uint32_t ret) "Read memory fault address 0 %#08x"
+ecc_mem_readl_mfar1(uint32_t ret) "Read memory fault address 1 %#08x"
+ecc_mem_readl_dr(uint32_t ret) "Read diagnostic %#08x"
+ecc_mem_readl_ecr0(uint32_t ret) "Read event count 1 %#08x"
+ecc_mem_readl_ecr1(uint32_t ret) "Read event count 2 %#08x"
+ecc_diag_mem_writeb(uint64_t addr, uint32_t val) "Write diagnostic %"PRId64" = %#02x"
+ecc_diag_mem_readb(uint64_t addr, uint32_t ret) "Read diagnostic %"PRId64"= %#02x"
 
 # hw/misc/slavio_misc.c
 slavio_misc_update_irq_raise(void) "Raise IRQ"
 slavio_misc_update_irq_lower(void) "Lower IRQ"
 slavio_set_power_fail(int power_failing, uint8_t config) "Power fail: %d, config: %d"
-slavio_cfg_mem_writeb(uint32_t val) "Write config %02x"
-slavio_cfg_mem_readb(uint32_t ret) "Read config %02x"
-slavio_diag_mem_writeb(uint32_t val) "Write diag %02x"
-slavio_diag_mem_readb(uint32_t ret) "Read diag %02x"
-slavio_mdm_mem_writeb(uint32_t val) "Write modem control %02x"
-slavio_mdm_mem_readb(uint32_t ret) "Read modem control %02x"
-slavio_aux1_mem_writeb(uint32_t val) "Write aux1 %02x"
-slavio_aux1_mem_readb(uint32_t ret) "Read aux1 %02x"
-slavio_aux2_mem_writeb(uint32_t val) "Write aux2 %02x"
-slavio_aux2_mem_readb(uint32_t ret) "Read aux2 %02x"
-apc_mem_writeb(uint32_t val) "Write power management %02x"
-apc_mem_readb(uint32_t ret) "Read power management %02x"
-slavio_sysctrl_mem_writel(uint32_t val) "Write system control %08x"
-slavio_sysctrl_mem_readl(uint32_t ret) "Read system control %08x"
-slavio_led_mem_writew(uint32_t val) "Write diagnostic LED %04x"
-slavio_led_mem_readw(uint32_t ret) "Read diagnostic LED %04x"
+slavio_cfg_mem_writeb(uint32_t val) "Write config %#02x"
+slavio_cfg_mem_readb(uint32_t ret) "Read config %#02x"
+slavio_diag_mem_writeb(uint32_t val) "Write diag %#02x"
+slavio_diag_mem_readb(uint32_t ret) "Read diag %#02x"
+slavio_mdm_mem_writeb(uint32_t val) "Write modem control %#02x"
+slavio_mdm_mem_readb(uint32_t ret) "Read modem control %#02x"
+slavio_aux1_mem_writeb(uint32_t val) "Write aux1 %#02x"
+slavio_aux1_mem_readb(uint32_t ret) "Read aux1 %#02x"
+slavio_aux2_mem_writeb(uint32_t val) "Write aux2 %#02x"
+slavio_aux2_mem_readb(uint32_t ret) "Read aux2 %#02x"
+apc_mem_writeb(uint32_t val) "Write power management %#02x"
+apc_mem_readb(uint32_t ret) "Read power management %#02x"
+slavio_sysctrl_mem_writel(uint32_t val) "Write system control %#08x"
+slavio_sysctrl_mem_readl(uint32_t ret) "Read system control %#08x"
+slavio_led_mem_writew(uint32_t val) "Write diagnostic LED %#04x"
+slavio_led_mem_readw(uint32_t ret) "Read diagnostic LED %#04x"
 
 # hw/misc/milkymist-hpdmc.c
-milkymist_hpdmc_memory_read(uint32_t addr, uint32_t value) "addr=%08x value=%08x"
-milkymist_hpdmc_memory_write(uint32_t addr, uint32_t value) "addr=%08x value=%08x"
+milkymist_hpdmc_memory_read(uint32_t addr, uint32_t value) "addr=%#08x value=%#08x"
+milkymist_hpdmc_memory_write(uint32_t addr, uint32_t value) "addr=%#08x value=%#08x"
 
 # hw/misc/milkymist-pfpu.c
-milkymist_pfpu_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_pfpu_memory_write(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_pfpu_vectout(uint32_t a, uint32_t b, uint32_t dma_ptr) "a %08x b %08x dma_ptr %08x"
+milkymist_pfpu_memory_read(uint32_t addr, uint32_t value) "addr %#08x value %#08x"
+milkymist_pfpu_memory_write(uint32_t addr, uint32_t value) "addr %#08x value %#08x"
+milkymist_pfpu_vectout(uint32_t a, uint32_t b, uint32_t dma_ptr) "a %#08x b %#08x dma_ptr %#08x"
 milkymist_pfpu_pulse_irq(void) "Pulse IRQ"
 
 # hw/misc/aspeed_scu.c
-aspeed_scu_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
+aspeed_scu_write(uint64_t offset, unsigned size, uint32_t data) "To %#" PRIx64 " of size %u: %#" PRIx32
 
 # hw/misc/mps2_scc.c
-mps2_scc_read(uint64_t offset, uint64_t data, unsigned size) "MPS2 SCC read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
-mps2_scc_write(uint64_t offset, uint64_t data, unsigned size) "MPS2 SCC write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
+mps2_scc_read(uint64_t offset, uint64_t data, unsigned size) "MPS2 SCC read: offset %#" PRIx64 " data %#" PRIx64 " size %u"
+mps2_scc_write(uint64_t offset, uint64_t data, unsigned size) "MPS2 SCC write: offset %#" PRIx64 " data %#" PRIx64 " size %u"
 mps2_scc_reset(void) "MPS2 SCC: reset"
 mps2_scc_leds(char led7, char led6, char led5, char led4, char led3, char led2, char led1, char led0) "MPS2 SCC LEDs: %c%c%c%c%c%c%c%c"
-mps2_scc_cfg_write(unsigned function, unsigned device, uint32_t value) "MPS2 SCC config write: function %d device %d data 0x%" PRIx32
-mps2_scc_cfg_read(unsigned function, unsigned device, uint32_t value) "MPS2 SCC config read: function %d device %d data 0x%" PRIx32
+mps2_scc_cfg_write(unsigned function, unsigned device, uint32_t value) "MPS2 SCC config write: function %d device %d data %#" PRIx32
+mps2_scc_cfg_read(unsigned function, unsigned device, uint32_t value) "MPS2 SCC config read: function %d device %d data %#" PRIx32
diff --git a/hw/net/trace-events b/hw/net/trace-events
index c71480535e..a6fcae5d2c 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -1,14 +1,14 @@
 # See docs/tracing.txt for syntax documentation.
 
 # hw/net/lance.c
-lance_mem_readw(uint64_t addr, uint32_t ret) "addr=%"PRIx64"val=0x%04x"
-lance_mem_writew(uint64_t addr, uint32_t val) "addr=%"PRIx64"val=0x%04x"
+lance_mem_readw(uint64_t addr, uint32_t ret) "addr=%#"PRIx64"val=%#04x"
+lance_mem_writew(uint64_t addr, uint32_t val) "addr=%#"PRIx64"val=%#04x"
 
 # hw/net/milkymist-minimac2.c
-milkymist_minimac2_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_minimac2_memory_write(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_minimac2_mdio_write(uint8_t phy_addr, uint8_t addr, uint16_t value) "phy_addr %02x addr %02x value %04x"
-milkymist_minimac2_mdio_read(uint8_t phy_addr, uint8_t addr, uint16_t value) "phy_addr %02x addr %02x value %04x"
+milkymist_minimac2_memory_read(uint32_t addr, uint32_t value) "addr %#08x value %#08x"
+milkymist_minimac2_memory_write(uint32_t addr, uint32_t value) "addr %#08x value %#08x"
+milkymist_minimac2_mdio_write(uint8_t phy_addr, uint8_t addr, uint16_t value) "phy_addr %#02x addr %#02x value %#04x"
+milkymist_minimac2_mdio_read(uint8_t phy_addr, uint8_t addr, uint16_t value) "phy_addr %#02x addr %#02x value %#04x"
 milkymist_minimac2_tx_frame(uint32_t length) "length %u"
 milkymist_minimac2_rx_frame(const void *buf, uint32_t length) "buf %p length %u"
 milkymist_minimac2_rx_transfer(const void *buf, uint32_t length) "buf %p length %d"
@@ -19,23 +19,23 @@ milkymist_minimac2_pulse_irq_tx(void) "Pulse IRQ TX"
 # hw/net/mipsnet.c
 mipsnet_send(uint32_t size) "sending len=%u"
 mipsnet_receive(uint32_t size) "receiving len=%u"
-mipsnet_read(uint64_t addr, uint32_t val) "read addr=0x%" PRIx64 " val=0x%x"
-mipsnet_write(uint64_t addr, uint64_t val) "write addr=0x%" PRIx64 " val=0x%" PRIx64
-mipsnet_irq(uint32_t isr, uint32_t intctl) "set irq to %d (%02x)"
+mipsnet_read(uint64_t addr, uint32_t val) "read addr=%#" PRIx64 " val=%#x"
+mipsnet_write(uint64_t addr, uint64_t val) "write addr=%#" PRIx64 " val=%#" PRIx64
+mipsnet_irq(uint32_t isr, uint32_t intctl) "set irq to %d (%#02x)"
 
 # hw/net/opencores_eth.c
-open_eth_mii_write(unsigned idx, uint16_t v) "MII[%02x] <- %04x"
-open_eth_mii_read(unsigned idx, uint16_t v) "MII[%02x] -> %04x"
-open_eth_update_irq(uint32_t v) "IRQ <- %x"
+open_eth_mii_write(unsigned idx, uint16_t v) "MII[%#02x] <- %#04x"
+open_eth_mii_read(unsigned idx, uint16_t v) "MII[%#02x] -> %#04x"
+open_eth_update_irq(uint32_t v) "IRQ <- %#x"
 open_eth_receive(unsigned len) "RX: len: %u"
-open_eth_receive_mcast(unsigned idx, uint32_t h0, uint32_t h1) "MCAST: idx = %u, hash: %08x:%08x"
+open_eth_receive_mcast(unsigned idx, uint32_t h0, uint32_t h1) "MCAST: idx = %u, hash: %#08x:%#08x"
 open_eth_receive_reject(void) "RX: rejected"
-open_eth_receive_desc(uint32_t addr, uint32_t len_flags) "RX: %08x, len_flags: %08x"
-open_eth_start_xmit(uint32_t addr, unsigned len, unsigned tx_len) "TX: %08x, len: %u, tx_len: %u"
-open_eth_reg_read(uint32_t addr, uint32_t v) "MAC[%02x] -> %08x"
-open_eth_reg_write(uint32_t addr, uint32_t v) "MAC[%02x] <- %08x"
-open_eth_desc_read(uint32_t addr, uint32_t v) "DESC[%04x] -> %08x"
-open_eth_desc_write(uint32_t addr, uint32_t v) "DESC[%04x] <- %08x"
+open_eth_receive_desc(uint32_t addr, uint32_t len_flags) "RX: %#08x, len_flags: %#08x"
+open_eth_start_xmit(uint32_t addr, unsigned len, unsigned tx_len) "TX: %#08x, len: %u, tx_len: %u"
+open_eth_reg_read(uint32_t addr, uint32_t v) "MAC[%#02x] -> %#08x"
+open_eth_reg_write(uint32_t addr, uint32_t v) "MAC[%#02x] <- %#08x"
+open_eth_desc_read(uint32_t addr, uint32_t v) "DESC[%#04x] -> %#08x"
+open_eth_desc_write(uint32_t addr, uint32_t v) "DESC[%#04x] <- %#08x"
 
 # hw/net/pcnet.c
 pcnet_s_reset(void *s) "s=%p"
@@ -43,19 +43,19 @@ pcnet_user_int(void *s) "s=%p"
 pcnet_isr_change(void *s, uint32_t isr, uint32_t isr_old) "s=%p INTA=%d<=%d"
 pcnet_init(void *s, uint64_t init_addr) "s=%p init_addr=%#"PRIx64
 pcnet_rlen_tlen(void *s, uint32_t rlen, uint32_t tlen) "s=%p rlen=%d tlen=%d"
-pcnet_ss32_rdra_tdra(void *s, uint32_t ss32, uint32_t rdra, uint32_t rcvrl, uint32_t tdra, uint32_t xmtrl) "s=%p ss32=%d rdra=0x%08x[%d] tdra=0x%08x[%d]"
+pcnet_ss32_rdra_tdra(void *s, uint32_t ss32, uint32_t rdra, uint32_t rcvrl, uint32_t tdra, uint32_t xmtrl) "s=%p ss32=%d rdra=%#08x[%d] tdra=%#08x[%d]"
 
 # hw/net/pcnet-pci.c
-pcnet_aprom_writeb(void *opaque, uint32_t addr, uint32_t val) "opaque=%p addr=0x%08x val=0x%02x"
-pcnet_aprom_readb(void *opaque, uint32_t addr, uint32_t val) "opaque=%p addr=0x%08x val=0x%02x"
+pcnet_aprom_writeb(void *opaque, uint32_t addr, uint32_t val) "opaque=%p addr=%#08x val=%#02x"
+pcnet_aprom_readb(void *opaque, uint32_t addr, uint32_t val) "opaque=%p addr=%#08x val=%#02x"
 pcnet_ioport_read(void *opaque, uint64_t addr, unsigned size) "opaque=%p addr=%#"PRIx64" size=%d"
 pcnet_ioport_write(void *opaque, uint64_t addr, uint64_t data, unsigned size) "opaque=%p addr=%#"PRIx64" data=%#"PRIx64" size=%d"
-pcnet_mmio_writeb(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=%#"PRIx64" val=0x%x"
-pcnet_mmio_writew(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=%#"PRIx64" val=0x%x"
-pcnet_mmio_writel(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=%#"PRIx64" val=0x%x"
-pcnet_mmio_readb(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=%#"PRIx64" val=0x%x"
-pcnet_mmio_readw(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=%#"PRIx64" val=0x%x"
-pcnet_mmio_readl(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=%#"PRIx64" val=0x%x"
+pcnet_mmio_writeb(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=%#"PRIx64" val=%#x"
+pcnet_mmio_writew(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=%#"PRIx64" val=%#x"
+pcnet_mmio_writel(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=%#"PRIx64" val=%#x"
+pcnet_mmio_readb(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=%#"PRIx64" val=%#x"
+pcnet_mmio_readw(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=%#"PRIx64" val=%#x"
+pcnet_mmio_readl(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=%#"PRIx64" val=%#x"
 
 # hw/net/net_rx_pkt.c
 net_rx_pkt_parsed(bool ip4, bool ip6, bool udp, bool tcp, size_t l3o, size_t l4o, size_t l5o) "RX packet parsed: ip4: %d, ip6: %d, udp: %d, tcp: %d, l3 offset: %zu, l4 offset: %zu, l5 offset: %zu"
@@ -71,7 +71,7 @@ net_rx_pkt_l4_csum_calc_ip4_tcp(void) "IP4/TCP packet"
 net_rx_pkt_l4_csum_calc_ip6_udp(void) "IP6/UDP packet"
 net_rx_pkt_l4_csum_calc_ip6_tcp(void) "IP6/TCP packet"
 net_rx_pkt_l4_csum_calc_ph_csum(uint32_t cntr, uint16_t csl) "Pseudo-header: checksum counter %u, length %u"
-net_rx_pkt_l4_csum_calc_csum(size_t l4hdr_off, uint16_t csl, uint32_t cntr, uint16_t csum) "L4 Checksum: L4 header offset: %zu, length: %u, counter: 0x%X, final checksum: 0x%X"
+net_rx_pkt_l4_csum_calc_csum(size_t l4hdr_off, uint16_t csl, uint32_t cntr, uint16_t csum) "L4 Checksum: L4 header offset: %zu, length: %u, counter: %#X, final checksum: %#X"
 
 net_rx_pkt_l4_csum_fix_entry(void) "Starting L4 checksum correction"
 net_rx_pkt_l4_csum_fix_tcp(uint32_t l4_cso) "TCP packet, L4 cso: %u"
@@ -79,41 +79,41 @@ net_rx_pkt_l4_csum_fix_udp(uint32_t l4_cso) "UDP packet, L4 cso: %u"
 net_rx_pkt_l4_csum_fix_not_xxp(void) "Not an IP4 packet"
 net_rx_pkt_l4_csum_fix_ip4_fragment(void) "IP4 fragment"
 net_rx_pkt_l4_csum_fix_udp_with_no_checksum(void) "UDP packet without checksum"
-net_rx_pkt_l4_csum_fix_csum(uint32_t cso, uint16_t csum) "L4 Checksum: Offset: %u, value 0x%X"
+net_rx_pkt_l4_csum_fix_csum(uint32_t cso, uint16_t csum) "L4 Checksum: Offset: %u, value %#X"
 
 net_rx_pkt_l3_csum_validate_entry(void) "Starting L3 checksum validation"
 net_rx_pkt_l3_csum_validate_not_ip4(void) "Not an IP4 packet"
-net_rx_pkt_l3_csum_validate_csum(size_t l3hdr_off, uint32_t csl, uint32_t cntr, uint16_t csum, bool csum_valid) "L3 Checksum: L3 header offset: %zu, length: %u, counter: 0x%X, final checksum: 0x%X, valid: %d"
+net_rx_pkt_l3_csum_validate_csum(size_t l3hdr_off, uint32_t csl, uint32_t cntr, uint16_t csum, bool csum_valid) "L3 Checksum: L3 header offset: %zu, length: %u, counter: %#X, final checksum: %#X, valid: %d"
 
 net_rx_pkt_rss_ip4(void) "Calculating IPv4 RSS  hash"
 net_rx_pkt_rss_ip4_tcp(void) "Calculating IPv4/TCP RSS  hash"
 net_rx_pkt_rss_ip6_tcp(void) "Calculating IPv6/TCP RSS  hash"
 net_rx_pkt_rss_ip6(void) "Calculating IPv6 RSS  hash"
 net_rx_pkt_rss_ip6_ex(void) "Calculating IPv6/EX RSS  hash"
-net_rx_pkt_rss_hash(size_t rss_length, uint32_t rss_hash) "RSS hash for %zu bytes: 0x%X"
+net_rx_pkt_rss_hash(size_t rss_length, uint32_t rss_hash) "RSS hash for %zu bytes: %#X"
 net_rx_pkt_rss_add_chunk(void* ptr, size_t size, size_t input_offset) "Add RSS chunk %p, %zu bytes, RSS input offset %zu bytes"
 
 # hw/net/e1000x_common.c
 e1000x_rx_can_recv_disabled(bool link_up, bool rx_enabled, bool pci_master) "link_up: %d, rx_enabled %d, pci_master %d"
-e1000x_vlan_is_vlan_pkt(bool is_vlan_pkt, uint16_t eth_proto, uint16_t vet) "Is VLAN packet: %d, ETH proto: 0x%X, VET: 0x%X"
-e1000x_rx_flt_ucast_match(uint32_t idx, uint8_t b0, uint8_t b1, uint8_t b2, uint8_t b3, uint8_t b4, uint8_t b5) "unicast match[%d]: %02x:%02x:%02x:%02x:%02x:%02x"
-e1000x_rx_flt_ucast_mismatch(uint8_t b0, uint8_t b1, uint8_t b2, uint8_t b3, uint8_t b4, uint8_t b5) "unicast mismatch: %02x:%02x:%02x:%02x:%02x:%02x"
-e1000x_rx_flt_inexact_mismatch(uint8_t b0, uint8_t b1, uint8_t b2, uint8_t b3, uint8_t b4, uint8_t b5, uint32_t mo, uint32_t mta, uint32_t mta_val) "inexact mismatch: %02x:%02x:%02x:%02x:%02x:%02x MO %d MTA[%d] %x"
+e1000x_vlan_is_vlan_pkt(bool is_vlan_pkt, uint16_t eth_proto, uint16_t vet) "Is VLAN packet: %d, ETH proto: %#X, VET: %#X"
+e1000x_rx_flt_ucast_match(uint32_t idx, uint8_t b0, uint8_t b1, uint8_t b2, uint8_t b3, uint8_t b4, uint8_t b5) "unicast match[%d]: %#02x:%#02x:%#02x:%#02x:%#02x:%#02x"
+e1000x_rx_flt_ucast_mismatch(uint8_t b0, uint8_t b1, uint8_t b2, uint8_t b3, uint8_t b4, uint8_t b5) "unicast mismatch: %#02x:%#02x:%#02x:%#02x:%#02x:%#02x"
+e1000x_rx_flt_inexact_mismatch(uint8_t b0, uint8_t b1, uint8_t b2, uint8_t b3, uint8_t b4, uint8_t b5, uint32_t mo, uint32_t mta, uint32_t mta_val) "inexact mismatch: %#02x:%#02x:%#02x:%#02x:%#02x:%#02x MO %d MTA[%d] %#x"
 e1000x_rx_link_down(uint32_t status_reg) "Received packet dropped because the link is down STATUS = %u"
 e1000x_rx_disabled(uint32_t rctl_reg) "Received packet dropped because receive is disabled RCTL = %u"
 e1000x_rx_oversized(size_t size) "Received packet dropped because it was oversized (%zu bytes)"
-e1000x_mac_indicate(uint8_t b0, uint8_t b1, uint8_t b2, uint8_t b3, uint8_t b4, uint8_t b5) "Indicating MAC to guest: %02x:%02x:%02x:%02x:%02x:%02x"
+e1000x_mac_indicate(uint8_t b0, uint8_t b1, uint8_t b2, uint8_t b3, uint8_t b4, uint8_t b5) "Indicating MAC to guest: %#02x:%#02x:%#02x:%#02x:%#02x:%#02x"
 e1000x_link_negotiation_start(void) "Start link auto negotiation"
 e1000x_link_negotiation_done(void) "Auto negotiation is completed"
 
 # hw/net/e1000e_core.c
-e1000e_core_write(uint64_t index, uint32_t size, uint64_t val) "Write to register 0x%"PRIx64", %d byte(s), value: 0x%"PRIx64
-e1000e_core_read(uint64_t index, uint32_t size, uint64_t val) "Read from register 0x%"PRIx64", %d byte(s), value: 0x%"PRIx64
-e1000e_core_mdic_read(uint8_t page, uint32_t addr, uint32_t data) "MDIC READ: PHY[%u][%u] = 0x%x"
+e1000e_core_write(uint64_t index, uint32_t size, uint64_t val) "Write to register %#"PRIx64", %d byte(s), value: %#"PRIx64
+e1000e_core_read(uint64_t index, uint32_t size, uint64_t val) "Read from register %#"PRIx64", %d byte(s), value: %#"PRIx64
+e1000e_core_mdic_read(uint8_t page, uint32_t addr, uint32_t data) "MDIC READ: PHY[%u][%u] = %#x"
 e1000e_core_mdic_read_unhandled(uint8_t page, uint32_t addr) "MDIC READ: PHY[%u][%u] UNHANDLED"
-e1000e_core_mdic_write(uint8_t page, uint32_t addr, uint32_t data) "MDIC WRITE: PHY[%u][%u] = 0x%x"
+e1000e_core_mdic_write(uint8_t page, uint32_t addr, uint32_t data) "MDIC WRITE: PHY[%u][%u] = %#x"
 e1000e_core_mdic_write_unhandled(uint8_t page, uint32_t addr) "MDIC WRITE: PHY[%u][%u] UNHANDLED"
-e1000e_core_ctrl_write(uint64_t index, uint32_t val) "Write CTRL register 0x%"PRIx64", value: 0x%X"
+e1000e_core_ctrl_write(uint64_t index, uint32_t val) "Write CTRL register %#"PRIx64", value: %#X"
 e1000e_core_ctrl_sw_reset(void) "Doing SW reset"
 e1000e_core_ctrl_phy_reset(void) "Doing PHY reset"
 
@@ -124,11 +124,11 @@ e1000e_link_set_ext_params(bool asd_check, bool speed_select_bypass) "Set extend
 e1000e_link_status(bool link_up, bool full_dplx, uint32_t speed, uint32_t asdv) "Link up: %d, Duplex: %d, Speed: %d, ASDV: %d"
 e1000e_link_status_changed(bool status) "New link status: %d"
 
-e1000e_wrn_regs_write_ro(uint64_t index, uint32_t size, uint64_t val) "WARNING: Write to RO register 0x%"PRIx64", %d byte(s), value: 0x%"PRIx64
-e1000e_wrn_regs_write_unknown(uint64_t index, uint32_t size, uint64_t val) "WARNING: Write to unknown register 0x%"PRIx64", %d byte(s), value: 0x%"PRIx64
-e1000e_wrn_regs_read_unknown(uint64_t index, uint32_t size) "WARNING: Read from unknown register 0x%"PRIx64", %d byte(s)"
-e1000e_wrn_regs_read_trivial(uint32_t index) "WARNING: Reading register at offset: 0x%05x. It is not fully implemented."
-e1000e_wrn_regs_write_trivial(uint32_t index) "WARNING: Writing to register at offset: 0x%05x. It is not fully implemented."
+e1000e_wrn_regs_write_ro(uint64_t index, uint32_t size, uint64_t val) "WARNING: Write to RO register %#"PRIx64", %d byte(s), value: %#"PRIx64
+e1000e_wrn_regs_write_unknown(uint64_t index, uint32_t size, uint64_t val) "WARNING: Write to unknown register %#"PRIx64", %d byte(s), value: %#"PRIx64
+e1000e_wrn_regs_read_unknown(uint64_t index, uint32_t size) "WARNING: Read from unknown register %#"PRIx64", %d byte(s)"
+e1000e_wrn_regs_read_trivial(uint32_t index) "WARNING: Reading register at offset: %#05x. It is not fully implemented."
+e1000e_wrn_regs_write_trivial(uint32_t index) "WARNING: Writing to register at offset: %#05x. It is not fully implemented."
 e1000e_wrn_no_ts_support(void) "WARNING: Guest requested TX timestamping which is not supported"
 e1000e_wrn_no_snap_support(void) "WARNING: Guest requested TX SNAP header update which is not supported"
 e1000e_wrn_iscsi_filtering_not_supported(void) "WARNING: Guest requested iSCSI filtering  which is not supported"
@@ -136,7 +136,7 @@ e1000e_wrn_nfsw_filtering_not_supported(void) "WARNING: Guest requested NFS writ
 e1000e_wrn_nfsr_filtering_not_supported(void) "WARNING: Guest requested NFS read filtering  which is not supported"
 
 e1000e_tx_disabled(void) "TX Disabled"
-e1000e_tx_descr(void *addr, uint32_t lower, uint32_t upper) "%p : %x %x"
+e1000e_tx_descr(void *addr, uint32_t lower, uint32_t upper) "%p : %#x %#x"
 
 e1000e_ring_free_space(int ridx, uint32_t rdlen, uint32_t rdh, uint32_t rdt) "ring #%d: LEN: %u, DH: %u, DT: %u"
 
@@ -144,15 +144,15 @@ e1000e_rx_can_recv_rings_full(void) "Cannot receive: all rings are full"
 e1000e_rx_can_recv(void) "Can receive"
 e1000e_rx_has_buffers(int ridx, uint32_t free_desc, size_t total_size, uint32_t desc_buf_size) "ring #%d: free descr: %u, packet size %zu, descr buffer size %u"
 e1000e_rx_null_descriptor(void) "Null RX descriptor!!"
-e1000e_rx_flt_vlan_mismatch(uint16_t vid) "VID mismatch: 0x%X"
-e1000e_rx_flt_vlan_match(uint16_t vid) "VID match: 0x%X"
-e1000e_rx_desc_ps_read(uint64_t a0, uint64_t a1, uint64_t a2, uint64_t a3) "buffers: [0x%"PRIx64", 0x%"PRIx64", 0x%"PRIx64", 0x%"PRIx64"]"
+e1000e_rx_flt_vlan_mismatch(uint16_t vid) "VID mismatch: %#X"
+e1000e_rx_flt_vlan_match(uint16_t vid) "VID match: %#X"
+e1000e_rx_desc_ps_read(uint64_t a0, uint64_t a1, uint64_t a2, uint64_t a3) "buffers: [%#"PRIx64", %#"PRIx64", %#"PRIx64", %#"PRIx64"]"
 e1000e_rx_desc_ps_write(uint16_t a0, uint16_t a1, uint16_t a2, uint16_t a3) "bytes written: [%u, %u, %u, %u]"
 e1000e_rx_desc_buff_sizes(uint32_t b0, uint32_t b1, uint32_t b2, uint32_t b3) "buffer sizes: [%u, %u, %u, %u]"
 e1000e_rx_desc_len(uint8_t rx_desc_len) "RX descriptor length: %u"
-e1000e_rx_desc_buff_write(uint8_t idx, uint64_t addr, uint16_t offset, const void* source, uint32_t len) "buffer #%u, addr: 0x%"PRIx64", offset: %u, from: %p, length: %u"
-e1000e_rx_descr(int ridx, uint64_t base, uint8_t len) "Next RX descriptor: ring #%d, PA: 0x%"PRIx64", length: %u"
-e1000e_rx_set_rctl(uint32_t rctl) "RCTL = 0x%x"
+e1000e_rx_desc_buff_write(uint8_t idx, uint64_t addr, uint16_t offset, const void* source, uint32_t len) "buffer #%u, addr: %#"PRIx64", offset: %u, from: %p, length: %u"
+e1000e_rx_descr(int ridx, uint64_t base, uint8_t len) "Next RX descriptor: ring #%d, PA: %#"PRIx64", length: %u"
+e1000e_rx_set_rctl(uint32_t rctl) "RCTL = %#x"
 e1000e_rx_receive_iov(int iovcnt) "Received vector of %d fragments"
 e1000e_rx_flt_dropped(void) "Received packet dropped by RX filter"
 e1000e_rx_written_to_guest(uint32_t causes) "Received packet written to guest (ICR causes %u)"
@@ -161,21 +161,21 @@ e1000e_rx_interrupt_set(uint32_t causes) "Receive interrupt set (ICR causes %u)"
 e1000e_rx_interrupt_delayed(uint32_t causes) "Receive interrupt delayed (ICR causes %u)"
 e1000e_rx_set_cso(int cso_state) "RX CSO state set to %d"
 e1000e_rx_set_rdt(int queue_idx, uint32_t val) "Setting RDT[%d] = %u"
-e1000e_rx_set_rfctl(uint32_t val) "Setting RFCTL = 0x%X"
+e1000e_rx_set_rfctl(uint32_t val) "Setting RFCTL = %#X"
 e1000e_rx_start_recv(void)
 
 e1000e_rx_rss_started(void) "Starting RSS processing"
 e1000e_rx_rss_disabled(void) "RSS is disabled"
 e1000e_rx_rss_type(uint32_t type) "RSS type is %u"
-e1000e_rx_rss_ip4(bool isfragment, bool istcp, uint32_t mrqc, bool tcpipv4_enabled, bool ipv4_enabled) "RSS IPv4: fragment %d, tcp %d, mrqc 0x%X, tcpipv4 enabled %d, ipv4 enabled %d"
-e1000e_rx_rss_ip6_rfctl(uint32_t rfctl) "RSS IPv6: rfctl 0x%X"
-e1000e_rx_rss_ip6(bool ex_dis, bool new_ex_dis, bool istcp, bool has_ext_headers, bool ex_dst_valid, bool ex_src_valid, uint32_t mrqc, bool tcpipv6_enabled, bool ipv6ex_enabled, bool ipv6_enabled) "RSS IPv6: ex_dis: %d, new_ex_dis: %d, tcp %d, has_ext_headers %d, ex_dst_valid %d, ex_src_valid %d, mrqc 0x%X, tcpipv6 enabled %d, ipv6ex enabled %d, ipv6 enabled %d"
+e1000e_rx_rss_ip4(bool isfragment, bool istcp, uint32_t mrqc, bool tcpipv4_enabled, bool ipv4_enabled) "RSS IPv4: fragment %d, tcp %d, mrqc %#X, tcpipv4 enabled %d, ipv4 enabled %d"
+e1000e_rx_rss_ip6_rfctl(uint32_t rfctl) "RSS IPv6: rfctl %#X"
+e1000e_rx_rss_ip6(bool ex_dis, bool new_ex_dis, bool istcp, bool has_ext_headers, bool ex_dst_valid, bool ex_src_valid, uint32_t mrqc, bool tcpipv6_enabled, bool ipv6ex_enabled, bool ipv6_enabled) "RSS IPv6: ex_dis: %d, new_ex_dis: %d, tcp %d, has_ext_headers %d, ex_dst_valid %d, ex_src_valid %d, mrqc %#X, tcpipv6 enabled %d, ipv6ex enabled %d, ipv6 enabled %d"
 e1000e_rx_rss_dispatched_to_queue(int queue_idx) "Packet being dispatched to queue %d"
 
 e1000e_rx_metadata_protocols(bool isip4, bool isip6, bool isudp, bool istcp) "protocols: ip4: %d, ip6: %d, udp: %d, tcp: %d"
-e1000e_rx_metadata_vlan(uint16_t vlan_tag) "VLAN tag is 0x%X"
-e1000e_rx_metadata_rss(uint32_t rss, uint32_t mrq) "RSS data: rss: 0x%X, mrq: 0x%X"
-e1000e_rx_metadata_ip_id(uint16_t ip_id) "the IPv4 ID is 0x%X"
+e1000e_rx_metadata_vlan(uint16_t vlan_tag) "VLAN tag is %#X"
+e1000e_rx_metadata_rss(uint32_t rss, uint32_t mrq) "RSS data: rss: %#X, mrq: %#X"
+e1000e_rx_metadata_ip_id(uint16_t ip_id) "the IPv4 ID is %#X"
 e1000e_rx_metadata_ack(void) "the packet is TCP ACK"
 e1000e_rx_metadata_pkt_type(uint32_t pkt_type) "the packet type is %u"
 e1000e_rx_metadata_no_virthdr(void) "the packet has no virt-header"
@@ -184,58 +184,58 @@ e1000e_rx_metadata_l3_cso_disabled(void) "IP4 CSO is disabled"
 e1000e_rx_metadata_l4_cso_disabled(void) "TCP/UDP CSO is disabled"
 e1000e_rx_metadata_l3_csum_validation_failed(void) "Cannot validate L3 checksum"
 e1000e_rx_metadata_l4_csum_validation_failed(void) "Cannot validate L4 checksum"
-e1000e_rx_metadata_status_flags(uint32_t status_flags) "status_flags is 0x%X"
+e1000e_rx_metadata_status_flags(uint32_t status_flags) "status_flags is %#X"
 e1000e_rx_metadata_ipv6_sum_disabled(void) "IPv6 RX checksummimg disabled by RFCTL"
 e1000e_rx_metadata_ipv6_filtering_disabled(void) "IPv6 RX filtering disabled by RFCTL"
 
-e1000e_vlan_vet(uint16_t vet) "Setting VLAN ethernet type 0x%X"
+e1000e_vlan_vet(uint16_t vet) "Setting VLAN ethernet type %#X"
 
-e1000e_irq_msi_notify(uint32_t cause) "MSI notify 0x%x"
+e1000e_irq_msi_notify(uint32_t cause) "MSI notify %#x"
 e1000e_irq_throttling_no_pending_interrupts(void) "No pending interrupts to notify"
 e1000e_irq_msi_notify_postponed(void) "Sending MSI postponed by ITR"
 e1000e_irq_legacy_notify_postponed(void) "Raising legacy IRQ postponed by ITR"
 e1000e_irq_throttling_no_pending_vec(int idx) "No pending interrupts for vector %d"
 e1000e_irq_msix_notify_postponed_vec(int idx) "Sending MSI-X postponed by EITR[%d]"
 e1000e_irq_legacy_notify(bool level) "IRQ line state: %d"
-e1000e_irq_msix_notify_vec(uint32_t vector) "MSI-X notify vector 0x%x"
-e1000e_irq_postponed_by_xitr(uint32_t reg) "Interrupt postponed by [E]ITR register 0x%x"
-e1000e_irq_clear_ims(uint32_t bits, uint32_t old_ims, uint32_t new_ims) "Clearing IMS bits 0x%x: 0x%x --> 0x%x"
-e1000e_irq_set_ims(uint32_t bits, uint32_t old_ims, uint32_t new_ims) "Setting IMS bits 0x%x: 0x%x --> 0x%x"
-e1000e_irq_fix_icr_asserted(uint32_t new_val) "ICR_ASSERTED bit fixed: 0x%x"
-e1000e_irq_add_msi_other(uint32_t new_val) "ICR_OTHER bit added: 0x%x"
-e1000e_irq_pending_interrupts(uint32_t pending, uint32_t icr, uint32_t ims) "ICR PENDING: 0x%x (ICR: 0x%x, IMS: 0x%x)"
-e1000e_irq_set_cause_entry(uint32_t val, uint32_t icr) "Going to set IRQ cause 0x%x, ICR: 0x%x"
-e1000e_irq_set_cause_exit(uint32_t val, uint32_t icr) "Set IRQ cause 0x%x, ICR: 0x%x"
-e1000e_irq_icr_write(uint32_t bits, uint32_t old_icr, uint32_t new_icr) "Clearing ICR bits 0x%x: 0x%x --> 0x%x"
-e1000e_irq_write_ics(uint32_t val) "Adding ICR bits 0x%x"
+e1000e_irq_msix_notify_vec(uint32_t vector) "MSI-X notify vector %#x"
+e1000e_irq_postponed_by_xitr(uint32_t reg) "Interrupt postponed by [E]ITR register %#x"
+e1000e_irq_clear_ims(uint32_t bits, uint32_t old_ims, uint32_t new_ims) "Clearing IMS bits %#x: %#x --> %#x"
+e1000e_irq_set_ims(uint32_t bits, uint32_t old_ims, uint32_t new_ims) "Setting IMS bits %#x: %#x --> %#x"
+e1000e_irq_fix_icr_asserted(uint32_t new_val) "ICR_ASSERTED bit fixed: %#x"
+e1000e_irq_add_msi_other(uint32_t new_val) "ICR_OTHER bit added: %#x"
+e1000e_irq_pending_interrupts(uint32_t pending, uint32_t icr, uint32_t ims) "ICR PENDING: %#x (ICR: %#x, IMS: %#x)"
+e1000e_irq_set_cause_entry(uint32_t val, uint32_t icr) "Going to set IRQ cause %#x, ICR: %#x"
+e1000e_irq_set_cause_exit(uint32_t val, uint32_t icr) "Set IRQ cause %#x, ICR: %#x"
+e1000e_irq_icr_write(uint32_t bits, uint32_t old_icr, uint32_t new_icr) "Clearing ICR bits %#x: %#x --> %#x"
+e1000e_irq_write_ics(uint32_t val) "Adding ICR bits %#x"
 e1000e_irq_icr_process_iame(void) "Clearing IMS bits due to IAME"
-e1000e_irq_read_ics(uint32_t ics) "Current ICS: 0x%x"
-e1000e_irq_read_ims(uint32_t ims) "Current IMS: 0x%x"
-e1000e_irq_icr_read_entry(uint32_t icr) "Starting ICR read. Current ICR: 0x%x"
-e1000e_irq_icr_read_exit(uint32_t icr) "Ending ICR read. Current ICR: 0x%x"
+e1000e_irq_read_ics(uint32_t ics) "Current ICS: %#x"
+e1000e_irq_read_ims(uint32_t ims) "Current IMS: %#x"
+e1000e_irq_icr_read_entry(uint32_t icr) "Starting ICR read. Current ICR: %#x"
+e1000e_irq_icr_read_exit(uint32_t icr) "Ending ICR read. Current ICR: %#x"
 e1000e_irq_icr_clear_zero_ims(void) "Clearing ICR on read due to zero IMS"
 e1000e_irq_icr_clear_iame(void) "Clearing ICR on read due to IAME"
-e1000e_irq_iam_clear_eiame(uint32_t iam, uint32_t cause) "Clearing IMS due to EIAME, IAM: 0x%X, cause: 0x%X"
-e1000e_irq_icr_clear_eiac(uint32_t icr, uint32_t eiac) "Clearing ICR bits due to EIAC, ICR: 0x%X, EIAC: 0x%X"
-e1000e_irq_ims_clear_set_imc(uint32_t val) "Clearing IMS bits due to IMC write 0x%x"
+e1000e_irq_iam_clear_eiame(uint32_t iam, uint32_t cause) "Clearing IMS due to EIAME, IAM: %#X, cause: %#X"
+e1000e_irq_icr_clear_eiac(uint32_t icr, uint32_t eiac) "Clearing ICR bits due to EIAC, ICR: %#X, EIAC: %#X"
+e1000e_irq_ims_clear_set_imc(uint32_t val) "Clearing IMS bits due to IMC write %#x"
 e1000e_irq_fire_delayed_interrupts(void) "Firing delayed interrupts"
-e1000e_irq_rearm_timer(uint32_t reg, int64_t delay_ns) "Mitigation timer armed for register 0x%X, delay %"PRId64" ns"
-e1000e_irq_throttling_timer(uint32_t reg) "Mitigation timer shot for register 0x%X"
+e1000e_irq_rearm_timer(uint32_t reg, int64_t delay_ns) "Mitigation timer armed for register %#X, delay %"PRId64" ns"
+e1000e_irq_throttling_timer(uint32_t reg) "Mitigation timer shot for register %#X"
 e1000e_irq_rdtr_fpd_running(void) "FPD written while RDTR was running"
 e1000e_irq_rdtr_fpd_not_running(void) "FPD written while RDTR was not running"
 e1000e_irq_tidv_fpd_running(void) "FPD written while TIDV was running"
 e1000e_irq_tidv_fpd_not_running(void) "FPD written while TIDV was not running"
 e1000e_irq_eitr_set(uint32_t eitr_num, uint32_t val) "EITR[%u] = %u"
 e1000e_irq_itr_set(uint32_t val) "ITR = %u"
-e1000e_irq_fire_all_timers(uint32_t val) "Firing all delay/throttling timers on all interrupts enable (0x%X written to IMS)"
-e1000e_irq_adding_delayed_causes(uint32_t val, uint32_t icr) "Merging delayed causes 0x%X to ICR 0x%X"
-e1000e_irq_msix_pending_clearing(uint32_t cause, uint32_t int_cfg, uint32_t vec) "Clearing MSI-X pending bit for cause 0x%x, IVAR config 0x%x, vector %u"
+e1000e_irq_fire_all_timers(uint32_t val) "Firing all delay/throttling timers on all interrupts enable (%#X written to IMS)"
+e1000e_irq_adding_delayed_causes(uint32_t val, uint32_t icr) "Merging delayed causes %#X to ICR %#X"
+e1000e_irq_msix_pending_clearing(uint32_t cause, uint32_t int_cfg, uint32_t vec) "Clearing MSI-X pending bit for cause %#x, IVAR config %#x, vector %u"
 
-e1000e_wrn_msix_vec_wrong(uint32_t cause, uint32_t cfg) "Invalid configuration for cause 0x%x: 0x%x"
-e1000e_wrn_msix_invalid(uint32_t cause, uint32_t cfg) "Invalid entry for cause 0x%x: 0x%x"
+e1000e_wrn_msix_vec_wrong(uint32_t cause, uint32_t cfg) "Invalid configuration for cause %#x: %#x"
+e1000e_wrn_msix_invalid(uint32_t cause, uint32_t cfg) "Invalid entry for cause %#x: %#x"
 
-e1000e_mac_set_permanent(uint8_t b0, uint8_t b1, uint8_t b2, uint8_t b3, uint8_t b4, uint8_t b5) "Set permanent MAC: %02x:%02x:%02x:%02x:%02x:%02x"
-e1000e_mac_set_sw(uint8_t b0, uint8_t b1, uint8_t b2, uint8_t b3, uint8_t b4, uint8_t b5) "Set SW MAC: %02x:%02x:%02x:%02x:%02x:%02x"
+e1000e_mac_set_permanent(uint8_t b0, uint8_t b1, uint8_t b2, uint8_t b3, uint8_t b4, uint8_t b5) "Set permanent MAC: %#02x:%#02x:%#02x:%#02x:%#02x:%#02x"
+e1000e_mac_set_sw(uint8_t b0, uint8_t b1, uint8_t b2, uint8_t b3, uint8_t b4, uint8_t b5) "Set SW MAC: %#02x:%#02x:%#02x:%#02x:%#02x:%#02x"
 
 # hw/net/e1000e.c
 e1000e_cb_pci_realize(void) "E1000E PCI realize entry"
@@ -244,15 +244,15 @@ e1000e_cb_qdev_reset(void) "E1000E qdev reset entry"
 e1000e_cb_pre_save(void) "E1000E pre save entry"
 e1000e_cb_post_load(void) "E1000E post load entry"
 
-e1000e_io_write_addr(uint64_t addr) "IOADDR write 0x%"PRIx64
-e1000e_io_write_data(uint64_t addr, uint64_t val) "IODATA write 0x%"PRIx64", value: 0x%"PRIx64
-e1000e_io_read_addr(uint64_t addr) "IOADDR read 0x%"PRIx64
-e1000e_io_read_data(uint64_t addr, uint64_t val) "IODATA read 0x%"PRIx64", value: 0x%"PRIx64
-e1000e_wrn_io_write_unknown(uint64_t addr) "IO write unknown address 0x%"PRIx64
-e1000e_wrn_io_read_unknown(uint64_t addr) "IO read unknown address 0x%"PRIx64
-e1000e_wrn_io_addr_undefined(uint64_t addr) "IO undefined register 0x%"PRIx64
-e1000e_wrn_io_addr_flash(uint64_t addr) "IO flash access (0x%"PRIx64") not implemented"
-e1000e_wrn_io_addr_unknown(uint64_t addr) "IO unknown register 0x%"PRIx64
+e1000e_io_write_addr(uint64_t addr) "IOADDR write %#"PRIx64
+e1000e_io_write_data(uint64_t addr, uint64_t val) "IODATA write %#"PRIx64", value: %#"PRIx64
+e1000e_io_read_addr(uint64_t addr) "IOADDR read %#"PRIx64
+e1000e_io_read_data(uint64_t addr, uint64_t val) "IODATA read %#"PRIx64", value: %#"PRIx64
+e1000e_wrn_io_write_unknown(uint64_t addr) "IO write unknown address %#"PRIx64
+e1000e_wrn_io_read_unknown(uint64_t addr) "IO read unknown address %#"PRIx64
+e1000e_wrn_io_addr_undefined(uint64_t addr) "IO undefined register %#"PRIx64
+e1000e_wrn_io_addr_flash(uint64_t addr) "IO flash access (%#"PRIx64") not implemented"
+e1000e_wrn_io_addr_unknown(uint64_t addr) "IO unknown register %#"PRIx64
 
 e1000e_msi_init_fail(int32_t res) "Failed to initialize MSI, error %d"
 e1000e_msix_init_fail(int32_t res) "Failed to initialize MSI-X, error %d"
@@ -265,16 +265,16 @@ e1000e_vm_state_stopped(void) "VM state is stopped"
 
 # hw/net/spapr_llan.c
 spapr_vlan_get_rx_bd_from_pool_found(int pool, int32_t count, uint32_t rx_bufs) "pool=%d count=%"PRId32" rxbufs=%"PRIu32
-spapr_vlan_get_rx_bd_from_page(int buf_ptr, uint64_t bd) "use_buf_ptr=%d bd=0x%016"PRIx64
+spapr_vlan_get_rx_bd_from_page(int buf_ptr, uint64_t bd) "use_buf_ptr=%d bd=%#016"PRIx64
 spapr_vlan_get_rx_bd_from_page_found(uint32_t use_buf_ptr, uint32_t rx_bufs) "ptr=%"PRIu32" rxbufs=%"PRIu32
 spapr_vlan_receive(const char *id, uint32_t rx_bufs) "[%s] rx_bufs=%"PRIu32
 spapr_vlan_receive_dma_completed(void) "DMA write completed"
-spapr_vlan_receive_wrote(uint64_t ptr, uint64_t hi, uint64_t lo) "rxq entry (ptr=0x%"PRIx64"): 0x%016"PRIx64" 0x%016"PRIx64
+spapr_vlan_receive_wrote(uint64_t ptr, uint64_t hi, uint64_t lo) "rxq entry (ptr=%#"PRIx64"): %#016"PRIx64" %#016"PRIx64
 spapr_vlan_add_rxbuf_to_pool_create(int pool, uint64_t len) "created RX pool %d for size %"PRIu64
 spapr_vlan_add_rxbuf_to_pool(int pool, uint64_t len, int32_t count) "add buf using pool %d (size %"PRIu64", count=%"PRId32")"
-spapr_vlan_add_rxbuf_to_page(uint32_t ptr, uint32_t rx_bufs, uint64_t bd) "added buf ptr=%"PRIu32"  rx_bufs=%"PRIu32" bd=0x%016"PRIx64
-spapr_vlan_h_add_logical_lan_buffer(uint64_t reg, uint64_t buf) "H_ADD_LOGICAL_LAN_BUFFER(0x%"PRIx64", 0x%"PRIx64")"
-spapr_vlan_h_send_logical_lan(uint64_t reg, uint64_t continue_token) "H_SEND_LOGICAL_LAN(0x%"PRIx64", <bufs>, 0x%"PRIx64")"
+spapr_vlan_add_rxbuf_to_page(uint32_t ptr, uint32_t rx_bufs, uint64_t bd) "added buf ptr=%"PRIu32"  rx_bufs=%"PRIu32" bd=%#016"PRIx64
+spapr_vlan_h_add_logical_lan_buffer(uint64_t reg, uint64_t buf) "H_ADD_LOGICAL_LAN_BUFFER(%#"PRIx64", %#"PRIx64")"
+spapr_vlan_h_send_logical_lan(uint64_t reg, uint64_t continue_token) "H_SEND_LOGICAL_LAN(%#"PRIx64", <bufs>, %#"PRIx64")"
 spapr_vlan_h_send_logical_lan_rxbufs(uint32_t rx_bufs) "rxbufs = %"PRIu32
-spapr_vlan_h_send_logical_lan_buf_desc(uint64_t buf) "   buf desc: 0x%"PRIx64
-spapr_vlan_h_send_logical_lan_total(int nbufs, unsigned total_len) "%d buffers, total length 0x%x"
+spapr_vlan_h_send_logical_lan_buf_desc(uint64_t buf) "   buf desc: %#"PRIx64
+spapr_vlan_h_send_logical_lan_total(int nbufs, unsigned total_len) "%d buffers, total length %#x"
diff --git a/hw/nvram/trace-events b/hw/nvram/trace-events
index 1f1e05ab69..5c3e2811f1 100644
--- a/hw/nvram/trace-events
+++ b/hw/nvram/trace-events
@@ -1,10 +1,10 @@
 # See docs/tracing.txt for syntax documentation.
 
 # hw/nvram/ds1225y.c
-nvram_read(uint32_t addr, uint32_t ret) "read addr %d: 0x%02x"
-nvram_write(uint32_t addr, uint32_t old, uint32_t val) "write addr %d: 0x%02x -> 0x%02x"
+nvram_read(uint32_t addr, uint32_t ret) "read addr %d: %#02x"
+nvram_write(uint32_t addr, uint32_t old, uint32_t val) "write addr %d: %#02x -> %#02x"
 
 # hw/nvram/fw_cfg.c
 fw_cfg_select(void *s, uint16_t key, int ret) "%p key %d = %d"
-fw_cfg_read(void *s, uint64_t ret) "%p = %"PRIx64
+fw_cfg_read(void *s, uint64_t ret) "%p = %#"PRIx64
 fw_cfg_add_file(void *s, int index, char *name, size_t len) "%p #%d: %s (%zd bytes)"
diff --git a/hw/pci/trace-events b/hw/pci/trace-events
index 83c8f5ace7..185cd7bbc3 100644
--- a/hw/pci/trace-events
+++ b/hw/pci/trace-events
@@ -1,12 +1,12 @@
 # See docs/tracing.txt for syntax documentation.
 
 # hw/pci/pci.c
-pci_update_mappings_del(void *d, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "d=%p %02x:%02x.%x %d,%#"PRIx64"+%#"PRIx64
-pci_update_mappings_add(void *d, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "d=%p %02x:%02x.%x %d,%#"PRIx64"+%#"PRIx64
+pci_update_mappings_del(void *d, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "d=%p %#02x:%#02x.%#x %d,%#"PRIx64"+%#"PRIx64
+pci_update_mappings_add(void *d, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "d=%p %#02x:%#02x.%#x %d,%#"PRIx64"+%#"PRIx64
 
 # hw/pci/pci_host.c
-pci_cfg_read(const char *dev, unsigned devid, unsigned fnid, unsigned offs, unsigned val) "%s %02u:%u @0x%x -> 0x%x"
-pci_cfg_write(const char *dev, unsigned devid, unsigned fnid, unsigned offs, unsigned val) "%s %02u:%u @0x%x <- 0x%x"
+pci_cfg_read(const char *dev, unsigned devid, unsigned fnid, unsigned offs, unsigned val) "%s %02u:%u @%#x -> %#x"
+pci_cfg_write(const char *dev, unsigned devid, unsigned fnid, unsigned offs, unsigned val) "%s %02u:%u @%#x <- %#x"
 
 # hw/pci/msix.c
 msix_write_config(char *name, bool enabled, bool masked) "dev %s enabled %d masked %d"
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 0f7d9be4ef..0f276c435a 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -1,97 +1,97 @@
 # See docs/tracing.txt for syntax documentation.
 
 # hw/ppc/spapr_pci.c
-spapr_pci_msi(const char *msg, uint32_t ca) "%s (cfg=%x)"
-spapr_pci_msi_setup(const char *name, unsigned vector, uint64_t addr) "dev\"%s\" vector %u, addr=%"PRIx64
-spapr_pci_rtas_ibm_change_msi(unsigned cfg, unsigned func, unsigned req, unsigned first) "cfgaddr %x func %u, requested %u, first irq %u"
+spapr_pci_msi(const char *msg, uint32_t ca) "%s (cfg=%#x)"
+spapr_pci_msi_setup(const char *name, unsigned vector, uint64_t addr) "dev\"%s\" vector %u, addr=%#"PRIx64
+spapr_pci_rtas_ibm_change_msi(unsigned cfg, unsigned func, unsigned req, unsigned first) "cfgaddr %#x func %u, requested %u, first irq %u"
 spapr_pci_rtas_ibm_query_interrupt_source_number(unsigned ioa, unsigned intr) "queries for #%u, IRQ%u"
-spapr_pci_msi_write(uint64_t addr, uint64_t data, uint32_t dt_irq) "@%"PRIx64"<=%"PRIx64" IRQ %u"
+spapr_pci_msi_write(uint64_t addr, uint64_t data, uint32_t dt_irq) "@%#"PRIx64"<=%#"PRIx64" IRQ %u"
 spapr_pci_lsi_set(const char *busname, int pin, uint32_t irq) "%s PIN%d IRQ %u"
-spapr_pci_msi_retry(unsigned config_addr, unsigned req_num, unsigned max_irqs) "Guest device at %x asked %u, have only %u"
+spapr_pci_msi_retry(unsigned config_addr, unsigned req_num, unsigned max_irqs) "Guest device at %#x asked %u, have only %u"
 
 # hw/ppc/spapr.c
 spapr_cas_failed(unsigned long n) "DT diff buffer is too small: %ld bytes"
 spapr_cas_continue(unsigned long n) "Copy changes to the guest: %ld bytes"
 
 # hw/ppc/spapr_hcall.c
-spapr_cas_pvr_try(uint32_t pvr) "%x"
-spapr_cas_pvr(uint32_t cur_pvr, bool explicit_match, uint32_t new_pvr) "current=%x, explicit_match=%u, new=%x"
-spapr_h_resize_hpt_prepare(uint64_t flags, uint64_t shift) "flags=0x%"PRIx64", shift=%"PRIu64
-spapr_h_resize_hpt_commit(uint64_t flags, uint64_t shift) "flags=0x%"PRIx64", shift=%"PRIu64
+spapr_cas_pvr_try(uint32_t pvr) "%#x"
+spapr_cas_pvr(uint32_t cur_pvr, bool explicit_match, uint32_t new_pvr) "current=%#x, explicit_match=%u, new=%#x"
+spapr_h_resize_hpt_prepare(uint64_t flags, uint64_t shift) "flags=%#"PRIx64", shift=%"PRIu64
+spapr_h_resize_hpt_commit(uint64_t flags, uint64_t shift) "flags=%#"PRIx64", shift=%"PRIu64
 
 # hw/ppc/spapr_iommu.c
-spapr_iommu_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t ret) "liobn=%"PRIx64" ioba=0x%"PRIx64" tce=0x%"PRIx64" ret=%"PRId64
-spapr_iommu_get(uint64_t liobn, uint64_t ioba, uint64_t ret, uint64_t tce) "liobn=%"PRIx64" ioba=0x%"PRIx64" ret=%"PRId64" tce=0x%"PRIx64
-spapr_iommu_indirect(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t iobaN, uint64_t tceN, uint64_t ret) "liobn=%"PRIx64" ioba=0x%"PRIx64" tcelist=0x%"PRIx64" iobaN=0x%"PRIx64" tceN=0x%"PRIx64" ret=%"PRId64
-spapr_iommu_stuff(uint64_t liobn, uint64_t ioba, uint64_t tce_value, uint64_t npages, uint64_t ret) "liobn=%"PRIx64" ioba=0x%"PRIx64" tcevalue=0x%"PRIx64" npages=%"PRId64" ret=%"PRId64
-spapr_iommu_pci_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t ret) "liobn=%"PRIx64" ioba=0x%"PRIx64" tce=0x%"PRIx64" ret=%"PRId64
-spapr_iommu_pci_get(uint64_t liobn, uint64_t ioba, uint64_t ret, uint64_t tce) "liobn=%"PRIx64" ioba=0x%"PRIx64" ret=%"PRId64" tce=0x%"PRIx64
-spapr_iommu_pci_indirect(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t iobaN, uint64_t tceN, uint64_t ret) "liobn=%"PRIx64" ioba=0x%"PRIx64" tcelist=0x%"PRIx64" iobaN=0x%"PRIx64" tceN=0x%"PRIx64" ret=%"PRId64
-spapr_iommu_pci_stuff(uint64_t liobn, uint64_t ioba, uint64_t tce_value, uint64_t npages, uint64_t ret) "liobn=%"PRIx64" ioba=0x%"PRIx64" tcevalue=0x%"PRIx64" npages=%"PRId64" ret=%"PRId64
-spapr_iommu_xlate(uint64_t liobn, uint64_t ioba, uint64_t tce, unsigned perm, unsigned pgsize) "liobn=%"PRIx64" 0x%"PRIx64" -> 0x%"PRIx64" perm=%u mask=%x"
-spapr_iommu_new_table(uint64_t liobn, void *table, int fd) "liobn=%"PRIx64" table=%p fd=%d"
-spapr_iommu_pre_save(uint64_t liobn, uint32_t nb, uint64_t offs, uint32_t ps) "liobn=%"PRIx64" %"PRIx32" bus_offset=%"PRIx64" ps=%"PRIu32
-spapr_iommu_post_load(uint64_t liobn, uint32_t pre_nb, uint32_t post_nb, uint64_t offs, uint32_t ps) "liobn=%"PRIx64" %"PRIx32" => %"PRIx32" bus_offset=%"PRIx64" ps=%"PRIu32
-spapr_iommu_ddw_query(uint64_t buid, uint32_t cfgaddr, unsigned wa, uint64_t win_size, uint32_t pgmask) "buid=%"PRIx64" addr=%"PRIx32", %u windows available, max window size=%"PRIx64", mask=%"PRIx32
-spapr_iommu_ddw_create(uint64_t buid, uint32_t cfgaddr, uint64_t pg_size, uint64_t req_size, uint64_t start, uint32_t liobn) "buid=%"PRIx64" addr=%"PRIx32", page size=0x%"PRIx64", requested=0x%"PRIx64", start addr=%"PRIx64", liobn=%"PRIx32
-spapr_iommu_ddw_remove(uint32_t liobn) "liobn=%"PRIx32
-spapr_iommu_ddw_reset(uint64_t buid, uint32_t cfgaddr) "buid=%"PRIx64" addr=%"PRIx32
+spapr_iommu_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t ret) "liobn=%#"PRIx64" ioba=%#"PRIx64" tce=%#"PRIx64" ret=%"PRId64
+spapr_iommu_get(uint64_t liobn, uint64_t ioba, uint64_t ret, uint64_t tce) "liobn=%#"PRIx64" ioba=%#"PRIx64" ret=%"PRId64" tce=%#"PRIx64
+spapr_iommu_indirect(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t iobaN, uint64_t tceN, uint64_t ret) "liobn=%#"PRIx64" ioba=%#"PRIx64" tcelist=%#"PRIx64" iobaN=%#"PRIx64" tceN=%#"PRIx64" ret=%"PRId64
+spapr_iommu_stuff(uint64_t liobn, uint64_t ioba, uint64_t tce_value, uint64_t npages, uint64_t ret) "liobn=%#"PRIx64" ioba=%#"PRIx64" tcevalue=%#"PRIx64" npages=%"PRId64" ret=%"PRId64
+spapr_iommu_pci_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t ret) "liobn=%#"PRIx64" ioba=%#"PRIx64" tce=%#"PRIx64" ret=%"PRId64
+spapr_iommu_pci_get(uint64_t liobn, uint64_t ioba, uint64_t ret, uint64_t tce) "liobn=%#"PRIx64" ioba=%#"PRIx64" ret=%"PRId64" tce=%#"PRIx64
+spapr_iommu_pci_indirect(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t iobaN, uint64_t tceN, uint64_t ret) "liobn=%#"PRIx64" ioba=%#"PRIx64" tcelist=%#"PRIx64" iobaN=%#"PRIx64" tceN=%#"PRIx64" ret=%"PRId64
+spapr_iommu_pci_stuff(uint64_t liobn, uint64_t ioba, uint64_t tce_value, uint64_t npages, uint64_t ret) "liobn=%#"PRIx64" ioba=%#"PRIx64" tcevalue=%#"PRIx64" npages=%"PRId64" ret=%"PRId64
+spapr_iommu_xlate(uint64_t liobn, uint64_t ioba, uint64_t tce, unsigned perm, unsigned pgsize) "liobn=%#"PRIx64" %#"PRIx64" -> %#"PRIx64" perm=%u mask=%#x"
+spapr_iommu_new_table(uint64_t liobn, void *table, int fd) "liobn=%#"PRIx64" table=%p fd=%d"
+spapr_iommu_pre_save(uint64_t liobn, uint32_t nb, uint64_t offs, uint32_t ps) "liobn=%#"PRIx64" %#"PRIx32" bus_offset=%#"PRIx64" ps=%"PRIu32
+spapr_iommu_post_load(uint64_t liobn, uint32_t pre_nb, uint32_t post_nb, uint64_t offs, uint32_t ps) "liobn=%#"PRIx64" %#"PRIx32" => %#"PRIx32" bus_offset=%#"PRIx64" ps=%"PRIu32
+spapr_iommu_ddw_query(uint64_t buid, uint32_t cfgaddr, unsigned wa, uint64_t win_size, uint32_t pgmask) "buid=%#"PRIx64" addr=%#"PRIx32", %u windows available, max window size=%#"PRIx64", mask=%#"PRIx32
+spapr_iommu_ddw_create(uint64_t buid, uint32_t cfgaddr, uint64_t pg_size, uint64_t req_size, uint64_t start, uint32_t liobn) "buid=%#"PRIx64" addr=%#"PRIx32", page size=%#"PRIx64", requested=%#"PRIx64", start addr=%#"PRIx64", liobn=%#"PRIx32
+spapr_iommu_ddw_remove(uint32_t liobn) "liobn=%#"PRIx32
+spapr_iommu_ddw_reset(uint64_t buid, uint32_t cfgaddr) "buid=%#"PRIx64" addr=%#"PRIx32
 
 # hw/ppc/spapr_drc.c
-spapr_drc_set_isolation_state(uint32_t index, int state) "drc: 0x%"PRIx32", state: %"PRIx32
-spapr_drc_set_isolation_state_finalizing(uint32_t index) "drc: 0x%"PRIx32
-spapr_drc_set_isolation_state_deferring(uint32_t index) "drc: 0x%"PRIx32
-spapr_drc_set_dr_indicator(uint32_t index, int state) "drc: 0x%"PRIx32", state: 0x%x"
-spapr_drc_set_allocation_state(uint32_t index, int state) "drc: 0x%"PRIx32", state: 0x%x"
-spapr_drc_set_allocation_state_finalizing(uint32_t index) "drc: 0x%"PRIx32
-spapr_drc_set_configured(uint32_t index) "drc: 0x%"PRIx32
-spapr_drc_set_configured_skipping(uint32_t index) "drc: 0x%"PRIx32", isolated device"
-spapr_drc_attach(uint32_t index) "drc: 0x%"PRIx32
-spapr_drc_detach(uint32_t index) "drc: 0x%"PRIx32
-spapr_drc_awaiting_quiesce(uint32_t index) "drc: 0x%"PRIx32
-spapr_drc_awaiting_allocation(uint32_t index) "drc: 0x%"PRIx32
-spapr_drc_reset(uint32_t index) "drc: 0x%"PRIx32
-spapr_drc_realize(uint32_t index) "drc: 0x%"PRIx32
-spapr_drc_realize_child(uint32_t index, char *childname) "drc: 0x%"PRIx32", child name: %s"
-spapr_drc_realize_complete(uint32_t index) "drc: 0x%"PRIx32
-spapr_drc_unrealize(uint32_t index) "drc: 0x%"PRIx32
+spapr_drc_set_isolation_state(uint32_t index, int state) "drc: %#"PRIx32", state: %#"PRIx32
+spapr_drc_set_isolation_state_finalizing(uint32_t index) "drc: %#"PRIx32
+spapr_drc_set_isolation_state_deferring(uint32_t index) "drc: %#"PRIx32
+spapr_drc_set_dr_indicator(uint32_t index, int state) "drc: %#"PRIx32", state: %#x"
+spapr_drc_set_allocation_state(uint32_t index, int state) "drc: %#"PRIx32", state: %#x"
+spapr_drc_set_allocation_state_finalizing(uint32_t index) "drc: %#"PRIx32
+spapr_drc_set_configured(uint32_t index) "drc: %#"PRIx32
+spapr_drc_set_configured_skipping(uint32_t index) "drc: %#"PRIx32", isolated device"
+spapr_drc_attach(uint32_t index) "drc: %#"PRIx32
+spapr_drc_detach(uint32_t index) "drc: %#"PRIx32
+spapr_drc_awaiting_quiesce(uint32_t index) "drc: %#"PRIx32
+spapr_drc_awaiting_allocation(uint32_t index) "drc: %#"PRIx32
+spapr_drc_reset(uint32_t index) "drc: %#"PRIx32
+spapr_drc_realize(uint32_t index) "drc: %#"PRIx32
+spapr_drc_realize_child(uint32_t index, char *childname) "drc: %#"PRIx32", child name: %s"
+spapr_drc_realize_complete(uint32_t index) "drc: %#"PRIx32
+spapr_drc_unrealize(uint32_t index) "drc: %#"PRIx32
 
 # hw/ppc/spapr_ovec.c
-spapr_ovec_parse_vector(int vector, int byte, uint16_t vec_len, uint8_t entry) "read guest vector %2d, byte %3d / %3d: 0x%.2x"
-spapr_ovec_populate_dt(int byte, uint16_t vec_len, uint8_t entry) "encoding guest vector byte %3d / %3d: 0x%.2x"
+spapr_ovec_parse_vector(int vector, int byte, uint16_t vec_len, uint8_t entry) "read guest vector %2d, byte %3d / %3d: %#.2x"
+spapr_ovec_populate_dt(int byte, uint16_t vec_len, uint8_t entry) "encoding guest vector byte %3d / %3d: %#.2x"
 
 # hw/ppc/spapr_rtas.c
-spapr_rtas_get_sensor_state_not_supported(uint32_t index, uint32_t type) "sensor index: 0x%"PRIx32", type: %"PRIu32
-spapr_rtas_get_sensor_state_invalid(uint32_t index) "sensor index: 0x%"PRIx32
-spapr_rtas_ibm_configure_connector_invalid(uint32_t index) "DRC index: 0x%"PRIx32
-spapr_rtas_ibm_configure_connector_missing_fdt(uint32_t index) "DRC index: 0x%"PRIx32
+spapr_rtas_get_sensor_state_not_supported(uint32_t index, uint32_t type) "sensor index: %#"PRIx32", type: %"PRIu32
+spapr_rtas_get_sensor_state_invalid(uint32_t index) "sensor index: %#"PRIx32
+spapr_rtas_ibm_configure_connector_invalid(uint32_t index) "DRC index: %#"PRIx32
+spapr_rtas_ibm_configure_connector_missing_fdt(uint32_t index) "DRC index: %#"PRIx32
 
 # hw/ppc/spapr_vio.c
-spapr_vio_h_reg_crq(uint64_t reg, uint64_t queue_addr, uint64_t queue_len) "CRQ for dev 0x%" PRIx64 " registered at 0x%" PRIx64 "/0x%" PRIx64
-spapr_vio_free_crq(uint32_t reg) "CRQ for dev 0x%" PRIx32 " freed"
+spapr_vio_h_reg_crq(uint64_t reg, uint64_t queue_addr, uint64_t queue_len) "CRQ for dev %#" PRIx64 " registered at %#" PRIx64 "/%#" PRIx64
+spapr_vio_free_crq(uint32_t reg) "CRQ for dev %#" PRIx32 " freed"
 
 # hw/ppc/ppc.c
-ppc_tb_adjust(uint64_t offs1, uint64_t offs2, int64_t diff, int64_t seconds) "adjusted from 0x%"PRIx64" to 0x%"PRIx64", diff %"PRId64" (%"PRId64"s)"
+ppc_tb_adjust(uint64_t offs1, uint64_t offs2, int64_t diff, int64_t seconds) "adjusted from %#"PRIx64" to %#"PRIx64", diff %"PRId64" (%"PRId64"s)"
 
 # hw/ppc/prep.c
-prep_io_800_writeb(uint32_t addr, uint32_t val) "0x%08" PRIx32 " => 0x%02" PRIx32
-prep_io_800_readb(uint32_t addr, uint32_t retval) "0x%08" PRIx32 " <= 0x%02" PRIx32
+prep_io_800_writeb(uint32_t addr, uint32_t val) "%#08" PRIx32 " => %#02" PRIx32
+prep_io_800_readb(uint32_t addr, uint32_t retval) "%#08" PRIx32 " <= %#02" PRIx32
 
 # hw/ppc/prep_systemio.c
-prep_systemio_read(uint32_t addr, uint32_t val) "read addr=%x val=%x"
-prep_systemio_write(uint32_t addr, uint32_t val) "write addr=%x val=%x"
+prep_systemio_read(uint32_t addr, uint32_t val) "read addr=%#x val=%#x"
+prep_systemio_write(uint32_t addr, uint32_t val) "write addr=%#x val=%#x"
 
 # hw/ppc/rs6000_mc.c
-rs6000mc_id_read(uint32_t addr, uint32_t val) "read addr=%x val=%x"
-rs6000mc_presence_read(uint32_t addr, uint32_t val) "read addr=%x val=%x"
-rs6000mc_size_read(uint32_t addr, uint32_t val) "read addr=%x val=%x"
-rs6000mc_size_write(uint32_t addr, uint32_t val) "write addr=%x val=%x"
-rs6000mc_parity_read(uint32_t addr, uint32_t val) "read addr=%x val=%x"
+rs6000mc_id_read(uint32_t addr, uint32_t val) "read addr=%#x val=%#x"
+rs6000mc_presence_read(uint32_t addr, uint32_t val) "read addr=%#x val=%#x"
+rs6000mc_size_read(uint32_t addr, uint32_t val) "read addr=%#x val=%#x"
+rs6000mc_size_write(uint32_t addr, uint32_t val) "write addr=%#x val=%#x"
+rs6000mc_parity_read(uint32_t addr, uint32_t val) "read addr=%#x val=%#x"
 
 # hw/ppc/mac_newworld.c
-mac99_uninorth_write(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
-mac99_uninorth_read(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
+mac99_uninorth_write(uint64_t addr, uint64_t value) "addr=%#" PRIx64 " val=%#"PRIx64
+mac99_uninorth_read(uint64_t addr, uint64_t value) "addr=%#" PRIx64 " val=%#"PRIx64
 
 # hw/ppc/ppc4xx_pci.c
-ppc4xx_pci_map_irq(int32_t devfn, int irq_num, int slot) "devfn %x irq %d -> %d"
+ppc4xx_pci_map_irq(int32_t devfn, int irq_num, int slot) "devfn %#x irq %d -> %d"
 ppc4xx_pci_set_irq(int irq_num) "PCI irq %d"
diff --git a/hw/s390x/trace-events b/hw/s390x/trace-events
index f07e974678..a18679c5cf 100644
--- a/hw/s390x/trace-events
+++ b/hw/s390x/trace-events
@@ -2,15 +2,15 @@
 
 # hw/s390x/css.c
 css_enable_facility(const char *facility) "CSS: enable %s"
-css_crw(uint8_t rsc, uint8_t erc, uint16_t rsid, const char *chained) "CSS: queueing crw: rsc=%x, erc=%x, rsid=%x %s"
-css_chpid_add(uint8_t cssid, uint8_t chpid, uint8_t type) "CSS: add chpid %x.%02x (type %02x)"
-css_new_image(uint8_t cssid, const char *default_cssid) "CSS: add css image %02x %s"
-css_assign_subch(const char *do_assign, uint8_t cssid, uint8_t ssid, uint16_t schid, uint16_t devno) "CSS: %s %x.%x.%04x (devno %04x)"
-css_io_interrupt(int cssid, int ssid, int schid, uint32_t intparm, uint8_t isc, const char *conditional) "CSS: I/O interrupt on sch %x.%x.%04x (intparm %08x, isc %x) %s"
-css_adapter_interrupt(uint8_t isc) "CSS: adapter I/O interrupt (isc %x)"
-css_do_sic(uint16_t mode, uint8_t isc) "CSS: set interruption mode %x on isc %x"
+css_crw(uint8_t rsc, uint8_t erc, uint16_t rsid, const char *chained) "CSS: queueing crw: rsc=%#x, erc=%#x, rsid=%#x %s"
+css_chpid_add(uint8_t cssid, uint8_t chpid, uint8_t type) "CSS: add chpid %#x.%#02x (type %#02x)"
+css_new_image(uint8_t cssid, const char *default_cssid) "CSS: add css image %#02x %s"
+css_assign_subch(const char *do_assign, uint8_t cssid, uint8_t ssid, uint16_t schid, uint16_t devno) "CSS: %s %#x.%#x.%#04x (devno %#04x)"
+css_io_interrupt(int cssid, int ssid, int schid, uint32_t intparm, uint8_t isc, const char *conditional) "CSS: I/O interrupt on sch %#x.%#x.%#04x (intparm %#08x, isc %#x) %s"
+css_adapter_interrupt(uint8_t isc) "CSS: adapter I/O interrupt (isc %#x)"
+css_do_sic(uint16_t mode, uint8_t isc) "CSS: set interruption mode %#x on isc %#x"
 
 # hw/s390x/virtio-ccw.c
-virtio_ccw_interpret_ccw(int cssid, int ssid, int schid, int cmd_code) "VIRTIO-CCW: %x.%x.%04x: interpret command %x"
-virtio_ccw_new_device(int cssid, int ssid, int schid, int devno, const char *devno_mode) "VIRTIO-CCW: add subchannel %x.%x.%04x, devno %04x (%s)"
-virtio_ccw_set_ind(uint64_t ind_loc, uint8_t ind_old, uint8_t ind_new) "VIRTIO-CCW: indicator at %" PRIu64 ": %x->%x"
+virtio_ccw_interpret_ccw(int cssid, int ssid, int schid, int cmd_code) "VIRTIO-CCW: %#x.%#x.%#04x: interpret command %#x"
+virtio_ccw_new_device(int cssid, int ssid, int schid, int devno, const char *devno_mode) "VIRTIO-CCW: add subchannel %#x.%#x.%#04x, devno %#04x (%s)"
+virtio_ccw_set_ind(uint64_t ind_loc, uint8_t ind_old, uint8_t ind_new) "VIRTIO-CCW: indicator at %" PRIu64 ": %#x->%#x"
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index 4a2e5d66df..4c6b7495a1 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -19,91 +19,91 @@ scsi_test_unit_ready(int target, int lun, int tag) "target %d lun %d tag %d"
 scsi_request_sense(int target, int lun, int tag) "target %d lun %d tag %d"
 
 # hw/scsi/mptsas.c
-mptsas_command_complete(void *dev, uint32_t ctx, uint32_t status, uint32_t resid) "dev %p context 0x%08x status %x resid %d"
-mptsas_diag_read(void *dev, uint32_t addr, uint32_t val) "dev %p addr 0x%08x value 0x%08x"
-mptsas_diag_write(void *dev, uint32_t addr, uint32_t val) "dev %p addr 0x%08x value 0x%08x"
+mptsas_command_complete(void *dev, uint32_t ctx, uint32_t status, uint32_t resid) "dev %p context %#08x status %#x resid %d"
+mptsas_diag_read(void *dev, uint32_t addr, uint32_t val) "dev %p addr %#08x value %#08x"
+mptsas_diag_write(void *dev, uint32_t addr, uint32_t val) "dev %p addr %#08x value %#08x"
 mptsas_irq_intx(void *dev, int level) "dev %p level %d"
 mptsas_irq_msi(void *dev) "dev %p "
-mptsas_mmio_read(void *dev, uint32_t addr, uint32_t val) "dev %p addr 0x%08x value 0x%x"
-mptsas_mmio_unhandled_read(void *dev, uint32_t addr) "dev %p addr 0x%08x"
-mptsas_mmio_unhandled_write(void *dev, uint32_t addr, uint32_t val) "dev %p addr 0x%08x value 0x%x"
-mptsas_mmio_write(void *dev, uint32_t addr, uint32_t val) "dev %p addr 0x%08x value 0x%x"
-mptsas_process_message(void *dev, int msg, uint32_t ctx) "dev %p cmd %d context 0x%08x\n"
+mptsas_mmio_read(void *dev, uint32_t addr, uint32_t val) "dev %p addr %#08x value %#x"
+mptsas_mmio_unhandled_read(void *dev, uint32_t addr) "dev %p addr %#08x"
+mptsas_mmio_unhandled_write(void *dev, uint32_t addr, uint32_t val) "dev %p addr %#08x value %#x"
+mptsas_mmio_write(void *dev, uint32_t addr, uint32_t val) "dev %p addr %#08x value %#x"
+mptsas_process_message(void *dev, int msg, uint32_t ctx) "dev %p cmd %d context %#08x\n"
 mptsas_process_scsi_io_request(void *dev, int bus, int target, int lun, uint64_t len) "dev %p dev %d:%d:%d length %"PRIu64""
 mptsas_reset(void *dev) "dev %p "
-mptsas_scsi_overflow(void *dev, uint32_t ctx, uint64_t req, uint64_t found) "dev %p context 0x%08x: %"PRIu64"/%"PRIu64""
-mptsas_sgl_overflow(void *dev, uint32_t ctx, uint64_t req, uint64_t found) "dev %p context 0x%08x: %"PRIu64"/%"PRIu64""
-mptsas_unhandled_cmd(void *dev, uint32_t ctx, uint8_t msg_cmd) "dev %p context 0x%08x: Unhandled cmd %x"
-mptsas_unhandled_doorbell_cmd(void *dev, int cmd) "dev %p value 0x%08x"
+mptsas_scsi_overflow(void *dev, uint32_t ctx, uint64_t req, uint64_t found) "dev %p context %#08x: %"PRIu64"/%"PRIu64""
+mptsas_sgl_overflow(void *dev, uint32_t ctx, uint64_t req, uint64_t found) "dev %p context %#08x: %"PRIu64"/%"PRIu64""
+mptsas_unhandled_cmd(void *dev, uint32_t ctx, uint8_t msg_cmd) "dev %p context %#08x: Unhandled cmd %#x"
+mptsas_unhandled_doorbell_cmd(void *dev, int cmd) "dev %p value %#08x"
 
 # hw/scsi/mptconfig.c
 mptsas_config_sas_device(void *dev, int address, int port, int phy_handle, int dev_handle, int page) "dev %p address %d (port %d, handles: phy %d dev %d) page %d"
 mptsas_config_sas_phy(void *dev, int address, int port, int phy_handle, int dev_handle, int page) "dev %p address %d (port %d, handles: phy %d dev %d) page %d"
 
 # hw/scsi/megasas.c
-megasas_init_firmware(uint64_t pa) "pa %" PRIx64 " "
-megasas_init_queue(uint64_t queue_pa, int queue_len, uint64_t head, uint64_t tail, uint32_t flags) "queue at %" PRIx64 " len %d head %" PRIx64 " tail %" PRIx64 " flags %x"
+megasas_init_firmware(uint64_t pa) "pa %#" PRIx64 " "
+megasas_init_queue(uint64_t queue_pa, int queue_len, uint64_t head, uint64_t tail, uint32_t flags) "queue at %#" PRIx64 " len %d head %#" PRIx64 " tail %#" PRIx64 " flags %#x"
 megasas_initq_map_failed(int frame) "scmd %d: failed to map queue"
-megasas_initq_mapped(uint64_t pa) "queue already mapped at %" PRIx64
+megasas_initq_mapped(uint64_t pa) "queue already mapped at %#" PRIx64
 megasas_initq_mismatch(int queue_len, int fw_cmds) "queue size %d max fw cmds %d"
-megasas_qf_mapped(unsigned int index) "skip mapped frame %x"
-megasas_qf_new(unsigned int index, uint64_t frame) "frame %x addr %" PRIx64
-megasas_qf_busy(unsigned long pa) "all frames busy for frame %lx"
-megasas_qf_enqueue(unsigned int index, unsigned int count, uint64_t context, unsigned int head, unsigned int tail, int busy) "frame %x count %d context %" PRIx64 " head %x tail %x busy %d"
-megasas_qf_update(unsigned int head, unsigned int tail, unsigned int busy) "head %x tail %x busy %d"
+megasas_qf_mapped(unsigned int index) "skip mapped frame %#x"
+megasas_qf_new(unsigned int index, uint64_t frame) "frame %#x addr %#" PRIx64
+megasas_qf_busy(unsigned long pa) "all frames busy for frame %#lx"
+megasas_qf_enqueue(unsigned int index, unsigned int count, uint64_t context, unsigned int head, unsigned int tail, int busy) "frame %#x count %d context %#" PRIx64 " head %#x tail %#x busy %d"
+megasas_qf_update(unsigned int head, unsigned int tail, unsigned int busy) "head %#x tail %#x busy %d"
 megasas_qf_map_failed(int cmd, unsigned long frame) "scmd %d: frame %lu"
-megasas_qf_complete_noirq(uint64_t context) "context %" PRIx64 " "
-megasas_qf_complete(uint64_t context, unsigned int head, unsigned int tail, int busy) "context %" PRIx64 " head %x tail %x busy %d"
-megasas_frame_busy(uint64_t addr) "frame %" PRIx64 " busy"
-megasas_unhandled_frame_cmd(int cmd, uint8_t frame_cmd) "scmd %d: MFI cmd %x"
-megasas_handle_scsi(const char *frame, int bus, int dev, int lun, void *sdev, unsigned long size) "%s dev %x/%x/%x sdev %p xfer %lu"
-megasas_scsi_target_not_present(const char *frame, int bus, int dev, int lun) "%s dev %x/%x/%x"
-megasas_scsi_invalid_cdb_len(const char *frame, int bus, int dev, int lun, int len) "%s dev %x/%x/%x invalid cdb len %d"
+megasas_qf_complete_noirq(uint64_t context) "context %#" PRIx64 " "
+megasas_qf_complete(uint64_t context, unsigned int head, unsigned int tail, int busy) "context %#" PRIx64 " head %#x tail %#x busy %d"
+megasas_frame_busy(uint64_t addr) "frame %#" PRIx64 " busy"
+megasas_unhandled_frame_cmd(int cmd, uint8_t frame_cmd) "scmd %d: MFI cmd %#x"
+megasas_handle_scsi(const char *frame, int bus, int dev, int lun, void *sdev, unsigned long size) "%s dev %#x/%#x/%#x sdev %p xfer %lu"
+megasas_scsi_target_not_present(const char *frame, int bus, int dev, int lun) "%s dev %#x/%#x/%#x"
+megasas_scsi_invalid_cdb_len(const char *frame, int bus, int dev, int lun, int len) "%s dev %#x/%#x/%#x invalid cdb len %d"
 megasas_iov_read_overflow(int cmd, int bytes, int len) "scmd %d: %d/%d bytes"
 megasas_iov_write_overflow(int cmd, int bytes, int len) "scmd %d: %d/%d bytes"
 megasas_iov_read_underflow(int cmd, int bytes, int len) "scmd %d: %d/%d bytes"
 megasas_iov_write_underflow(int cmd, int bytes, int len) "scmd %d: %d/%d bytes"
-megasas_scsi_req_alloc_failed(const char *frame, int dev, int lun) "%s dev %x/%x"
+megasas_scsi_req_alloc_failed(const char *frame, int dev, int lun) "%s dev %#x/%#x"
 megasas_scsi_read_start(int cmd, int len) "scmd %d: transfer %d bytes of data"
 megasas_scsi_write_start(int cmd, int len) "scmd %d: transfer %d bytes of data"
 megasas_scsi_nodata(int cmd) "scmd %d: no data to be transferred"
-megasas_scsi_complete(int cmd, uint32_t status, int len, int xfer) "scmd %d: status %x, len %u/%u"
-megasas_command_complete(int cmd, uint32_t status, uint32_t resid) "scmd %d: status %x, residual %d"
-megasas_handle_io(int cmd, const char *frame, int dev, int lun, unsigned long lba, unsigned long count) "scmd %d: %s dev %x/%x lba %lx count %lu"
-megasas_io_target_not_present(int cmd, const char *frame, int dev, int lun) "scmd %d: %s dev 1/%x/%x LUN not present"
-megasas_io_read_start(int cmd, unsigned long lba, unsigned long count, unsigned long len) "scmd %d: start LBA %lx %lu blocks (%lu bytes)"
-megasas_io_write_start(int cmd, unsigned long lba, unsigned long count, unsigned long len) "scmd %d: start LBA %lx %lu blocks (%lu bytes)"
+megasas_scsi_complete(int cmd, uint32_t status, int len, int xfer) "scmd %d: status %#x, len %u/%u"
+megasas_command_complete(int cmd, uint32_t status, uint32_t resid) "scmd %d: status %#x, residual %d"
+megasas_handle_io(int cmd, const char *frame, int dev, int lun, unsigned long lba, unsigned long count) "scmd %d: %s dev %#x/%#x lba %#lx count %lu"
+megasas_io_target_not_present(int cmd, const char *frame, int dev, int lun) "scmd %d: %s dev 1/%#x/%#x LUN not present"
+megasas_io_read_start(int cmd, unsigned long lba, unsigned long count, unsigned long len) "scmd %d: start LBA %#lx %lu blocks (%lu bytes)"
+megasas_io_write_start(int cmd, unsigned long lba, unsigned long count, unsigned long len) "scmd %d: start LBA %#lx %lu blocks (%lu bytes)"
 megasas_io_complete(int cmd, uint32_t len) "scmd %d: %d bytes"
 megasas_iovec_sgl_overflow(int cmd, int index, int limit) "scmd %d: iovec count %d limit %d"
 megasas_iovec_sgl_underflow(int cmd, int index) "scmd %d: iovec count %d"
-megasas_iovec_sgl_invalid(int cmd, int index, uint64_t pa, uint32_t len) "scmd %d: element %d pa %" PRIx64 " len %u"
+megasas_iovec_sgl_invalid(int cmd, int index, uint64_t pa, uint32_t len) "scmd %d: element %d pa %#" PRIx64 " len %u"
 megasas_iovec_overflow(int cmd, int len, int limit) "scmd %d: len %d limit %d"
 megasas_iovec_underflow(int cmd, int len, int limit) "scmd %d: len %d limit %d"
-megasas_handle_dcmd(int cmd, int opcode) "scmd %d: MFI DCMD opcode %x"
+megasas_handle_dcmd(int cmd, int opcode) "scmd %d: MFI DCMD opcode %#x"
 megasas_finish_dcmd(int cmd, int size) "scmd %d: MFI DCMD wrote %d bytes"
 megasas_dcmd_req_alloc_failed(int cmd, const char *desc) "scmd %d: %s"
 megasas_dcmd_internal_submit(int cmd, const char *desc, int dev) "scmd %d: %s to dev %d"
-megasas_dcmd_internal_finish(int cmd, int opcode, int lun) "scmd %d: cmd %x lun %d"
-megasas_dcmd_internal_invalid(int cmd, int opcode) "scmd %d: DCMD %x"
-megasas_dcmd_unhandled(int cmd, int opcode, int len) "scmd %d: opcode %x, len %d"
+megasas_dcmd_internal_finish(int cmd, int opcode, int lun) "scmd %d: cmd %#x lun %d"
+megasas_dcmd_internal_invalid(int cmd, int opcode) "scmd %d: DCMD %#x"
+megasas_dcmd_unhandled(int cmd, int opcode, int len) "scmd %d: opcode %#x, len %d"
 megasas_dcmd_zero_sge(int cmd) "scmd %d: zero DCMD sge count"
 megasas_dcmd_invalid_sge(int cmd, int count) "scmd %d: DCMD sge count %d"
 megasas_dcmd_invalid_xfer_len(int cmd, unsigned long size, unsigned long max) "scmd %d: xfer len %ld, max %ld"
 megasas_dcmd_enter(int cmd, const char *dcmd, int len) "scmd %d: DCMD %s len %d"
 megasas_dcmd_dummy(int cmd, unsigned long size) "scmd %d: xfer len %ld"
-megasas_dcmd_set_fw_time(int cmd, unsigned long time) "scmd %d: Set FW time %lx"
+megasas_dcmd_set_fw_time(int cmd, unsigned long time) "scmd %d: Set FW time %#lx"
 megasas_dcmd_pd_get_list(int cmd, int num, int max, int offset) "scmd %d: DCMD PD get list: %d / %d PDs, size %d"
 megasas_dcmd_ld_get_list(int cmd, int num, int max) "scmd %d: DCMD LD get list: found %d / %d LDs"
 megasas_dcmd_ld_get_info(int cmd, int ld_id) "scmd %d: dev %d"
-megasas_dcmd_ld_list_query(int cmd, int flags) "scmd %d: query flags %x"
+megasas_dcmd_ld_list_query(int cmd, int flags) "scmd %d: query flags %#x"
 megasas_dcmd_pd_get_info(int cmd, int pd_id) "scmd %d: dev %d"
-megasas_dcmd_pd_list_query(int cmd, int flags) "scmd %d: query flags %x"
+megasas_dcmd_pd_list_query(int cmd, int flags) "scmd %d: query flags %#x"
 megasas_dcmd_reset_ld(int cmd, int target_id) "scmd %d: dev %d"
 megasas_dcmd_unsupported(int cmd, unsigned long size) "scmd %d: set properties len %ld"
-megasas_abort_frame(int cmd, int abort_cmd) "scmd %d: frame %x"
-megasas_abort_no_cmd(int cmd, uint64_t context) "scmd %d: no active command for frame context %" PRIx64
-megasas_abort_invalid_context(int cmd, uint64_t context, int abort_cmd) "scmd %d: invalid frame context %" PRIx64 " for abort frame %x"
-megasas_reset(int fw_state) "firmware state %x"
+megasas_abort_frame(int cmd, int abort_cmd) "scmd %d: frame %#x"
+megasas_abort_no_cmd(int cmd, uint64_t context) "scmd %d: no active command for frame context %#" PRIx64
+megasas_abort_invalid_context(int cmd, uint64_t context, int abort_cmd) "scmd %d: invalid frame context %#" PRIx64 " for abort frame %#x"
+megasas_reset(int fw_state) "firmware state %#x"
 megasas_init(int sges, int cmds, const char *mode) "Using %d sges, %d cmds, %s mode"
 megasas_msix_raise(int vector) "vector %d"
 megasas_msi_raise(int vector) "vector %d"
@@ -113,56 +113,56 @@ megasas_intr_enabled(void) "Interrupts enabled"
 megasas_intr_disabled(void) "Interrupts disabled"
 megasas_msix_enabled(int vector) "vector %d"
 megasas_msi_enabled(int vector) "vector %d"
-megasas_mmio_readl(const char *reg, uint32_t val) "reg %s: 0x%x"
-megasas_mmio_invalid_readl(unsigned long addr) "addr 0x%lx"
-megasas_mmio_writel(const char *reg, uint32_t val) "reg %s: 0x%x"
-megasas_mmio_invalid_writel(uint32_t addr, uint32_t val) "addr 0x%x: 0x%x"
+megasas_mmio_readl(const char *reg, uint32_t val) "reg %s: %#x"
+megasas_mmio_invalid_readl(unsigned long addr) "addr %#lx"
+megasas_mmio_writel(const char *reg, uint32_t val) "reg %s: %#x"
+megasas_mmio_invalid_writel(uint32_t addr, uint32_t val) "addr %#x: %#x"
 
 # hw/scsi/vmw_pvscsi.c
 pvscsi_ring_init_data(uint32_t txr_len_log2, uint32_t rxr_len_log2) "TX/RX rings logarithms set to %d/%d"
 pvscsi_ring_init_msg(uint32_t len_log2) "MSG ring logarithm set to %d"
-pvscsi_ring_flush_cmp(uint64_t filled_cmp_ptr) "new production counter of completion ring is 0x%"PRIx64
-pvscsi_ring_flush_msg(uint64_t filled_cmp_ptr) "new production counter of message ring is 0x%"PRIx64
-pvscsi_update_irq_level(bool raise, uint64_t mask, uint64_t status) "interrupt level set to %d (MASK: 0x%"PRIx64", STATUS: 0x%"PRIx64")"
+pvscsi_ring_flush_cmp(uint64_t filled_cmp_ptr) "new production counter of completion ring is %#"PRIx64
+pvscsi_ring_flush_msg(uint64_t filled_cmp_ptr) "new production counter of message ring is %#"PRIx64
+pvscsi_update_irq_level(bool raise, uint64_t mask, uint64_t status) "interrupt level set to %d (MASK: %#"PRIx64", STATUS: %#"PRIx64")"
 pvscsi_update_irq_msi(void) "sending MSI notification"
-pvscsi_cmp_ring_put(unsigned long addr) "got completion descriptor 0x%lx"
-pvscsi_msg_ring_put(unsigned long addr) "got message descriptor 0x%lx"
-pvscsi_complete_request(uint64_t context, uint64_t len, uint8_t sense_key) "completion: ctx: 0x%"PRIx64", len: 0x%"PRIx64", sense key: %u"
+pvscsi_cmp_ring_put(unsigned long addr) "got completion descriptor %#lx"
+pvscsi_msg_ring_put(unsigned long addr) "got message descriptor %#lx"
+pvscsi_complete_request(uint64_t context, uint64_t len, uint8_t sense_key) "completion: ctx: %#"PRIx64", len: %#"PRIx64", sense key: %u"
 pvscsi_get_sg_list(int nsg, size_t size) "get SG list: depth: %u, size: %zu"
-pvscsi_get_next_sg_elem(uint32_t flags) "unknown flags in SG element (val: 0x%x)"
-pvscsi_command_complete_not_found(uint32_t tag) "can't find request for tag 0x%x"
+pvscsi_get_next_sg_elem(uint32_t flags) "unknown flags in SG element (val: %#x)"
+pvscsi_command_complete_not_found(uint32_t tag) "can't find request for tag %#x"
 pvscsi_command_complete_data_run(void) "not all data required for command transferred"
 pvscsi_command_complete_sense_len(int len) "sense information length is %d bytes"
-pvscsi_convert_sglist(uint64_t context, unsigned long addr, uint32_t resid) "element: ctx: 0x%"PRIx64" addr: 0x%lx, len: %ul"
-pvscsi_process_req_descr(uint8_t cmd, uint64_t ctx) "SCSI cmd 0x%x, ctx: 0x%"PRIx64
+pvscsi_convert_sglist(uint64_t context, unsigned long addr, uint32_t resid) "element: ctx: %#"PRIx64" addr: %#lx, len: %ul"
+pvscsi_process_req_descr(uint8_t cmd, uint64_t ctx) "SCSI cmd %#x, ctx: %#"PRIx64
 pvscsi_process_req_descr_unknown_device(void) "command directed to unknown device rejected"
 pvscsi_process_req_descr_invalid_dir(void) "command with invalid transfer direction rejected"
-pvscsi_process_io(unsigned long addr) "got descriptor 0x%lx"
+pvscsi_process_io(unsigned long addr) "got descriptor %#lx"
 pvscsi_on_cmd_noimpl(const char* cmd) "unimplemented command %s ignored"
 pvscsi_on_cmd_reset_dev(uint32_t tgt, int lun, void* dev) "PVSCSI_CMD_RESET_DEVICE[target %u lun %d (dev 0x%p)]"
 pvscsi_on_cmd_arrived(const char* cmd) "command %s arrived"
-pvscsi_on_cmd_abort(uint64_t ctx, uint32_t tgt) "command PVSCSI_CMD_ABORT_CMD for ctx 0x%"PRIx64", target %u"
-pvscsi_on_cmd_unknown(uint64_t cmd_id) "unknown command %"PRIx64
-pvscsi_on_cmd_unknown_data(uint32_t data) "data for unknown command 0x:%x"
-pvscsi_io_write(const char* cmd, uint64_t val) "%s write: %"PRIx64
-pvscsi_io_write_unknown(unsigned long addr, unsigned sz, uint64_t val) "unknown write address: 0x%lx size: %u bytes value: 0x%"PRIx64
-pvscsi_io_read(const char* cmd, uint64_t status) "%s read: 0x%"PRIx64
-pvscsi_io_read_unknown(unsigned long addr, unsigned sz) "unknown read address: 0x%lx size: %u bytes"
+pvscsi_on_cmd_abort(uint64_t ctx, uint32_t tgt) "command PVSCSI_CMD_ABORT_CMD for ctx %#"PRIx64", target %u"
+pvscsi_on_cmd_unknown(uint64_t cmd_id) "unknown command %#"PRIx64
+pvscsi_on_cmd_unknown_data(uint32_t data) "data for unknown command 0x:%#x"
+pvscsi_io_write(const char* cmd, uint64_t val) "%s write: %#"PRIx64
+pvscsi_io_write_unknown(unsigned long addr, unsigned sz, uint64_t val) "unknown write address: %#lx size: %u bytes value: %#"PRIx64
+pvscsi_io_read(const char* cmd, uint64_t status) "%s read: %#"PRIx64
+pvscsi_io_read_unknown(unsigned long addr, unsigned sz) "unknown read address: %#lx size: %u bytes"
 pvscsi_init_msi_fail(int res) "failed to initialize MSI, error %d"
 pvscsi_state(const char* state) "starting %s ..."
-pvscsi_tx_rings_ppn(const char* label, uint64_t ppn) "%s page: %"PRIx64
+pvscsi_tx_rings_ppn(const char* label, uint64_t ppn) "%s page: %#"PRIx64
 pvscsi_tx_rings_num_pages(const char* label, uint32_t num) "Number of %s pages: %u"
 
 # hw/scsi/esp.c
 esp_error_fifo_overrun(void) "FIFO overrun"
-esp_error_unhandled_command(uint32_t val) "unhandled command (%2.2x)"
-esp_error_invalid_write(uint32_t val, uint32_t addr) "invalid write of 0x%02x at [0x%x]"
+esp_error_unhandled_command(uint32_t val) "unhandled command (%#2.2x)"
+esp_error_invalid_write(uint32_t val, uint32_t addr) "invalid write of %#02x at [%#x]"
 esp_raise_irq(void) "Raise IRQ"
 esp_lower_irq(void) "Lower IRQ"
 esp_dma_enable(void) "Raise enable"
 esp_dma_disable(void) "Lower enable"
 esp_get_cmd(uint32_t dmalen, int target) "len %d target %d"
-esp_do_busid_cmd(uint8_t busid) "busid 0x%x"
+esp_do_busid_cmd(uint8_t busid) "busid %#x"
 esp_handle_satn_stop(uint32_t cmdlen) "cmdlen %d"
 esp_write_response(uint32_t status) "Transfer status (status=%d)"
 esp_do_dma(uint32_t cmdlen, uint32_t len) "command len %d + %d"
@@ -172,60 +172,60 @@ esp_command_complete_fail(void) "Command failed"
 esp_transfer_data(uint32_t dma_left, int32_t ti_size) "transfer %d/%d"
 esp_handle_ti(uint32_t minlen) "Transfer Information len %d"
 esp_handle_ti_cmd(uint32_t cmdlen) "command len %d"
-esp_mem_readb(uint32_t saddr, uint8_t reg) "reg[%d]: 0x%2.2x"
-esp_mem_writeb(uint32_t saddr, uint8_t reg, uint32_t val) "reg[%d]: 0x%2.2x -> 0x%2.2x"
-esp_mem_writeb_cmd_nop(uint32_t val) "NOP (%2.2x)"
-esp_mem_writeb_cmd_flush(uint32_t val) "Flush FIFO (%2.2x)"
-esp_mem_writeb_cmd_reset(uint32_t val) "Chip reset (%2.2x)"
-esp_mem_writeb_cmd_bus_reset(uint32_t val) "Bus reset (%2.2x)"
-esp_mem_writeb_cmd_iccs(uint32_t val) "Initiator Command Complete Sequence (%2.2x)"
-esp_mem_writeb_cmd_msgacc(uint32_t val) "Message Accepted (%2.2x)"
-esp_mem_writeb_cmd_pad(uint32_t val) "Transfer padding (%2.2x)"
-esp_mem_writeb_cmd_satn(uint32_t val) "Set ATN (%2.2x)"
-esp_mem_writeb_cmd_rstatn(uint32_t val) "Reset ATN (%2.2x)"
-esp_mem_writeb_cmd_sel(uint32_t val) "Select without ATN (%2.2x)"
-esp_mem_writeb_cmd_selatn(uint32_t val) "Select with ATN (%2.2x)"
-esp_mem_writeb_cmd_selatns(uint32_t val) "Select with ATN & stop (%2.2x)"
-esp_mem_writeb_cmd_ensel(uint32_t val) "Enable selection (%2.2x)"
-esp_mem_writeb_cmd_dissel(uint32_t val) "Disable selection (%2.2x)"
+esp_mem_readb(uint32_t saddr, uint8_t reg) "reg[%d]: %#2.2x"
+esp_mem_writeb(uint32_t saddr, uint8_t reg, uint32_t val) "reg[%d]: %#2.2x -> %#2.2x"
+esp_mem_writeb_cmd_nop(uint32_t val) "NOP (%#2.2x)"
+esp_mem_writeb_cmd_flush(uint32_t val) "Flush FIFO (%#2.2x)"
+esp_mem_writeb_cmd_reset(uint32_t val) "Chip reset (%#2.2x)"
+esp_mem_writeb_cmd_bus_reset(uint32_t val) "Bus reset (%#2.2x)"
+esp_mem_writeb_cmd_iccs(uint32_t val) "Initiator Command Complete Sequence (%#2.2x)"
+esp_mem_writeb_cmd_msgacc(uint32_t val) "Message Accepted (%#2.2x)"
+esp_mem_writeb_cmd_pad(uint32_t val) "Transfer padding (%#2.2x)"
+esp_mem_writeb_cmd_satn(uint32_t val) "Set ATN (%#2.2x)"
+esp_mem_writeb_cmd_rstatn(uint32_t val) "Reset ATN (%#2.2x)"
+esp_mem_writeb_cmd_sel(uint32_t val) "Select without ATN (%#2.2x)"
+esp_mem_writeb_cmd_selatn(uint32_t val) "Select with ATN (%#2.2x)"
+esp_mem_writeb_cmd_selatns(uint32_t val) "Select with ATN & stop (%#2.2x)"
+esp_mem_writeb_cmd_ensel(uint32_t val) "Enable selection (%#2.2x)"
+esp_mem_writeb_cmd_dissel(uint32_t val) "Disable selection (%#2.2x)"
 
 # hw/scsi/esp-pci.c
 esp_pci_error_invalid_dma_direction(void) "invalid DMA transfer direction"
-esp_pci_error_invalid_read(uint32_t reg) "read access outside bounds (reg 0x%x)"
-esp_pci_error_invalid_write(uint32_t reg) "write access outside bounds (reg 0x%x)"
-esp_pci_error_invalid_write_dma(uint32_t val, uint32_t addr) "invalid write of 0x%02x at [0x%x]"
-esp_pci_dma_read(uint32_t saddr, uint32_t reg) "reg[%d]: 0x%8.8x"
-esp_pci_dma_write(uint32_t saddr, uint32_t reg, uint32_t val) "reg[%d]: 0x%8.8x -> 0x%8.8x"
-esp_pci_dma_idle(uint32_t val) "IDLE (%.8x)"
-esp_pci_dma_blast(uint32_t val) "BLAST (%.8x)"
-esp_pci_dma_abort(uint32_t val) "ABORT (%.8x)"
-esp_pci_dma_start(uint32_t val) "START (%.8x)"
-esp_pci_sbac_read(uint32_t reg) "sbac: 0x%8.8x"
-esp_pci_sbac_write(uint32_t reg, uint32_t val) "sbac: 0x%8.8x -> 0x%8.8x"
+esp_pci_error_invalid_read(uint32_t reg) "read access outside bounds (reg %#x)"
+esp_pci_error_invalid_write(uint32_t reg) "write access outside bounds (reg %#x)"
+esp_pci_error_invalid_write_dma(uint32_t val, uint32_t addr) "invalid write of %#02x at [%#x]"
+esp_pci_dma_read(uint32_t saddr, uint32_t reg) "reg[%d]: %#8.8x"
+esp_pci_dma_write(uint32_t saddr, uint32_t reg, uint32_t val) "reg[%d]: %#8.8x -> %#8.8x"
+esp_pci_dma_idle(uint32_t val) "IDLE (%#.8x)"
+esp_pci_dma_blast(uint32_t val) "BLAST (%#.8x)"
+esp_pci_dma_abort(uint32_t val) "ABORT (%#.8x)"
+esp_pci_dma_start(uint32_t val) "START (%#.8x)"
+esp_pci_sbac_read(uint32_t reg) "sbac: %#8.8x"
+esp_pci_sbac_write(uint32_t reg, uint32_t val) "sbac: %#8.8x -> %#8.8x"
 
 # hw/scsi/spapr_vscsi.c
-spapr_vscsi_send_rsp(uint8_t status, int32_t res_in, int32_t res_out) "status: 0x%x, res_in: %"PRId32", res_out: %"PRId32
+spapr_vscsi_send_rsp(uint8_t status, int32_t res_in, int32_t res_out) "status: %#x, res_in: %"PRId32", res_out: %"PRId32
 spapr_vscsi_fetch_desc_no_data(void) "no data descriptor"
 spapr_vscsi_fetch_desc_direct(void) "direct segment"
-spapr_vscsi_fetch_desc_indirect(uint32_t qtag, unsigned desc, unsigned local_desc) "indirect segment local tag=0x%"PRIx32" desc#%u/%u"
+spapr_vscsi_fetch_desc_indirect(uint32_t qtag, unsigned desc, unsigned local_desc) "indirect segment local tag=%#"PRIx32" desc#%u/%u"
 spapr_vscsi_fetch_desc_out_of_range(unsigned desc, unsigned desc_offset) "#%u is ouf of range (%u bytes)"
 spapr_vscsi_fetch_desc_dma_read_error(int rc) "spapr_vio_dma_read -> %d reading ext_desc"
-spapr_vscsi_fetch_desc_indirect_seg_ext(uint32_t qtag, unsigned n, unsigned desc, uint64_t va, uint32_t len) "indirect segment ext. tag=0x%"PRIx32" desc#%u/%u { va=0x%"PRIx64" len=0x%"PRIx32" }"
+spapr_vscsi_fetch_desc_indirect_seg_ext(uint32_t qtag, unsigned n, unsigned desc, uint64_t va, uint32_t len) "indirect segment ext. tag=%#"PRIx32" desc#%u/%u { va=%#"PRIx64" len=%#"PRIx32" }"
 spapr_vscsi_fetch_desc_out_of_desc(void) "Out of descriptors !"
-spapr_vscsi_fetch_desc_out_of_desc_boundary(unsigned offset, unsigned desc, uint32_t len) "   offset=0x%x is out of a descriptor #%u boundary=%"PRIx32
-spapr_vscsi_fetch_desc_done(unsigned desc_num, unsigned desc_offset, uint64_t va, uint32_t len) "   cur=%u offs=0x%x ret { va=0x%"PRIx64" len=0x%"PRIx32" }"
-spapr_vscsi_srp_indirect_data(uint32_t len) "indirect segment 0x%"PRIx32" bytes"
+spapr_vscsi_fetch_desc_out_of_desc_boundary(unsigned offset, unsigned desc, uint32_t len) "   offset=%#x is out of a descriptor #%u boundary=%#"PRIx32
+spapr_vscsi_fetch_desc_done(unsigned desc_num, unsigned desc_offset, uint64_t va, uint32_t len) "   cur=%u offs=%#x ret { va=%#"PRIx64" len=%#"PRIx32" }"
+spapr_vscsi_srp_indirect_data(uint32_t len) "indirect segment %#"PRIx32" bytes"
 spapr_vscsi_srp_indirect_data_rw(int writing, int rc) "spapr_vio_dma_r/w(%d) -> %d"
-spapr_vscsi_srp_indirect_data_buf(unsigned a, unsigned b, unsigned c, unsigned d) "     data: %02x %02x %02x %02x..."
-spapr_vscsi_srp_transfer_data(uint32_t len) "no data desc transfer, skipping 0x%"PRIx32" bytes"
-spapr_vscsi_transfer_data(uint32_t tag, uint32_t len, void *req) "SCSI xfer complete tag=0x%"PRIx32" len=0x%"PRIx32", req=%p"
-spapr_vscsi_command_complete(uint32_t tag, uint32_t status, void *req) "SCSI cmd complete, tag=0x%"PRIx32" status=0x%"PRIx32", req=%p"
-spapr_vscsi_command_complete_sense_data1(uint32_t len, unsigned s0, unsigned s1, unsigned s2, unsigned s3, unsigned s4, unsigned s5, unsigned s6, unsigned s7) "Sense data, %d bytes: %02x %02x %02x %02x %02x %02x %02x %02x"
-spapr_vscsi_command_complete_sense_data2(unsigned s8, unsigned s9, unsigned s10, unsigned s11, unsigned s12, unsigned s13, unsigned s14, unsigned s15)         "                      %02x %02x %02x %02x %02x %02x %02x %02x"
+spapr_vscsi_srp_indirect_data_buf(unsigned a, unsigned b, unsigned c, unsigned d) "     data: %#02x %#02x %#02x %#02x..."
+spapr_vscsi_srp_transfer_data(uint32_t len) "no data desc transfer, skipping %#"PRIx32" bytes"
+spapr_vscsi_transfer_data(uint32_t tag, uint32_t len, void *req) "SCSI xfer complete tag=%#"PRIx32" len=%#"PRIx32", req=%p"
+spapr_vscsi_command_complete(uint32_t tag, uint32_t status, void *req) "SCSI cmd complete, tag=%#"PRIx32" status=%#"PRIx32", req=%p"
+spapr_vscsi_command_complete_sense_data1(uint32_t len, unsigned s0, unsigned s1, unsigned s2, unsigned s3, unsigned s4, unsigned s5, unsigned s6, unsigned s7) "Sense data, %d bytes: %#02x %#02x %#02x %#02x %#02x %#02x %#02x %#02x"
+spapr_vscsi_command_complete_sense_data2(unsigned s8, unsigned s9, unsigned s10, unsigned s11, unsigned s12, unsigned s13, unsigned s14, unsigned s15)         "                      %#02x %#02x %#02x %#02x %#02x %#02x %#02x %#02x"
 spapr_vscsi_command_complete_status(uint32_t status) "Command complete err=%"PRIu32
-spapr_vscsi_save_request(uint32_t qtag, unsigned desc, unsigned offset) "saving tag=%"PRIu32", current desc#%u, offset=0x%x"
-spapr_vscsi_load_request(uint32_t qtag, unsigned desc, unsigned offset) "restoring tag=%"PRIu32", current desc#%u, offset=0x%x"
+spapr_vscsi_save_request(uint32_t qtag, unsigned desc, unsigned offset) "saving tag=%"PRIu32", current desc#%u, offset=%#x"
+spapr_vscsi_load_request(uint32_t qtag, unsigned desc, unsigned offset) "restoring tag=%"PRIu32", current desc#%u, offset=%#x"
 spapr_vscsi_process_login(void) "Got login, sending response !"
-spapr_vscsi_queue_cmd_no_drive(uint64_t lun) "Command for lun %08" PRIx64 " with no drive"
-spapr_vscsi_queue_cmd(uint32_t qtag, unsigned cdb, const char *cmd, int lun, int ret) "Queued command tag 0x%"PRIx32" CMD 0x%x=%s LUN %d ret: %d"
-spapr_vscsi_do_crq(unsigned c0, unsigned c1) "crq: %02x %02x ..."
+spapr_vscsi_queue_cmd_no_drive(uint64_t lun) "Command for lun %#08" PRIx64 " with no drive"
+spapr_vscsi_queue_cmd(uint32_t qtag, unsigned cdb, const char *cmd, int lun, int ret) "Queued command tag %#"PRIx32" CMD %#x=%s LUN %d ret: %d"
+spapr_vscsi_do_crq(unsigned c0, unsigned c1) "crq: %#02x %#02x ..."
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index b17e7ba442..e7cc25e19a 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -1,5 +1,5 @@
 # See docs/tracing.txt for syntax documentation.
 
 # hw/sd/milkymist-memcard.c
-milkymist_memcard_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_memcard_memory_write(uint32_t addr, uint32_t value) "addr %08x value %08x"
+milkymist_memcard_memory_read(uint32_t addr, uint32_t value) "addr %#08x value %#08x"
+milkymist_memcard_memory_write(uint32_t addr, uint32_t value) "addr %#08x value %#08x"
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index fd8196be66..c7a06301af 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -1,39 +1,39 @@
 # See docs/tracing.txt for syntax documentation.
 
 # hw/timer/slavio_timer.c
-slavio_timer_get_out(uint64_t limit, uint32_t counthigh, uint32_t count) "limit %"PRIx64" count %x%08x"
-slavio_timer_irq(uint32_t counthigh, uint32_t count) "callback: count %x%08x"
-slavio_timer_mem_readl_invalid(uint64_t addr) "invalid read address %"PRIx64
-slavio_timer_mem_readl(uint64_t addr, uint32_t ret) "read %"PRIx64" = %08x"
-slavio_timer_mem_writel(uint64_t addr, uint32_t val) "write %"PRIx64" = %08x"
-slavio_timer_mem_writel_limit(unsigned int timer_index, uint64_t count) "processor %d user timer set to %016"PRIx64
+slavio_timer_get_out(uint64_t limit, uint32_t counthigh, uint32_t count) "limit %#"PRIx64" count %#x%#08x"
+slavio_timer_irq(uint32_t counthigh, uint32_t count) "callback: count %#x%#08x"
+slavio_timer_mem_readl_invalid(uint64_t addr) "invalid read address %#"PRIx64
+slavio_timer_mem_readl(uint64_t addr, uint32_t ret) "read %#"PRIx64" = %#08x"
+slavio_timer_mem_writel(uint64_t addr, uint32_t val) "write %#"PRIx64" = %#08x"
+slavio_timer_mem_writel_limit(unsigned int timer_index, uint64_t count) "processor %d user timer set to %#016"PRIx64
 slavio_timer_mem_writel_counter_invalid(void) "not user timer"
 slavio_timer_mem_writel_status_start(unsigned int timer_index) "processor %d user timer started"
 slavio_timer_mem_writel_status_stop(unsigned int timer_index) "processor %d user timer stopped"
 slavio_timer_mem_writel_mode_user(unsigned int timer_index) "processor %d changed from counter to user timer"
 slavio_timer_mem_writel_mode_counter(unsigned int timer_index) "processor %d changed from user timer to counter"
 slavio_timer_mem_writel_mode_invalid(void) "not system timer"
-slavio_timer_mem_writel_invalid(uint64_t addr) "invalid write address %"PRIx64
+slavio_timer_mem_writel_invalid(uint64_t addr) "invalid write address %#"PRIx64
 
 # hw/timer/grlib_gptimer.c
-grlib_gptimer_enable(int id, uint32_t count) "timer:%d set count 0x%x and run"
-grlib_gptimer_disabled(int id, uint32_t config) "timer:%d Timer disable config 0x%x"
-grlib_gptimer_restart(int id, uint32_t reload) "timer:%d reload val: 0x%x"
-grlib_gptimer_set_scaler(uint32_t scaler, uint32_t freq) "scaler:0x%x freq: 0x%x"
+grlib_gptimer_enable(int id, uint32_t count) "timer:%d set count %#x and run"
+grlib_gptimer_disabled(int id, uint32_t config) "timer:%d Timer disable config %#x"
+grlib_gptimer_restart(int id, uint32_t reload) "timer:%d reload val: %#x"
+grlib_gptimer_set_scaler(uint32_t scaler, uint32_t freq) "scaler:%#x freq: %#x"
 grlib_gptimer_hit(int id) "timer:%d HIT"
-grlib_gptimer_readl(int id, uint64_t addr, uint32_t val) "timer:%d addr 0x%"PRIx64" 0x%x"
-grlib_gptimer_writel(int id, uint64_t addr, uint32_t val) "timer:%d addr 0x%"PRIx64" 0x%x"
+grlib_gptimer_readl(int id, uint64_t addr, uint32_t val) "timer:%d addr %#"PRIx64" %#x"
+grlib_gptimer_writel(int id, uint64_t addr, uint32_t val) "timer:%d addr %#"PRIx64" %#x"
 
 # hw/timer/lm32_timer.c
-lm32_timer_memory_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
-lm32_timer_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+lm32_timer_memory_write(uint32_t addr, uint32_t value) "addr %#08x value %#08x"
+lm32_timer_memory_read(uint32_t addr, uint32_t value) "addr %#08x value %#08x"
 lm32_timer_hit(void) "timer hit"
 lm32_timer_irq_state(int level) "irq state %d"
 
 # hw/timer/milkymist-sysctl.c
-milkymist_sysctl_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_sysctl_memory_write(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_sysctl_icap_write(uint32_t value) "value %08x"
+milkymist_sysctl_memory_read(uint32_t addr, uint32_t value) "addr %#08x value %#08x"
+milkymist_sysctl_memory_write(uint32_t addr, uint32_t value) "addr %#08x value %#08x"
+milkymist_sysctl_icap_write(uint32_t value) "value %#08x"
 milkymist_sysctl_start_timer0(void) "Start timer0"
 milkymist_sysctl_stop_timer0(void) "Stop timer0"
 milkymist_sysctl_start_timer1(void) "Start timer1"
@@ -46,17 +46,17 @@ aspeed_timer_ctrl_enable(uint8_t i, bool enable) "Timer %" PRIu8 ": %d"
 aspeed_timer_ctrl_external_clock(uint8_t i, bool enable) "Timer %" PRIu8 ": %d"
 aspeed_timer_ctrl_overflow_interrupt(uint8_t i, bool enable) "Timer %" PRIu8 ": %d"
 aspeed_timer_ctrl_pulse_enable(uint8_t i, bool enable) "Timer %" PRIu8 ": %d"
-aspeed_timer_set_ctrl2(uint32_t value) "Value: 0x%" PRIx32
-aspeed_timer_set_value(int timer, int reg, uint32_t value) "Timer %d register %d: 0x%" PRIx32
-aspeed_timer_read(uint64_t offset, unsigned size, uint64_t value) "From 0x%" PRIx64 ": of size %u: 0x%" PRIx64
+aspeed_timer_set_ctrl2(uint32_t value) "Value: %#" PRIx32
+aspeed_timer_set_value(int timer, int reg, uint32_t value) "Timer %d register %d: %#" PRIx32
+aspeed_timer_read(uint64_t offset, unsigned size, uint64_t value) "From %#" PRIx64 ": of size %u: %#" PRIx64
 
 # hw/timer/armv7m_systick.c
 systick_reload(void) "systick reload"
 systick_timer_tick(void) "systick reload"
-systick_read(uint64_t addr, uint32_t value, unsigned size) "systick read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
-systick_write(uint64_t addr, uint32_t value, unsigned size) "systick write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
+systick_read(uint64_t addr, uint32_t value, unsigned size) "systick read addr %#" PRIx64 " data %#" PRIx32 " size %u"
+systick_write(uint64_t addr, uint32_t value, unsigned size) "systick write addr %#" PRIx64 " data %#" PRIx32 " size %u"
 
 # hw/char/cmsdk_apb_timer.c
-cmsdk_apb_timer_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB timer read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
-cmsdk_apb_timer_write(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB timer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
+cmsdk_apb_timer_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB timer read: offset %#" PRIx64 " data %#" PRIx64 " size %u"
+cmsdk_apb_timer_write(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB timer write: offset %#" PRIx64 " data %#" PRIx64 " size %u"
 cmsdk_apb_timer_reset(void) "CMSDK APB timer: reset"
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index 0c323d4cac..5b180c34b2 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -11,16 +11,16 @@ usb_port_detach(int bus, const char *port) "bus %d, port %s"
 usb_port_release(int bus, const char *port) "bus %d, port %s"
 
 # hw/usb/hcd-ohci.c
-usb_ohci_iso_td_read_failed(uint32_t addr) "ISO_TD read error at %x"
-usb_ohci_iso_td_head(uint32_t head, uint32_t tail, uint32_t flags, uint32_t bp, uint32_t next, uint32_t be, uint32_t framenum, uint32_t startframe, uint32_t framecount, int rel_frame_num) "ISO_TD ED head 0x%.8x tailp 0x%.8x\n0x%.8x 0x%.8x 0x%.8x 0x%.8x\nframe_number 0x%.8x starting_frame 0x%.8x\nframe_count  0x%.8x relative %d"
-usb_ohci_iso_td_head_offset(uint32_t o0, uint32_t o1, uint32_t o2, uint32_t o3, uint32_t o4, uint32_t o5, uint32_t o6, uint32_t o7) "0x%.8x 0x%.8x 0x%.8x 0x%.8x 0x%.8x 0x%.8x 0x%.8x 0x%.8x"
+usb_ohci_iso_td_read_failed(uint32_t addr) "ISO_TD read error at %#x"
+usb_ohci_iso_td_head(uint32_t head, uint32_t tail, uint32_t flags, uint32_t bp, uint32_t next, uint32_t be, uint32_t framenum, uint32_t startframe, uint32_t framecount, int rel_frame_num) "ISO_TD ED head %#.8x tailp %#.8x\n%#.8x %#.8x %#.8x %#.8x\nframe_number %#.8x starting_frame %#.8x\nframe_count  %#.8x relative %d"
+usb_ohci_iso_td_head_offset(uint32_t o0, uint32_t o1, uint32_t o2, uint32_t o3, uint32_t o4, uint32_t o5, uint32_t o6, uint32_t o7) "%#.8x %#.8x %#.8x %#.8x %#.8x %#.8x %#.8x %#.8x"
 usb_ohci_iso_td_relative_frame_number_neg(int rel) "ISO_TD R=%d < 0"
 usb_ohci_iso_td_relative_frame_number_big(int rel, int count) "ISO_TD R=%d > FC=%d"
 usb_ohci_iso_td_bad_direction(int dir) "Bad direction %d"
-usb_ohci_iso_td_bad_bp_be(uint32_t bp, uint32_t be) "ISO_TD bp 0x%.8x be 0x%.8x"
-usb_ohci_iso_td_bad_cc_not_accessed(uint32_t start, uint32_t next) "ISO_TD cc != not accessed 0x%.8x 0x%.8x"
-usb_ohci_iso_td_bad_cc_overrun(uint32_t start, uint32_t next) "ISO_TD start_offset=0x%.8x > next_offset=0x%.8x"
-usb_ohci_iso_td_so(uint32_t so, uint32_t eo, uint32_t s, uint32_t e, const char *str, ssize_t len, int ret) "0x%.8x eo 0x%.8x\nsa 0x%.8x ea 0x%.8x\ndir %s len %zu ret %d"
+usb_ohci_iso_td_bad_bp_be(uint32_t bp, uint32_t be) "ISO_TD bp %#.8x be %#.8x"
+usb_ohci_iso_td_bad_cc_not_accessed(uint32_t start, uint32_t next) "ISO_TD cc != not accessed %#.8x %#.8x"
+usb_ohci_iso_td_bad_cc_overrun(uint32_t start, uint32_t next) "ISO_TD start_offset=%#.8x > next_offset=%#.8x"
+usb_ohci_iso_td_so(uint32_t so, uint32_t eo, uint32_t s, uint32_t e, const char *str, ssize_t len, int ret) "%#.8x eo %#.8x\nsa %#.8x ea %#.8x\ndir %s len %zu ret %d"
 usb_ohci_iso_td_data_overrun(int ret, ssize_t len) "DataOverrun %d > %zu"
 usb_ohci_iso_td_data_underrun(int ret) "DataUnderrun %d"
 usb_ohci_iso_td_nak(int ret) "got NAK/STALL %d"
@@ -36,31 +36,31 @@ usb_ohci_start(const char *s) "%s: USB Operational"
 usb_ohci_resume(const char *s) "%s: USB Resume"
 usb_ohci_stop(const char *s) "%s: USB Suspended"
 usb_ohci_exit(const char *s) "%s"
-usb_ohci_set_ctl(const char *s, uint32_t new_state) "%s: new state 0x%x"
+usb_ohci_set_ctl(const char *s, uint32_t new_state) "%s: new state %#x"
 usb_ohci_td_underrun(void) ""
 usb_ohci_td_dev_error(void) ""
 usb_ohci_td_nak(void) ""
 usb_ohci_td_stall(void) ""
 usb_ohci_td_babble(void) ""
 usb_ohci_td_bad_device_response(int rc) "%d"
-usb_ohci_td_read_error(uint32_t addr) "TD read error at %x"
+usb_ohci_td_read_error(uint32_t addr) "TD read error at %#x"
 usb_ohci_td_bad_direction(int dir) "Bad direction %d"
 usb_ohci_td_skip_async(void) ""
-usb_ohci_td_pkt_hdr(uint32_t addr, int64_t pktlen, int64_t len, const char *s, int flag_r, uint32_t cbp, uint32_t be) " TD @ 0x%.8x %" PRId64 " of %" PRId64 " bytes %s r=%d cbp=0x%.8x be=0x%.8x"
+usb_ohci_td_pkt_hdr(uint32_t addr, int64_t pktlen, int64_t len, const char *s, int flag_r, uint32_t cbp, uint32_t be) " TD @ %#.8x %" PRId64 " of %" PRId64 " bytes %s r=%d cbp=%#.8x be=%#.8x"
 usb_ohci_td_pkt_short(const char *dir, const char *buf) "%s data: %s"
 usb_ohci_td_pkt_full(const char *dir, const char *buf) "%s data: %s"
 usb_ohci_td_too_many_pending(void) ""
 usb_ohci_td_packet_status(int status) "status=%d"
-usb_ohci_ed_read_error(uint32_t addr) "ED read error at %x"
-usb_ohci_ed_pkt(uint32_t cur, int h, int c, uint32_t head, uint32_t tail, uint32_t next) "ED @ 0x%.8x h=%u c=%u\n  head=0x%.8x tailp=0x%.8x next=0x%.8x"
+usb_ohci_ed_read_error(uint32_t addr) "ED read error at %#x"
+usb_ohci_ed_pkt(uint32_t cur, int h, int c, uint32_t head, uint32_t tail, uint32_t next) "ED @ %#.8x h=%u c=%u\n  head=%#.8x tailp=%#.8x next=%#.8x"
 usb_ohci_ed_pkt_flags(uint32_t fa, uint32_t en, uint32_t d, int s, int k, int f, uint32_t mps) "fa=%u en=%u d=%u s=%u k=%u f=%u mps=%u"
-usb_ohci_hcca_read_error(uint32_t addr) "HCCA read error at %x"
-usb_ohci_mem_read_unaligned(uint32_t addr) "at %x"
-usb_ohci_mem_read_bad_offset(uint32_t addr) "%x"
-usb_ohci_mem_write_unaligned(uint32_t addr) "at %x"
-usb_ohci_mem_write_bad_offset(uint32_t addr) "%x"
-usb_ohci_process_lists(uint32_t head, uint32_t cur) "head %x, cur %x"
-usb_ohci_set_frame_interval(const char *name, uint16_t fi_x, uint16_t fi_u) "%s: FrameInterval = 0x%x (%u)"
+usb_ohci_hcca_read_error(uint32_t addr) "HCCA read error at %#x"
+usb_ohci_mem_read_unaligned(uint32_t addr) "at %#x"
+usb_ohci_mem_read_bad_offset(uint32_t addr) "%#x"
+usb_ohci_mem_write_unaligned(uint32_t addr) "at %#x"
+usb_ohci_mem_write_bad_offset(uint32_t addr) "%#x"
+usb_ohci_process_lists(uint32_t head, uint32_t cur) "head %#x, cur %#x"
+usb_ohci_set_frame_interval(const char *name, uint16_t fi_x, uint16_t fi_u) "%s: FrameInterval = %#x (%u)"
 usb_ohci_hub_power_up(void) "powered up all ports"
 usb_ohci_hub_power_down(void) "powered down all ports"
 usb_ohci_init_time(int64_t frametime, int64_t bittime) "usb_bit_time=%" PRId64 " usb_frame_time=%" PRId64
@@ -70,22 +70,22 @@ usb_ohci_async_complete(void) ""
 # hw/usb/hcd-ehci.c
 usb_ehci_reset(void) "=== RESET ==="
 usb_ehci_unrealize(void) "=== UNREALIZE ==="
-usb_ehci_opreg_read(uint32_t addr, const char *str, uint32_t val) "rd mmio %04x [%s] = %x"
-usb_ehci_opreg_write(uint32_t addr, const char *str, uint32_t val) "wr mmio %04x [%s] = %x"
-usb_ehci_opreg_change(uint32_t addr, const char *str, uint32_t new, uint32_t old) "ch mmio %04x [%s] = %x (old: %x)"
-usb_ehci_portsc_read(uint32_t addr, uint32_t port, uint32_t val) "rd mmio %04x [port %d] = %x"
-usb_ehci_portsc_write(uint32_t addr, uint32_t port, uint32_t val) "wr mmio %04x [port %d] = %x"
-usb_ehci_portsc_change(uint32_t addr, uint32_t port, uint32_t new, uint32_t old) "ch mmio %04x [port %d] = %x (old: %x)"
+usb_ehci_opreg_read(uint32_t addr, const char *str, uint32_t val) "rd mmio %#04x [%s] = %#x"
+usb_ehci_opreg_write(uint32_t addr, const char *str, uint32_t val) "wr mmio %#04x [%s] = %#x"
+usb_ehci_opreg_change(uint32_t addr, const char *str, uint32_t new, uint32_t old) "ch mmio %#04x [%s] = %#x (old: %#x)"
+usb_ehci_portsc_read(uint32_t addr, uint32_t port, uint32_t val) "rd mmio %#04x [port %d] = %#x"
+usb_ehci_portsc_write(uint32_t addr, uint32_t port, uint32_t val) "wr mmio %#04x [port %d] = %#x"
+usb_ehci_portsc_change(uint32_t addr, uint32_t port, uint32_t new, uint32_t old) "ch mmio %#04x [port %d] = %#x (old: %#x)"
 usb_ehci_usbsts(const char *sts, int state) "usbsts %s %d"
 usb_ehci_state(const char *schedule, const char *state) "%s schedule %s"
-usb_ehci_qh_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t c_qtd, uint32_t n_qtd, uint32_t a_qtd) "q %p - QH @ %08x: next %08x qtds %08x,%08x,%08x"
-usb_ehci_qh_fields(uint32_t addr, int rl, int mplen, int eps, int ep, int devaddr) "QH @ %08x - rl %d, mplen %d, eps %d, ep %d, dev %d"
-usb_ehci_qh_bits(uint32_t addr, int c, int h, int dtc, int i) "QH @ %08x - c %d, h %d, dtc %d, i %d"
-usb_ehci_qtd_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t altnext) "q %p - QTD @ %08x: next %08x altnext %08x"
-usb_ehci_qtd_fields(uint32_t addr, int tbytes, int cpage, int cerr, int pid) "QTD @ %08x - tbytes %d, cpage %d, cerr %d, pid %d"
-usb_ehci_qtd_bits(uint32_t addr, int ioc, int active, int halt, int babble, int xacterr) "QTD @ %08x - ioc %d, active %d, halt %d, babble %d, xacterr %d"
-usb_ehci_itd(uint32_t addr, uint32_t nxt, uint32_t mplen, uint32_t mult, uint32_t ep, uint32_t devaddr) "ITD @ %08x: next %08x - mplen %d, mult %d, ep %d, dev %d"
-usb_ehci_sitd(uint32_t addr, uint32_t nxt, uint32_t active) "ITD @ %08x: next %08x - active %d"
+usb_ehci_qh_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t c_qtd, uint32_t n_qtd, uint32_t a_qtd) "q %p - QH @ %#08x: next %#08x qtds %#08x,%#08x,%#08x"
+usb_ehci_qh_fields(uint32_t addr, int rl, int mplen, int eps, int ep, int devaddr) "QH @ %#08x - rl %d, mplen %d, eps %d, ep %d, dev %d"
+usb_ehci_qh_bits(uint32_t addr, int c, int h, int dtc, int i) "QH @ %#08x - c %d, h %d, dtc %d, i %d"
+usb_ehci_qtd_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t altnext) "q %p - QTD @ %#08x: next %#08x altnext %#08x"
+usb_ehci_qtd_fields(uint32_t addr, int tbytes, int cpage, int cerr, int pid) "QTD @ %#08x - tbytes %d, cpage %d, cerr %d, pid %d"
+usb_ehci_qtd_bits(uint32_t addr, int ioc, int active, int halt, int babble, int xacterr) "QTD @ %#08x - ioc %d, active %d, halt %d, babble %d, xacterr %d"
+usb_ehci_itd(uint32_t addr, uint32_t nxt, uint32_t mplen, uint32_t mult, uint32_t ep, uint32_t devaddr) "ITD @ %#08x: next %#08x - mplen %d, mult %d, ep %d, dev %d"
+usb_ehci_sitd(uint32_t addr, uint32_t nxt, uint32_t active) "ITD @ %#08x: next %#08x - active %d"
 usb_ehci_port_attach(uint32_t port, const char *owner, const char *device) "attach port #%d, owner %s, device %s"
 usb_ehci_port_detach(uint32_t port, const char *owner) "detach port #%d, owner %s"
 usb_ehci_port_reset(uint32_t port, int enable) "reset port #%d - %d"
@@ -94,7 +94,7 @@ usb_ehci_port_wakeup(uint32_t port) "port #%d"
 usb_ehci_port_resume(uint32_t port) "port #%d"
 usb_ehci_queue_action(void *q, const char *action) "q %p: %s"
 usb_ehci_packet_action(void *q, void *p, const char *action) "q %p p %p: %s"
-usb_ehci_irq(uint32_t level, uint32_t frindex, uint32_t sts, uint32_t mask) "level %d, frindex 0x%04x, sts 0x%x, mask 0x%x"
+usb_ehci_irq(uint32_t level, uint32_t frindex, uint32_t sts, uint32_t mask) "level %d, frindex %#04x, sts %#x, mask %#x"
 usb_ehci_guest_bug(const char *reason) "%s"
 usb_ehci_doorbell_ring(void) ""
 usb_ehci_doorbell_ack(void) ""
@@ -109,51 +109,51 @@ usb_uhci_frame_start(uint32_t num) "nr %d"
 usb_uhci_frame_stop_bandwidth(void) ""
 usb_uhci_frame_loop_stop_idle(void) ""
 usb_uhci_frame_loop_continue(void) ""
-usb_uhci_mmio_readw(uint32_t addr, uint32_t val) "addr 0x%04x, ret 0x%04x"
-usb_uhci_mmio_writew(uint32_t addr, uint32_t val) "addr 0x%04x, val 0x%04x"
-usb_uhci_queue_add(uint32_t token) "token 0x%x"
-usb_uhci_queue_del(uint32_t token, const char *reason) "token 0x%x: %s"
-usb_uhci_packet_add(uint32_t token, uint32_t addr) "token 0x%x, td 0x%x"
-usb_uhci_packet_link_async(uint32_t token, uint32_t addr) "token 0x%x, td 0x%x"
-usb_uhci_packet_unlink_async(uint32_t token, uint32_t addr) "token 0x%x, td 0x%x"
-usb_uhci_packet_cancel(uint32_t token, uint32_t addr, int done) "token 0x%x, td 0x%x, done %d"
-usb_uhci_packet_complete_success(uint32_t token, uint32_t addr) "token 0x%x, td 0x%x"
-usb_uhci_packet_complete_shortxfer(uint32_t token, uint32_t addr) "token 0x%x, td 0x%x"
-usb_uhci_packet_complete_stall(uint32_t token, uint32_t addr) "token 0x%x, td 0x%x"
-usb_uhci_packet_complete_babble(uint32_t token, uint32_t addr) "token 0x%x, td 0x%x"
-usb_uhci_packet_complete_error(uint32_t token, uint32_t addr) "token 0x%x, td 0x%x"
-usb_uhci_packet_del(uint32_t token, uint32_t addr) "token 0x%x, td 0x%x"
-usb_uhci_qh_load(uint32_t qh) "qh 0x%x"
-usb_uhci_td_load(uint32_t qh, uint32_t td, uint32_t ctrl, uint32_t token) "qh 0x%x, td 0x%x, ctrl 0x%x, token 0x%x"
-usb_uhci_td_queue(uint32_t td, uint32_t ctrl, uint32_t token) "td 0x%x, ctrl 0x%x, token 0x%x"
-usb_uhci_td_nextqh(uint32_t qh, uint32_t td) "qh 0x%x, td 0x%x"
-usb_uhci_td_async(uint32_t qh, uint32_t td) "qh 0x%x, td 0x%x"
-usb_uhci_td_complete(uint32_t qh, uint32_t td) "qh 0x%x, td 0x%x"
+usb_uhci_mmio_readw(uint32_t addr, uint32_t val) "addr %#04x, ret %#04x"
+usb_uhci_mmio_writew(uint32_t addr, uint32_t val) "addr %#04x, val %#04x"
+usb_uhci_queue_add(uint32_t token) "token %#x"
+usb_uhci_queue_del(uint32_t token, const char *reason) "token %#x: %s"
+usb_uhci_packet_add(uint32_t token, uint32_t addr) "token %#x, td %#x"
+usb_uhci_packet_link_async(uint32_t token, uint32_t addr) "token %#x, td %#x"
+usb_uhci_packet_unlink_async(uint32_t token, uint32_t addr) "token %#x, td %#x"
+usb_uhci_packet_cancel(uint32_t token, uint32_t addr, int done) "token %#x, td %#x, done %d"
+usb_uhci_packet_complete_success(uint32_t token, uint32_t addr) "token %#x, td %#x"
+usb_uhci_packet_complete_shortxfer(uint32_t token, uint32_t addr) "token %#x, td %#x"
+usb_uhci_packet_complete_stall(uint32_t token, uint32_t addr) "token %#x, td %#x"
+usb_uhci_packet_complete_babble(uint32_t token, uint32_t addr) "token %#x, td %#x"
+usb_uhci_packet_complete_error(uint32_t token, uint32_t addr) "token %#x, td %#x"
+usb_uhci_packet_del(uint32_t token, uint32_t addr) "token %#x, td %#x"
+usb_uhci_qh_load(uint32_t qh) "qh %#x"
+usb_uhci_td_load(uint32_t qh, uint32_t td, uint32_t ctrl, uint32_t token) "qh %#x, td %#x, ctrl %#x, token %#x"
+usb_uhci_td_queue(uint32_t td, uint32_t ctrl, uint32_t token) "td %#x, ctrl %#x, token %#x"
+usb_uhci_td_nextqh(uint32_t qh, uint32_t td) "qh %#x, td %#x"
+usb_uhci_td_async(uint32_t qh, uint32_t td) "qh %#x, td %#x"
+usb_uhci_td_complete(uint32_t qh, uint32_t td) "qh %#x, td %#x"
 
 # hw/usb/hcd-xhci.c
 usb_xhci_reset(void) "=== RESET ==="
 usb_xhci_exit(void) "=== EXIT ==="
 usb_xhci_run(void) ""
 usb_xhci_stop(void) ""
-usb_xhci_cap_read(uint32_t off, uint32_t val) "off 0x%04x, ret 0x%08x"
-usb_xhci_oper_read(uint32_t off, uint32_t val) "off 0x%04x, ret 0x%08x"
-usb_xhci_port_read(uint32_t port, uint32_t off, uint32_t val) "port %d, off 0x%04x, ret 0x%08x"
-usb_xhci_runtime_read(uint32_t off, uint32_t val) "off 0x%04x, ret 0x%08x"
-usb_xhci_doorbell_read(uint32_t off, uint32_t val) "off 0x%04x, ret 0x%08x"
-usb_xhci_oper_write(uint32_t off, uint32_t val) "off 0x%04x, val 0x%08x"
-usb_xhci_port_write(uint32_t port, uint32_t off, uint32_t val) "port %d, off 0x%04x, val 0x%08x"
-usb_xhci_runtime_write(uint32_t off, uint32_t val) "off 0x%04x, val 0x%08x"
-usb_xhci_doorbell_write(uint32_t off, uint32_t val) "off 0x%04x, val 0x%08x"
+usb_xhci_cap_read(uint32_t off, uint32_t val) "off %#04x, ret %#08x"
+usb_xhci_oper_read(uint32_t off, uint32_t val) "off %#04x, ret %#08x"
+usb_xhci_port_read(uint32_t port, uint32_t off, uint32_t val) "port %d, off %#04x, ret %#08x"
+usb_xhci_runtime_read(uint32_t off, uint32_t val) "off %#04x, ret %#08x"
+usb_xhci_doorbell_read(uint32_t off, uint32_t val) "off %#04x, ret %#08x"
+usb_xhci_oper_write(uint32_t off, uint32_t val) "off %#04x, val %#08x"
+usb_xhci_port_write(uint32_t port, uint32_t off, uint32_t val) "port %d, off %#04x, val %#08x"
+usb_xhci_runtime_write(uint32_t off, uint32_t val) "off %#04x, val %#08x"
+usb_xhci_doorbell_write(uint32_t off, uint32_t val) "off %#04x, val %#08x"
 usb_xhci_irq_intx(uint32_t level) "level %d"
 usb_xhci_irq_msi(uint32_t nr) "nr %d"
 usb_xhci_irq_msix(uint32_t nr) "nr %d"
 usb_xhci_irq_msix_use(uint32_t nr) "nr %d"
 usb_xhci_irq_msix_unuse(uint32_t nr) "nr %d"
-usb_xhci_queue_event(uint32_t vector, uint32_t idx, const char *trb, const char *evt, uint64_t param, uint32_t status, uint32_t control) "v %d, idx %d, %s, %s, p %016" PRIx64 ", s %08x, c 0x%08x"
-usb_xhci_fetch_trb(uint64_t addr, const char *name, uint64_t param, uint32_t status, uint32_t control) "addr %016" PRIx64 ", %s, p %016" PRIx64 ", s %08x, c 0x%08x"
+usb_xhci_queue_event(uint32_t vector, uint32_t idx, const char *trb, const char *evt, uint64_t param, uint32_t status, uint32_t control) "v %d, idx %d, %s, %s, p %#016" PRIx64 ", s %#08x, c %#08x"
+usb_xhci_fetch_trb(uint64_t addr, const char *name, uint64_t param, uint32_t status, uint32_t control) "addr %#016" PRIx64 ", %s, p %#016" PRIx64 ", s %#08x, c %#08x"
 usb_xhci_port_reset(uint32_t port, bool warm) "port %d, warm %d"
 usb_xhci_port_link(uint32_t port, uint32_t pls) "port %d, pls %d"
-usb_xhci_port_notify(uint32_t port, uint32_t pls) "port %d, bits %x"
+usb_xhci_port_notify(uint32_t port, uint32_t pls) "port %d, bits %#x"
 usb_xhci_slot_enable(uint32_t slotid) "slotid %d"
 usb_xhci_slot_disable(uint32_t slotid) "slotid %d"
 usb_xhci_slot_address(uint32_t slotid, const char *port) "slotid %d, port %s"
@@ -162,7 +162,7 @@ usb_xhci_slot_evaluate(uint32_t slotid) "slotid %d"
 usb_xhci_slot_reset(uint32_t slotid) "slotid %d"
 usb_xhci_ep_enable(uint32_t slotid, uint32_t epid) "slotid %d, epid %d"
 usb_xhci_ep_disable(uint32_t slotid, uint32_t epid) "slotid %d, epid %d"
-usb_xhci_ep_set_dequeue(uint32_t slotid, uint32_t epid, uint32_t streamid, uint64_t param) "slotid %d, epid %d, streamid %d, ptr %016" PRIx64
+usb_xhci_ep_set_dequeue(uint32_t slotid, uint32_t epid, uint32_t streamid, uint64_t param) "slotid %d, epid %d, streamid %d, ptr %#016" PRIx64
 usb_xhci_ep_kick(uint32_t slotid, uint32_t epid, uint32_t streamid) "slotid %d, epid %d, streamid %d"
 usb_xhci_ep_stop(uint32_t slotid, uint32_t epid) "slotid %d, epid %d"
 usb_xhci_ep_reset(uint32_t slotid, uint32_t epid) "slotid %d, epid %d"
@@ -173,7 +173,7 @@ usb_xhci_xfer_nak(void *xfer) "%p"
 usb_xhci_xfer_retry(void *xfer) "%p"
 usb_xhci_xfer_success(void *xfer, uint32_t bytes) "%p: len %d"
 usb_xhci_xfer_error(void *xfer, uint32_t ret) "%p: ret %d"
-usb_xhci_unimplemented(const char *item, int nr) "%s (0x%x)"
+usb_xhci_unimplemented(const char *item, int nr) "%s (%#x)"
 usb_xhci_enforced_limit(const char *item) "%s"
 
 # hw/usb/desc.c
@@ -183,7 +183,7 @@ usb_desc_config(int addr, int index, int len, int ret) "dev %d query config %d,
 usb_desc_other_speed_config(int addr, int index, int len, int ret) "dev %d query config %d, len %d, ret %d"
 usb_desc_string(int addr, int index, int len, int ret) "dev %d query string %d, len %d, ret %d"
 usb_desc_bos(int addr, int len, int ret) "dev %d bos, len %d, ret %d"
-usb_desc_msos(int addr, int index, int len, int ret) "dev %d msos, index 0x%x, len %d, ret %d"
+usb_desc_msos(int addr, int index, int len, int ret) "dev %d msos, index %#x, len %d, ret %d"
 usb_set_addr(int addr) "dev %d"
 usb_set_config(int addr, int config, int ret) "dev %d, config %d, ret %d"
 usb_set_interface(int addr, int iface, int alt, int ret) "dev %d, interface %d, altsetting %d, ret %d"
@@ -192,34 +192,34 @@ usb_set_device_feature(int addr, int feature, int ret) "dev %d, feature %d, ret
 
 # hw/usb/dev-hub.c
 usb_hub_reset(int addr) "dev %d"
-usb_hub_control(int addr, int request, int value, int index, int length) "dev %d, req 0x%x, value %d, index %d, langth %d"
-usb_hub_get_port_status(int addr, int nr, int status, int changed) "dev %d, port %d, status 0x%x, changed 0x%x"
+usb_hub_control(int addr, int request, int value, int index, int length) "dev %d, req %#x, value %d, index %d, langth %d"
+usb_hub_get_port_status(int addr, int nr, int status, int changed) "dev %d, port %d, status %#x, changed %#x"
 usb_hub_set_port_feature(int addr, int nr, const char *f) "dev %d, port %d, feature %s"
 usb_hub_clear_port_feature(int addr, int nr, const char *f) "dev %d, port %d, feature %s"
 usb_hub_attach(int addr, int nr) "dev %d, port %d"
 usb_hub_detach(int addr, int nr) "dev %d, port %d"
-usb_hub_status_report(int addr, int status) "dev %d, status 0x%x"
+usb_hub_status_report(int addr, int status) "dev %d, status %#x"
 
 # hw/usb/dev-uas.c
 usb_uas_reset(int addr) "dev %d"
-usb_uas_command(int addr, uint16_t tag, int lun, uint32_t lun64_1, uint32_t lun64_2) "dev %d, tag 0x%x, lun %d, lun64 %08x-%08x"
-usb_uas_response(int addr, uint16_t tag, uint8_t code) "dev %d, tag 0x%x, code 0x%x"
-usb_uas_sense(int addr, uint16_t tag, uint8_t status) "dev %d, tag 0x%x, status 0x%x"
-usb_uas_read_ready(int addr, uint16_t tag) "dev %d, tag 0x%x"
-usb_uas_write_ready(int addr, uint16_t tag) "dev %d, tag 0x%x"
-usb_uas_xfer_data(int addr, uint16_t tag, uint32_t copy, uint32_t uoff, uint32_t usize, uint32_t soff, uint32_t ssize) "dev %d, tag 0x%x, copy %d, usb-pkt %d/%d, scsi-buf %d/%d"
-usb_uas_scsi_data(int addr, uint16_t tag, uint32_t bytes) "dev %d, tag 0x%x, bytes %d"
-usb_uas_scsi_complete(int addr, uint16_t tag, uint32_t status, uint32_t resid) "dev %d, tag 0x%x, status 0x%x, residue %d"
-usb_uas_tmf_abort_task(int addr, uint16_t tag, uint16_t task_tag) "dev %d, tag 0x%x, task-tag 0x%x"
-usb_uas_tmf_logical_unit_reset(int addr, uint16_t tag, int lun) "dev %d, tag 0x%x, lun %d"
-usb_uas_tmf_unsupported(int addr, uint16_t tag, uint32_t function) "dev %d, tag 0x%x, function 0x%x"
+usb_uas_command(int addr, uint16_t tag, int lun, uint32_t lun64_1, uint32_t lun64_2) "dev %d, tag %#x, lun %d, lun64 %#08x-%#08x"
+usb_uas_response(int addr, uint16_t tag, uint8_t code) "dev %d, tag %#x, code %#x"
+usb_uas_sense(int addr, uint16_t tag, uint8_t status) "dev %d, tag %#x, status %#x"
+usb_uas_read_ready(int addr, uint16_t tag) "dev %d, tag %#x"
+usb_uas_write_ready(int addr, uint16_t tag) "dev %d, tag %#x"
+usb_uas_xfer_data(int addr, uint16_t tag, uint32_t copy, uint32_t uoff, uint32_t usize, uint32_t soff, uint32_t ssize) "dev %d, tag %#x, copy %d, usb-pkt %d/%d, scsi-buf %d/%d"
+usb_uas_scsi_data(int addr, uint16_t tag, uint32_t bytes) "dev %d, tag %#x, bytes %d"
+usb_uas_scsi_complete(int addr, uint16_t tag, uint32_t status, uint32_t resid) "dev %d, tag %#x, status %#x, residue %d"
+usb_uas_tmf_abort_task(int addr, uint16_t tag, uint16_t task_tag) "dev %d, tag %#x, task-tag %#x"
+usb_uas_tmf_logical_unit_reset(int addr, uint16_t tag, int lun) "dev %d, tag %#x, lun %d"
+usb_uas_tmf_unsupported(int addr, uint16_t tag, uint32_t function) "dev %d, tag %#x, function %#x"
 
 # hw/usb/dev-mtp.c
 usb_mtp_reset(int addr) "dev %d"
-usb_mtp_command(int dev, uint16_t code, uint32_t trans, uint32_t arg0, uint32_t arg1, uint32_t arg2, uint32_t arg3, uint32_t arg4) "dev %d, code 0x%x, trans 0x%x, args 0x%x, 0x%x, 0x%x, 0x%x, 0x%x"
-usb_mtp_success(int dev, uint32_t trans, uint32_t arg0, uint32_t arg1) "dev %d, trans 0x%x, args 0x%x, 0x%x"
-usb_mtp_error(int dev, uint16_t code, uint32_t trans, uint32_t arg0, uint32_t arg1) "dev %d, code 0x%x, trans 0x%x, args 0x%x, 0x%x"
-usb_mtp_data_in(int dev, uint32_t trans, uint32_t len) "dev %d, trans 0x%x, len %d"
+usb_mtp_command(int dev, uint16_t code, uint32_t trans, uint32_t arg0, uint32_t arg1, uint32_t arg2, uint32_t arg3, uint32_t arg4) "dev %d, code %#x, trans %#x, args %#x, %#x, %#x, %#x, %#x"
+usb_mtp_success(int dev, uint32_t trans, uint32_t arg0, uint32_t arg1) "dev %d, trans %#x, args %#x, %#x"
+usb_mtp_error(int dev, uint16_t code, uint32_t trans, uint32_t arg0, uint32_t arg1) "dev %d, code %#x, trans %#x, args %#x, %#x"
+usb_mtp_data_in(int dev, uint32_t trans, uint32_t len) "dev %d, trans %#x, len %d"
 usb_mtp_xfer(int dev, uint32_t ep, uint32_t dlen, uint32_t plen) "dev %d, ep %d, %d/%d"
 usb_mtp_nak(int dev, uint32_t ep) "dev %d, ep %d"
 usb_mtp_stall(int dev, const char *reason) "dev %d, reason: %s"
@@ -228,16 +228,16 @@ usb_mtp_op_open_session(int dev) "dev %d"
 usb_mtp_op_close_session(int dev) "dev %d"
 usb_mtp_op_get_storage_ids(int dev) "dev %d"
 usb_mtp_op_get_storage_info(int dev) "dev %d"
-usb_mtp_op_get_num_objects(int dev, uint32_t handle, const char *path) "dev %d, handle 0x%x, path %s"
-usb_mtp_op_get_object_handles(int dev, uint32_t handle, const char *path) "dev %d, handle 0x%x, path %s"
-usb_mtp_op_get_object_info(int dev, uint32_t handle, const char *path) "dev %d, handle 0x%x, path %s"
-usb_mtp_op_get_object(int dev, uint32_t handle, const char *path) "dev %d, handle 0x%x, path %s"
-usb_mtp_op_get_partial_object(int dev, uint32_t handle, const char *path, uint32_t offset, uint32_t length) "dev %d, handle 0x%x, path %s, off %d, len %d"
-usb_mtp_op_unknown(int dev, uint32_t code) "dev %d, command code 0x%x"
-usb_mtp_object_alloc(int dev, uint32_t handle, const char *path) "dev %d, handle 0x%x, path %s"
-usb_mtp_object_free(int dev, uint32_t handle, const char *path) "dev %d, handle 0x%x, path %s"
-usb_mtp_add_child(int dev, uint32_t handle, const char *path) "dev %d, handle 0x%x, path %s"
-usb_mtp_inotify_event(int dev, const char *path, uint32_t mask, const char *s) "dev %d, path %s mask 0x%x event %s"
+usb_mtp_op_get_num_objects(int dev, uint32_t handle, const char *path) "dev %d, handle %#x, path %s"
+usb_mtp_op_get_object_handles(int dev, uint32_t handle, const char *path) "dev %d, handle %#x, path %s"
+usb_mtp_op_get_object_info(int dev, uint32_t handle, const char *path) "dev %d, handle %#x, path %s"
+usb_mtp_op_get_object(int dev, uint32_t handle, const char *path) "dev %d, handle %#x, path %s"
+usb_mtp_op_get_partial_object(int dev, uint32_t handle, const char *path, uint32_t offset, uint32_t length) "dev %d, handle %#x, path %s, off %d, len %d"
+usb_mtp_op_unknown(int dev, uint32_t code) "dev %d, command code %#x"
+usb_mtp_object_alloc(int dev, uint32_t handle, const char *path) "dev %d, handle %#x, path %s"
+usb_mtp_object_free(int dev, uint32_t handle, const char *path) "dev %d, handle %#x, path %s"
+usb_mtp_add_child(int dev, uint32_t handle, const char *path) "dev %d, handle %#x, path %s"
+usb_mtp_inotify_event(int dev, const char *path, uint32_t mask, const char *s) "dev %d, path %s mask %#x event %s"
 
 # hw/usb/host-libusb.c
 usb_host_open_started(int bus, int addr) "dev %d:%d"
@@ -251,7 +251,7 @@ usb_host_set_config(int bus, int addr, int config) "dev %d:%d, config %d"
 usb_host_set_interface(int bus, int addr, int interface, int alt) "dev %d:%d, interface %d, alt %d"
 usb_host_claim_interface(int bus, int addr, int config, int interface) "dev %d:%d, config %d, if %d"
 usb_host_release_interface(int bus, int addr, int interface) "dev %d:%d, if %d"
-usb_host_req_control(int bus, int addr, void *p, int req, int value, int index) "dev %d:%d, packet %p, req 0x%x, value %d, index %d"
+usb_host_req_control(int bus, int addr, void *p, int req, int value, int index) "dev %d:%d, packet %p, req %#x, value %d, index %d"
 usb_host_req_data(int bus, int addr, void *p, int in, int ep, int size) "dev %d:%d, packet %p, in %d, ep %d, size %d"
 usb_host_req_complete(int bus, int addr, void *p, int status, int length) "dev %d:%d, packet %p, status %d, length %d"
 usb_host_req_emulated(int bus, int addr, void *p, int status) "dev %d:%d, packet %p, status %d"
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 2561c6d31a..edd332fe9a 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -8,66 +8,66 @@ vfio_intx_disable_kvm(const char *name) " (%s) KVM INTx accel disabled"
 vfio_intx_update(const char *name, int new_irq, int target_irq) " (%s) IRQ moved %d -> %d"
 vfio_intx_enable(const char *name) " (%s)"
 vfio_intx_disable(const char *name) " (%s)"
-vfio_msi_interrupt(const char *name, int index, uint64_t addr, int data) " (%s) vector %d 0x%"PRIx64"/0x%x"
+vfio_msi_interrupt(const char *name, int index, uint64_t addr, int data) " (%s) vector %d %#"PRIx64"/%#x"
 vfio_msix_vector_do_use(const char *name, int index) " (%s) vector %d used"
 vfio_msix_vector_release(const char *name, int index) " (%s) vector %d released"
 vfio_msix_enable(const char *name) " (%s)"
 vfio_msix_pba_disable(const char *name) " (%s)"
 vfio_msix_pba_enable(const char *name) " (%s)"
 vfio_msix_disable(const char *name) " (%s)"
-vfio_msix_fixup(const char *name, int bar, uint64_t start, uint64_t end) " (%s) MSI-X region %d mmap fixup [0x%"PRIx64" - 0x%"PRIx64"]"
+vfio_msix_fixup(const char *name, int bar, uint64_t start, uint64_t end) " (%s) MSI-X region %d mmap fixup [%#"PRIx64" - %#"PRIx64"]"
 vfio_msi_enable(const char *name, int nr_vectors) " (%s) Enabled %d MSI vectors"
 vfio_msi_disable(const char *name) " (%s)"
-vfio_pci_load_rom(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device %s ROM:\n  size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
-vfio_rom_read(const char *name, uint64_t addr, int size, uint64_t data) " (%s, 0x%"PRIx64", 0x%x) = 0x%"PRIx64
-vfio_pci_size_rom(const char *name, int size) "%s ROM size 0x%x"
-vfio_vga_write(uint64_t addr, uint64_t data, int size) " (0x%"PRIx64", 0x%"PRIx64", %d)"
-vfio_vga_read(uint64_t addr, int size, uint64_t data) " (0x%"PRIx64", %d) = 0x%"PRIx64
-vfio_pci_read_config(const char *name, int addr, int len, int val) " (%s, @0x%x, len=0x%x) %x"
-vfio_pci_write_config(const char *name, int addr, int val, int len) " (%s, @0x%x, 0x%x, len=0x%x)"
-vfio_msi_setup(const char *name, int pos) "%s PCI MSI CAP @0x%x"
-vfio_msix_early_setup(const char *name, int pos, int table_bar, int offset, int entries) "%s PCI MSI-X CAP @0x%x, BAR %d, offset 0x%x, entries %d"
+vfio_pci_load_rom(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device %s ROM:\n  size: %#lx, offset: %#lx, flags: %#lx"
+vfio_rom_read(const char *name, uint64_t addr, int size, uint64_t data) " (%s, %#"PRIx64", %#x) = %#"PRIx64
+vfio_pci_size_rom(const char *name, int size) "%s ROM size %#x"
+vfio_vga_write(uint64_t addr, uint64_t data, int size) " (%#"PRIx64", %#"PRIx64", %d)"
+vfio_vga_read(uint64_t addr, int size, uint64_t data) " (%#"PRIx64", %d) = %#"PRIx64
+vfio_pci_read_config(const char *name, int addr, int len, int val) " (%s, @%#x, len=%#x) %#x"
+vfio_pci_write_config(const char *name, int addr, int val, int len) " (%s, @%#x, %#x, len=%#x)"
+vfio_msi_setup(const char *name, int pos) "%s PCI MSI CAP @%#x"
+vfio_msix_early_setup(const char *name, int pos, int table_bar, int offset, int entries) "%s PCI MSI-X CAP @%#x, BAR %d, offset %#x, entries %d"
 vfio_check_pcie_flr(const char *name) "%s Supports FLR via PCIe cap"
 vfio_check_pm_reset(const char *name) "%s Supports PM reset"
 vfio_check_af_flr(const char *name) "%s Supports FLR via AF cap"
 vfio_pci_hot_reset(const char *name, const char *type) " (%s) %s"
 vfio_pci_hot_reset_has_dep_devices(const char *name) "%s: hot reset dependent devices:"
-vfio_pci_hot_reset_dep_devices(int domain, int bus, int slot, int function, int group_id) "\t%04x:%02x:%02x.%x group %d"
+vfio_pci_hot_reset_dep_devices(int domain, int bus, int slot, int function, int group_id) "\t%#04x:%#02x:%#02x.%#x group %d"
 vfio_pci_hot_reset_result(const char *name, const char *result) "%s hot reset: %s"
-vfio_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device %s config:\n  size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
+vfio_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device %s config:\n  size: %#lx, offset: %#lx, flags: %#lx"
 vfio_populate_device_get_irq_info_failure(void) "VFIO_DEVICE_GET_IRQ_INFO failure: %m"
 vfio_realize(const char *name, int group_id) " (%s) group %d"
-vfio_add_ext_cap_dropped(const char *name, uint16_t cap, uint16_t offset) "%s %x@%x"
+vfio_add_ext_cap_dropped(const char *name, uint16_t cap, uint16_t offset) "%s %#x@%#x"
 vfio_pci_reset(const char *name) " (%s)"
 vfio_pci_reset_flr(const char *name) "%s FLR/VFIO_DEVICE_RESET"
 vfio_pci_reset_pm(const char *name) "%s PCI PM Reset"
-vfio_pci_emulated_vendor_id(const char *name, uint16_t val) "%s %04x"
-vfio_pci_emulated_device_id(const char *name, uint16_t val) "%s %04x"
-vfio_pci_emulated_sub_vendor_id(const char *name, uint16_t val) "%s %04x"
-vfio_pci_emulated_sub_device_id(const char *name, uint16_t val) "%s %04x"
+vfio_pci_emulated_vendor_id(const char *name, uint16_t val) "%s %#04x"
+vfio_pci_emulated_device_id(const char *name, uint16_t val) "%s %#04x"
+vfio_pci_emulated_sub_vendor_id(const char *name, uint16_t val) "%s %#04x"
+vfio_pci_emulated_sub_device_id(const char *name, uint16_t val) "%s %#04x"
 
 # hw/vfio/pci-quirks.c
-vfio_quirk_rom_blacklisted(const char *name, uint16_t vid, uint16_t did) "%s %04x:%04x"
-vfio_quirk_generic_window_address_write(const char *name, const char * region_name, uint64_t data) "%s %s 0x%"PRIx64
-vfio_quirk_generic_window_data_read(const char *name, const char * region_name, uint64_t data) "%s %s 0x%"PRIx64
-vfio_quirk_generic_window_data_write(const char *name, const char * region_name, uint64_t data) "%s %s 0x%"PRIx64
-vfio_quirk_generic_mirror_read(const char *name, const char * region_name, uint64_t addr, uint64_t data) "%s %s 0x%"PRIx64": 0x%"PRIx64
-vfio_quirk_generic_mirror_write(const char *name, const char * region_name, uint64_t addr, uint64_t data) "%s %s 0x%"PRIx64": 0x%"PRIx64
-vfio_quirk_ati_3c3_read(const char *name, uint64_t data) "%s 0x%"PRIx64
+vfio_quirk_rom_blacklisted(const char *name, uint16_t vid, uint16_t did) "%s %#04x:%#04x"
+vfio_quirk_generic_window_address_write(const char *name, const char * region_name, uint64_t data) "%s %s %#"PRIx64
+vfio_quirk_generic_window_data_read(const char *name, const char * region_name, uint64_t data) "%s %s %#"PRIx64
+vfio_quirk_generic_window_data_write(const char *name, const char * region_name, uint64_t data) "%s %s %#"PRIx64
+vfio_quirk_generic_mirror_read(const char *name, const char * region_name, uint64_t addr, uint64_t data) "%s %s %#"PRIx64": %#"PRIx64
+vfio_quirk_generic_mirror_write(const char *name, const char * region_name, uint64_t addr, uint64_t data) "%s %s %#"PRIx64": %#"PRIx64
+vfio_quirk_ati_3c3_read(const char *name, uint64_t data) "%s %#"PRIx64
 vfio_quirk_ati_3c3_probe(const char *name) "%s"
 vfio_quirk_ati_bar4_probe(const char *name) "%s"
 vfio_quirk_ati_bar2_probe(const char *name) "%s"
 vfio_quirk_nvidia_3d0_state(const char *name, const char *state) "%s %s"
-vfio_quirk_nvidia_3d0_read(const char *name, uint8_t offset, unsigned size, uint64_t val) " (%s, @0x%x, len=0x%x) %"PRIx64
-vfio_quirk_nvidia_3d0_write(const char *name, uint8_t offset, uint64_t data, unsigned size) "(%s, @0x%x, 0x%"PRIx64", len=0x%x)"
+vfio_quirk_nvidia_3d0_read(const char *name, uint8_t offset, unsigned size, uint64_t val) " (%s, @%#x, len=%#x) %#"PRIx64
+vfio_quirk_nvidia_3d0_write(const char *name, uint8_t offset, uint64_t data, unsigned size) "(%s, @%#x, %#"PRIx64", len=%#x)"
 vfio_quirk_nvidia_3d0_probe(const char *name) "%s"
 vfio_quirk_nvidia_bar5_state(const char *name, const char *state) "%s %s"
 vfio_quirk_nvidia_bar5_probe(const char *name) "%s"
 vfio_quirk_nvidia_bar0_msi_ack(const char *name) "%s"
 vfio_quirk_nvidia_bar0_probe(const char *name) "%s"
-vfio_quirk_rtl8168_fake_latch(const char *name, uint64_t val) "%s 0x%"PRIx64
-vfio_quirk_rtl8168_msix_write(const char *name, uint16_t offset, uint64_t val) "%s MSI-X table write[0x%x]: 0x%"PRIx64
-vfio_quirk_rtl8168_msix_read(const char *name, uint16_t offset, uint64_t val) "%s MSI-X table read[0x%x]: 0x%"PRIx64
+vfio_quirk_rtl8168_fake_latch(const char *name, uint64_t val) "%s %#"PRIx64
+vfio_quirk_rtl8168_msix_write(const char *name, uint16_t offset, uint64_t val) "%s MSI-X table write[%#x]: %#"PRIx64
+vfio_quirk_rtl8168_msix_read(const char *name, uint16_t offset, uint64_t val) "%s MSI-X table read[%#x]: %#"PRIx64
 vfio_quirk_rtl8168_probe(const char *name) "%s"
 
 vfio_quirk_ati_bonaire_reset_skipped(const char *name) "%s"
@@ -75,34 +75,34 @@ vfio_quirk_ati_bonaire_reset_no_smc(const char *name) "%s"
 vfio_quirk_ati_bonaire_reset_timeout(const char *name) "%s"
 vfio_quirk_ati_bonaire_reset_done(const char *name) "%s"
 vfio_quirk_ati_bonaire_reset(const char *name) "%s"
-vfio_pci_igd_bar4_write(const char *name, uint32_t index, uint32_t data, uint32_t base) "%s [%03x] %08x -> %08x"
+vfio_pci_igd_bar4_write(const char *name, uint32_t index, uint32_t data, uint32_t base) "%s [%#03x] %#08x -> %#08x"
 vfio_pci_igd_bdsm_enabled(const char *name, int size) "%s %dMB"
 vfio_pci_igd_opregion_enabled(const char *name) "%s"
 vfio_pci_igd_host_bridge_enabled(const char *name) "%s"
 vfio_pci_igd_lpc_bridge_enabled(const char *name) "%s"
 
 # hw/vfio/common.c
-vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
-vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t data) " (%s:region%d+0x%"PRIx64", %d) = 0x%"PRIx64
-vfio_iommu_map_notify(const char *op, uint64_t iova_start, uint64_t iova_end) "iommu %s @ %"PRIx64" - %"PRIx64
-vfio_listener_region_add_skip(uint64_t start, uint64_t end) "SKIPPING region_add %"PRIx64" - %"PRIx64
-vfio_listener_region_add_iommu(uint64_t start, uint64_t end) "region_add [iommu] %"PRIx64" - %"PRIx64
-vfio_listener_region_add_ram(uint64_t iova_start, uint64_t iova_end, void *vaddr) "region_add [ram] %"PRIx64" - %"PRIx64" [%p]"
-vfio_listener_region_del_skip(uint64_t start, uint64_t end) "SKIPPING region_del %"PRIx64" - %"PRIx64
-vfio_listener_region_del(uint64_t start, uint64_t end) "region_del %"PRIx64" - %"PRIx64
+vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+%#"PRIx64", %#"PRIx64 ", %d)"
+vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t data) " (%s:region%d+%#"PRIx64", %d) = %#"PRIx64
+vfio_iommu_map_notify(const char *op, uint64_t iova_start, uint64_t iova_end) "iommu %s @ %#"PRIx64" - %#"PRIx64
+vfio_listener_region_add_skip(uint64_t start, uint64_t end) "SKIPPING region_add %#"PRIx64" - %#"PRIx64
+vfio_listener_region_add_iommu(uint64_t start, uint64_t end) "region_add [iommu] %#"PRIx64" - %#"PRIx64
+vfio_listener_region_add_ram(uint64_t iova_start, uint64_t iova_end, void *vaddr) "region_add [ram] %#"PRIx64" - %#"PRIx64" [%p]"
+vfio_listener_region_del_skip(uint64_t start, uint64_t end) "SKIPPING region_del %#"PRIx64" - %#"PRIx64
+vfio_listener_region_del(uint64_t start, uint64_t end) "region_del %#"PRIx64" - %#"PRIx64
 vfio_disconnect_container(int fd) "close container->fd=%d"
 vfio_put_group(int fd) "close group->fd=%d"
 vfio_get_device(const char * name, unsigned int flags, unsigned int num_regions, unsigned int num_irqs) "Device %s flags: %u, regions: %u, irqs: %u"
 vfio_put_base_device(int fd) "close vdev->fd=%d"
-vfio_region_setup(const char *dev, int index, const char *name, unsigned long flags, unsigned long offset, unsigned long size) "Device %s, region %d \"%s\", flags: %lx, offset: %lx, size: %lx"
-vfio_region_mmap_fault(const char *name, int index, unsigned long offset, unsigned long size, int fault) "Region %s mmaps[%d], [%lx - %lx], fault: %d"
-vfio_region_mmap(const char *name, unsigned long offset, unsigned long end) "Region %s [%lx - %lx]"
+vfio_region_setup(const char *dev, int index, const char *name, unsigned long flags, unsigned long offset, unsigned long size) "Device %s, region %d \"%s\", flags: %#lx, offset: %#lx, size: %#lx"
+vfio_region_mmap_fault(const char *name, int index, unsigned long offset, unsigned long size, int fault) "Region %s mmaps[%d], [%#lx - %#lx], fault: %d"
+vfio_region_mmap(const char *name, unsigned long offset, unsigned long end) "Region %s [%#lx - %#lx]"
 vfio_region_exit(const char *name, int index) "Device %s, region %d"
 vfio_region_finalize(const char *name, int index) "Device %s, region %d"
 vfio_region_mmaps_set_enabled(const char *name, bool enabled) "Region %s mmaps enabled: %d"
 vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Device %s region %d: %d sparse mmap entries"
-vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
-vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%0x8"
+vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [%#lx - %#lx]"
+vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %#08x/%#0x8"
 
 # hw/vfio/platform.c
 vfio_platform_base_device_init(char *name, int groupid) "%s belongs to group #%d"
@@ -111,15 +111,15 @@ vfio_platform_eoi(int pin, int fd) "EOI IRQ pin %d (fd=%d)"
 vfio_platform_intp_mmap_enable(int pin) "IRQ #%d still active, stay in slow path"
 vfio_platform_intp_interrupt(int pin, int fd) "Inject IRQ #%d (fd = %d)"
 vfio_platform_intp_inject_pending_lockheld(int pin, int fd) "Inject pending IRQ #%d (fd = %d)"
-vfio_platform_populate_interrupts(int pin, int count, int flags) "- IRQ index %d: count %d, flags=0x%x"
+vfio_platform_populate_interrupts(int pin, int count, int flags) "- IRQ index %d: count %d, flags=%#x"
 vfio_intp_interrupt_set_pending(int index) "irq %d is set PENDING"
 vfio_platform_start_level_irqfd_injection(int index, int fd, int resamplefd) "IRQ index=%d, fd = %d, resamplefd = %d"
 vfio_platform_start_edge_irqfd_injection(int index, int fd) "IRQ index=%d, fd = %d"
 
 # hw/vfio/spapr.c
-vfio_prereg_listener_region_add_skip(uint64_t start, uint64_t end) "%"PRIx64" - %"PRIx64
-vfio_prereg_listener_region_del_skip(uint64_t start, uint64_t end) "%"PRIx64" - %"PRIx64
-vfio_prereg_register(uint64_t va, uint64_t size, int ret) "va=%"PRIx64" size=%"PRIx64" ret=%d"
-vfio_prereg_unregister(uint64_t va, uint64_t size, int ret) "va=%"PRIx64" size=%"PRIx64" ret=%d"
-vfio_spapr_create_window(int ps, uint64_t ws, uint64_t off) "pageshift=0x%x winsize=0x%"PRIx64" offset=0x%"PRIx64
-vfio_spapr_remove_window(uint64_t off) "offset=%"PRIx64
+vfio_prereg_listener_region_add_skip(uint64_t start, uint64_t end) "%#"PRIx64" - %#"PRIx64
+vfio_prereg_listener_region_del_skip(uint64_t start, uint64_t end) "%#"PRIx64" - %#"PRIx64
+vfio_prereg_register(uint64_t va, uint64_t size, int ret) "va=%#"PRIx64" size=%#"PRIx64" ret=%d"
+vfio_prereg_unregister(uint64_t va, uint64_t size, int ret) "va=%#"PRIx64" size=%#"PRIx64" ret=%d"
+vfio_spapr_create_window(int ps, uint64_t ws, uint64_t off) "pageshift=%#x winsize=%#"PRIx64" offset=%#"PRIx64
+vfio_spapr_remove_window(uint64_t off) "offset=%#"PRIx64
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index e24d8fa997..85fdb8d51b 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -20,8 +20,8 @@ virtio_rng_vm_state_change(void *rng, int running, int state) "rng %p: state cha
 
 # hw/virtio/virtio-balloon.c
 #
-virtio_balloon_bad_addr(uint64_t gpa) "%"PRIx64
-virtio_balloon_handle_output(const char *name, uint64_t gpa) "section name: %s gpa: %"PRIx64
+virtio_balloon_bad_addr(uint64_t gpa) "%#"PRIx64
+virtio_balloon_handle_output(const char *name, uint64_t gpa) "section name: %s gpa: %#"PRIx64
 virtio_balloon_get_config(uint32_t num_pages, uint32_t actual) "num_pages: %d actual: %d"
 virtio_balloon_set_config(uint32_t actual, uint32_t oldactual) "actual: %d oldactual: %d"
-virtio_balloon_to_target(uint64_t target, uint32_t num_pages) "balloon target: %"PRIx64" num_pages: %d"
+virtio_balloon_to_target(uint64_t target, uint32_t num_pages) "balloon target: %#"PRIx64" num_pages: %d"
diff --git a/hw/xen/trace-events b/hw/xen/trace-events
index 5615dce2c1..5e706231a9 100644
--- a/hw/xen/trace-events
+++ b/hw/xen/trace-events
@@ -9,6 +9,6 @@ xen_map_mmio_range(uint32_t id, uint64_t start_addr, uint64_t end_addr) "id: %u
 xen_unmap_mmio_range(uint32_t id, uint64_t start_addr, uint64_t end_addr) "id: %u start: %#"PRIx64" end: %#"PRIx64
 xen_map_portio_range(uint32_t id, uint64_t start_addr, uint64_t end_addr) "id: %u start: %#"PRIx64" end: %#"PRIx64
 xen_unmap_portio_range(uint32_t id, uint64_t start_addr, uint64_t end_addr) "id: %u start: %#"PRIx64" end: %#"PRIx64
-xen_map_pcidev(uint32_t id, uint8_t bus, uint8_t dev, uint8_t func) "id: %u bdf: %02x.%02x.%02x"
-xen_unmap_pcidev(uint32_t id, uint8_t bus, uint8_t dev, uint8_t func) "id: %u bdf: %02x.%02x.%02x"
+xen_map_pcidev(uint32_t id, uint8_t bus, uint8_t dev, uint8_t func) "id: %u bdf: %#02x.%#02x.%#02x"
+xen_unmap_pcidev(uint32_t id, uint8_t bus, uint8_t dev, uint8_t func) "id: %u bdf: %#02x.%#02x.%#02x"
 xen_domid_restrict(int err) "err: %u"
diff --git a/linux-user/trace-events b/linux-user/trace-events
index fc71f91ccb..161fc6ebc5 100644
--- a/linux-user/trace-events
+++ b/linux-user/trace-events
@@ -1,12 +1,12 @@
 # See docs/tracing.txt for syntax documentation.
 
 # linux-user/signal.c
-user_setup_frame(void *env, uint64_t frame_addr) "env=%p frame_addr=%"PRIx64
-user_setup_rt_frame(void *env, uint64_t frame_addr) "env=%p frame_addr=%"PRIx64
-user_do_rt_sigreturn(void *env, uint64_t frame_addr) "env=%p frame_addr=%"PRIx64
-user_do_sigreturn(void *env, uint64_t frame_addr) "env=%p frame_addr=%"PRIx64
+user_setup_frame(void *env, uint64_t frame_addr) "env=%p frame_addr=%#"PRIx64
+user_setup_rt_frame(void *env, uint64_t frame_addr) "env=%p frame_addr=%#"PRIx64
+user_do_rt_sigreturn(void *env, uint64_t frame_addr) "env=%p frame_addr=%#"PRIx64
+user_do_sigreturn(void *env, uint64_t frame_addr) "env=%p frame_addr=%#"PRIx64
 user_force_sig(void *env, int target_sig, int host_sig) "env=%p signal %d (host %d)"
 user_handle_signal(void *env, int target_sig) "env=%p signal %d"
 user_host_signal(void *env, int host_sig, int target_sig) "env=%p signal %d (target %d("
 user_queue_signal(void *env, int target_sig) "env=%p signal %d"
-user_s390x_restore_sigregs(void *env, uint64_t sc_psw_addr, uint64_t env_psw_addr) "env=%p frame psw.addr %"PRIx64 " current psw.addr %"PRIx64
+user_s390x_restore_sigregs(void *env, uint64_t sc_psw_addr, uint64_t env_psw_addr) "env=%p frame psw.addr %#"PRIx64 " current psw.addr %#"PRIx64
diff --git a/migration/trace-events b/migration/trace-events
index cb2c4b5b40..823f1df598 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -20,18 +20,18 @@ loadvm_postcopy_handle_run_vmstart(void) ""
 loadvm_postcopy_ram_handle_discard(void) ""
 loadvm_postcopy_ram_handle_discard_end(void) ""
 loadvm_postcopy_ram_handle_discard_header(const char *ramid, uint16_t len) "%s: %ud"
-loadvm_process_command(uint16_t com, uint16_t len) "com=0x%x len=%d"
-loadvm_process_command_ping(uint32_t val) "%x"
+loadvm_process_command(uint16_t com, uint16_t len) "com=%#x len=%d"
+loadvm_process_command_ping(uint32_t val) "%#x"
 postcopy_ram_listen_thread_exit(void) ""
 postcopy_ram_listen_thread_start(void) ""
 qemu_savevm_send_postcopy_advise(void) ""
 qemu_savevm_send_postcopy_ram_discard(const char *id, uint16_t len) "%s: %ud"
-savevm_command_send(uint16_t command, uint16_t len) "com=0x%x len=%d"
+savevm_command_send(uint16_t command, uint16_t len) "com=%#x len=%d"
 savevm_section_start(const char *id, unsigned int section_id) "%s, section_id %u"
 savevm_section_end(const char *id, unsigned int section_id, int ret) "%s, section_id %u -> %d"
 savevm_section_skip(const char *id, unsigned int section_id) "%s, section_id %u"
 savevm_send_open_return_path(void) ""
-savevm_send_ping(uint32_t val) "%x"
+savevm_send_ping(uint32_t val) "%#x"
 savevm_send_postcopy_listen(void) ""
 savevm_send_postcopy_run(void) ""
 savevm_state_setup(void) ""
@@ -65,17 +65,17 @@ put_qtailq_end(const char *name, const char *reason) "%s %s"
 qemu_file_fclose(void) ""
 
 # migration/ram.c
-get_queued_page(const char *block_name, uint64_t tmp_offset, unsigned long page_abs) "%s/%" PRIx64 " page_abs=%lx"
-get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset, unsigned long page_abs, int sent) "%s/%" PRIx64 " page_abs=%lx (sent=%d)"
+get_queued_page(const char *block_name, uint64_t tmp_offset, unsigned long page_abs) "%s/%#" PRIx64 " page_abs=%#lx"
+get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset, unsigned long page_abs, int sent) "%s/%#" PRIx64 " page_abs=%#lx (sent=%d)"
 migration_bitmap_sync_start(void) ""
 migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
 migration_throttle(void) ""
-ram_discard_range(const char *rbname, uint64_t start, size_t len) "%s: start: %" PRIx64 " %zx"
-ram_load_loop(const char *rbname, uint64_t addr, int flags, void *host) "%s: addr: %" PRIx64 " flags: %x host: %p"
-ram_load_postcopy_loop(uint64_t addr, int flags) "@%" PRIx64 " %x"
+ram_discard_range(const char *rbname, uint64_t start, size_t len) "%s: start: %#" PRIx64 " %#zx"
+ram_load_loop(const char *rbname, uint64_t addr, int flags, void *host) "%s: addr: %#" PRIx64 " flags: %#x host: %p"
+ram_load_postcopy_loop(uint64_t addr, int flags) "@%#" PRIx64 " %#x"
 ram_postcopy_send_discard_bitmap(void) ""
-ram_save_page(const char *rbname, uint64_t offset, void *host) "%s: offset: %" PRIx64 " host: %p"
-ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: %zx len: %zx"
+ram_save_page(const char *rbname, uint64_t offset, void *host) "%s: offset: %#" PRIx64 " host: %p"
+ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: %#zx len: %#zx"
 
 # migration/migration.c
 await_return_path_close_on_source_close(void) ""
@@ -84,7 +84,7 @@ migrate_set_state(int new_state) "new state %d"
 migrate_fd_cleanup(void) ""
 migrate_fd_error(const char *error_desc) "error=%s"
 migrate_fd_cancel(void) ""
-migrate_handle_rp_req_pages(const char *rbname, size_t start, size_t len) "in %s at %zx len %zx"
+migrate_handle_rp_req_pages(const char *rbname, size_t start, size_t len) "in %s at %#zx len %#zx"
 migrate_pending(uint64_t size, uint64_t max, uint64_t post, uint64_t nonpost) "pending size %" PRIu64 " max %" PRIu64 " (post=%" PRIu64 " nonpost=%" PRIu64 ")"
 migrate_send_rp_message(int msg_type, uint16_t len) "%d: len %d"
 migration_completion_file_err(void) ""
@@ -103,8 +103,8 @@ source_return_path_thread_bad_end(void) ""
 source_return_path_thread_end(void) ""
 source_return_path_thread_entry(void) ""
 source_return_path_thread_loop_top(void) ""
-source_return_path_thread_pong(uint32_t val) "%x"
-source_return_path_thread_shut(uint32_t val) "%x"
+source_return_path_thread_pong(uint32_t val) "%#x"
+source_return_path_thread_shut(uint32_t val) "%#x"
 migrate_global_state_post_load(const char *state) "loaded state: %s"
 migrate_global_state_pre_save(const char *state) "saved state: %s"
 migration_thread_low_pending(uint64_t pending) "%" PRIu64
@@ -143,10 +143,10 @@ qemu_rdma_register_and_get_keys(uint64_t len, void *start) "Registering %" PRIu6
 qemu_rdma_registration_handle_compress(int64_t length, int index, int64_t offset) "Zapping zero chunk: %" PRId64 " bytes, index %d, offset %" PRId64
 qemu_rdma_registration_handle_finished(void) ""
 qemu_rdma_registration_handle_ram_blocks(void) ""
-qemu_rdma_registration_handle_ram_blocks_loop(const char *name, uint64_t offset, uint64_t length, void *local_host_addr, unsigned int src_index) "%s: @%" PRIx64 "/%" PRIu64 " host:@%p src_index: %u"
+qemu_rdma_registration_handle_ram_blocks_loop(const char *name, uint64_t offset, uint64_t length, void *local_host_addr, unsigned int src_index) "%s: @%#" PRIx64 "/%" PRIu64 " host:@%p src_index: %u"
 qemu_rdma_registration_handle_register(int requests) "%d requests"
 qemu_rdma_registration_handle_register_loop(int req, int index, uint64_t addr, uint64_t chunks) "Registration request (%d): index %d, current_addr %" PRIu64 " chunks: %" PRIu64
-qemu_rdma_registration_handle_register_rkey(int rkey) "%x"
+qemu_rdma_registration_handle_register_rkey(int rkey) "%#x"
 qemu_rdma_registration_handle_unregister(int requests) "%d requests"
 qemu_rdma_registration_handle_unregister_loop(int count, int index, uint64_t chunk) "Unregistration request (%d): index %d, chunk %" PRIu64
 qemu_rdma_registration_handle_unregister_success(uint64_t chunk) "%" PRIu64
@@ -163,9 +163,9 @@ qemu_rdma_unregister_waiting_send(uint64_t chunk) "Sending unregister for chunk:
 qemu_rdma_unregister_waiting_complete(uint64_t chunk) "Unregister for chunk: %" PRIu64 " complete."
 qemu_rdma_write_flush(int sent) "sent total: %d"
 qemu_rdma_write_one_block(int count, int block, uint64_t chunk, uint64_t current, uint64_t len, int nb_sent, int nb_chunks) "(%d) Not clobbering: block: %d chunk %" PRIu64 " current %" PRIu64 " len %" PRIu64 " %d %d"
-qemu_rdma_write_one_post(uint64_t chunk, long addr, long remote, uint32_t len) "Posting chunk: %" PRIu64 ", addr: %lx remote: %lx, bytes %" PRIu32
+qemu_rdma_write_one_post(uint64_t chunk, long addr, long remote, uint32_t len) "Posting chunk: %" PRIu64 ", addr: %#lx remote: %#lx, bytes %" PRIu32
 qemu_rdma_write_one_queue_full(void) ""
-qemu_rdma_write_one_recvregres(int mykey, int theirkey, uint64_t chunk) "Received registration result: my key: %x their key %x, chunk %" PRIu64
+qemu_rdma_write_one_recvregres(int mykey, int theirkey, uint64_t chunk) "Received registration result: my key: %#x their key %#x, chunk %" PRIu64
 qemu_rdma_write_one_sendreg(uint64_t chunk, int len, int index, int64_t offset) "Sending registration request chunk %" PRIu64 " for %d bytes, index: %d, offset: %" PRId64
 qemu_rdma_write_one_top(uint64_t chunks, uint64_t size) "Writing %" PRIu64 " chunks, (%" PRIu64 " MB)"
 qemu_rdma_write_one_zero(uint64_t chunk, int len, int index, int64_t offset) "Entire chunk is zero, sending compress: %" PRIu64 " for %d bytes, index: %d, offset: %" PRId64
@@ -180,17 +180,17 @@ rdma_start_outgoing_migration_after_rdma_source_init(void) ""
 
 # migration/postcopy-ram.c
 postcopy_discard_send_finish(const char *ramblock, int nwords, int ncmds) "%s mask words sent=%d in %d commands"
-postcopy_discard_send_range(const char *ramblock, unsigned long start, unsigned long length) "%s:%lx/%lx"
-postcopy_cleanup_range(const char *ramblock, void *host_addr, size_t offset, size_t length) "%s: %p offset=%zx length=%zx"
-postcopy_init_range(const char *ramblock, void *host_addr, size_t offset, size_t length) "%s: %p offset=%zx length=%zx"
-postcopy_nhp_range(const char *ramblock, void *host_addr, size_t offset, size_t length) "%s: %p offset=%zx length=%zx"
+postcopy_discard_send_range(const char *ramblock, unsigned long start, unsigned long length) "%s:%#lx/%#lx"
+postcopy_cleanup_range(const char *ramblock, void *host_addr, size_t offset, size_t length) "%s: %p offset=%#zx length=%#zx"
+postcopy_init_range(const char *ramblock, void *host_addr, size_t offset, size_t length) "%s: %p offset=%#zx length=%#zx"
+postcopy_nhp_range(const char *ramblock, void *host_addr, size_t offset, size_t length) "%s: %p offset=%#zx length=%#zx"
 postcopy_place_page(void *host_addr) "host=%p"
 postcopy_place_page_zero(void *host_addr) "host=%p"
 postcopy_ram_enable_notify(void) ""
 postcopy_ram_fault_thread_entry(void) ""
 postcopy_ram_fault_thread_exit(void) ""
 postcopy_ram_fault_thread_quit(void) ""
-postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ramblock, size_t offset) "Request for HVA=%" PRIx64 " rb=%s offset=%zx"
+postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ramblock, size_t offset) "Request for HVA=%#" PRIx64 " rb=%s offset=%#zx"
 postcopy_ram_incoming_cleanup_closeuf(void) ""
 postcopy_ram_incoming_cleanup_entry(void) ""
 postcopy_ram_incoming_cleanup_exit(void) ""
diff --git a/nbd/trace-events b/nbd/trace-events
index d7c7746ea8..7b3d93b15a 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -1,12 +1,12 @@
 # nbd/client.c
 nbd_unknown_error(int err) "Squashing unexpected error %d to EINVAL"
 nbd_send_option_request(uint32_t opt, const char *name, uint32_t len) "Sending option request %" PRIu32" (%s), len %" PRIu32
-nbd_receive_option_reply(uint32_t option, const char *optname, uint32_t type, const char *typename, uint32_t length) "Received option reply %" PRIx32" (%s), type %" PRIx32" (%s), len %" PRIu32
-nbd_reply_err_unsup(uint32_t option, const char *name) "server doesn't understand request %" PRIx32 " (%s), attempting fallback"
+nbd_receive_option_reply(uint32_t option, const char *optname, uint32_t type, const char *typename, uint32_t length) "Received option reply %#" PRIx32" (%s), type %#" PRIx32" (%s), len %" PRIu32
+nbd_reply_err_unsup(uint32_t option, const char *name) "server doesn't understand request %#" PRIx32 " (%s), attempting fallback"
 nbd_opt_go_start(const char *name) "Attempting NBD_OPT_GO for export '%s'"
 nbd_opt_go_success(void) "Export is good to go"
 nbd_opt_go_info_unknown(int info, const char *name) "Ignoring unknown info %d (%s)"
-nbd_opt_go_info_block_size(uint32_t minimum, uint32_t preferred, uint32_t maximum) "Block sizes are 0x%" PRIx32 ", 0x%" PRIx32 ", 0x%" PRIx32
+nbd_opt_go_info_block_size(uint32_t minimum, uint32_t preferred, uint32_t maximum) "Block sizes are %#" PRIx32 ", %#" PRIx32 ", %#" PRIx32
 nbd_receive_query_exports_start(const char *wantname) "Querying export list for '%s'"
 nbd_receive_query_exports_success(const char *wantname) "Found desired export name '%s'"
 nbd_receive_starttls_request(void) "Requesting TLS from server"
@@ -14,10 +14,10 @@ nbd_receive_starttls_reply(void) "Getting TLS reply from server"
 nbd_receive_starttls_new_client(void) "TLS request approved, setting up TLS"
 nbd_receive_starttls_tls_handshake(void) "Starting TLS handshake"
 nbd_receive_negotiate(void *tlscreds, const char *hostname) "Receiving negotiation tlscreds=%p hostname=%s"
-nbd_receive_negotiate_magic(uint64_t magic) "Magic is 0x%" PRIx64
-nbd_receive_negotiate_server_flags(uint32_t globalflags) "Global flags are %" PRIx32
+nbd_receive_negotiate_magic(uint64_t magic) "Magic is %#" PRIx64
+nbd_receive_negotiate_server_flags(uint32_t globalflags) "Global flags are %#" PRIx32
 nbd_receive_negotiate_default_name(void) "Using default NBD export name \"\""
-nbd_receive_negotiate_size_flags(uint64_t size, uint16_t flags) "Size is %" PRIu64 ", export flags %" PRIx16
+nbd_receive_negotiate_size_flags(uint64_t size, uint16_t flags) "Size is %" PRIu64 ", export flags %#" PRIx16
 nbd_init_set_socket(void) "Setting NBD socket"
 nbd_init_set_block_size(unsigned long block_size) "Setting block size to %lu"
 nbd_init_set_size(unsigned long sectors) "Setting size to %lu block(s)"
@@ -28,11 +28,11 @@ nbd_client_loop(void) "Doing NBD loop"
 nbd_client_loop_ret(int ret, const char *error) "NBD loop returned %d: %s"
 nbd_client_clear_queue(void) "Clearing NBD queue"
 nbd_client_clear_socket(void) "Clearing NBD socket"
-nbd_send_request(uint64_t from, uint32_t len, uint64_t handle, uint16_t flags, uint16_t type, const char *name) "Sending request to server: { .from = %" PRIu64", .len = %" PRIu32 ", .handle = %" PRIu64 ", .flags = %" PRIx16 ", .type = %" PRIu16 " (%s) }"
-nbd_receive_reply(uint32_t magic, int32_t error, uint64_t handle) "Got reply: { magic = 0x%" PRIx32 ", .error = % " PRId32 ", handle = %" PRIu64" }"
+nbd_send_request(uint64_t from, uint32_t len, uint64_t handle, uint16_t flags, uint16_t type, const char *name) "Sending request to server: { .from = %" PRIu64", .len = %" PRIu32 ", .handle = %" PRIu64 ", .flags = %#" PRIx16 ", .type = %" PRIu16 " (%s) }"
+nbd_receive_reply(uint32_t magic, int32_t error, uint64_t handle) "Got reply: { magic = %#" PRIx32 ", .error = % " PRId32 ", handle = %" PRIu64" }"
 
 # nbd/server.c
-nbd_negotiate_send_rep_len(uint32_t opt, const char *optname, uint32_t type, const char *typename, uint32_t len) "Reply opt=%" PRIx32 " (%s), type=%" PRIx32 " (%s), len=%" PRIu32
+nbd_negotiate_send_rep_len(uint32_t opt, const char *optname, uint32_t type, const char *typename, uint32_t len) "Reply opt=%#" PRIx32 " (%s), type=%#" PRIx32 " (%s), len=%" PRIu32
 nbd_negotiate_send_rep_err(const char *msg) "sending error message \"%s\""
 nbd_negotiate_send_rep_list(const char *name, const char *desc) "Advertising export name '%s' description '%s'"
 nbd_negotiate_handle_export_name(void) "Checking length"
@@ -40,17 +40,17 @@ nbd_negotiate_handle_export_name_request(const char *name) "Client requested exp
 nbd_negotiate_send_info(int info, const char *name, uint32_t length) "Sending NBD_REP_INFO type %d (%s) with remaining length %" PRIu32
 nbd_negotiate_handle_info_requests(int requests) "Client requested %d items of info"
 nbd_negotiate_handle_info_request(int request, const char *name) "Client requested info %d (%s)"
-nbd_negotiate_handle_info_block_size(uint32_t minimum, uint32_t preferred, uint32_t maximum) "advertising minimum 0x%" PRIx32 ", preferred 0x%" PRIx32 ", maximum 0x%" PRIx32
+nbd_negotiate_handle_info_block_size(uint32_t minimum, uint32_t preferred, uint32_t maximum) "advertising minimum %#" PRIx32 ", preferred %#" PRIx32 ", maximum %#" PRIx32
 nbd_negotiate_handle_starttls(void) "Setting up TLS"
 nbd_negotiate_handle_starttls_handshake(void) "Starting TLS handshake"
-nbd_negotiate_options_flags(uint32_t flags) "Received client flags 0x%" PRIx32
-nbd_negotiate_options_check_magic(uint64_t magic) "Checking opts magic 0x%" PRIx64
-nbd_negotiate_options_check_option(uint32_t option, const char *name) "Checking option 0x%" PRIx32 " (%s)"
+nbd_negotiate_options_flags(uint32_t flags) "Received client flags %#" PRIx32
+nbd_negotiate_options_check_magic(uint64_t magic) "Checking opts magic %#" PRIx64
+nbd_negotiate_options_check_option(uint32_t option, const char *name) "Checking option %#" PRIx32 " (%s)"
 nbd_negotiate_begin(void) "Beginning negotiation"
-nbd_negotiate_old_style(uint64_t size, unsigned flags) "advertising size %" PRIu64 " and flags %x"
-nbd_negotiate_new_style_size_flags(uint64_t size, unsigned flags) "advertising size %" PRIu64 " and flags %x"
+nbd_negotiate_old_style(uint64_t size, unsigned flags) "advertising size %" PRIu64 " and flags %#x"
+nbd_negotiate_new_style_size_flags(uint64_t size, unsigned flags) "advertising size %" PRIu64 " and flags %#x"
 nbd_negotiate_success(void) "Negotiation succeeded"
-nbd_receive_request(uint32_t magic, uint16_t flags, uint16_t type, uint64_t from, uint32_t len) "Got request: { magic = 0x%" PRIx32 ", .flags = %" PRIx16 ", .type = %" PRIx16 ", from = %" PRIu64 ", len = %" PRIu32 " }"
+nbd_receive_request(uint32_t magic, uint16_t flags, uint16_t type, uint64_t from, uint32_t len) "Got request: { magic = %#" PRIx32 ", .flags = %#" PRIx16 ", .type = %#" PRIx16 ", from = %" PRIu64 ", len = %" PRIu32 " }"
 nbd_send_reply(int32_t error, uint64_t handle) "Sending response to client: { .error = %" PRId32 ", handle = %" PRIu64 " }"
 nbd_blk_aio_attached(const char *name, void *ctx) "Export %s: Attaching clients to AIO context %p\n"
 nbd_blk_aio_detach(const char *name, void *ctx) "Export %s: Detaching clients from AIO context %p\n"
diff --git a/net/trace-events b/net/trace-events
index 247e5c04db..f389bdd748 100644
--- a/net/trace-events
+++ b/net/trace-events
@@ -13,9 +13,9 @@ colo_compare_icmp_miscompare(const char *sta, int size) ": %s = %d"
 colo_compare_ip_info(int psize, const char *sta, const char *stb, int ssize, const char *stc, const char *std) "ppkt size = %d, ip_src = %s, ip_dst = %s, spkt size = %d, ip_src = %s, ip_dst = %s"
 colo_old_packet_check_found(int64_t old_time) "%" PRId64
 colo_compare_miscompare(void) ""
-colo_compare_tcp_info(const char *pkt, uint32_t seq, uint32_t ack, int res, uint32_t flag, int size) "side: %s seq/ack= %u/%u res= %d flags= %x pkt_size: %d\n"
+colo_compare_tcp_info(const char *pkt, uint32_t seq, uint32_t ack, int res, uint32_t flag, int size) "side: %s seq/ack= %u/%u res= %d flags= %#x pkt_size: %d\n"
 
 # net/filter-rewriter.c
 colo_filter_rewriter_debug(void) ""
-colo_filter_rewriter_pkt_info(const char *func, const char *src, const char *dst, uint32_t seq, uint32_t ack, uint32_t flag) "%s: src/dst: %s/%s p: seq/ack=%u/%u  flags=%x\n"
+colo_filter_rewriter_pkt_info(const char *func, const char *src, const char *dst, uint32_t seq, uint32_t ack, uint32_t flag) "%s: src/dst: %s/%s p: seq/ack=%u/%u  flags=%#x\n"
 colo_filter_rewriter_conn_offset(uint32_t offset) ": offset=%u\n"
diff --git a/target/arm/trace-events b/target/arm/trace-events
index e21c84fc6f..8e73415e41 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -1,10 +1,10 @@
 # See docs/tracing.txt for syntax documentation.
 
 # target/arm/helper.c
-arm_gt_recalc(int timer, int irqstate, uint64_t nexttick) "gt recalc: timer %d irqstate %d next tick %" PRIx64
+arm_gt_recalc(int timer, int irqstate, uint64_t nexttick) "gt recalc: timer %d irqstate %d next tick %#" PRIx64
 arm_gt_recalc_disabled(int timer) "gt recalc: timer %d irqstate 0 timer disabled"
-arm_gt_cval_write(int timer, uint64_t value) "gt_cval_write: timer %d value %" PRIx64
-arm_gt_tval_write(int timer, uint64_t value) "gt_tval_write: timer %d value %" PRIx64
-arm_gt_ctl_write(int timer, uint64_t value) "gt_ctl_write: timer %d value %" PRIx64
+arm_gt_cval_write(int timer, uint64_t value) "gt_cval_write: timer %d value %#" PRIx64
+arm_gt_tval_write(int timer, uint64_t value) "gt_tval_write: timer %d value %#" PRIx64
+arm_gt_ctl_write(int timer, uint64_t value) "gt_ctl_write: timer %d value %#" PRIx64
 arm_gt_imask_toggle(int timer, int irqstate) "gt_ctl_write: timer %d IMASK toggle, new irqstate %d"
-arm_gt_cntvoff_write(uint64_t value) "gt_cntvoff_write: value %" PRIx64
+arm_gt_cntvoff_write(uint64_t value) "gt_cntvoff_write: value %#" PRIx64
diff --git a/target/s390x/trace-events b/target/s390x/trace-events
index 1574033e31..95a19ecf75 100644
--- a/target/s390x/trace-events
+++ b/target/s390x/trace-events
@@ -6,9 +6,9 @@ set_skeys_nonzero(int rc) "SKEY: Call to set_skeys unexpectedly returned %d"
 
 # target/s390x/ioinst.c
 ioinst(const char *insn) "IOINST: %s"
-ioinst_sch_id(const char *insn, int cssid, int ssid, int schid) "IOINST: %s (%x.%x.%04x)"
-ioinst_chp_id(const char *insn, int cssid, int chpid) "IOINST: %s (%x.%02x)"
-ioinst_chsc_cmd(uint16_t cmd, uint16_t len) "IOINST: chsc command %04x, len %04x"
+ioinst_sch_id(const char *insn, int cssid, int ssid, int schid) "IOINST: %s (%#x.%#x.%#04x)"
+ioinst_chp_id(const char *insn, int cssid, int chpid) "IOINST: %s (%#x.%#02x)"
+ioinst_chsc_cmd(uint16_t cmd, uint16_t len) "IOINST: chsc command %#04x, len %#04x"
 
 # target/s390x/kvm.c
 kvm_enable_cmma(int rc) "CMMA: enabling with result code %d"
diff --git a/target/sparc/trace-events b/target/sparc/trace-events
index 8df178a347..d31479ab99 100644
--- a/target/sparc/trace-events
+++ b/target/sparc/trace-events
@@ -1,28 +1,28 @@
 # See docs/tracing.txt for syntax documentation.
 
 # target/sparc/mmu_helper.c
-mmu_helper_dfault(uint64_t address, uint64_t context, int mmu_idx, uint32_t tl) "DFAULT at %"PRIx64" context %"PRIx64" mmu_idx=%d tl=%d"
-mmu_helper_dprot(uint64_t address, uint64_t context, int mmu_idx, uint32_t tl) "DPROT at %"PRIx64" context %"PRIx64" mmu_idx=%d tl=%d"
-mmu_helper_dmiss(uint64_t address, uint64_t context) "DMISS at %"PRIx64" context %"PRIx64
-mmu_helper_tfault(uint64_t address, uint64_t context) "TFAULT at %"PRIx64" context %"PRIx64
-mmu_helper_tmiss(uint64_t address, uint64_t context) "TMISS at %"PRIx64" context %"PRIx64
-mmu_helper_get_phys_addr_code(uint32_t tl, int mmu_idx, uint64_t prim_context, uint64_t sec_context, uint64_t address) "tl=%d mmu_idx=%d primary context=%"PRIx64" secondary context=%"PRIx64" address=%"PRIx64
-mmu_helper_get_phys_addr_data(uint32_t tl, int mmu_idx, uint64_t prim_context, uint64_t sec_context, uint64_t address) "tl=%d mmu_idx=%d primary context=%"PRIx64" secondary context=%"PRIx64" address=%"PRIx64
-mmu_helper_mmu_fault(uint64_t address, uint64_t paddr, int mmu_idx, uint32_t tl, uint64_t prim_context, uint64_t sec_context) "Translate at %"PRIx64" -> %"PRIx64", mmu_idx=%d tl=%d primary context=%"PRIx64" secondary context=%"PRIx64
+mmu_helper_dfault(uint64_t address, uint64_t context, int mmu_idx, uint32_t tl) "DFAULT at %#"PRIx64" context %#"PRIx64" mmu_idx=%d tl=%d"
+mmu_helper_dprot(uint64_t address, uint64_t context, int mmu_idx, uint32_t tl) "DPROT at %#"PRIx64" context %#"PRIx64" mmu_idx=%d tl=%d"
+mmu_helper_dmiss(uint64_t address, uint64_t context) "DMISS at %#"PRIx64" context %#"PRIx64
+mmu_helper_tfault(uint64_t address, uint64_t context) "TFAULT at %#"PRIx64" context %#"PRIx64
+mmu_helper_tmiss(uint64_t address, uint64_t context) "TMISS at %#"PRIx64" context %#"PRIx64
+mmu_helper_get_phys_addr_code(uint32_t tl, int mmu_idx, uint64_t prim_context, uint64_t sec_context, uint64_t address) "tl=%d mmu_idx=%d primary context=%#"PRIx64" secondary context=%#"PRIx64" address=%#"PRIx64
+mmu_helper_get_phys_addr_data(uint32_t tl, int mmu_idx, uint64_t prim_context, uint64_t sec_context, uint64_t address) "tl=%d mmu_idx=%d primary context=%#"PRIx64" secondary context=%#"PRIx64" address=%#"PRIx64
+mmu_helper_mmu_fault(uint64_t address, uint64_t paddr, int mmu_idx, uint32_t tl, uint64_t prim_context, uint64_t sec_context) "Translate at %#"PRIx64" -> %#"PRIx64", mmu_idx=%d tl=%d primary context=%#"PRIx64" secondary context=%#"PRIx64
 
 # target/sparc/int64_helper.c
-int_helper_set_softint(uint32_t softint) "new %08x"
-int_helper_clear_softint(uint32_t softint) "new %08x"
-int_helper_write_softint(uint32_t softint) "new %08x"
+int_helper_set_softint(uint32_t softint) "new %#08x"
+int_helper_clear_softint(uint32_t softint) "new %#08x"
+int_helper_write_softint(uint32_t softint) "new %#08x"
 
 # target/sparc/int32_helper.c
 int_helper_icache_freeze(void) "Instruction cache: freeze"
 int_helper_dcache_freeze(void) "Data cache: freeze"
 
 # target/sparc/win_helper.c
-win_helper_gregset_error(uint32_t pstate) "ERROR in get_gregset: active pstate bits=%x"
-win_helper_switch_pstate(uint32_t pstate_regs, uint32_t new_pstate_regs) "change_pstate: switching regs old=%x new=%x"
-win_helper_no_switch_pstate(uint32_t new_pstate_regs) "change_pstate: regs new=%x (unchanged)"
-win_helper_wrpil(uint32_t psrpil, uint32_t new_pil) "old=%x new=%x"
+win_helper_gregset_error(uint32_t pstate) "ERROR in get_gregset: active pstate bits=%#x"
+win_helper_switch_pstate(uint32_t pstate_regs, uint32_t new_pstate_regs) "change_pstate: switching regs old=%#x new=%#x"
+win_helper_no_switch_pstate(uint32_t new_pstate_regs) "change_pstate: regs new=%#x (unchanged)"
+win_helper_wrpil(uint32_t psrpil, uint32_t new_pil) "old=%#x new=%#x"
 win_helper_done(uint32_t tl) "tl=%d"
 win_helper_retry(uint32_t tl) "tl=%d"
diff --git a/trace-events b/trace-events
index f9dbd7f509..389ecf4c49 100644
--- a/trace-events
+++ b/trace-events
@@ -106,7 +106,7 @@ vcpu guest_cpu_reset(void)
 #
 # Mode: user, softmmu
 # Targets: TCG(all)
-vcpu tcg guest_mem_before(TCGv vaddr, uint8_t info) "info=%d", "vaddr=0x%016"PRIx64" info=%d"
+vcpu tcg guest_mem_before(TCGv vaddr, uint8_t info) "info=%d", "vaddr=%#016"PRIx64" info=%d"
 
 # @num: System call number.
 # @arg*: System call argument value.
@@ -115,7 +115,7 @@ vcpu tcg guest_mem_before(TCGv vaddr, uint8_t info) "info=%d", "vaddr=0x%016"PRI
 #
 # Mode: user
 # Targets: TCG(all)
-vcpu guest_user_syscall(uint64_t num, uint64_t arg1, uint64_t arg2, uint64_t arg3, uint64_t arg4, uint64_t arg5, uint64_t arg6, uint64_t arg7, uint64_t arg8) "num=0x%016"PRIx64" arg1=0x%016"PRIx64" arg2=0x%016"PRIx64" arg3=0x%016"PRIx64" arg4=0x%016"PRIx64" arg5=0x%016"PRIx64" arg6=0x%016"PRIx64" arg7=0x%016"PRIx64" arg8=0x%016"PRIx64
+vcpu guest_user_syscall(uint64_t num, uint64_t arg1, uint64_t arg2, uint64_t arg3, uint64_t arg4, uint64_t arg5, uint64_t arg6, uint64_t arg7, uint64_t arg8) "num=%#016"PRIx64" arg1=%#016"PRIx64" arg2=%#016"PRIx64" arg3=%#016"PRIx64" arg4=%#016"PRIx64" arg5=%#016"PRIx64" arg6=%#016"PRIx64" arg7=%#016"PRIx64" arg8=%#016"PRIx64
 
 # @num: System call number.
 # @ret: System call result value.
@@ -124,4 +124,4 @@ vcpu guest_user_syscall(uint64_t num, uint64_t arg1, uint64_t arg2, uint64_t arg
 #
 # Mode: user
 # Targets: TCG(all)
-vcpu guest_user_syscall_ret(uint64_t num, uint64_t ret) "num=0x%016"PRIx64" ret=0x%016"PRIx64
+vcpu guest_user_syscall_ret(uint64_t num, uint64_t ret) "num=%#016"PRIx64" ret=%#016"PRIx64
diff --git a/ui/trace-events b/ui/trace-events
index 19ce5f85f6..0518599544 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -8,7 +8,7 @@ console_txt_new(int w, int h) "%dx%d"
 console_select(int nr) "%d"
 console_refresh(int interval) "interval %d ms"
 displaysurface_create(void *display_surface, int w, int h) "surface=%p, %dx%d"
-displaysurface_create_from(void *display_surface, int w, int h, uint32_t format) "surface=%p, %dx%d, format 0x%x"
+displaysurface_create_from(void *display_surface, int w, int h, uint32_t format) "surface=%p, %dx%d, format %#x"
 displaysurface_create_pixman(void *display_surface) "surface=%p"
 displaysurface_free(void *display_surface) "surface=%p"
 displaychangelistener_register(void *dcl, const char *name) "%p [ %s ]"
@@ -25,22 +25,22 @@ gd_ungrab(const char *tab, const char *device) "tab=%s, dev=%s"
 # ui/vnc.c
 vnc_key_guest_leds(bool caps, bool num, bool scroll) "caps %d, num %d, scroll %d"
 vnc_key_map_init(const char *layout) "%s"
-vnc_key_event_ext(bool down, int sym, int keycode, const char *name) "down %d, sym 0x%x, keycode 0x%x [%s]"
-vnc_key_event_map(bool down, int sym, int keycode, const char *name) "down %d, sym 0x%x -> keycode 0x%x [%s]"
+vnc_key_event_ext(bool down, int sym, int keycode, const char *name) "down %d, sym %#x, keycode %#x [%s]"
+vnc_key_event_map(bool down, int sym, int keycode, const char *name) "down %d, sym %#x -> keycode %#x [%s]"
 vnc_key_sync_numlock(bool on) "%d"
 vnc_key_sync_capslock(bool on) "%d"
 
 # ui/input.c
-input_event_key_number(int conidx, int number, const char *qcode, bool down) "con %d, key number 0x%x [%s], down %d"
+input_event_key_number(int conidx, int number, const char *qcode, bool down) "con %d, key number %#x [%s], down %d"
 input_event_key_qcode(int conidx, const char *qcode, bool down) "con %d, key qcode %s, down %d"
 input_event_btn(int conidx, const char *btn, bool down) "con %d, button %s, down %d"
 input_event_rel(int conidx, const char *axis, int value) "con %d, axis %s, value %d"
-input_event_abs(int conidx, const char *axis, int value) "con %d, axis %s, value 0x%x"
+input_event_abs(int conidx, const char *axis, int value) "con %d, axis %s, value %#x"
 input_event_sync(void) ""
 input_mouse_mode(int absolute) "absolute %d"
 
 # ui/spice-display.c
-qemu_spice_add_memslot(int qid, uint32_t slot_id, unsigned long virt_start, unsigned long virt_end, int async) "%d %u: host virt 0x%lx - 0x%lx async=%d"
+qemu_spice_add_memslot(int qid, uint32_t slot_id, unsigned long virt_start, unsigned long virt_end, int async) "%d %u: host virt %#lx - %#lx async=%d"
 qemu_spice_del_memslot(int qid, uint32_t gid, uint32_t slot_id) "%d gid=%u sid=%u"
 qemu_spice_create_primary_surface(int qid, uint32_t sid, void *surface, int async) "%d sid=%u surface=%p async=%d"
 qemu_spice_destroy_primary_surface(int qid, uint32_t sid, int async) "%d sid=%u async=%d"
@@ -49,5 +49,5 @@ qemu_spice_create_update(uint32_t left, uint32_t right, uint32_t top, uint32_t b
 
 # ui/keymaps.c
 keymap_parse(const char *file) "file %s"
-keymap_add(const char *type, int sym, int code, const char *line) "%-6s sym=0x%04x code=0x%04x (line: %s)"
-keymap_unmapped(int sym) "sym=0x%04x"
+keymap_add(const char *type, int sym, int code, const char *line) "%-6s sym=%#04x code=%#04x (line: %s)"
+keymap_unmapped(int sym) "sym=%#04x"
diff --git a/util/trace-events b/util/trace-events
index fa540c620b..954b32daec 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -42,7 +42,7 @@ qemu_vfree(void *ptr) "ptr %p"
 qemu_anon_ram_free(void *ptr, size_t size) "ptr %p size %zu"
 
 # util/hbitmap.c
-hbitmap_iter_skip_words(const void *hb, void *hbi, uint64_t pos, unsigned long cur) "hb %p hbi %p pos %"PRId64" cur 0x%lx"
+hbitmap_iter_skip_words(const void *hb, void *hbi, uint64_t pos, unsigned long cur) "hb %p hbi %p pos %"PRId64" cur %#lx"
 hbitmap_reset(void *hb, uint64_t start, uint64_t count, uint64_t sbit, uint64_t ebit) "hb %p items %"PRIu64",%"PRIu64" bits %"PRIu64"..%"PRIu64
 hbitmap_set(void *hb, uint64_t start, uint64_t count, uint64_t sbit, uint64_t ebit) "hb %p items %"PRIu64",%"PRIu64" bits %"PRIu64"..%"PRIu64
 
-- 
2.11.1
