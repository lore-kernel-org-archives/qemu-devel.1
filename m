Received: from eggs.gnu.org ([2001:4830:134:3::10]:39673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gIWj5-0001sI-Ig
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gIWj2-0004HH-Eq
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:30:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gIWj2-00049b-0a
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:30:48 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wA2ATfVH120222
	for <qemu-devel@nongnu.org>; Fri, 2 Nov 2018 06:30:31 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ngmkwrmvw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 06:30:30 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 2 Nov 2018 10:30:28 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri,  2 Nov 2018 11:30:17 +0100
In-Reply-To: <1541154621-22423-1-git-send-email-pmorel@linux.ibm.com>
References: <1541154621-22423-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1541154621-22423-2-git-send-email-pmorel@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v1 1/5] s390x/vfio: ap: Linux uapi VFIO place
 holder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: borntraeger@de.ibm.com
Cc: cohuck@redhat.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com, eric.auger@redhat.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com

This file would be copied from Linux,
I put it here for the review.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 linux-headers/linux/vfio.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index ceb6453394..32b1fec362 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -816,6 +816,28 @@ struct vfio_iommu_spapr_tce_remove {
 };
 #define VFIO_IOMMU_SPAPR_TCE_REMOVE	_IO(VFIO_TYPE, VFIO_BASE + 20)
 
+/**
+ * VFIO_AP_SET_IRQ - _IOWR(VFIO_TYPE, VFIO_BASE + 21, struct vfio_ap_aqic)
+ *
+ * Setup IRQ for an AP Queue
+ * @cmd contains the AP queue number (apqn)
+ * @status receives the resulting status of the command
+ * @nib is the Notification Indicator byte address
+ * @adapter_id allows to retrieve the associated adapter
+ */
+struct vfio_ap_aqic {
+	__u32   argsz;
+	__u32   flags;
+	/* in */
+	__u64 cmd;
+	__u64 status;
+	__u64 nib;
+	__u32 adapter_id;
+};
+#define VFIO_AP_SET_IRQ			_IO(VFIO_TYPE, VFIO_BASE + 21)
+#define VFIO_AP_CLEAR_IRQ		_IO(VFIO_TYPE, VFIO_BASE + 22)
+
 /* ***************************************************************** */
 
+
 #endif /* VFIO_H */
-- 
2.17.0
