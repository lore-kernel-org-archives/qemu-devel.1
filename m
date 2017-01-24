Received: from eggs.gnu.org ([2001:4830:134:3::10]:42417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVxem-00021N-JY
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:44:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVxei-0002cz-OV
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:44:52 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 24 Jan 2017 12:39:10 +0300
Message-Id: <fe0c16f05035cb583f519bcf09fe17990b559ff9.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 06/31] hw: Fix typos found by codespell
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Stefan Weil <sw@weilnetz.de>

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Acked-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/core/generic-loader.c  | 4 ++--
 hw/core/qdev-properties.c | 2 +-
 hw/display/xlnx_dp.c      | 4 ++--
 hw/i386/pc.c              | 2 +-
 hw/net/cadence_gem.c      | 2 +-
 hw/net/spapr_llan.c       | 4 ++--
 hw/ppc/spapr_drc.c        | 2 +-
 hw/s390x/s390-pci-bus.h   | 4 ++--
 hw/usb/dev-mtp.c          | 2 +-
 hw/vfio/pci-quirks.c      | 2 +-
 hw/virtio/virtio-crypto.c | 2 +-
 11 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index 208f549..58f1f02 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -27,7 +27,7 @@
  * this it needs a backend to manage the datas, the same as other
  * memory-related devices. In this case as the backend is so trivial we
  * have merged it with the frontend instead of creating and maintaining a
- * seperate backend.
+ * separate backend.
  */
 
 #include "qemu/osdep.h"
@@ -79,7 +79,7 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
                        "loading memory values");
             return;
         } else if (!s->data_len) {
-            /* We cant' check for !data here as a value of 0 is still valid. */
+            /* We can't check for !data here as a value of 0 is still valid. */
             error_setg(errp, "Both data and data-len must be specified");
             return;
         } else if (s->data_len > 8) {
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 2a82768..6ab4265 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -711,7 +711,7 @@ static void get_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
 
     /*
      * Catch "invalid" device reference from vfio-pci and allow the
-     * default buffer representing the non-existant device to be used.
+     * default buffer representing the non-existent device to be used.
      */
     if (~addr->domain || ~addr->bus || ~addr->slot || ~addr->function) {
         rc = snprintf(buffer, sizeof(buffer), "%04x:%02x:%02x.%0d",
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index f43eb09..f7b7b80 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -555,7 +555,7 @@ static void xlnx_dp_recreate_surface(XlnxDPState *s)
     if ((width != 0) && (height != 0)) {
         /*
          * As dpy_gfx_replace_surface calls qemu_free_displaysurface on the
-         * surface we need to be carefull and don't free the surface associated
+         * surface we need to be careful and don't free the surface associated
          * to the console or double free will happen.
          */
         if (s->bout_plane.surface != current_console_surface) {
@@ -1160,7 +1160,7 @@ static void xlnx_dp_update_display(void *opaque)
      */
     if (!xlnx_dpdma_start_operation(s->dpdma, 3, false)) {
         /*
-         * An error occured don't do anything with the data..
+         * An error occurred don't do anything with the data..
          * Trigger an underflow interrupt.
          */
         s->core_registers[DP_INT_STATUS] |= (1 << 21);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f721fde..9ab7e29 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1784,7 +1784,7 @@ static int pc_apic_cmp(const void *a, const void *b)
 
 /* returns pointer to CPUArchId descriptor that matches CPU's apic_id
  * in pcms->possible_cpus->cpus, if pcms->possible_cpus->cpus has no
- * entry correponding to CPU's apic_id returns NULL.
+ * entry corresponding to CPU's apic_id returns NULL.
  */
 static CPUArchId *pc_find_cpu_slot(PCMachineState *pcms, CPUState *cpu,
                                    int *idx)
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 7915732..e99d454 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -896,7 +896,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
 
     DB_PRINT("config bufsize: %d packet size: %ld\n", rxbufsize, size);
 
-    /* Find which queue we are targetting */
+    /* Find which queue we are targeting */
     q = get_queue_from_screen(s, rxbuf_ptr, rxbufsize);
 
     while (bytes_to_copy) {
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index 01ecb02..058908d 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -105,7 +105,7 @@ typedef struct VIOsPAPRVLANDevice {
     uint32_t add_buf_ptr, use_buf_ptr, rx_bufs;
     hwaddr rxq_ptr;
     QEMUTimer *rxp_timer;
-    uint32_t compat_flags;             /* Compatability flags for migration */
+    uint32_t compat_flags;             /* Compatibility flags for migration */
     RxBufPool *rx_pool[RX_MAX_POOLS];  /* Receive buffer descriptor pools */
 } VIOsPAPRVLANDevice;
 
@@ -559,7 +559,7 @@ static target_long spapr_vlan_add_rxbuf_to_pool(VIOsPAPRVLANDevice *dev,
     if (pool < 0) {
         /*
          * No matching pool found? Try to use a new one. If the guest used all
-         * pools before, but changed the size of one pool inbetween, we might
+         * pools before, but changed the size of one pool in the meantime, we might
          * need to recycle that pool here (if it's empty already). Thus scan
          * all buffer pools now, starting with the last (likely empty) one.
          */
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index a0c44ee..2de6377 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -59,7 +59,7 @@ static uint32_t set_isolation_state(sPAPRDRConnector *drc,
     trace_spapr_drc_set_isolation_state(get_index(drc), state);
 
     if (state == SPAPR_DR_ISOLATION_STATE_UNISOLATED) {
-        /* cannot unisolate a non-existant resource, and, or resources
+        /* cannot unisolate a non-existent resource, and, or resources
          * which are in an 'UNUSABLE' allocation state. (PAPR 2.7, 13.5.3.5)
          */
         if (!drc->dev ||
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index b0adefa..0aad9cc 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -183,8 +183,8 @@ enum ZpciIoatDtype {
  *          may enter an error state
  * blocked: ignore all DMA and interrupts; transition back to enabled or from
  *          error state via mpcifc
- * error: an error occured; transition back to enabled via mpcifc
- * permanent error: an unrecoverable error occured; transition to standby via
+ * error: an error occurred; transition back to enabled via mpcifc
+ * permanent error: an unrecoverable error occurred; transition to standby via
  *                  sclp deconfigure
  */
 typedef enum {
diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 9cb0f50..809dcf5 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1093,7 +1093,7 @@ static MTPData *usb_mtp_get_object_prop_value(MTPState *s, MTPControl *c,
         }
         break;
     case PROP_PERSISTENT_UNIQUE_OBJECT_IDENTIFIER:
-        /* Should be persistant between sessions,
+        /* Should be persistent between sessions,
          * but using our objedt ID is "good enough"
          * for now */
         usb_mtp_add_u64(d, 0x0000000000000000);
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 811eecd..6c771f7 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1171,7 +1171,7 @@ static int vfio_pci_igd_host_init(VFIOPCIDevice *vdev,
  * IGD LPC/ISA bridge support code.  The vBIOS needs this, but we can't write
  * arbitrary values into just any bridge, so we must create our own.  We try
  * to handle if the user has created it for us, which they might want to do
- * to enable multifuction so we don't occupy the whole PCI slot.
+ * to enable multifunction so we don't occupy the whole PCI slot.
  */
 static void vfio_pci_igd_lpc_bridge_realize(PCIDevice *pdev, Error **errp)
 {
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 296472f..0353eb6 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -786,7 +786,7 @@ static void virtio_crypto_device_realize(DeviceState *dev, Error **errp)
     vcrypto->max_queues = MAX(vcrypto->cryptodev->conf.peers.queues, 1);
     if (vcrypto->max_queues + 1 > VIRTIO_QUEUE_MAX) {
         error_setg(errp, "Invalid number of queues (= %" PRIu32 "), "
-                   "must be a postive integer less than %d.",
+                   "must be a positive integer less than %d.",
                    vcrypto->max_queues, VIRTIO_QUEUE_MAX);
         return;
     }
-- 
2.1.4
