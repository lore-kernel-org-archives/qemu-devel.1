Received: from eggs.gnu.org ([2001:4830:134:3::10]:44963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cRFLw-0000YR-4T
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:37:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cRFLr-0000gK-5Z
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:37:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58035
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cRFLr-0000fu-0A
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:37:51 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0B9XkY8033232
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 04:37:49 -0500
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27whs9130u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 04:37:49 -0500
Received: from localhost
	by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 11 Jan 2017 09:37:47 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Wed, 11 Jan 2017 10:37:31 +0100
Message-Id: <20170111093742.21946-1-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 00/11] s390x patches for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, Cornelia Huck <cornelia.huck@de.ibm.com>

The first set of s390x patches for 2.9.

The major part is an update of the zpci code, which enables proper
multibus support and also makes the code nicer all around.

Other than that, introduction of the 2.9 machine and some optimization.

Christian Borntraeger (1):
  s390x: remove double compat statement

Cornelia Huck (1):
  s390x: add compat machine for 2.9

Fei Li (1):
  s390x/kvm: use kvm_gsi_routing_enabled in flic

Pierre Morel (3):
  s390x/pci: change the device array to a list
  s390x/pci: PCI multibus bridge handling
  s390x/pci: handle PCIBridge bus number

Yi Min Zhao (5):
  s390x/pci: make S390PCIIOMMU inherit Object
  s390x/pci: dynamically allocate iommu
  s390x/pci: optimize calling s390_get_phb()
  s390x/pci: use hashtable to look up zpci via fh
  s390x/pci: merge msix init functions

 hw/intc/s390_flic_kvm.c    |   4 +-
 hw/s390x/s390-pci-bus.c    | 361 +++++++++++++++++++++++++++++----------------
 hw/s390x/s390-pci-bus.h    |  46 ++++--
 hw/s390x/s390-pci-inst.c   |  74 +++++-----
 hw/s390x/s390-pci-inst.h   |   2 +-
 hw/s390x/s390-virtio-ccw.c |  19 ++-
 target/s390x/kvm.c         |   2 +-
 7 files changed, 327 insertions(+), 181 deletions(-)

-- 
2.11.0
