Received: from eggs.gnu.org ([2001:4830:134:3::10]:36243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cRZlO-00008X-2K
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:25:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cRZlK-0005Ow-NL
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:25:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cRZlK-0005Ok-Ea
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:25:30 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0C7O2P9006078
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 02:25:29 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27x2q5mxkn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 02:25:29 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 12 Jan 2017 00:25:28 -0700
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Thu, 12 Jan 2017 08:25:03 +0100
In-Reply-To: <20170112072513.98411-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170112072513.98411-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170112072513.98411-3-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RFC v2 02/12] vfio: linux-headers update for
 vfio-ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com

From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>

This is a placeholder for a linux-headers update.

Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
---
 include/standard-headers/asm-s390/vfio_ccw.h | 28 ++++++++++++++++++++++++++++
 linux-headers/linux/vfio.h                   | 17 +++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 include/standard-headers/asm-s390/vfio_ccw.h

diff --git a/include/standard-headers/asm-s390/vfio_ccw.h b/include/standard-headers/asm-s390/vfio_ccw.h
new file mode 100644
index 0000000..cddc09b
--- /dev/null
+++ b/include/standard-headers/asm-s390/vfio_ccw.h
@@ -0,0 +1,28 @@
+/*
+ * Interfaces for vfio-ccw
+ *
+ * Copyright IBM Corp. 2017
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ *
+ * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ */
+
+#ifndef _VFIO_CCW_H_
+#define _VFIO_CCW_H_
+
+#include "standard-headers/linux/types.h"
+
+struct ccw_io_region {
+#define ORB_AREA_SIZE 12
+	uint8_t  orb_area[ORB_AREA_SIZE];
+#define SCSW_AREA_SIZE 12
+	uint8_t  scsw_area[SCSW_AREA_SIZE];
+#define IRB_AREA_SIZE 96
+	uint8_t  irb_area[IRB_AREA_SIZE];
+	uint32_t ret_code;
+} QEMU_PACKED;
+
+#endif
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 759b850..b09d247 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -198,6 +198,7 @@ struct vfio_device_info {
 #define VFIO_DEVICE_FLAGS_PCI	(1 << 1)	/* vfio-pci device */
 #define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)	/* vfio-platform device */
 #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
+#define VFIO_DEVICE_FLAGS_CCW   (1 << 4)	/* vfio-ccw device */
 	__u32	num_regions;	/* Max region index + 1 */
 	__u32	num_irqs;	/* Max IRQ index + 1 */
 };
@@ -436,6 +437,22 @@ enum {
 	VFIO_PCI_NUM_IRQS
 };
 
+/*
+ * The VFIO-CCW bus driver makes use of the following fixed region and
+ * IRQ index mapping.  Unimplemented regions return a size of zero.
+ * Unimplemented IRQ types return a count of zero.
+ */
+
+enum {
+        VFIO_CCW_CONFIG_REGION_INDEX,
+        VFIO_CCW_NUM_REGIONS
+};
+
+enum {
+        VFIO_CCW_IO_IRQ_INDEX,
+        VFIO_CCW_NUM_IRQS
+};
+
 /**
  * VFIO_DEVICE_GET_PCI_HOT_RESET_INFO - _IORW(VFIO_TYPE, VFIO_BASE + 12,
  *					      struct vfio_pci_hot_reset_info)
-- 
2.8.4
