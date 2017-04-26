Received: from eggs.gnu.org ([2001:4830:134:3::10]:50596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K7g-00037D-FN
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K7b-0002ZH-Gs
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:30840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1d3K7b-0002Z6-6t
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:31 -0400
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Wed, 26 Apr 2017 18:06:43 +0800
Message-Id: <1493201210-14357-14-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [RFC PATCH 13/20] IOMMU: add pasid_table_info for
 guest pasid table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com
Cc: kvm@vger.kernel.org, jasowang@redhat.com, iommu@lists.linux-foundation.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, yi.l.liu@intel.com, jean-philippe.brucker@arm.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

This patch adds iommu.h to define some generic definition for IOMMU.

Here defines "struct pasid_table_info" for guest pasid table bind.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 linux-headers/linux/iommu.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 linux-headers/linux/iommu.h

diff --git a/linux-headers/linux/iommu.h b/linux-headers/linux/iommu.h
new file mode 100644
index 0000000..4519dcf
--- /dev/null
+++ b/linux-headers/linux/iommu.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2017 Intel Corporation.
+ * Author: Yi Liu <yi.l.liu@linux.intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#ifndef __LINUX_IOMMU_H
+#define __LINUX_IOMMU_H
+
+#include <linux/errno.h>
+
+struct pasid_table_info {
+	__u64  ptr;	/* PASID table ptr */
+	__u64  size;	/* PASID table size*/
+	__u32  model;	/* magic number */
+#define	INTEL_IOMMU	(1 << 0)
+#define	ARM_SMMU	(1 << 1)
+	__u8   opaque[];/* IOMMU-specific details */
+};
+
+#endif /* __LINUX_IOMMU_H */
-- 
1.9.1
