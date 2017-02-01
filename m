Received: from eggs.gnu.org ([2001:4830:134:3::10]:36444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cYqqX-0001jY-GY
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:04:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cYqqU-0004Ie-CW
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:04:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39994
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1cYqqU-0004IJ-6R
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:04:54 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v11940Vn105129
	for <qemu-devel@nongnu.org>; Wed, 1 Feb 2017 04:04:53 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28b8wuyba7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 04:04:52 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 1 Feb 2017 09:04:50 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed,  1 Feb 2017 10:04:42 +0100
In-Reply-To: <1485939884-39956-1-git-send-email-borntraeger@de.ibm.com>
References: <1485939884-39956-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1485939884-39956-2-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 1/3] s390-pci: fix compilation on older GCC
 versions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Paolo Bonzini <pbonzini@redhat.com>

S390PCIBusDevice is typedef'ed earlier in the file, before the hunks
that this patch modifies.  The double typedef causes old versions of
GCC to complain.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1485523252-88288-1-git-send-email-pbonzini@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/s390-pci-bus.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index 0aad9cc..dcbf482 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -279,7 +279,7 @@ typedef struct S390PCIIOMMUTable {
     S390PCIIOMMU *iommu[PCI_SLOT_MAX];
 } S390PCIIOMMUTable;
 
-typedef struct S390PCIBusDevice {
+struct S390PCIBusDevice {
     DeviceState qdev;
     PCIDevice *pdev;
     ZpciState state;
@@ -301,7 +301,7 @@ typedef struct S390PCIBusDevice {
     IndAddr *indicator;
     QEMUTimer *release_timer;
     QTAILQ_ENTRY(S390PCIBusDevice) link;
-} S390PCIBusDevice;
+};
 
 typedef struct S390PCIBus {
     BusState qbus;
-- 
2.7.4
