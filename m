Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF52BC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 21:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98C9420719
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 21:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="L2xxkFx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C9420719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGrLA-0006oI-M1
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 17:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1jGrK1-0005Fy-FE
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1jGrJy-0004UE-QD
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:42:53 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6083)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1jGrJy-0004U2-I7
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:42:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e7a7ecb0000>; Tue, 24 Mar 2020 14:42:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 24 Mar 2020 14:42:49 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 24 Mar 2020 14:42:49 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 24 Mar
 2020 21:42:48 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 24 Mar 2020 21:42:42 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v16 QEMU 01/16] vfio: KABI for migration interface - Kernel
 header placeholder
Date: Wed, 25 Mar 2020 02:38:59 +0530
Message-ID: <1585084154-29461-2-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1585086156; bh=c3Rwhkunyga+sbGbUgiT6GLjdLh9EeLpvB5+CxEaL8k=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=L2xxkFx+OFlVY99Y+hm85OyTWhc3JSIVU57a8kiXGvb2dKkwAPoIs7c6B3DMqu1mH
 ZbD18NPaqh3x2Nc4wrXapJWrJJxeCoAIxRiewU9cY/q4sy4D6vUjzNesW2I1Lhzfoo
 RE2ws/5e4E0BZF1XWd2KXH5gM5rrZh5vtGxgA9l1nLX6XmmRWEnUotqyYq3ZVN6Dbs
 1RfDjMGwl44xk8/O2aJxaa84hOigq9O8NzB+s5ZjJej8aq24SyE8++EGBxJb8jLjx2
 63sCWmfszo7U5h/YHlOEgE26q6R7hyPyuE+CFmKnonSgEfzs9Qpqefo3Q9Zj/R6TU0
 hyBQ4dhufKYrg==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.65
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yan.y.zhao@intel.com, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, Kirti Wankhede <kwankhede@nvidia.com>,
 eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com,
 changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kernel header patches are being reviewed along with kernel side changes.
This patch is only for place holder.
Link to Kernel patch set:
https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg07429.html

This patch include all changes in vfio.h from above patch set

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 linux-headers/linux/vfio.h | 297 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 295 insertions(+), 2 deletions(-)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index fb10370d2928..78cadee85ac6 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -305,6 +305,7 @@ struct vfio_region_info_cap_type {
 #define VFIO_REGION_TYPE_PCI_VENDOR_MASK	(0xffff)
 #define VFIO_REGION_TYPE_GFX                    (1)
 #define VFIO_REGION_TYPE_CCW			(2)
+#define VFIO_REGION_TYPE_MIGRATION              (3)
 
 /* sub-types for VFIO_REGION_TYPE_PCI_* */
 
@@ -379,6 +380,232 @@ struct vfio_region_gfx_edid {
 /* sub-types for VFIO_REGION_TYPE_CCW */
 #define VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD	(1)
 
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
+ *      The user application should read data_offset in the migration region
+ *      from where the user application should read the device data during the
+ *      _SAVING state or write the device data during the _RESUMING state. See
+ *      below for details of sequence to be followed.
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
+ * section can be trapped, mapped, or partitioned, depending on how the kernel
+ * driver defines the data section. The data section partition can be defined
+ * as mapped by the sparse mmap capability. If mmapped, data_offset should be
+ * page aligned, whereas initial section which contains the
+ * vfio_device_migration_info structure, might not end at the offset, which is
+ * page aligned. The user is not required to access through mmap regardless
+ * of the capabilities of the region mmap.
+ * The vendor driver should determine whether and how to partition the data
+ * section. The vendor driver should return data_offset accordingly.
+ *
+ * The sequence to be followed for the _SAVING|_RUNNING device state or
+ * pre-copy phase and for the _SAVING device state or stop-and-copy phase is as
+ * follows:
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
+ * If an error occurs during the above sequence, the vendor driver can return
+ * an error code for next read() or write() operation, which will terminate the
+ * loop. The user application should then take the next necessary action, for
+ * example, failing migration or terminating the user application.
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
+ *    written in the migration region. Vendor driver should apply the
+ *    user-provided migration region data to the device resume state.
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
+} __attribute__((packed));
+
 /*
  * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
  * which allows direct access to non-MSIX registers which happened to be within
@@ -720,8 +947,9 @@ struct vfio_device_ioeventfd {
 struct vfio_iommu_type1_info {
 	__u32	argsz;
 	__u32	flags;
-#define VFIO_IOMMU_INFO_PGSIZES (1 << 0)	/* supported page sizes info */
-#define VFIO_IOMMU_INFO_CAPS	(1 << 1)	/* Info supports caps */
+#define VFIO_IOMMU_INFO_PGSIZES   (1 << 0) /* supported page sizes info */
+#define VFIO_IOMMU_INFO_CAPS      (1 << 1) /* Info supports caps */
+#define VFIO_IOMMU_INFO_DIRTY_PGS (1 << 2) /* supports dirty page tracking */
 	__u64	iova_pgsizes;	/* Bitmap of supported page sizes */
 	__u32   cap_offset;	/* Offset within info struct of first cap */
 };
@@ -768,6 +996,12 @@ struct vfio_iommu_type1_dma_map {
 
 #define VFIO_IOMMU_MAP_DMA _IO(VFIO_TYPE, VFIO_BASE + 13)
 
+struct vfio_bitmap {
+    __u64        pgsize;           /* page size for bitmap */
+    __u64        size;             /* in bytes */
+    __u64        *data;     /* one bit per page */
+};
+
 /**
  * VFIO_IOMMU_UNMAP_DMA - _IOWR(VFIO_TYPE, VFIO_BASE + 14,
  *							struct vfio_dma_unmap)
@@ -777,12 +1011,23 @@ struct vfio_iommu_type1_dma_map {
  * field.  No guarantee is made to the user that arbitrary unmaps of iova
  * or size different from those used in the original mapping call will
  * succeed.
+ * VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP should be set to get dirty bitmap
+ * before unmapping IO virtual addresses. When this flag is set, user must
+ * provide data[] as structure vfio_bitmap. User must allocate memory to get
+ * bitmap, clear the bitmap memory by setting zero and must set size of
+ * allocated memory in vfio_bitmap.size field. One bit in bitmap
+ * represents per page, page of user provided page size in 'pgsize',
+ * consecutively starting from iova offset. Bit set indicates page at that
+ * offset from iova is dirty. Bitmap of pages in the range of unmapped size is
+ * returned in vfio_bitmap.data
  */
 struct vfio_iommu_type1_dma_unmap {
 	__u32	argsz;
 	__u32	flags;
+#define VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP (1 << 0)
 	__u64	iova;				/* IO virtual address */
 	__u64	size;				/* Size of mapping (bytes) */
+        __u8    data[];
 };
 
 #define VFIO_IOMMU_UNMAP_DMA _IO(VFIO_TYPE, VFIO_BASE + 14)
@@ -794,6 +1039,54 @@ struct vfio_iommu_type1_dma_unmap {
 #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
 #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
 
+/**
+ * VFIO_IOMMU_DIRTY_PAGES - _IOWR(VFIO_TYPE, VFIO_BASE + 17,
+ *                                     struct vfio_iommu_type1_dirty_bitmap)
+ * IOCTL is used for dirty pages tracking. Caller sets argsz, which is size of
+ * struct vfio_iommu_type1_dirty_bitmap. Caller set flag depend on which
+ * operation to perform, details as below:
+ *
+ * When IOCTL is called with VFIO_IOMMU_DIRTY_PAGES_FLAG_START set, indicates
+ * migration is active and IOMMU module should track pages which are pinned and
+ * could be dirtied by device.
+ * Dirty pages are tracked until tracking is stopped by user application by
+ * setting VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP flag.
+ *
+ * When IOCTL is called with VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP set, indicates
+ * IOMMU should stop tracking pinned pages.
+ *
+ * When IOCTL is called with VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP flag set,
+ * IOCTL returns dirty pages bitmap for IOMMU container during migration for
+ * given IOVA range. User must provide data[] as the structure
+ * vfio_iommu_type1_dirty_bitmap_get through which user provides IOVA range and
+ * pgsize. This interface supports to get bitmap of smallest supported pgsize
+ * only and can be modified in future to get bitmap of specified pgsize.
+ * User must allocate memory for bitmap, zero the bitmap memory and set size
+ * of allocated memory in bitmap_size field. One bit is used to represent one
+ * page consecutively starting from iova offset. User should provide page size
+ * in 'pgsize'. Bit set in bitmap indicates page at that offset from iova is
+ * dirty. Caller must set argsz including size of structure
+ * vfio_iommu_type1_dirty_bitmap_get.
+ *
+ * Only one flag should be set at a time.
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
+    __u64              iova;	/* IO virtual address */
+    __u64              size;	/* Size of iova range */
+    struct vfio_bitmap bitmap;
+};
+
+#define VFIO_IOMMU_DIRTY_PAGES             _IO(VFIO_TYPE, VFIO_BASE + 17)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
 /*
-- 
2.7.0


