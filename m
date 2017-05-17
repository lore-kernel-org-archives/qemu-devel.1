Received: from eggs.gnu.org ([2001:4830:134:3::10]:48850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dAn9O-0003Ug-C1
	for qemu-devel@nongnu.org; Tue, 16 May 2017 20:49:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dAn9J-0001cG-Fh
	for qemu-devel@nongnu.org; Tue, 16 May 2017 20:49:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dAn9J-0001ap-59
	for qemu-devel@nongnu.org; Tue, 16 May 2017 20:49:09 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4H0mqnf008863
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 20:49:08 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2agatfk9u2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 20:49:07 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 16 May 2017 18:49:07 -0600
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Wed, 17 May 2017 02:48:13 +0200
In-Reply-To: <20170517004813.58227-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170517004813.58227-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170517004813.58227-14-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v8 13/13] MAINTAINERS: Add vfio-ccw maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, eric.auger@redhat.com

Add Cornelia Huck as the vfio-ccw maintainer.

Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index efdec47319..a4ae36b411 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -997,6 +997,13 @@ S: Supported
 F: hw/vfio/*
 F: include/hw/vfio/
 
+vfio-ccw
+M: Cornelia Huck <cornelia.huck@de.ibm.com>
+S: Supported
+F: hw/vfio/ccw.c
+F: hw/s390x/s390-ccw.c
+F: include/hw/s390x/s390-ccw.h
+
 vhost
 M: Michael S. Tsirkin <mst@redhat.com>
 S: Supported
-- 
2.11.2
