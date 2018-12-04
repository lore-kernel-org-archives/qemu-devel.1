Received: from eggs.gnu.org ([2001:4830:134:3::10]:60913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gUAu5-00077A-Kk
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:38:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gUAtx-0004vV-1b
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:38:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gUAtw-0004uR-N7
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:38:12 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB4DOxoq064964
	for <qemu-devel@nongnu.org>; Tue, 4 Dec 2018 08:38:11 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p5rekxjky-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 08:38:10 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 4 Dec 2018 13:38:08 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue,  4 Dec 2018 14:38:02 +0100
MIME-Version: 1.0
Message-Id: <20181204133802.100998-1-borntraeger@de.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] s390/MAINTAINERS: Add Halil as kvm and machine
 maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Halil does more work in this area than I do right now. Lets add Halil.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63effdc473..76fbf1331a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -365,8 +365,9 @@ S: Maintained
 F: target/ppc/kvm.c
 
 S390
-M: Christian Borntraeger <borntraeger@de.ibm.com>
+M: Halil Pasic <pasic@linux.ibm.com>
 M: Cornelia Huck <cohuck@redhat.com>
+M: Christian Borntraeger <borntraeger@de.ibm.com>
 S: Maintained
 F: target/s390x/kvm.c
 F: target/s390x/kvm_s390x.h
@@ -1057,6 +1058,7 @@ S390 Machines
 -------------
 S390 Virtio-ccw
 M: Cornelia Huck <cohuck@redhat.com>
+M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@de.ibm.com>
 S: Supported
 F: hw/char/sclp*.[hc]
-- 
2.20.0.rc1.10.g7068cbc4a
