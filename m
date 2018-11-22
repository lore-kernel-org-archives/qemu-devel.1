Received: from eggs.gnu.org ([2001:4830:134:3::10]:59480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gPrxe-0007fz-Ny
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:36:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gPrxa-0000Br-3B
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:36:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gPrxZ-00008V-R2
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:36:10 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAMGYjf0039321
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 11:36:09 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nwxjx42ns-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 11:36:08 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Thu, 22 Nov 2018 16:36:06 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 22 Nov 2018 17:35:52 +0100
In-Reply-To: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
References: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1542904555-1136-4-git-send-email-pmorel@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v2 3/6] s390x/vfio: ap: Linux uapi VFIO place
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
 linux-headers/linux/vfio.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index ceb6453..d5d10bc9 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -816,6 +816,31 @@ struct vfio_iommu_spapr_tce_remove {
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
+	/* out */
+        __u32 status;
+	/* in */
+        __u32 adapter_id;
+        __u64 nib;
+        __u16 apqn;
+        __u8 isc;
+        __u8 reserved[5];
+};
+#define VFIO_AP_SET_IRQ			_IO(VFIO_TYPE, VFIO_BASE + 21)
+#define VFIO_AP_CLEAR_IRQ		_IO(VFIO_TYPE, VFIO_BASE + 22)
+
 /* ***************************************************************** */
 
+
 #endif /* VFIO_H */
-- 
2.7.4
