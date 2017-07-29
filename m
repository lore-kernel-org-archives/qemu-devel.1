Received: from eggs.gnu.org ([2001:4830:134:3::10]:34290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dbRXR-0005Hr-Az
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 09:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dbRXO-00068C-53
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 09:12:13 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:40612 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dbRXN-00062c-IQ
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 09:12:10 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Sat, 29 Jul 2017 16:11:57 +0300
Message-Id: <20170729131159.24949-3-vsementsov@virtuozzo.com>
In-Reply-To: <20170729131159.24949-1-vsementsov@virtuozzo.com>
References: <20170729131159.24949-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 2/4] trace-events: fix code style: %# -> 0x%
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, stefanha@gmail.com, peter.maydell@linaro.org, berrange@redhat.com

In trace format '#' flag of printf is forbidden. Fix it to '0x%'.

This patch is created by the following:

check that we have a problem
> find . -name trace-events | xargs grep '%#' | wc -l
56

check that there are no cases with additional printf flags
> find . -name trace-events | xargs grep '%[-+ 0]+#' | wc -l
0

check that there are no wrong usage of '#' and '0x' together
> find . -name trace-events | xargs grep '0x%#' | wc -l
0

fix the problem
> find . -name trace-events | xargs sed -i 's/%#/0x%/g'

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 audio/trace-events       |  4 ++--
 block/trace-events       |  6 +++---
 hw/display/trace-events  |  2 +-
 hw/i386/xen/trace-events | 22 +++++++++++-----------
 hw/input/trace-events    |  2 +-
 hw/intc/trace-events     | 20 ++++++++++----------
 hw/net/trace-events      | 18 +++++++++---------
 hw/pci/trace-events      |  4 ++--
 hw/scsi/trace-events     |  6 +++---
 hw/xen/trace-events      |  8 ++++----
 trace-events             | 20 ++++++++++----------
 11 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/audio/trace-events b/audio/trace-events
index 517359039e..939ab99e76 100644
--- a/audio/trace-events
+++ b/audio/trace-events
@@ -3,7 +3,7 @@
 # audio/alsaaudio.c
 alsa_revents(int revents) "revents = %d"
 alsa_pollout(int i, int fd) "i = %d fd = %d"
-alsa_set_handler(int events, int index, int fd, int err) "events=%#x index=%d fd=%d err=%d"
+alsa_set_handler(int events, int index, int fd, int err) "events=0x%x index=%d fd=%d err=%d"
 alsa_wrote_zero(int len) "Failed to write %d frames (wrote zero)"
 alsa_read_zero(long len) "Failed to read %ld frames (read zero)"
 alsa_xrun_out(void) "Recovering from playback xrun"
@@ -13,5 +13,5 @@ alsa_resume_in(void) "Resuming suspended input stream"
 alsa_no_frames(int state) "No frames available and ALSA state is %d"
 
 # audio/ossaudio.c
-oss_version(int version) "OSS version = %#x"
+oss_version(int version) "OSS version = 0x%x"
 oss_invalid_available_size(int size, int bufsize) "Invalid available size, size=%d bufsize=%d"
diff --git a/block/trace-events b/block/trace-events
index 4a4df25323..622c754495 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -1,7 +1,7 @@
 # See docs/tracing.txt for syntax documentation.
 
 # block.c
-bdrv_open_common(void *bs, const char *filename, int flags, const char *format_name) "bs %p filename \"%s\" flags %#x format_name \"%s\""
+bdrv_open_common(void *bs, const char *filename, int flags, const char *format_name) "bs %p filename \"%s\" flags 0x%x format_name \"%s\""
 bdrv_lock_medium(void *bs, bool locked) "bs %p locked %d"
 
 # block/block-backend.c
@@ -11,7 +11,7 @@ blk_co_pwritev(void *blk, void *bs, int64_t offset, unsigned int bytes, int flag
 # block/io.c
 bdrv_co_readv(void *bs, int64_t sector_num, int nb_sector) "bs %p sector_num %"PRId64" nb_sectors %d"
 bdrv_co_writev(void *bs, int64_t sector_num, int nb_sector) "bs %p sector_num %"PRId64" nb_sectors %d"
-bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int count, int flags) "bs %p offset %"PRId64" count %d flags %#x"
+bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int count, int flags) "bs %p offset %"PRId64" count %d flags 0x%x"
 bdrv_co_do_copy_on_readv(void *bs, int64_t offset, unsigned int bytes, int64_t cluster_offset, unsigned int cluster_bytes) "bs %p offset %"PRId64" bytes %u cluster_offset %"PRId64" cluster_bytes %u"
 
 # block/stream.c
@@ -100,7 +100,7 @@ qed_need_check_timer_cb(void *s) "s %p"
 qed_start_need_check_timer(void *s) "s %p"
 qed_cancel_need_check_timer(void *s) "s %p"
 qed_aio_complete(void *s, void *acb, int ret) "s %p acb %p ret %d"
-qed_aio_setup(void *s, void *acb, int64_t sector_num, int nb_sectors, void *opaque, int flags) "s %p acb %p sector_num %"PRId64" nb_sectors %d opaque %p flags %#x"
+qed_aio_setup(void *s, void *acb, int64_t sector_num, int nb_sectors, void *opaque, int flags) "s %p acb %p sector_num %"PRId64" nb_sectors %d opaque %p flags 0x%x"
 qed_aio_next_io(void *s, void *acb, int ret, uint64_t cur_pos) "s %p acb %p ret %d cur_pos %"PRIu64
 qed_aio_read_data(void *s, void *acb, int ret, uint64_t offset, size_t len) "s %p acb %p ret %d offset %"PRIu64" len %zu"
 qed_aio_write_data(void *s, void *acb, int ret, uint64_t offset, size_t len) "s %p acb %p ret %d offset %"PRIu64" len %zu"
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 3e896d2e3f..16d19122f0 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -5,7 +5,7 @@ jazz_led_read(uint64_t addr, uint8_t val) "read addr=0x%"PRIx64": 0x%x"
 jazz_led_write(uint64_t addr, uint8_t new) "write addr=0x%"PRIx64": 0x%x"
 
 # hw/display/xenfb.c
-xenfb_mouse_event(void *opaque, int dx, int dy, int dz, int button_state, int abs_pointer_wanted) "%p x %d y %d z %d bs %#x abs %d"
+xenfb_mouse_event(void *opaque, int dx, int dy, int dz, int button_state, int abs_pointer_wanted) "%p x %d y %d z %d bs 0x%x abs %d"
 xenfb_input_connected(void *xendev, int abs_pointer_wanted) "%p abs %d"
 
 # hw/display/g364fb.c
diff --git a/hw/i386/xen/trace-events b/hw/i386/xen/trace-events
index 547438db13..28a8d7dd82 100644
--- a/hw/i386/xen/trace-events
+++ b/hw/i386/xen/trace-events
@@ -6,18 +6,18 @@ xen_pv_mmio_read(uint64_t addr) "WARNING: read from Xen PV Device MMIO space (ad
 xen_pv_mmio_write(uint64_t addr) "WARNING: write to Xen PV Device MMIO space (address %"PRIx64")"
 
 # xen-hvm.c
-xen_ram_alloc(unsigned long ram_addr, unsigned long size) "requested: %#lx, size %#lx"
-xen_client_set_memory(uint64_t start_addr, unsigned long size, bool log_dirty) "%#"PRIx64" size %#lx, log_dirty %i"
-handle_ioreq(void *req, uint32_t type, uint32_t dir, uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=%p type=%d dir=%d df=%d ptr=%d port=%#"PRIx64" data=%#"PRIx64" count=%d size=%d"
-handle_ioreq_read(void *req, uint32_t type, uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=%p read type=%d df=%d ptr=%d port=%#"PRIx64" data=%#"PRIx64" count=%d size=%d"
-handle_ioreq_write(void *req, uint32_t type, uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=%p write type=%d df=%d ptr=%d port=%#"PRIx64" data=%#"PRIx64" count=%d size=%d"
-cpu_ioreq_pio(void *req, uint32_t dir, uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=%p pio dir=%d df=%d ptr=%d port=%#"PRIx64" data=%#"PRIx64" count=%d size=%d"
-cpu_ioreq_pio_read_reg(void *req, uint64_t data, uint64_t addr, uint32_t size) "I/O=%p pio read reg data=%#"PRIx64" port=%#"PRIx64" size=%d"
-cpu_ioreq_pio_write_reg(void *req, uint64_t data, uint64_t addr, uint32_t size) "I/O=%p pio write reg data=%#"PRIx64" port=%#"PRIx64" size=%d"
-cpu_ioreq_move(void *req, uint32_t dir, uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=%p copy dir=%d df=%d ptr=%d port=%#"PRIx64" data=%#"PRIx64" count=%d size=%d"
+xen_ram_alloc(unsigned long ram_addr, unsigned long size) "requested: 0x%lx, size 0x%lx"
+xen_client_set_memory(uint64_t start_addr, unsigned long size, bool log_dirty) "0x%"PRIx64" size 0x%lx, log_dirty %i"
+handle_ioreq(void *req, uint32_t type, uint32_t dir, uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=%p type=%d dir=%d df=%d ptr=%d port=0x%"PRIx64" data=0x%"PRIx64" count=%d size=%d"
+handle_ioreq_read(void *req, uint32_t type, uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=%p read type=%d df=%d ptr=%d port=0x%"PRIx64" data=0x%"PRIx64" count=%d size=%d"
+handle_ioreq_write(void *req, uint32_t type, uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=%p write type=%d df=%d ptr=%d port=0x%"PRIx64" data=0x%"PRIx64" count=%d size=%d"
+cpu_ioreq_pio(void *req, uint32_t dir, uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=%p pio dir=%d df=%d ptr=%d port=0x%"PRIx64" data=0x%"PRIx64" count=%d size=%d"
+cpu_ioreq_pio_read_reg(void *req, uint64_t data, uint64_t addr, uint32_t size) "I/O=%p pio read reg data=0x%"PRIx64" port=0x%"PRIx64" size=%d"
+cpu_ioreq_pio_write_reg(void *req, uint64_t data, uint64_t addr, uint32_t size) "I/O=%p pio write reg data=0x%"PRIx64" port=0x%"PRIx64" size=%d"
+cpu_ioreq_move(void *req, uint32_t dir, uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=%p copy dir=%d df=%d ptr=%d port=0x%"PRIx64" data=0x%"PRIx64" count=%d size=%d"
 
 # xen-mapcache.c
-xen_map_cache(uint64_t phys_addr) "want %#"PRIx64
-xen_remap_bucket(uint64_t index) "index %#"PRIx64
+xen_map_cache(uint64_t phys_addr) "want 0x%"PRIx64
+xen_remap_bucket(uint64_t index) "index 0x%"PRIx64
 xen_map_cache_return(void* ptr) "%p"
 
diff --git a/hw/input/trace-events b/hw/input/trace-events
index 5a87818b49..485195d65f 100644
--- a/hw/input/trace-events
+++ b/hw/input/trace-events
@@ -7,7 +7,7 @@ ps2_set_ledstate(void *s, int ledstate) "%p ledstate %d"
 ps2_reset_keyboard(void *s) "%p"
 ps2_write_keyboard(void *opaque, int val) "%p val %d"
 ps2_keyboard_set_translation(void *opaque, int mode) "%p mode %d"
-ps2_mouse_send_packet(void *s, int dx1, int dy1, int dz1, int b) "%p x %d y %d z %d bs %#x"
+ps2_mouse_send_packet(void *s, int dx1, int dy1, int dz1, int b) "%p x %d y %d z %d bs 0x%x"
 ps2_mouse_fake_event(void *opaque) "%p"
 ps2_write_mouse(void *opaque, int val) "%p val %d"
 ps2_kbd_reset(void *opaque) "%p"
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index c586714d89..d1de370bbf 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -52,17 +52,17 @@ lm32_pic_get_im(uint32_t im) "im 0x%08x"
 lm32_pic_get_ip(uint32_t ip) "ip 0x%08x"
 
 # hw/intc/xics.c
-xics_icp_check_ipi(int server, uint8_t mfrr) "CPU %d can take IPI mfrr=%#x"
-xics_icp_accept(uint32_t old_xirr, uint32_t new_xirr) "icp_accept: XIRR %#"PRIx32"->%#"PRIx32
-xics_icp_eoi(int server, uint32_t xirr, uint32_t new_xirr) "icp_eoi: server %d given XIRR %#"PRIx32" new XIRR %#"PRIx32
-xics_icp_irq(int server, int nr, uint8_t priority) "cpu %d trying to deliver irq %#"PRIx32" priority %#x"
-xics_icp_raise(uint32_t xirr, uint8_t pending_priority) "raising IRQ new XIRR=%#x new pending priority=%#x"
-xics_ics_simple_set_irq_msi(int srcno, int nr) "set_irq_msi: srcno %d [irq %#x]"
+xics_icp_check_ipi(int server, uint8_t mfrr) "CPU %d can take IPI mfrr=0x%x"
+xics_icp_accept(uint32_t old_xirr, uint32_t new_xirr) "icp_accept: XIRR 0x%"PRIx32"->0x%"PRIx32
+xics_icp_eoi(int server, uint32_t xirr, uint32_t new_xirr) "icp_eoi: server %d given XIRR 0x%"PRIx32" new XIRR 0x%"PRIx32
+xics_icp_irq(int server, int nr, uint8_t priority) "cpu %d trying to deliver irq 0x%"PRIx32" priority 0x%x"
+xics_icp_raise(uint32_t xirr, uint8_t pending_priority) "raising IRQ new XIRR=0x%x new pending priority=0x%x"
+xics_ics_simple_set_irq_msi(int srcno, int nr) "set_irq_msi: srcno %d [irq 0x%x]"
 xics_masked_pending(void) "set_irq_msi: masked pending"
-xics_ics_simple_set_irq_lsi(int srcno, int nr) "set_irq_lsi: srcno %d [irq %#x]"
-xics_ics_simple_write_xive(int nr, int srcno, int server, uint8_t priority) "ics_write_xive: irq %#x [src %d] server %#x prio %#x"
-xics_ics_simple_reject(int nr, int srcno) "reject irq %#x [src %d]"
-xics_ics_simple_eoi(int nr) "ics_eoi: irq %#x"
+xics_ics_simple_set_irq_lsi(int srcno, int nr) "set_irq_lsi: srcno %d [irq 0x%x]"
+xics_ics_simple_write_xive(int nr, int srcno, int server, uint8_t priority) "ics_write_xive: irq 0x%x [src %d] server 0x%x prio 0x%x"
+xics_ics_simple_reject(int nr, int srcno) "reject irq 0x%x [src %d]"
+xics_ics_simple_eoi(int nr) "ics_eoi: irq 0x%x"
 xics_alloc(int irq) "irq %d"
 xics_alloc_block(int first, int num, bool lsi, int align) "first irq %d, %d irqs, lsi=%d, alignnum %d"
 xics_ics_free(int src, int irq, int num) "Source#%d, first irq %d, %d irqs"
diff --git a/hw/net/trace-events b/hw/net/trace-events
index c71480535e..ccb1dd01e8 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -41,21 +41,21 @@ open_eth_desc_write(uint32_t addr, uint32_t v) "DESC[%04x] <- %08x"
 pcnet_s_reset(void *s) "s=%p"
 pcnet_user_int(void *s) "s=%p"
 pcnet_isr_change(void *s, uint32_t isr, uint32_t isr_old) "s=%p INTA=%d<=%d"
-pcnet_init(void *s, uint64_t init_addr) "s=%p init_addr=%#"PRIx64
+pcnet_init(void *s, uint64_t init_addr) "s=%p init_addr=0x%"PRIx64
 pcnet_rlen_tlen(void *s, uint32_t rlen, uint32_t tlen) "s=%p rlen=%d tlen=%d"
 pcnet_ss32_rdra_tdra(void *s, uint32_t ss32, uint32_t rdra, uint32_t rcvrl, uint32_t tdra, uint32_t xmtrl) "s=%p ss32=%d rdra=0x%08x[%d] tdra=0x%08x[%d]"
 
 # hw/net/pcnet-pci.c
 pcnet_aprom_writeb(void *opaque, uint32_t addr, uint32_t val) "opaque=%p addr=0x%08x val=0x%02x"
 pcnet_aprom_readb(void *opaque, uint32_t addr, uint32_t val) "opaque=%p addr=0x%08x val=0x%02x"
-pcnet_ioport_read(void *opaque, uint64_t addr, unsigned size) "opaque=%p addr=%#"PRIx64" size=%d"
-pcnet_ioport_write(void *opaque, uint64_t addr, uint64_t data, unsigned size) "opaque=%p addr=%#"PRIx64" data=%#"PRIx64" size=%d"
-pcnet_mmio_writeb(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=%#"PRIx64" val=0x%x"
-pcnet_mmio_writew(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=%#"PRIx64" val=0x%x"
-pcnet_mmio_writel(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=%#"PRIx64" val=0x%x"
-pcnet_mmio_readb(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=%#"PRIx64" val=0x%x"
-pcnet_mmio_readw(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=%#"PRIx64" val=0x%x"
-pcnet_mmio_readl(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=%#"PRIx64" val=0x%x"
+pcnet_ioport_read(void *opaque, uint64_t addr, unsigned size) "opaque=%p addr=0x%"PRIx64" size=%d"
+pcnet_ioport_write(void *opaque, uint64_t addr, uint64_t data, unsigned size) "opaque=%p addr=0x%"PRIx64" data=0x%"PRIx64" size=%d"
+pcnet_mmio_writeb(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=0x%"PRIx64" val=0x%x"
+pcnet_mmio_writew(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=0x%"PRIx64" val=0x%x"
+pcnet_mmio_writel(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=0x%"PRIx64" val=0x%x"
+pcnet_mmio_readb(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=0x%"PRIx64" val=0x%x"
+pcnet_mmio_readw(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=0x%"PRIx64" val=0x%x"
+pcnet_mmio_readl(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=0x%"PRIx64" val=0x%x"
 
 # hw/net/net_rx_pkt.c
 net_rx_pkt_parsed(bool ip4, bool ip6, bool udp, bool tcp, size_t l3o, size_t l4o, size_t l5o) "RX packet parsed: ip4: %d, ip6: %d, udp: %d, tcp: %d, l3 offset: %zu, l4 offset: %zu, l5 offset: %zu"
diff --git a/hw/pci/trace-events b/hw/pci/trace-events
index 83c8f5ace7..52dda1425a 100644
--- a/hw/pci/trace-events
+++ b/hw/pci/trace-events
@@ -1,8 +1,8 @@
 # See docs/tracing.txt for syntax documentation.
 
 # hw/pci/pci.c
-pci_update_mappings_del(void *d, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "d=%p %02x:%02x.%x %d,%#"PRIx64"+%#"PRIx64
-pci_update_mappings_add(void *d, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "d=%p %02x:%02x.%x %d,%#"PRIx64"+%#"PRIx64
+pci_update_mappings_del(void *d, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "d=%p %02x:%02x.%x %d,0x%"PRIx64"+0x%"PRIx64
+pci_update_mappings_add(void *d, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "d=%p %02x:%02x.%x %d,0x%"PRIx64"+0x%"PRIx64
 
 # hw/pci/pci_host.c
 pci_cfg_read(const char *dev, unsigned devid, unsigned fnid, unsigned offs, unsigned val) "%s %02u:%u @0x%x -> 0x%x"
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index 4a2e5d66df..3e196da6e8 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -11,10 +11,10 @@ scsi_req_continue_canceled(int target, int lun, int tag) "target %d lun %d tag %
 scsi_req_parsed(int target, int lun, int tag, int cmd, int mode, int xfer) "target %d lun %d tag %d command %d dir %d length %d"
 scsi_req_parsed_lba(int target, int lun, int tag, int cmd, uint64_t lba) "target %d lun %d tag %d command %d lba %"PRIu64
 scsi_req_parse_bad(int target, int lun, int tag, int cmd) "target %d lun %d tag %d command %d"
-scsi_req_build_sense(int target, int lun, int tag, int key, int asc, int ascq) "target %d lun %d tag %d key %#02x asc %#02x ascq %#02x"
-scsi_device_set_ua(int target, int lun, int key, int asc, int ascq) "target %d lun %d key %#02x asc %#02x ascq %#02x"
+scsi_req_build_sense(int target, int lun, int tag, int key, int asc, int ascq) "target %d lun %d tag %d key 0x%02x asc 0x%02x ascq 0x%02x"
+scsi_device_set_ua(int target, int lun, int key, int asc, int ascq) "target %d lun %d key 0x%02x asc 0x%02x ascq 0x%02x"
 scsi_report_luns(int target, int lun, int tag) "target %d lun %d tag %d"
-scsi_inquiry(int target, int lun, int tag, int cdb1, int cdb2) "target %d lun %d tag %d page %#02x/%#02x"
+scsi_inquiry(int target, int lun, int tag, int cdb1, int cdb2) "target %d lun %d tag %d page 0x%02x/0x%02x"
 scsi_test_unit_ready(int target, int lun, int tag) "target %d lun %d tag %d"
 scsi_request_sense(int target, int lun, int tag) "target %d lun %d tag %d"
 
diff --git a/hw/xen/trace-events b/hw/xen/trace-events
index 5615dce2c1..ebc05ef536 100644
--- a/hw/xen/trace-events
+++ b/hw/xen/trace-events
@@ -5,10 +5,10 @@ xen_default_ioreq_server(void) ""
 xen_ioreq_server_create(uint32_t id) "id: %u"
 xen_ioreq_server_destroy(uint32_t id) "id: %u"
 xen_ioreq_server_state(uint32_t id, bool enable) "id: %u: enable: %i"
-xen_map_mmio_range(uint32_t id, uint64_t start_addr, uint64_t end_addr) "id: %u start: %#"PRIx64" end: %#"PRIx64
-xen_unmap_mmio_range(uint32_t id, uint64_t start_addr, uint64_t end_addr) "id: %u start: %#"PRIx64" end: %#"PRIx64
-xen_map_portio_range(uint32_t id, uint64_t start_addr, uint64_t end_addr) "id: %u start: %#"PRIx64" end: %#"PRIx64
-xen_unmap_portio_range(uint32_t id, uint64_t start_addr, uint64_t end_addr) "id: %u start: %#"PRIx64" end: %#"PRIx64
+xen_map_mmio_range(uint32_t id, uint64_t start_addr, uint64_t end_addr) "id: %u start: 0x%"PRIx64" end: 0x%"PRIx64
+xen_unmap_mmio_range(uint32_t id, uint64_t start_addr, uint64_t end_addr) "id: %u start: 0x%"PRIx64" end: 0x%"PRIx64
+xen_map_portio_range(uint32_t id, uint64_t start_addr, uint64_t end_addr) "id: %u start: 0x%"PRIx64" end: 0x%"PRIx64
+xen_unmap_portio_range(uint32_t id, uint64_t start_addr, uint64_t end_addr) "id: %u start: 0x%"PRIx64" end: 0x%"PRIx64
 xen_map_pcidev(uint32_t id, uint8_t bus, uint8_t dev, uint8_t func) "id: %u bdf: %02x.%02x.%02x"
 xen_unmap_pcidev(uint32_t id, uint8_t bus, uint8_t dev, uint8_t func) "id: %u bdf: %02x.%02x.%02x"
 xen_domid_restrict(int err) "err: %u"
diff --git a/trace-events b/trace-events
index f9dbd7f509..1f50f56d9d 100644
--- a/trace-events
+++ b/trace-events
@@ -26,8 +26,8 @@
 # The <format-string> should be a sprintf()-compatible format string.
 
 # ioport.c
-cpu_in(unsigned int addr, char size, unsigned int val) "addr %#x(%c) value %u"
-cpu_out(unsigned int addr, char size, unsigned int val) "addr %#x(%c) value %u"
+cpu_in(unsigned int addr, char size, unsigned int val) "addr 0x%x(%c) value %u"
+cpu_out(unsigned int addr, char size, unsigned int val) "addr 0x%x(%c) value %u"
 
 # balloon.c
 # Since requests are raised via monitor, not many tracepoints are needed.
@@ -56,14 +56,14 @@ dma_blk_cb(void *dbs, int ret) "dbs=%p ret=%d"
 dma_map_wait(void *dbs) "dbs=%p"
 
 # memory.c
-memory_region_ops_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr %#"PRIx64" value %#"PRIx64" size %u"
-memory_region_ops_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr %#"PRIx64" value %#"PRIx64" size %u"
-memory_region_subpage_read(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset %#"PRIx64" value %#"PRIx64" size %u"
-memory_region_subpage_write(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset %#"PRIx64" value %#"PRIx64" size %u"
-memory_region_tb_read(int cpu_index, uint64_t addr, uint64_t value, unsigned size) "cpu %d addr %#"PRIx64" value %#"PRIx64" size %u"
-memory_region_tb_write(int cpu_index, uint64_t addr, uint64_t value, unsigned size) "cpu %d addr %#"PRIx64" value %#"PRIx64" size %u"
-memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr %#"PRIx64" value %#"PRIx64" size %u"
-memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr %#"PRIx64" value %#"PRIx64" size %u"
+memory_region_ops_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
+memory_region_ops_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
+memory_region_subpage_read(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
+memory_region_subpage_write(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
+memory_region_tb_read(int cpu_index, uint64_t addr, uint64_t value, unsigned size) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
+memory_region_tb_write(int cpu_index, uint64_t addr, uint64_t value, unsigned size) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
+memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
+memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
 
 ### Guest events, keep at bottom
 
-- 
2.11.1
