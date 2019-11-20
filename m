Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C81AC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 00:53:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F14222DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 00:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F14222DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXEFK-0000c9-50
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 19:53:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iXEES-0000Cu-60
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 19:52:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iXEEP-0000u0-U1
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 19:52:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9224
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iXEEP-0000t2-Od
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 19:52:29 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAK0qJYl024080; Tue, 19 Nov 2019 19:52:22 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2way22af24-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Nov 2019 19:52:21 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xAK0qLWr025309;
 Tue, 19 Nov 2019 19:52:21 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2way22aeyv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Nov 2019 19:52:21 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAK0oViR020157;
 Wed, 20 Nov 2019 00:52:15 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma02dal.us.ibm.com with ESMTP id 2wa8r6garb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Nov 2019 00:52:15 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAK0qEpo53543286
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Nov 2019 00:52:14 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 240466E052;
 Wed, 20 Nov 2019 00:52:14 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 026E86E04E;
 Wed, 20 Nov 2019 00:52:13 +0000 (GMT)
Received: from localhost (unknown [9.53.179.218])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 20 Nov 2019 00:52:13 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] virtio-pci: disable vring processing when bus-mastering is
 disabled
Date: Tue, 19 Nov 2019 18:50:03 -0600
Message-Id: <20191120005003.27035-1-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_08:2019-11-15,2019-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=13 spamscore=0 adultscore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911200007
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the SLOF firmware for pseries guests will disable/re-enable
a PCI device multiple times via IO/MEM/MASTER bits of PCI_COMMAND
register after the initial probe/feature negotiation, as it tends to
work with a single device at a time at various stages like probing
and running block/network bootloaders without doing a full reset
in-between.

In QEMU, when PCI_COMMAND_MASTER is disabled we disable the
corresponding IOMMU memory region, so DMA accesses (including to vring
fields like idx/flags) will no longer undergo the necessary
translation. Normally we wouldn't expect this to happen since it would
be misbehavior on the driver side to continue driving DMA requests.

However, in the case of pseries, with iommu_platform=on, we trigger the
following sequence when tearing down the virtio-blk dataplane ioeventfd
in response to the guest unsetting PCI_COMMAND_MASTER:

  #2  0x0000555555922651 in virtqueue_map_desc (vdev=vdev@entry=0x555556dbcfb0, p_num_sg=p_num_sg@entry=0x7fffe657e1a8, addr=addr@entry=0x7fffe657e240, iov=iov@entry=0x7fffe6580240, max_num_sg=max_num_sg@entry=1024, is_write=is_write@entry=false, pa=0, sz=0)
      at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:757
  #3  0x0000555555922a89 in virtqueue_pop (vq=vq@entry=0x555556dc8660, sz=sz@entry=184)
      at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:950
  #4  0x00005555558d3eca in virtio_blk_get_request (vq=0x555556dc8660, s=0x555556dbcfb0)
      at /home/mdroth/w/qemu.git/hw/block/virtio-blk.c:255
  #5  0x00005555558d3eca in virtio_blk_handle_vq (s=0x555556dbcfb0, vq=0x555556dc8660)
      at /home/mdroth/w/qemu.git/hw/block/virtio-blk.c:776
  #6  0x000055555591dd66 in virtio_queue_notify_aio_vq (vq=vq@entry=0x555556dc8660)
      at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:1550
  #7  0x000055555591ecef in virtio_queue_notify_aio_vq (vq=0x555556dc8660)
      at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:1546
  #8  0x000055555591ecef in virtio_queue_host_notifier_aio_poll (opaque=0x555556dc86c8)
      at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:2527
  #9  0x0000555555d02164 in run_poll_handlers_once (ctx=ctx@entry=0x55555688bfc0, timeout=timeout@entry=0x7fffe65844a8)
      at /home/mdroth/w/qemu.git/util/aio-posix.c:520
  #10 0x0000555555d02d1b in try_poll_mode (timeout=0x7fffe65844a8, ctx=0x55555688bfc0)
      at /home/mdroth/w/qemu.git/util/aio-posix.c:607
  #11 0x0000555555d02d1b in aio_poll (ctx=ctx@entry=0x55555688bfc0, blocking=blocking@entry=true)
      at /home/mdroth/w/qemu.git/util/aio-posix.c:639
  #12 0x0000555555d0004d in aio_wait_bh_oneshot (ctx=0x55555688bfc0, cb=cb@entry=0x5555558d5130 <virtio_blk_data_plane_stop_bh>, opaque=opaque@entry=0x555556de86f0)
      at /home/mdroth/w/qemu.git/util/aio-wait.c:71
  #13 0x00005555558d59bf in virtio_blk_data_plane_stop (vdev=<optimized out>)
      at /home/mdroth/w/qemu.git/hw/block/dataplane/virtio-blk.c:288
  #14 0x0000555555b906a1 in virtio_bus_stop_ioeventfd (bus=bus@entry=0x555556dbcf38)
      at /home/mdroth/w/qemu.git/hw/virtio/virtio-bus.c:245
  #15 0x0000555555b90dbb in virtio_bus_stop_ioeventfd (bus=bus@entry=0x555556dbcf38)
      at /home/mdroth/w/qemu.git/hw/virtio/virtio-bus.c:237
  #16 0x0000555555b92a8e in virtio_pci_stop_ioeventfd (proxy=0x555556db4e40)
      at /home/mdroth/w/qemu.git/hw/virtio/virtio-pci.c:292
  #17 0x0000555555b92a8e in virtio_write_config (pci_dev=0x555556db4e40, address=<optimized out>, val=1048832, len=<optimized out>)
      at /home/mdroth/w/qemu.git/hw/virtio/virtio-pci.c:613

I.e. the calling code is only scheduling a one-shot BH for
virtio_blk_data_plane_stop_bh, but somehow we end up trying to process
an additional virtqueue entry before we get there. This is likely due
to the following check in virtio_queue_host_notifier_aio_poll:

  static bool virtio_queue_host_notifier_aio_poll(void *opaque)
  {
      EventNotifier *n = opaque;
      VirtQueue *vq = container_of(n, VirtQueue, host_notifier);
      bool progress;

      if (!vq->vring.desc || virtio_queue_empty(vq)) {
          return false;
      }

      progress = virtio_queue_notify_aio_vq(vq);

namely the call to virtio_queue_empty(). In this case, since no new
requests have actually been issued, shadow_avail_idx == last_avail_idx,
so we actually try to access the vring via vring_avail_idx() to get
the latest non-shadowed idx:

  int virtio_queue_empty(VirtQueue *vq)
  {
      bool empty;
      ...

      if (vq->shadow_avail_idx != vq->last_avail_idx) {
          return 0;
      }

      rcu_read_lock();
      empty = vring_avail_idx(vq) == vq->last_avail_idx;
      rcu_read_unlock();
      return empty;

but since the IOMMU region has been disabled we get a bogus value (0
usually), which causes virtio_queue_empty() to falsely report that
there are entries to be processed, which causes errors such as:

  "virtio: zero sized buffers are not allowed"

or

  "virtio-blk missing headers"

and puts the device in an error state.

This patch works around the issue by introducing virtio_set_disabled(),
which sets a 'disabled' flag to bypass checks like virtio_queue_empty()
when bus-mastering is disabled. Since we'd check this flag at all the
same sites as vdev->broken, we replace those checks with an inline
function which checks for either vdev->broken or vdev->disabled.

The 'disabled' flag is only migrated when set, which should be fairly
rare, but to maintain migration compatibility we disable it's use for
older machine types. Users requiring the use of the flag in conjunction
with older machine types can set it explicitly as a virtio-device
option.

NOTES:

 - This leaves some other oddities in play, like the fact that
   DRIVER_OK also gets unset in response to bus-mastering being
   disabled, but not restored (however the device seems to continue
   working)
 - Similarly, we disable the host notifier via
   virtio_bus_stop_ioeventfd(), which seems to move the handling out
   of virtio-blk dataplane and back into the main IO thread, and it
   ends up staying there till a reset (but otherwise continues working
   normally)

Cc: David Gibson <david@gibson.dropbear.id.au>,
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
v2:
 - add migration support and only default to using 'disabled' flag
   for newer machines via virtio-device compat option (MST)
 - use inline functions to decouple checks from specific fields (MST)
 - rebased on master
---
 hw/core/machine.c          |  1 +
 hw/virtio/virtio-pci.c     | 12 ++++++++----
 hw/virtio/virtio.c         | 35 ++++++++++++++++++++++++++++-------
 include/hw/virtio/virtio.h | 15 +++++++++++++++
 4 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1689ad3bf8..9f3073b23b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -29,6 +29,7 @@
 
 GlobalProperty hw_compat_4_1[] = {
     { "virtio-pci", "x-pcie-flr-init", "off" },
+    { "virtio-device", "use-disabled-flag", "false" },
 };
 const size_t hw_compat_4_1_len = G_N_ELEMENTS(hw_compat_4_1);
 
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index c6b47a9c73..394d409fb9 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -608,10 +608,14 @@ static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
         pcie_cap_flr_write_config(pci_dev, address, val, len);
     }
 
-    if (range_covers_byte(address, len, PCI_COMMAND) &&
-        !(pci_dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
-        virtio_pci_stop_ioeventfd(proxy);
-        virtio_set_status(vdev, vdev->status & ~VIRTIO_CONFIG_S_DRIVER_OK);
+    if (range_covers_byte(address, len, PCI_COMMAND)) {
+        if (!(pci_dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
+            virtio_set_disabled(vdev, true);
+            virtio_pci_stop_ioeventfd(proxy);
+            virtio_set_status(vdev, vdev->status & ~VIRTIO_CONFIG_S_DRIVER_OK);
+        } else {
+            virtio_set_disabled(vdev, false);
+        }
     }
 
     if (proxy->config_cap &&
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 04716b5f6c..3cb603a466 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -546,7 +546,7 @@ static inline bool is_desc_avail(uint16_t flags, bool wrap_counter)
  * Called within rcu_read_lock().  */
 static int virtio_queue_empty_rcu(VirtQueue *vq)
 {
-    if (unlikely(vq->vdev->broken)) {
+    if (virtio_device_disabled(vq->vdev)) {
         return 1;
     }
 
@@ -565,7 +565,7 @@ static int virtio_queue_split_empty(VirtQueue *vq)
 {
     bool empty;
 
-    if (unlikely(vq->vdev->broken)) {
+    if (virtio_device_disabled(vq->vdev)) {
         return 1;
     }
 
@@ -783,7 +783,7 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
 
     virtqueue_unmap_sg(vq, elem, len);
 
-    if (unlikely(vq->vdev->broken)) {
+    if (virtio_device_disabled(vq->vdev)) {
         return;
     }
 
@@ -839,7 +839,7 @@ static void virtqueue_packed_flush(VirtQueue *vq, unsigned int count)
 
 void virtqueue_flush(VirtQueue *vq, unsigned int count)
 {
-    if (unlikely(vq->vdev->broken)) {
+    if (virtio_device_disabled(vq->vdev)) {
         vq->inuse -= count;
         return;
     }
@@ -1602,7 +1602,7 @@ err_undo_map:
 
 void *virtqueue_pop(VirtQueue *vq, size_t sz)
 {
-    if (unlikely(vq->vdev->broken)) {
+    if (virtio_device_disabled(vq->vdev)) {
         return NULL;
     }
 
@@ -1698,7 +1698,7 @@ unsigned int virtqueue_drop_all(VirtQueue *vq)
 {
     struct VirtIODevice *vdev = vq->vdev;
 
-    if (unlikely(vdev->broken)) {
+    if (virtio_device_disabled(vq->vdev)) {
         return 0;
     }
 
@@ -1816,7 +1816,7 @@ static void virtio_notify_vector(VirtIODevice *vdev, uint16_t vector)
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
 
-    if (unlikely(vdev->broken)) {
+    if (virtio_device_disabled(vdev)) {
         return;
     }
 
@@ -1920,6 +1920,7 @@ void virtio_reset(void *opaque)
     vdev->guest_features = 0;
     vdev->queue_sel = 0;
     vdev->status = 0;
+    vdev->disabled = false;
     atomic_set(&vdev->isr, 0);
     vdev->config_vector = VIRTIO_NO_VECTOR;
     virtio_notify_vector(vdev, vdev->config_vector);
@@ -2553,6 +2554,13 @@ static bool virtio_started_needed(void *opaque)
     return vdev->started;
 }
 
+static bool virtio_disabled_needed(void *opaque)
+{
+    VirtIODevice *vdev = opaque;
+
+    return vdev->disabled;
+}
+
 static const VMStateDescription vmstate_virtqueue = {
     .name = "virtqueue_state",
     .version_id = 1,
@@ -2718,6 +2726,17 @@ static const VMStateDescription vmstate_virtio_started = {
     }
 };
 
+static const VMStateDescription vmstate_virtio_disabled = {
+    .name = "virtio/disabled",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = &virtio_disabled_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(disabled, VirtIODevice),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_virtio = {
     .name = "virtio",
     .version_id = 1,
@@ -2735,6 +2754,7 @@ static const VMStateDescription vmstate_virtio = {
         &vmstate_virtio_extra_state,
         &vmstate_virtio_started,
         &vmstate_virtio_packed_virtqueues,
+        &vmstate_virtio_disabled,
         NULL
     }
 };
@@ -3569,6 +3589,7 @@ static void virtio_device_instance_finalize(Object *obj)
 static Property virtio_properties[] = {
     DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
     DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
+    DEFINE_PROP_BOOL("use-disabled-flag", VirtIODevice, use_disabled_flag, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c32a815303..f23d2efbc0 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -100,6 +100,8 @@ struct VirtIODevice
     uint16_t device_id;
     bool vm_running;
     bool broken; /* device in invalid state, needs reset */
+    bool use_disabled_flag; /* allow use of 'disable' flag when needed */
+    bool disabled; /* device in temporarily disabled state */
     bool use_started;
     bool started;
     bool start_on_kick; /* when virtio 1.0 feature has not been negotiated */
@@ -378,4 +380,17 @@ static inline void virtio_set_started(VirtIODevice *vdev, bool started)
         vdev->started = started;
     }
 }
+
+static inline void virtio_set_disabled(VirtIODevice *vdev, bool disable)
+{
+    if (vdev->use_disabled_flag) {
+        vdev->disabled = disable;
+    }
+}
+
+static inline bool virtio_device_disabled(VirtIODevice *vdev)
+{
+    return unlikely(vdev->disabled || vdev->broken);
+}
+
 #endif
-- 
2.17.1


