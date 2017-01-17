Received: from eggs.gnu.org ([2001:4830:134:3::10]:48850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cTPZa-00026J-Ei
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:56:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cTPZX-000824-Co
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:56:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36452
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cTPZX-000818-7W
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:56:55 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0H8rUsb105951
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 03:56:53 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2812q5avn6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 03:56:52 -0500
Received: from localhost
	by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 17 Jan 2017 08:56:50 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue, 17 Jan 2017 09:56:33 +0100
Message-Id: <20170117085645.4267-1-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 00/12] s390x update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>

The following changes since commit 2ccede18bd24fce5db83fef3674563a1f256717b:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.9-pull-request' into staging (2017-01-16 12:41:35 +0000)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20170117

for you to fetch changes up to 5fd04a2b92bf81f39da63fba9e5ae563a8b929ae:

  virtio-ccw: fix ring sizing (2017-01-16 16:23:27 +0100)

----------------------------------------------------------------
First set of s390x patches for 2.9:
- rework of the zpci code, giving us proper multibus support
- introduction of the 2.9 machine
- fixes and improvements

----------------------------------------------------------------

Christian Borntraeger (1):
  s390x: remove double compat statement

Cornelia Huck (1):
  s390x: add compat machine for 2.9

Fei Li (1):
  s390x/kvm: use kvm_gsi_routing_enabled in flic

Michael S. Tsirkin (1):
  virtio-ccw: fix ring sizing

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
 hw/s390x/virtio-ccw.c      |   2 +-
 hw/virtio/virtio.c         |   5 +
 include/hw/virtio/virtio.h |   1 +
 target/s390x/kvm.c         |   2 +-
 10 files changed, 334 insertions(+), 182 deletions(-)

-- 
2.11.0
