Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A238AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D6C3208C7
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbUFpH+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6C3208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmGk3-0002mH-LP
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 09:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jmGjE-00022Z-Bj
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:06:44 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39834
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jmGjA-00017M-3Q
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592571999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pNzH+uDuq45cNJ5o0b0Qu5bZy+1keBG3Dyrw5KIKonw=;
 b=LbUFpH+PJ6nwPlgHhiC7RmMzChOlhyJjRjynAzQN2d+KXhMhtCoTEJx/QErNVaeAxmUoqo
 y81Nz+84B+VQrr4vAgwlBrFxxZbsw0amPc4QVLCS4N4R/Q1cm92bV1ld01XeIXSF/ouLuR
 +YtmCpB0GX96XD/YG4UBLQ6MyE8SUzI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-Wj8aj5O7N4a3adTEoqb2lg-1; Fri, 19 Jun 2020 09:06:34 -0400
X-MC-Unique: Wj8aj5O7N4a3adTEoqb2lg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1285464
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 13:06:33 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4930110013C4;
 Fri, 19 Jun 2020 13:06:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-headers: update to Linux 5.8-rc1
Date: Fri, 19 Jun 2020 09:06:32 -0400
Message-Id: <20200619130632.4369-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:45:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/standard-headers/linux/virtio_ids.h  |   1 +
 include/standard-headers/linux/virtio_ring.h |  48 ++-
 linux-headers/linux/vfio.h                   | 322 +++++++++++++++++++
 linux-headers/linux/vfio_ccw.h               |  19 ++
 linux-headers/linux/vhost.h                  |   4 +
 5 files changed, 384 insertions(+), 10 deletions(-)

diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
index ecc27a1740..b052355ac7 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -44,6 +44,7 @@
 #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
 #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
 #define VIRTIO_ID_IOMMU        23 /* virtio IOMMU */
+#define VIRTIO_ID_MEM          24 /* virtio mem */
 #define VIRTIO_ID_FS           26 /* virtio filesystem */
 #define VIRTIO_ID_PMEM         27 /* virtio pmem */
 #define VIRTIO_ID_MAC80211_HWSIM 29 /* virtio mac80211-hwsim */
diff --git a/include/standard-headers/linux/virtio_ring.h b/include/standard-headers/linux/virtio_ring.h
index f230fed479..0fa0e1067f 100644
--- a/include/standard-headers/linux/virtio_ring.h
+++ b/include/standard-headers/linux/virtio_ring.h
@@ -84,6 +84,13 @@
  * at the end of the used ring. Guest should ignore the used->flags field. */
 #define VIRTIO_RING_F_EVENT_IDX		29
 
+/* Alignment requirements for vring elements.
+ * When using pre-virtio 1.0 layout, these fall out naturally.
+ */
+#define VRING_AVAIL_ALIGN_SIZE 2
+#define VRING_USED_ALIGN_SIZE 4
+#define VRING_DESC_ALIGN_SIZE 16
+
 /* Virtio ring descriptors: 16 bytes.  These can chain together via "next". */
 struct vring_desc {
 	/* Address (guest-physical). */
@@ -110,28 +117,47 @@ struct vring_used_elem {
 	__virtio32 len;
 };
 
+typedef struct vring_used_elem __attribute__((aligned(VRING_USED_ALIGN_SIZE)))
+	vring_used_elem_t;
+
 struct vring_used {
 	__virtio16 flags;
 	__virtio16 idx;
-	struct vring_used_elem ring[];
+	vring_used_elem_t ring[];
 };
 
+/*
+ * The ring element addresses are passed between components with different
+ * alignments assumptions. Thus, we might need to decrease the compiler-selected
+ * alignment, and so must use a typedef to make sure the aligned attribute
+ * actually takes hold:
+ *
+ * https://gcc.gnu.org/onlinedocs//gcc/Common-Type-Attributes.html#Common-Type-Attributes
+ *
+ * When used on a struct, or struct member, the aligned attribute can only
+ * increase the alignment; in order to decrease it, the packed attribute must
+ * be specified as well. When used as part of a typedef, the aligned attribute
+ * can both increase and decrease alignment, and specifying the packed
+ * attribute generates a warning.
+ */
+typedef struct vring_desc __attribute__((aligned(VRING_DESC_ALIGN_SIZE)))
+	vring_desc_t;
+typedef struct vring_avail __attribute__((aligned(VRING_AVAIL_ALIGN_SIZE)))
+	vring_avail_t;
+typedef struct vring_used __attribute__((aligned(VRING_USED_ALIGN_SIZE)))
+	vring_used_t;
+
 struct vring {
 	unsigned int num;
 
-	struct vring_desc *desc;
+	vring_desc_t *desc;
 
-	struct vring_avail *avail;
+	vring_avail_t *avail;
 
-	struct vring_used *used;
+	vring_used_t *used;
 };
 
-/* Alignment requirements for vring elements.
- * When using pre-virtio 1.0 layout, these fall out naturally.
- */
-#define VRING_AVAIL_ALIGN_SIZE 2
-#define VRING_USED_ALIGN_SIZE 4
-#define VRING_DESC_ALIGN_SIZE 16
+#ifndef VIRTIO_RING_NO_LEGACY
 
 /* The standard layout for the ring is a continuous chunk of memory which looks
  * like this.  We assume num is a power of 2.
@@ -179,6 +205,8 @@ static inline unsigned vring_size(unsigned int num, unsigned long align)
 		+ sizeof(__virtio16) * 3 + sizeof(struct vring_used_elem) * num;
 }
 
+#endif /* VIRTIO_RING_NO_LEGACY */
+
 /* The following is used with USED_EVENT_IDX and AVAIL_EVENT_IDX */
 /* Assuming a given event_idx value from the other side, if
  * we have just incremented index from old to new_idx,
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index a41c452865..f09df262c4 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -305,6 +305,7 @@ struct vfio_region_info_cap_type {
 #define VFIO_REGION_TYPE_PCI_VENDOR_MASK	(0xffff)
 #define VFIO_REGION_TYPE_GFX                    (1)
 #define VFIO_REGION_TYPE_CCW			(2)
+#define VFIO_REGION_TYPE_MIGRATION              (3)
 
 /* sub-types for VFIO_REGION_TYPE_PCI_* */
 
@@ -378,6 +379,235 @@ struct vfio_region_gfx_edid {
 
 /* sub-types for VFIO_REGION_TYPE_CCW */
 #define VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD	(1)
+#define VFIO_REGION_SUBTYPE_CCW_SCHIB		(2)
+#define VFIO_REGION_SUBTYPE_CCW_CRW		(3)
+
+/* sub-types for VFIO_REGION_TYPE_MIGRATION */
+#define VFIO_REGION_SUBTYPE_MIGRATION           (1)
+
+/*
+ * The structure vfio_device_migration_info is placed at the 0th offset of
+ * the VFIO_REGION_SUBTYPE_MIGRATION region to get and set VFIO device related
+ * migration information. Field accesses from this structure are only supported
+ * at their native width and alignment. Otherwise, the result is undefined and
+ * vendor drivers should return an error.
+ *
+ * device_state: (read/write)
+ *      - The user application writes to this field to inform the vendor driver
+ *        about the device state to be transitioned to.
+ *      - The vendor driver should take the necessary actions to change the
+ *        device state. After successful transition to a given state, the
+ *        vendor driver should return success on write(device_state, state)
+ *        system call. If the device state transition fails, the vendor driver
+ *        should return an appropriate -errno for the fault condition.
+ *      - On the user application side, if the device state transition fails,
+ *	  that is, if write(device_state, state) returns an error, read
+ *	  device_state again to determine the current state of the device from
+ *	  the vendor driver.
+ *      - The vendor driver should return previous state of the device unless
+ *        the vendor driver has encountered an internal error, in which case
+ *        the vendor driver may report the device_state VFIO_DEVICE_STATE_ERROR.
+ *      - The user application must use the device reset ioctl to recover the
+ *        device from VFIO_DEVICE_STATE_ERROR state. If the device is
+ *        indicated to be in a valid device state by reading device_state, the
+ *        user application may attempt to transition the device to any valid
+ *        state reachable from the current state or terminate itself.
+ *
+ *      device_state consists of 3 bits:
+ *      - If bit 0 is set, it indicates the _RUNNING state. If bit 0 is clear,
+ *        it indicates the _STOP state. When the device state is changed to
+ *        _STOP, driver should stop the device before write() returns.
+ *      - If bit 1 is set, it indicates the _SAVING state, which means that the
+ *        driver should start gathering device state information that will be
+ *        provided to the VFIO user application to save the device's state.
+ *      - If bit 2 is set, it indicates the _RESUMING state, which means that
+ *        the driver should prepare to resume the device. Data provided through
+ *        the migration region should be used to resume the device.
+ *      Bits 3 - 31 are reserved for future use. To preserve them, the user
+ *      application should perform a read-modify-write operation on this
+ *      field when modifying the specified bits.
+ *
+ *  +------- _RESUMING
+ *  |+------ _SAVING
+ *  ||+----- _RUNNING
+ *  |||
+ *  000b => Device Stopped, not saving or resuming
+ *  001b => Device running, which is the default state
+ *  010b => Stop the device & save the device state, stop-and-copy state
+ *  011b => Device running and save the device state, pre-copy state
+ *  100b => Device stopped and the device state is resuming
+ *  101b => Invalid state
+ *  110b => Error state
+ *  111b => Invalid state
+ *
+ * State transitions:
+ *
+ *              _RESUMING  _RUNNING    Pre-copy    Stop-and-copy   _STOP
+ *                (100b)     (001b)     (011b)        (010b)       (000b)
+ * 0. Running or default state
+ *                             |
+ *
+ * 1. Normal Shutdown (optional)
+ *                             |------------------------------------->|
+ *
+ * 2. Save the state or suspend
+ *                             |------------------------->|---------->|
+ *
+ * 3. Save the state during live migration
+ *                             |----------->|------------>|---------->|
+ *
+ * 4. Resuming
+ *                  |<---------|
+ *
+ * 5. Resumed
+ *                  |--------->|
+ *
+ * 0. Default state of VFIO device is _RUNNNG when the user application starts.
+ * 1. During normal shutdown of the user application, the user application may
+ *    optionally change the VFIO device state from _RUNNING to _STOP. This
+ *    transition is optional. The vendor driver must support this transition but
+ *    must not require it.
+ * 2. When the user application saves state or suspends the application, the
+ *    device state transitions from _RUNNING to stop-and-copy and then to _STOP.
+ *    On state transition from _RUNNING to stop-and-copy, driver must stop the
+ *    device, save the device state and send it to the application through the
+ *    migration region. The sequence to be followed for such transition is given
+ *    below.
+ * 3. In live migration of user application, the state transitions from _RUNNING
+ *    to pre-copy, to stop-and-copy, and to _STOP.
+ *    On state transition from _RUNNING to pre-copy, the driver should start
+ *    gathering the device state while the application is still running and send
+ *    the device state data to application through the migration region.
+ *    On state transition from pre-copy to stop-and-copy, the driver must stop
+ *    the device, save the device state and send it to the user application
+ *    through the migration region.
+ *    Vendor drivers must support the pre-copy state even for implementations
+ *    where no data is provided to the user before the stop-and-copy state. The
+ *    user must not be required to consume all migration data before the device
+ *    transitions to a new state, including the stop-and-copy state.
+ *    The sequence to be followed for above two transitions is given below.
+ * 4. To start the resuming phase, the device state should be transitioned from
+ *    the _RUNNING to the _RESUMING state.
+ *    In the _RESUMING state, the driver should use the device state data
+ *    received through the migration region to resume the device.
+ * 5. After providing saved device data to the driver, the application should
+ *    change the state from _RESUMING to _RUNNING.
+ *
+ * reserved:
+ *      Reads on this field return zero and writes are ignored.
+ *
+ * pending_bytes: (read only)
+ *      The number of pending bytes still to be migrated from the vendor driver.
+ *
+ * data_offset: (read only)
+ *      The user application should read data_offset field from the migration
+ *      region. The user application should read the device data from this
+ *      offset within the migration region during the _SAVING state or write
+ *      the device data during the _RESUMING state. See below for details of
+ *      sequence to be followed.
+ *
+ * data_size: (read/write)
+ *      The user application should read data_size to get the size in bytes of
+ *      the data copied in the migration region during the _SAVING state and
+ *      write the size in bytes of the data copied in the migration region
+ *      during the _RESUMING state.
+ *
+ * The format of the migration region is as follows:
+ *  ------------------------------------------------------------------
+ * |vfio_device_migration_info|    data section                      |
+ * |                          |     ///////////////////////////////  |
+ * ------------------------------------------------------------------
+ *   ^                              ^
+ *  offset 0-trapped part        data_offset
+ *
+ * The structure vfio_device_migration_info is always followed by the data
+ * section in the region, so data_offset will always be nonzero. The offset
+ * from where the data is copied is decided by the kernel driver. The data
+ * section can be trapped, mmapped, or partitioned, depending on how the kernel
+ * driver defines the data section. The data section partition can be defined
+ * as mapped by the sparse mmap capability. If mmapped, data_offset must be
+ * page aligned, whereas initial section which contains the
+ * vfio_device_migration_info structure, might not end at the offset, which is
+ * page aligned. The user is not required to access through mmap regardless
+ * of the capabilities of the region mmap.
+ * The vendor driver should determine whether and how to partition the data
+ * section. The vendor driver should return data_offset accordingly.
+ *
+ * The sequence to be followed while in pre-copy state and stop-and-copy state
+ * is as follows:
+ * a. Read pending_bytes, indicating the start of a new iteration to get device
+ *    data. Repeated read on pending_bytes at this stage should have no side
+ *    effects.
+ *    If pending_bytes == 0, the user application should not iterate to get data
+ *    for that device.
+ *    If pending_bytes > 0, perform the following steps.
+ * b. Read data_offset, indicating that the vendor driver should make data
+ *    available through the data section. The vendor driver should return this
+ *    read operation only after data is available from (region + data_offset)
+ *    to (region + data_offset + data_size).
+ * c. Read data_size, which is the amount of data in bytes available through
+ *    the migration region.
+ *    Read on data_offset and data_size should return the offset and size of
+ *    the current buffer if the user application reads data_offset and
+ *    data_size more than once here.
+ * d. Read data_size bytes of data from (region + data_offset) from the
+ *    migration region.
+ * e. Process the data.
+ * f. Read pending_bytes, which indicates that the data from the previous
+ *    iteration has been read. If pending_bytes > 0, go to step b.
+ *
+ * The user application can transition from the _SAVING|_RUNNING
+ * (pre-copy state) to the _SAVING (stop-and-copy) state regardless of the
+ * number of pending bytes. The user application should iterate in _SAVING
+ * (stop-and-copy) until pending_bytes is 0.
+ *
+ * The sequence to be followed while _RESUMING device state is as follows:
+ * While data for this device is available, repeat the following steps:
+ * a. Read data_offset from where the user application should write data.
+ * b. Write migration data starting at the migration region + data_offset for
+ *    the length determined by data_size from the migration source.
+ * c. Write data_size, which indicates to the vendor driver that data is
+ *    written in the migration region. Vendor driver must return this write
+ *    operations on consuming data. Vendor driver should apply the
+ *    user-provided migration region data to the device resume state.
+ *
+ * If an error occurs during the above sequences, the vendor driver can return
+ * an error code for next read() or write() operation, which will terminate the
+ * loop. The user application should then take the next necessary action, for
+ * example, failing migration or terminating the user application.
+ *
+ * For the user application, data is opaque. The user application should write
+ * data in the same order as the data is received and the data should be of
+ * same transaction size at the source.
+ */
+
+struct vfio_device_migration_info {
+	__u32 device_state;         /* VFIO device state */
+#define VFIO_DEVICE_STATE_STOP      (0)
+#define VFIO_DEVICE_STATE_RUNNING   (1 << 0)
+#define VFIO_DEVICE_STATE_SAVING    (1 << 1)
+#define VFIO_DEVICE_STATE_RESUMING  (1 << 2)
+#define VFIO_DEVICE_STATE_MASK      (VFIO_DEVICE_STATE_RUNNING | \
+				     VFIO_DEVICE_STATE_SAVING |  \
+				     VFIO_DEVICE_STATE_RESUMING)
+
+#define VFIO_DEVICE_STATE_VALID(state) \
+	(state & VFIO_DEVICE_STATE_RESUMING ? \
+	(state & VFIO_DEVICE_STATE_MASK) == VFIO_DEVICE_STATE_RESUMING : 1)
+
+#define VFIO_DEVICE_STATE_IS_ERROR(state) \
+	((state & VFIO_DEVICE_STATE_MASK) == (VFIO_DEVICE_STATE_SAVING | \
+					      VFIO_DEVICE_STATE_RESUMING))
+
+#define VFIO_DEVICE_STATE_SET_ERROR(state) \
+	((state & ~VFIO_DEVICE_STATE_MASK) | VFIO_DEVICE_SATE_SAVING | \
+					     VFIO_DEVICE_STATE_RESUMING)
+
+	__u32 reserved;
+	__u64 pending_bytes;
+	__u64 data_offset;
+	__u64 data_size;
+};
 
 /*
  * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
@@ -577,6 +807,7 @@ enum {
 
 enum {
 	VFIO_CCW_IO_IRQ_INDEX,
+	VFIO_CCW_CRW_IRQ_INDEX,
 	VFIO_CCW_NUM_IRQS
 };
 
@@ -785,6 +1016,29 @@ struct vfio_iommu_type1_info_cap_iova_range {
 	struct	vfio_iova_range iova_ranges[];
 };
 
+/*
+ * The migration capability allows to report supported features for migration.
+ *
+ * The structures below define version 1 of this capability.
+ *
+ * The existence of this capability indicates that IOMMU kernel driver supports
+ * dirty page logging.
+ *
+ * pgsize_bitmap: Kernel driver returns bitmap of supported page sizes for dirty
+ * page logging.
+ * max_dirty_bitmap_size: Kernel driver returns maximum supported dirty bitmap
+ * size in bytes that can be used by user applications when getting the dirty
+ * bitmap.
+ */
+#define VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION  1
+
+struct vfio_iommu_type1_info_cap_migration {
+	struct	vfio_info_cap_header header;
+	__u32	flags;
+	__u64	pgsize_bitmap;
+	__u64	max_dirty_bitmap_size;		/* in bytes */
+};
+
 #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
 
 /**
@@ -805,6 +1059,12 @@ struct vfio_iommu_type1_dma_map {
 
 #define VFIO_IOMMU_MAP_DMA _IO(VFIO_TYPE, VFIO_BASE + 13)
 
+struct vfio_bitmap {
+	__u64        pgsize;	/* page size for bitmap in bytes */
+	__u64        size;	/* in bytes */
+	__u64 *data;	/* one bit per page */
+};
+
 /**
  * VFIO_IOMMU_UNMAP_DMA - _IOWR(VFIO_TYPE, VFIO_BASE + 14,
  *							struct vfio_dma_unmap)
@@ -814,12 +1074,23 @@ struct vfio_iommu_type1_dma_map {
  * field.  No guarantee is made to the user that arbitrary unmaps of iova
  * or size different from those used in the original mapping call will
  * succeed.
+ * VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP should be set to get the dirty bitmap
+ * before unmapping IO virtual addresses. When this flag is set, the user must
+ * provide a struct vfio_bitmap in data[]. User must provide zero-allocated
+ * memory via vfio_bitmap.data and its size in the vfio_bitmap.size field.
+ * A bit in the bitmap represents one page, of user provided page size in
+ * vfio_bitmap.pgsize field, consecutively starting from iova offset. Bit set
+ * indicates that the page at that offset from iova is dirty. A Bitmap of the
+ * pages in the range of unmapped size is returned in the user-provided
+ * vfio_bitmap.data.
  */
 struct vfio_iommu_type1_dma_unmap {
 	__u32	argsz;
 	__u32	flags;
+#define VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP (1 << 0)
 	__u64	iova;				/* IO virtual address */
 	__u64	size;				/* Size of mapping (bytes) */
+	__u8    data[];
 };
 
 #define VFIO_IOMMU_UNMAP_DMA _IO(VFIO_TYPE, VFIO_BASE + 14)
@@ -831,6 +1102,57 @@ struct vfio_iommu_type1_dma_unmap {
 #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
 #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
 
+/**
+ * VFIO_IOMMU_DIRTY_PAGES - _IOWR(VFIO_TYPE, VFIO_BASE + 17,
+ *                                     struct vfio_iommu_type1_dirty_bitmap)
+ * IOCTL is used for dirty pages logging.
+ * Caller should set flag depending on which operation to perform, details as
+ * below:
+ *
+ * Calling the IOCTL with VFIO_IOMMU_DIRTY_PAGES_FLAG_START flag set, instructs
+ * the IOMMU driver to log pages that are dirtied or potentially dirtied by
+ * the device; designed to be used when a migration is in progress. Dirty pages
+ * are logged until logging is disabled by user application by calling the IOCTL
+ * with VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP flag.
+ *
+ * Calling the IOCTL with VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP flag set, instructs
+ * the IOMMU driver to stop logging dirtied pages.
+ *
+ * Calling the IOCTL with VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP flag set
+ * returns the dirty pages bitmap for IOMMU container for a given IOVA range.
+ * The user must specify the IOVA range and the pgsize through the structure
+ * vfio_iommu_type1_dirty_bitmap_get in the data[] portion. This interface
+ * supports getting a bitmap of the smallest supported pgsize only and can be
+ * modified in future to get a bitmap of any specified supported pgsize. The
+ * user must provide a zeroed memory area for the bitmap memory and specify its
+ * size in bitmap.size. One bit is used to represent one page consecutively
+ * starting from iova offset. The user should provide page size in bitmap.pgsize
+ * field. A bit set in the bitmap indicates that the page at that offset from
+ * iova is dirty. The caller must set argsz to a value including the size of
+ * structure vfio_iommu_type1_dirty_bitmap_get, but excluding the size of the
+ * actual bitmap. If dirty pages logging is not enabled, an error will be
+ * returned.
+ *
+ * Only one of the flags _START, _STOP and _GET may be specified at a time.
+ *
+ */
+struct vfio_iommu_type1_dirty_bitmap {
+	__u32        argsz;
+	__u32        flags;
+#define VFIO_IOMMU_DIRTY_PAGES_FLAG_START	(1 << 0)
+#define VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP	(1 << 1)
+#define VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP	(1 << 2)
+	__u8         data[];
+};
+
+struct vfio_iommu_type1_dirty_bitmap_get {
+	__u64              iova;	/* IO virtual address */
+	__u64              size;	/* Size of iova range */
+	struct vfio_bitmap bitmap;
+};
+
+#define VFIO_IOMMU_DIRTY_PAGES             _IO(VFIO_TYPE, VFIO_BASE + 17)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
 /*
diff --git a/linux-headers/linux/vfio_ccw.h b/linux-headers/linux/vfio_ccw.h
index fcc3e69ef5..516496f1d4 100644
--- a/linux-headers/linux/vfio_ccw.h
+++ b/linux-headers/linux/vfio_ccw.h
@@ -34,4 +34,23 @@ struct ccw_cmd_region {
 	__u32 ret_code;
 } __attribute__((packed));
 
+/*
+ * Used for processing commands that read the subchannel-information block
+ * Reading this region triggers a stsch() to hardware
+ * Note: this is controlled by a capability
+ */
+struct ccw_schib_region {
+#define SCHIB_AREA_SIZE 52
+	__u8 schib_area[SCHIB_AREA_SIZE];
+} __attribute__((packed));
+
+/*
+ * Used for returning a Channel Report Word to userspace.
+ * Note: this is controlled by a capability
+ */
+struct ccw_crw_region {
+	__u32 crw;
+	__u32 pad;
+} __attribute__((packed));
+
 #endif
diff --git a/linux-headers/linux/vhost.h b/linux-headers/linux/vhost.h
index 9fe72e4b13..0c2349612e 100644
--- a/linux-headers/linux/vhost.h
+++ b/linux-headers/linux/vhost.h
@@ -15,6 +15,8 @@
 #include <linux/types.h>
 #include <linux/ioctl.h>
 
+#define VHOST_FILE_UNBIND -1
+
 /* ioctls */
 
 #define VHOST_VIRTIO 0xAF
@@ -140,4 +142,6 @@
 /* Get the max ring size. */
 #define VHOST_VDPA_GET_VRING_NUM	_IOR(VHOST_VIRTIO, 0x76, __u16)
 
+/* Set event fd for config interrupt*/
+#define VHOST_VDPA_SET_CONFIG_CALL	_IOW(VHOST_VIRTIO, 0x77, int)
 #endif
-- 
2.26.2


