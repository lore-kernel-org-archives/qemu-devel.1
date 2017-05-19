Received: from eggs.gnu.org ([2001:4830:134:3::10]:41751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dBfaF-0005Jc-6L
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:56:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dBfaE-0000EP-Cj
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:56:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1dBfaE-0000Dl-2J
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:56:34 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4JAmt9C091254
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:56:33 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ahwn9mugw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:56:32 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 19 May 2017 11:56:30 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Fri, 19 May 2017 12:55:59 +0200
In-Reply-To: <20170519105600.11589-1-cornelia.huck@de.ibm.com>
References: <20170519105600.11589-1-cornelia.huck@de.ibm.com>
Message-Id: <20170519105600.11589-21-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 20/21] MAINTAINERS: Add vfio-ccw maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

Add Cornelia Huck as the vfio-ccw maintainer.

Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170517004813.58227-14-bjsdjshi@linux.vnet.ibm.com>
[CH: add tree]
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ef2ec58a94..7df088259b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1005,6 +1005,14 @@ S: Supported
 F: hw/vfio/*
 F: include/hw/vfio/
 
+vfio-ccw
+M: Cornelia Huck <cornelia.huck@de.ibm.com>
+S: Supported
+F: hw/vfio/ccw.c
+F: hw/s390x/s390-ccw.c
+F: include/hw/s390x/s390-ccw.h
+T: git git://github.com/cohuck/qemu.git s390-next
+
 vhost
 M: Michael S. Tsirkin <mst@redhat.com>
 S: Supported
-- 
2.13.0
