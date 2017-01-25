Received: from eggs.gnu.org ([2001:4830:134:3::10]:37189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWOLJ-0006DJ-9x
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:14:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWOLG-0005tV-2N
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:14:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cWOLF-0005tI-Qk
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:14:30 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E268E4E357
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 14:14:29 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 25 Jan 2017 14:14:26 +0000
Message-Id: <20170125141426.23454-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] trace: clean up trace-events files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Daniel Berrange <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

There are a number of unused trace events that
scripts/cleanup-trace-events.pl finds.  The "hw/vfio/pci-quirks.c"
filename was typoed and "qapi/qapi-visit-core.c" was missing the qapi/
directory prefix.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/trace-events      | 2 --
 hw/block/trace-events   | 1 -
 hw/display/trace-events | 1 -
 hw/i386/trace-events    | 1 -
 hw/input/trace-events   | 2 --
 hw/intc/trace-events    | 1 -
 hw/net/trace-events     | 8 --------
 hw/usb/trace-events     | 1 -
 hw/vfio/trace-events    | 2 +-
 migration/trace-events  | 3 ---
 qapi/trace-events       | 3 +--
 trace-events            | 1 -
 12 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/block/trace-events b/block/trace-events
index 671a6a8..0bc5c0a 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -35,8 +35,6 @@ mirror_one_iteration(void *s, int64_t sector_num, int nb_sectors) "s %p sector_n
 mirror_iteration_done(void *s, int64_t sector_num, int nb_sectors, int ret) "s %p sector_num %"PRId64" nb_sectors %d ret %d"
 mirror_yield(void *s, int64_t cnt, int buf_free_count, int in_flight) "s %p dirty count %"PRId64" free buffers %d in_flight %d"
 mirror_yield_in_flight(void *s, int64_t sector_num, int in_flight) "s %p sector_num %"PRId64" in_flight %d"
-mirror_yield_buf_busy(void *s, int nb_chunks, int in_flight) "s %p requested chunks %d in_flight %d"
-mirror_break_buf_busy(void *s, int nb_chunks, int in_flight) "s %p requested chunks %d in_flight %d"
 
 # block/backup.c
 backup_do_cow_enter(void *job, int64_t start, int64_t sector_num, int nb_sectors) "job %p start %"PRId64" sector_num %"PRId64" nb_sectors %d"
diff --git a/hw/block/trace-events b/hw/block/trace-events
index d0dd94f..2b85644 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -10,7 +10,6 @@ virtio_blk_submit_multireq(void *mrb, int start, int num_reqs, uint64_t offset,
 # hw/block/dataplane/virtio-blk.c
 virtio_blk_data_plane_start(void *s) "dataplane %p"
 virtio_blk_data_plane_stop(void *s) "dataplane %p"
-virtio_blk_data_plane_process_request(void *s, unsigned int out_num, unsigned int in_num, unsigned int head) "dataplane %p out_num %u in_num %u head %u"
 
 # hw/block/hd-geometry.c
 hd_geometry_lchs_guess(void *blk, int cyls, int heads, int secs) "blk %p LCHS %d %d %d"
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 332abab..aadb612 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -34,7 +34,6 @@ vmware_setmode(uint32_t w, uint32_t h, uint32_t bpp) "%dx%d @ %d bpp"
 # hw/display/virtio-gpu.c
 virtio_gpu_features(bool virgl) "virgl %d"
 virtio_gpu_cmd_get_display_info(void) ""
-virtio_gpu_cmd_get_caps(void) ""
 virtio_gpu_cmd_set_scanout(uint32_t id, uint32_t res, uint32_t w, uint32_t h, uint32_t x, uint32_t y) "id %d, res 0x%x, w %d, h %d, x %d, y %d"
 virtio_gpu_cmd_res_create_2d(uint32_t res, uint32_t fmt, uint32_t w, uint32_t h) "res 0x%x, fmt 0x%x, w %d, h %d"
 virtio_gpu_cmd_res_create_3d(uint32_t res, uint32_t fmt, uint32_t w, uint32_t h, uint32_t d) "res 0x%x, fmt 0x%x, w %d, h %d, d %d"
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index d2b4973..4111b2f 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -30,7 +30,6 @@ amdvi_devtab_inval(uint8_t bus, uint8_t slot, uint8_t func) "device table entry
 amdvi_completion_wait(uint64_t addr, uint64_t data) "completion wait requested with store address 0x%"PRIx64" and store data 0x%"PRIx64
 amdvi_control_status(uint64_t val) "MMIO_STATUS state 0x%"PRIx64
 amdvi_iotlb_reset(void) "IOTLB exceed size limit - reset "
-amdvi_completion_wait_exec(uint64_t addr, uint64_t data) "completion wait requested with store address 0x%"PRIx64" and store data 0x%"PRIx64
 amdvi_dte_get_fail(uint64_t addr, uint32_t offset) "error: failed to access Device Entry devtab 0x%"PRIx64" offset 0x%"PRIx32
 amdvi_invalid_dte(uint64_t addr) "PTE entry at 0x%"PRIx64" is invalid "
 amdvi_get_pte_hwerror(uint64_t addr) "hardware error eccessing PTE at addr 0x%"PRIx64
diff --git a/hw/input/trace-events b/hw/input/trace-events
index 8c4003f..f3bfbed 100644
--- a/hw/input/trace-events
+++ b/hw/input/trace-events
@@ -8,8 +8,6 @@ ps2_reset_keyboard(void *s) "%p"
 ps2_write_keyboard(void *opaque, int val) "%p val %d"
 ps2_keyboard_set_translation(void *opaque, int mode) "%p mode %d"
 ps2_mouse_send_packet(void *s, int dx1, int dy1, int dz1, int b) "%p x %d y %d z %d bs %#x"
-ps2_mouse_event_disabled(void *opaque, int dx, int dy, int dz, int buttons_state, int mouse_dx, int mouse_dy, int mouse_dz) "%p x %d y %d z %d bs %#x mx %d my %d mz %d "
-ps2_mouse_event(void *opaque, int dx, int dy, int dz, int buttons_state, int mouse_dx, int mouse_dy, int mouse_dz) "%p x %d y %d z %d bs %#x mx %d my %d mz %d "
 ps2_mouse_fake_event(void *opaque) "%p"
 ps2_write_mouse(void *opaque, int val) "%p val %d"
 ps2_kbd_reset(void *opaque) "%p"
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 92a6171..39a538d 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -67,7 +67,6 @@ xics_alloc(int irq) "irq %d"
 xics_alloc_block(int first, int num, bool lsi, int align) "first irq %d, %d irqs, lsi=%d, alignnum %d"
 xics_ics_free(int src, int irq, int num) "Source#%d, first irq %d, %d irqs"
 xics_ics_free_warn(int src, int irq) "Source#%d, irq %d is already free"
-xics_icp_post_load(uint32_t server_no, uint32_t xirr, uint64_t addr, uint8_t pend) "server_no %d, xirr %#x, xirr_owner 0x%" PRIx64 ", pending %d"
 
 # hw/intc/s390_flic_kvm.c
 flic_create_device(int err) "flic: create device failed %d"
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 1a5c909..c714805 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -63,10 +63,6 @@ net_rx_pkt_l4_csum_validate_entry(void) "Starting L4 checksum validation"
 net_rx_pkt_l4_csum_validate_not_xxp(void) "Not a TCP/UDP packet"
 net_rx_pkt_l4_csum_validate_udp_with_no_checksum(void) "UDP packet without checksum"
 net_rx_pkt_l4_csum_validate_ip4_fragment(void) "IP4 fragment"
-net_rx_pkt_l4_csum_validate_ip4_udp(void) "IP4/UDP packet"
-net_rx_pkt_l4_csum_validate_ip4_tcp(void) "IP4/TCP packet"
-net_rx_pkt_l4_csum_validate_ip6_udp(void) "IP6/UDP packet"
-net_rx_pkt_l4_csum_validate_ip6_tcp(void) "IP6/TCP packet"
 net_rx_pkt_l4_csum_validate_csum(bool csum_valid) "Checksum valid: %d"
 
 net_rx_pkt_l4_csum_calc_entry(void) "Starting L4 checksum calculation"
@@ -117,7 +113,6 @@ e1000e_core_mdic_read(uint8_t page, uint32_t addr, uint32_t data) "MDIC READ: PH
 e1000e_core_mdic_read_unhandled(uint8_t page, uint32_t addr) "MDIC READ: PHY[%u][%u] UNHANDLED"
 e1000e_core_mdic_write(uint8_t page, uint32_t addr, uint32_t data) "MDIC WRITE: PHY[%u][%u] = 0x%x"
 e1000e_core_mdic_write_unhandled(uint8_t page, uint32_t addr) "MDIC WRITE: PHY[%u][%u] UNHANDLED"
-e1000e_core_eeeprom_write(uint16_t bit_in, uint16_t bit_out, uint16_t reading) "eeprom bitnum in %d out %d, reading %d"
 e1000e_core_ctrl_write(uint64_t index, uint32_t val) "Write CTRL register 0x%"PRIx64", value: 0x%X"
 e1000e_core_ctrl_sw_reset(void) "Doing SW reset"
 e1000e_core_ctrl_phy_reset(void) "Doing PHY reset"
@@ -159,7 +154,6 @@ e1000e_rx_desc_buff_write(uint8_t idx, uint64_t addr, uint16_t offset, const voi
 e1000e_rx_descr(int ridx, uint64_t base, uint8_t len) "Next RX descriptor: ring #%d, PA: 0x%"PRIx64", length: %u"
 e1000e_rx_set_rctl(uint32_t rctl) "RCTL = 0x%x"
 e1000e_rx_receive_iov(int iovcnt) "Received vector of %d fragments"
-e1000e_rx_packet_size(size_t full, size_t vhdr, size_t data) "Received packet of %zu bytes total, %zu virt header, %zu data"
 e1000e_rx_flt_dropped(void) "Received packet dropped by RX filter"
 e1000e_rx_written_to_guest(uint32_t causes) "Received packet written to guest (ICR causes %u)"
 e1000e_rx_not_written_to_guest(uint32_t causes) "Received packet NOT written to guest (ICR causes %u)"
@@ -196,14 +190,12 @@ e1000e_rx_metadata_ipv6_filtering_disabled(void) "IPv6 RX filtering disabled by
 
 e1000e_vlan_vet(uint16_t vet) "Setting VLAN ethernet type 0x%X"
 
-e1000e_irq_set_cause(uint32_t cause) "IRQ cause set 0x%x"
 e1000e_irq_msi_notify(uint32_t cause) "MSI notify 0x%x"
 e1000e_irq_throttling_no_pending_interrupts(void) "No pending interrupts to notify"
 e1000e_irq_msi_notify_postponed(void) "Sending MSI postponed by ITR"
 e1000e_irq_legacy_notify_postponed(void) "Raising legacy IRQ postponed by ITR"
 e1000e_irq_throttling_no_pending_vec(int idx) "No pending interrupts for vector %d"
 e1000e_irq_msix_notify_postponed_vec(int idx) "Sending MSI-X postponed by EITR[%d]"
-e1000e_irq_msix_notify(uint32_t cause) "MSI-X notify 0x%x"
 e1000e_irq_legacy_notify(bool level) "IRQ line state: %d"
 e1000e_irq_msix_notify_vec(uint32_t vector) "MSI-X notify vector 0x%x"
 e1000e_irq_postponed_by_xitr(uint32_t reg) "Interrupt postponed by [E]ITR register 0x%x"
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index 2d42fd4..fdd1d29 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -60,7 +60,6 @@ usb_ohci_mem_read_bad_offset(uint32_t addr) "%x"
 usb_ohci_mem_write_unaligned(uint32_t addr) "at %x"
 usb_ohci_mem_write_bad_offset(uint32_t addr) "%x"
 usb_ohci_process_lists(uint32_t head, uint32_t cur) "head %x, cur %x"
-usb_ohci_bus_eof_timer_failed(const char *name) "%s: timer_new_ns failed"
 usb_ohci_set_frame_interval(const char *name, uint16_t fi_x, uint16_t fi_u) "%s: FrameInterval = 0x%x (%u)"
 usb_ohci_hub_power_up(void) "powered up all ports"
 usb_ohci_hub_power_down(void) "powered down all ports"
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index ef81609..8de8281 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -46,7 +46,7 @@ vfio_pci_emulated_device_id(const char *name, uint16_t val) "%s %04x"
 vfio_pci_emulated_sub_vendor_id(const char *name, uint16_t val) "%s %04x"
 vfio_pci_emulated_sub_device_id(const char *name, uint16_t val) "%s %04x"
 
-# hw/vfio/pci-quirks.
+# hw/vfio/pci-quirks.c
 vfio_quirk_rom_blacklisted(const char *name, uint16_t vid, uint16_t did) "%s %04x:%04x"
 vfio_quirk_generic_window_address_write(const char *name, const char * region_name, uint64_t data) "%s %s 0x%"PRIx64
 vfio_quirk_generic_window_data_read(const char *name, const char * region_name, uint64_t data) "%s %s 0x%"PRIx64
diff --git a/migration/trace-events b/migration/trace-events
index 48e531d..fa660e3 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -4,8 +4,6 @@
 qemu_loadvm_state_section(unsigned int section_type) "%d"
 qemu_loadvm_state_section_command(int ret) "%d"
 qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
-qemu_loadvm_state_main(void) ""
-qemu_loadvm_state_main_quit_parent(void) ""
 qemu_loadvm_state_post_main(int ret) "%d"
 qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
 qemu_savevm_send_packaged(void) ""
@@ -118,7 +116,6 @@ qemu_rdma_accept_incoming_migration_accepted(void) ""
 qemu_rdma_accept_pin_state(bool pin) "%d"
 qemu_rdma_accept_pin_verbsc(void *verbs) "Verbs context after listen: %p"
 qemu_rdma_block_for_wrid_miss(const char *wcompstr, int wcomp, const char *gcompstr, uint64_t req) "A Wanted wrid %s (%d) but got %s (%" PRIu64 ")"
-qemu_rdma_block_for_wrid_miss_b(const char *wcompstr, int wcomp, const char *gcompstr, uint64_t req) "B Wanted wrid %s (%d) but got %s (%" PRIu64 ")"
 qemu_rdma_cleanup_disconnect(void) ""
 qemu_rdma_cleanup_waiting_for_disconnect(void) ""
 qemu_rdma_close(void) ""
diff --git a/qapi/trace-events b/qapi/trace-events
index 2c5d3bc..82a0b73 100644
--- a/qapi/trace-events
+++ b/qapi/trace-events
@@ -1,4 +1,4 @@
-# qapi-visit-core.c
+# qapi/qapi-visit-core.c
 visit_free(void *v) "v=%p"
 visit_complete(void *v, void *opaque) "v=%p opaque=%p"
 
@@ -15,7 +15,6 @@ visit_end_alternate(void *v, void *obj) "v=%p obj=%p"
 
 visit_optional(void *v, const char *name, bool *present) "v=%p name=%s present=%p"
 
-visit_type_enum(void *v, const char *name, int *obj) "v=%p name=%s obj=%p"
 visit_type_int(void *v, const char *name, int64_t *obj) "v=%p name=%s obj=%p"
 visit_type_uint8(void *v, const char *name, uint8_t *obj) "v=%p name=%s obj=%p"
 visit_type_uint16(void *v, const char *name, uint16_t *obj) "v=%p name=%s obj=%p"
diff --git a/trace-events b/trace-events
index 839a9d0..70b5c7c 100644
--- a/trace-events
+++ b/trace-events
@@ -90,7 +90,6 @@ handle_qmp_command(void *mon, const char *cmd_name) "mon %p cmd_name \"%s\""
 monitor_protocol_event_handler(uint32_t event, void *qdict) "event=%d data=%p"
 monitor_protocol_event_emit(uint32_t event, void *data) "event=%d data=%p"
 monitor_protocol_event_queue(uint32_t event, void *qdict, uint64_t rate) "event=%d data=%p rate=%" PRId64
-monitor_protocol_event_throttle(uint32_t event, uint64_t rate) "event=%d rate=%" PRId64
 
 # dma-helpers.c
 dma_blk_io(void *dbs, void *bs, int64_t offset, bool to_dev) "dbs=%p bs=%p offset=%" PRId64 " to_dev=%d"
-- 
2.9.3
