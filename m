Received: from eggs.gnu.org ([2001:4830:134:3::10]:44370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eZTB3-0004lf-4G
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 22:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eZTB2-0002w1-4a
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 22:05:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1eZTB1-0002vH-TD
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 22:05:12 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0B34JDW040322
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 22:05:11 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fdxxqsm9p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 22:05:10 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 10 Jan 2018 20:05:10 -0700
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Thu, 11 Jan 2018 04:04:55 +0100
In-Reply-To: <20180111030459.33757-1-bjsdjshi@linux.vnet.ibm.com>
References: <20180111030459.33757-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20180111030459.33757-2-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 1/5] vfio: linux-headers update for vfio-ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com

This is a placeholder for a linux-headers update.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 linux-headers/linux/vfio.h     | 2 ++
 linux-headers/linux/vfio_ccw.h | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 4312e961ff..24d85be022 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -457,11 +457,13 @@ enum {
 
 enum {
 	VFIO_CCW_CONFIG_REGION_INDEX,
+	VFIO_CCW_SCHIB_REGION_INDEX,
 	VFIO_CCW_NUM_REGIONS
 };
 
 enum {
 	VFIO_CCW_IO_IRQ_INDEX,
+	VFIO_CCW_CHP_IRQ_INDEX,
 	VFIO_CCW_NUM_IRQS
 };
 
diff --git a/linux-headers/linux/vfio_ccw.h b/linux-headers/linux/vfio_ccw.h
index 5bf96c3812..4944dd946e 100644
--- a/linux-headers/linux/vfio_ccw.h
+++ b/linux-headers/linux/vfio_ccw.h
@@ -22,4 +22,10 @@ struct ccw_io_region {
 	__u32	ret_code;
 } __attribute__((packed));
 
+struct ccw_schib_region {
+        __u8	cc;
+#define SCHIB_AREA_SIZE 52
+        __u8	schib_area[SCHIB_AREA_SIZE];
+} __attribute__((packed));
+
 #endif
-- 
2.13.5
