Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90658C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA7A20673
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hS0yLmph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA7A20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48868 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdyeI-0005Co-Kq
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 11:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37820)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwankhede@nvidia.com>) id 1hdyJm-0005qQ-JG
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1hdyJk-0005KP-VK
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:45:38 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1930)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1hdyJk-0005Fs-LE
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:45:36 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d0b9ac20002>; Thu, 20 Jun 2019 07:40:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 20 Jun 2019 07:40:03 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 20 Jun 2019 07:40:03 -0700
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 14:40:03 +0000
Received: from kwankhede-dev.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 20 Jun 2019 14:39:56 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Date: Thu, 20 Jun 2019 20:07:29 +0530
Message-ID: <1561041461-22326-2-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
References: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1561041603; bh=THnmNciup8K6MltIgZk/d5O+MlQPVi/MbEN8A0oJa+Y=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=hS0yLmphazasVj+UCwipyFec04P+70ew/U7JKL6aJg1/09jkYH5YNjLwftmSDUt3P
 JAGrtLPSnGCMhE0WurRwdOQeKsrTyaz23zzkhp2V2ZhYFyMTVLVU8FBsDXhSJI+0S4
 917TII1ZZOzH1/wD34ExlpbrFxgvEPKJ4yNqNcUD763bSFAT0IFgjzlsWEs3iX2LD8
 CUZX+M+elFzztc/hS/bbPqovVHnWlglm2i2JpjmwWyvvVNOTKUcAq9OvJ6+eMxI6gE
 tfjVkzuawjk5boFEr0+dx4zFoDrh6X+fOKsBT/vovfUr6U6ghIsuBs+6qF8ASWmCEJ
 4luoR0uXpmHZQ==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.65
Subject: [Qemu-devel] [PATCH v4 01/13] vfio: KABI for migration interface
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
Cc: Kirti Wankhede <kwankhede@nvidia.com>, Zhengxiao.zx@Alibaba-inc.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, yan.y.zhao@intel.com,
 eskultet@redhat.com, ziye.yang@intel.com, qemu-devel@nongnu.org,
 cohuck@redhat.com, shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com,
 zhi.a.wang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 yulei.zhang@intel.com, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com
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
 linux-headers/linux/vfio.h | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 24f505199f83..274ec477eb82 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -372,6 +372,77 @@ struct vfio_region_gfx_edid {
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
+ *      to. If device state transition fails, write to this field return error.
+ *      It consists of 3 bits:
+ *      - If bit 0 set, indicates _RUNNING state. When its reset, that indicates
+ *        _STOPPED state. When device is changed to _STOPPED, driver should stop
+ *        device before write returns.
+ *      - If bit 1 set, indicates _SAVING state.
+ *      - If bit 2 set, indicates _RESUMING state.
+ *
+ * pending bytes: (read only)
+ *      Read pending bytes yet to be migrated from vendor driver
+ *
+ * data_offset: (read only)
+ *      User application should read data_offset in migration region from where
+ *      user application should read data during _SAVING state or write data
+ *      during _RESUMING state.
+ *
+ * data_size: (read/write)
+ *      User application should read data_size to know data copied in migration
+ *      region during _SAVING state and write size of data copied in migration
+ *      region during _RESUMING state.
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
+ *      Vendor driver should return 0 if there are 0 pages dirty in requested
+ *      range.
+ *      Vendor driver should return -1 to mark all pages in the section as
+ *      dirty.
+ */
+
+struct vfio_device_migration_info {
+        __u32 device_state;         /* VFIO device state */
+#define VFIO_DEVICE_STATE_STOPPED   (0)
+#define VFIO_DEVICE_STATE_RUNNING   (1 << 0)
+#define VFIO_DEVICE_STATE_SAVING    (1 << 1)
+#define VFIO_DEVICE_STATE_RESUMING  (1 << 2)
+#define VFIO_DEVICE_STATE_INVALID   (VFIO_DEVICE_STATE_SAVING | \
+                                     VFIO_DEVICE_STATE_RESUMING)
+        __u32 reserved;
+        __u64 pending_bytes;
+        __u64 data_offset;
+        __u64 data_size;
+        __u64 start_pfn;
+        __u64 page_size;
+        __u64 total_pfns;
+        __s64 copied_pfns;
+} __attribute__((packed));
+
 /*
  * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
  * which allows direct access to non-MSIX registers which happened to be within
-- 
2.7.0


