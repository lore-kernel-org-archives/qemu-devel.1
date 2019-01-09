Received: from eggs.gnu.org ([209.51.188.92]:41828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1ghDKn-0000Y4-EB
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:51:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1ghDAo-0004Ah-3D
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:41:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38240
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1ghDAn-0004AP-UU
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:41:30 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x09CXlHC149887
	for <qemu-devel@nongnu.org>; Wed, 9 Jan 2019 07:41:28 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2pwfvr3wp8-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 07:41:28 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Wed, 9 Jan 2019 12:41:27 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed,  9 Jan 2019 13:41:17 +0100
Message-Id: <1547037680-21458-1-git-send-email-pmorel@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v1 0/3] [RFC] get real IOMMU information from
 VFIO IOMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: walling@linux.ibm.com
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, pasic@linux.ibm.com, thuth@redhat.com

In the Z-Architecture, the IOMMU information may change on a device
basis.
until this patch series we used hardcoded values to define the
IOMMU aperture we provide to the guest during PCI enumeration.

Let's ask the host about the IOMMU specific configuration using
VFIO capabilities.

NOTES:
1- You will need the according Linux patch to test this.

2- I am really not happy to add S390 dedicated code in the
   VFIO common code, as do SPAPR, but I did not find a better
   solution.
   Any idea?

Pierre Morel (3):
  vfio: Linux header placeholder
  vfio/pci: Get real IOMMU information from container
  s390x/pci: Reporting the host aperture to the guest

 hw/s390x/s390-pci-bus.c       |  2 +-
 hw/s390x/s390-pci-bus.h       |  3 ++
 hw/s390x/s390-pci-inst.c      | 20 ++++++++++--
 hw/vfio/common.c              | 75 +++++++++++++++++++++++++++++++++----------
 include/hw/vfio/vfio-common.h |  3 ++
 linux-headers/linux/vfio.h    | 65 +++++++++++++++++++++++++++++++++++--
 6 files changed, 144 insertions(+), 24 deletions(-)

-- 
2.7.4
