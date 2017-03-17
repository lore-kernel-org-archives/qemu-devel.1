Received: from eggs.gnu.org ([2001:4830:134:3::10]:57109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1coiPk-0006xD-8q
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 23:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1coiPf-0000Ug-CP
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 23:18:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52793
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1coiPf-0000UX-5i
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 23:18:47 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2H3Ds2K005114
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 23:18:46 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 297nkp1xc4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 23:18:46 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 16 Mar 2017 21:18:45 -0600
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Fri, 17 Mar 2017 04:17:43 +0100
In-Reply-To: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170317031743.40128-17-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 16/16] MAINTAINERS: Add vfio-ccw maintainers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

Add Cornelia Huck and myself as the vfio-ccw driver maintainers.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c776906..01a6675 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10859,6 +10859,16 @@ W:	http://www.ibm.com/developerworks/linux/linux390/
 S:	Supported
 F:	drivers/iommu/s390-iommu.c
 
+S390 VFIO-CCW DRIVER
+M:	Cornelia Huck <cornelia.huck@de.ibm.com>
+M:	Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+L:	linux-s390@vger.kernel.org
+L:	kvm@vger.kernel.org
+S:	Supported
+F:	drivers/s390/cio/vfio_ccw*
+F:	Documentation/s390/vfio-ccw.txt
+F:	include/uapi/linux/vfio_ccw.h
+
 S3C24XX SD/MMC Driver
 M:	Ben Dooks <ben-linux@fluff.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.8.4
