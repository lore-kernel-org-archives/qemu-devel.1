Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575A7C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 09:53:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15C782080C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 09:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aEhNpJRe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C782080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkmoH-0004g4-Ce
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 05:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49821)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwankhede@nvidia.com>) id 1hkmn6-0003Nj-E5
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:52:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1hkmn4-0003zD-JA
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:52:04 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10295)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1hkmn4-0003yW-8m
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:52:02 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d2463bf0000>; Tue, 09 Jul 2019 02:51:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 09 Jul 2019 02:52:01 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 09 Jul 2019 02:52:01 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Jul
 2019 09:52:00 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 9 Jul 2019 09:51:54 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Date: Tue, 9 Jul 2019 15:19:08 +0530
Message-ID: <1562665760-26158-2-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1562665760-26158-1-git-send-email-kwankhede@nvidia.com>
References: <1562665760-26158-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1562665919; bh=gmFkRUjnMPn0H+3vl9QKit/mJp2xO4oax1Qjt+/ao9s=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=aEhNpJRep4chRMESRUSFfeVM/mGuUFPzIx8WGrnonRroh+/T3E2W95SFlgzhaHRhQ
 vqAsMNq2YAG6MDHP2d5cEoyJGhsNUaLcKlVacWEPwdW0gmchg8mlWGMXtdZgkSmD/W
 FtcTHtaCpsmSpmJ5yzJG1790l2T8SlE9bIaBC/RIFKfaqKs2NZCCdcjiqyKnFg1n+8
 mGFrWV7NapOm3WRhzpkuH6fb9g9j8e+g+42l5wncBaCXpL2dO7O9zMm/THpZwzDlA4
 Mfi2O2Ppi3AT7uWvBmjqzn2C6GMO1hM5YiVPeWCXC1U9wT94SZYduy4pmOQRiR954g
 bSCikbygXk4xw==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.65
Subject: [Qemu-devel] [PATCH v7 01/13] vfio: KABI for migration interface
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

- Defined MIGRATION region type and sub-type.
- Used 3 bits to define VFIO device states.
    Bit 0 => _RUNNING
    Bit 1 => _SAVING
    Bit 2 => _RESUMING
    Combination of these bits defines VFIO device's state during migration
    _STOPPED => All bits 0 indicates VFIO device stopped.
    _RUNNING => Normal VFIO device running state.
    _SAVING | _RUNNING => vCPUs are running, VFIO device is running but start
                          saving state of device i.e. pre-copy state
    _SAVING  => vCPUs are stoppped, VFIO device should be stopped, and
                          save device state,i.e. stop-n-copy state
    _RESUMING => VFIO device resuming state.
    _SAVING | _RESUMING => Invalid state if _SAVING and _RESUMING bits are set
- Defined vfio_device_migration_info structure which will be placed at 0th
  offset of migration region to get/set VFIO device related information.
  Defined members of structure and usage on read/write access:
    * device_state: (read/write)
        To convey VFIO device state to be transitioned to. Only 3 bits are used
        as of now.
    * pending bytes: (read only)
        To get pending bytes yet to be migrated for VFIO device.
    * data_offset: (read only)
        To get data offset in migration from where data exist during _SAVING
        and from where data should be written by user space application during
         _RESUMING state
    * data_size: (read/write)
        To get and set size of data copied in migration region during _SAVING
        and _RESUMING state.
    * start_pfn, page_size, total_pfns: (write only)
        To get bitmap of dirty pages from vendor driver from given
        start address for total_pfns.
    * copied_pfns: (read only)
        To get number of pfns bitmap copied in migration region.
        Vendor driver should copy the bitmap with bits set only for
        pages to be marked dirty in migration region. Vendor driver
        should return 0 if there are 0 pages dirty in requested
        range. Vendor driver should return -1 to mark all pages in the section
        as dirty

Migration region looks like:
 ------------------------------------------------------------------
|vfio_device_migration_info|    data section                      |
|                          |     ///////////////////////////////  |
 ------------------------------------------------------------------
 ^                              ^                              ^
 offset 0-trapped part        data_offset                 data_size

Data section is always followed by vfio_device_migration_info
structure in the region, so data_offset will always be none-0.
Offset from where data is copied is decided by kernel driver, data
section can be trapped or mapped depending on how kernel driver
defines data section. If mmapped, then data_offset should be page
aligned, where as initial section which contain
vfio_device_migration_info structure might not end at offset which
is page aligned.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 linux-headers/linux/vfio.h | 166 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 24f505199f83..6696a4600545 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -372,6 +372,172 @@ struct vfio_region_gfx_edid {
  */
 #define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
 
+/* Migration region type and sub-type */
+#define VFIO_REGION_TYPE_MIGRATION	        (2)
+#define VFIO_REGION_SUBTYPE_MIGRATION	        (1)
+
+/**
+ * Structure vfio_device_migration_info is placed at 0th offset of
+ * VFIO_REGION_SUBTYPE_MIGRATION region to get/set VFIO device related migration
+ * information. Field accesses from this structure are only supported at their
+ * native width and alignment, otherwise should return error.
+ *
+ * device_state: (read/write)
+ *      To indicate vendor driver the state VFIO device should be transitioned
+ *      to. If device state transition fails, write on this field return error.
+ *      It consists of 3 bits:
+ *      - If bit 0 set, indicates _RUNNING state. When its reset, that indicates
+ *        _STOPPED state. When device is changed to _STOPPED, driver should stop
+ *        device before write() returns.
+ *      - If bit 1 set, indicates _SAVING state.
+ *      - If bit 2 set, indicates _RESUMING state.
+ *      _SAVING and _RESUMING set at the same time is invalid state.
+ *
+ * pending bytes: (read only)
+ *      Number of pending bytes yet to be migrated from vendor driver
+ *
+ * data_offset: (read only)
+ *      User application should read data_offset in migration region from where
+ *      user application should read device data during _SAVING state or write
+ *      device data during _RESUMING state or read dirty pages bitmap. See below
+ *      for detail of sequence to be followed.
+ *
+ * data_size: (read/write)
+ *      User application should read data_size to get size of data copied in
+ *      migration region during _SAVING state and write size of data copied in
+ *      migration region during _RESUMING state.
+ *
+ * start_pfn: (write only)
+ *      Start address pfn to get bitmap of dirty pages from vendor driver duing
+ *      _SAVING state.
+ *
+ * page_size: (write only)
+ *      User application should write the page_size of pfn.
+ *
+ * total_pfns: (write only)
+ *      Total pfn count from start_pfn for which dirty bitmap is requested.
+ *
+ * copied_pfns: (read only)
+ *      pfn count for which dirty bitmap is copied to migration region.
+ *      Vendor driver should copy the bitmap with bits set only for pages to be
+ *      marked dirty in migration region.
+ *      - Vendor driver should return VFIO_DEVICE_DIRTY_PFNS_NONE if none of the
+ *        pages are dirty in requested range or rest of the range.
+ *      - Vendor driver should return VFIO_DEVICE_DIRTY_PFNS_ALL to mark all
+ *        pages dirty in the given section.
+ *      - Vendor driver should return pfn count for which bitmap is written in
+ *        the region.
+ *
+ * Migration region looks like:
+ *  ------------------------------------------------------------------
+ * |vfio_device_migration_info|    data section                      |
+ * |                          |     ///////////////////////////////  |
+ * ------------------------------------------------------------------
+ *   ^                              ^                              ^
+ *  offset 0-trapped part        data_offset                 data_size
+ *
+ * Data section is always followed by vfio_device_migration_info structure
+ * in the region, so data_offset will always be none-0. Offset from where data
+ * is copied is decided by kernel driver, data section can be trapped or
+ * mapped depending on how kernel driver defines data section. If mmapped,
+ * then data_offset should be page aligned, where as initial section which
+ * contain vfio_device_migration_info structure might not end at offset which
+ * is page aligned.
+ * Data_offset can be same or different for device data and dirty page bitmap.
+ * Vendor driver should decide whether to partition data section and how to
+ * partition the data section. Vendor driver should return data_offset
+ * accordingly.
+ *
+ * Sequence to be followed:
+ * In _SAVING|_RUNNING device state or pre-copy phase:
+ * a. read pending_bytes. If pending_bytes > 0, go through below steps.
+ * b. read data_offset, indicates kernel driver to write data to staging buffer
+ *    which is mmapped.
+ * c. read data_size, amount of data in bytes written by vendor driver in
+ *    migration region.
+ * d. if data section is trapped, read from data_offset of data_size.
+ * e. if data section is mmaped, read data_size bytes from mmaped buffer from
+ *    data_offset in the migration region.
+ * f. Write data_size and data to file stream.
+ * g. iterate through steps a to f while (pending_bytes > 0)
+ *
+ * In _SAVING device state or stop-and-copy phase:
+ * a. read config space of device and save to migration file stream. This
+ *    doesn't need to be from vendor driver. Any other special config state
+ *    from driver can be saved as data in following iteration.
+ * b. read pending_bytes.
+ * c. read data_offset, indicates kernel driver to write data to staging
+ *    buffer which is mmapped.
+ * d. read data_size, amount of data in bytes written by vendor driver in
+ *    migration region.
+ * e. if data section is trapped, read from data_offset of data_size.
+ * f. if data section is mmaped, read data_size bytes from mmaped buffer from
+ *    data_offset in the migration region.
+ * g. Write data_size and data to file stream
+ * h. iterate through steps b to g while (pending_bytes > 0)
+ *
+ * When data region is mapped, its user's responsibility to read data from
+ * data_offset of data_size before moving to next steps.
+ *
+ * Dirty page tracking is part of RAM copy state, where vendor driver
+ * provides the bitmap of pages which are dirtied by vendor driver through
+ * migration region and as part of RAM copy those pages gets copied to file
+ * stream.
+ *
+ * To get dirty page bitmap:
+ * a. write start_pfn, page_size and total_pfns.
+ * b. read copied_pfns.
+ *     - Vendor driver should return VFIO_DEVICE_DIRTY_PFNS_NONE if driver
+ *       doesn't have any page to report dirty in given range or rest of the
+ *       range. Exit loop.
+ *     - Vendor driver should return VFIO_DEVICE_DIRTY_PFNS_ALL to mark all
+ *       pages dirty for given range. Mark all pages in the range as dirty and
+ *       exit the loop.
+ *     - Vendor driver should return copied_pfns and provide bitmap for
+ *       copied_pfn, which means that bitmap copied for given range contains
+ *       information for all pages where some bits are 0s and some are 1s.
+ * c. read data_offset, where vendor driver has written bitmap.
+ * d. read bitmap from the region or mmaped part of the region.
+ * e. Iterate through steps a to d while (total copied_pfns < total_pfns)
+ *
+ * In _RESUMING device state:
+ * - Load device config state.
+ * - While end of data for this device is not reached, repeat below steps:
+ *      - read data_size from file stream, read data from file stream of
+ *        data_size.
+ *      - read data_offset from where User application should write data.
+ *          if region is mmaped, write data of data_size to mmaped region.
+ *      - write data_size.
+ *          In case of mmapped region, write on data_size indicates kernel
+ *          driver that data is written in staging buffer.
+ *      - if region is trapped, write data of data_size from data_offset.
+ *
+ * For user application, data is opaque. User should write data in the same
+ * order as received.
+ */
+
+struct vfio_device_migration_info {
+        __u32 device_state;         /* VFIO device state */
+#define VFIO_DEVICE_STATE_RUNNING   (1 << 0)
+#define VFIO_DEVICE_STATE_SAVING    (1 << 1)
+#define VFIO_DEVICE_STATE_RESUMING  (1 << 2)
+#define VFIO_DEVICE_STATE_MASK      (VFIO_DEVICE_STATE_RUNNING | \
+                                     VFIO_DEVICE_STATE_SAVING | \
+                                     VFIO_DEVICE_STATE_RESUMING)
+#define VFIO_DEVICE_STATE_INVALID   (VFIO_DEVICE_STATE_SAVING | \
+                                     VFIO_DEVICE_STATE_RESUMING)
+        __u32 reserved;
+        __u64 pending_bytes;
+        __u64 data_offset;
+        __u64 data_size;
+        __u64 start_pfn;
+        __u64 page_size;
+        __u64 total_pfns;
+        __u64 copied_pfns;
+#define VFIO_DEVICE_DIRTY_PFNS_NONE     (0)
+#define VFIO_DEVICE_DIRTY_PFNS_ALL      (~0ULL)
+} __attribute__((packed));
+
 /*
  * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
  * which allows direct access to non-MSIX registers which happened to be within
-- 
2.7.0


