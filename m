Received: from eggs.gnu.org ([2001:4830:134:3::10]:33819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cUVIm-0004S0-SU
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:16:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cUVIi-0003bG-0s
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:16:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cUVIh-0003ah-N8
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:16:03 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0K9Df6d134929
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 04:16:02 -0500
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
	by mx0a-001b2d01.pphosted.com with ESMTP id 283cj6f91u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 04:16:02 -0500
Received: from localhost
	by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 20 Jan 2017 09:15:59 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Fri, 20 Jan 2017 10:15:41 +0100
Message-Id: <20170120091553.11013-1-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL v2 00/12] s390x update
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

The following changes since commit 0f6bcf68a99efdc531b209551f2b760b0bdcc554:

  Merge remote-tracking branch 'remotes/artyom/tags/pull-sun4v-20170118' into staging (2017-01-19 18:34:13 +0000)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20170120-v2

for you to fetch changes up to 8c797e758ad41b8dd6ea6f72c6f0194dedb30a2f:

  virtio-ccw: fix ring sizing (2017-01-20 10:02:02 +0100)

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
