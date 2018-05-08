Received: from eggs.gnu.org ([2001:4830:134:3::10]:40398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1fG1gb-00042Q-Qx
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1fG1ga-00070b-O6
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:25:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1fG1ga-00070M-Fr
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:25:40 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w48CPdJe077126
	for <qemu-devel@nongnu.org>; Tue, 8 May 2018 08:25:39 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hu8kg1b64-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 08:25:39 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Tue, 8 May 2018 08:25:28 -0400
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Tue,  8 May 2018 08:25:03 -0400
In-Reply-To: <1525782303-16940-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1525782303-16940-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Message-Id: <1525782303-16940-7-git-send-email-akrowiak@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v5 6/6] MAINTAINERS: add entries for AP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, akrowiak@linux.vnet.ibm.com

Added entries for the s390 adjunct processor (AP) support.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 MAINTAINERS |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 459e359..c9e8d7b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -82,6 +82,7 @@ S390
 M: Cornelia Huck <cohuck@redhat.com>
 S: Supported
 F: default-configs/s390x-softmmu.mak
+F: docs/vfio-ap.txt
 F: gdb-xml/s390*.xml
 F: hw/char/sclp*.[hc]
 F: hw/char/terminal3270.c
@@ -89,6 +90,7 @@ F: hw/intc/s390_flic.c
 F: hw/intc/s390_flic_kvm.c
 F: hw/s390x/
 F: hw/vfio/ccw.c
+F: hw/vfio/ap.c
 F: hw/watchdog/wdt_diag288.c
 F: include/hw/s390x/
 F: include/hw/watchdog/wdt_diag288.h
@@ -1152,6 +1154,18 @@ F: include/hw/s390x/s390-ccw.h
 T: git git://github.com/cohuck/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
+vfio-ap
+M: Christian Borntraeger <borntraeger@de.ibm.com>
+M: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
+M: Halil Pasic <pasic@linux.vnet.ibm.com>
+M: Pierre Morel <pmorel@linux.vnet.ibm.com>
+S: Maintained
+F: hw/vfio/ap.c
+F: hw/s390x/ap-device.c
+F: include/hw/s390x/ap-device.h
+F: docs/vfio-ap.txt
+L: qemu-s390x@nongnu.org
+
 vhost
 M: Michael S. Tsirkin <mst@redhat.com>
 S: Supported
-- 
1.7.1
