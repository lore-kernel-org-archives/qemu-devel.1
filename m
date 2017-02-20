Received: from eggs.gnu.org ([2001:4830:134:3::10]:39296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfkj3-0003lX-Os
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfkiz-0005aI-PM
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38994
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cfkiz-0005a8-Ix
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:41 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1K9s7eL015788
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:57:39 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28qshc2ptr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:57:39 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 20 Feb 2017 09:57:38 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Mon, 20 Feb 2017 10:57:22 +0100
Message-Id: <20170220095734.7890-1-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 00/12] more s390x patches for 2.9
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

A selection of s390x patches:
- cleanups and improvements
- program check loop detection (useful with the corresponding kernel
  patch)
- wire up virtio-crypto for ccw
- and finally support many virtqueues for virtio-ccw

Christian Borntraeger (3):
  s390x/kvm: detect some program check loops
  s390x/arch_dump: use proper note name and note size
  s390x/arch_dump: pass cpuid into notes sections

Cornelia Huck (2):
  s390x/s390-virtio: get rid of DPRINTF
  s390x/flic: fail migration on source already

Halil Pasic (7):
  virtio-ccw: handle virtio 1 only devices
  virtio-ccw: add virtio-crypto-ccw device
  virtio-ccw: Check the number of vqs in CCW_CMD_SET_IND
  s390x: add property adapter_routes_max_batch
  virtio-ccw: check flic->adapter_routes_max_batch
  s390x: bump ADAPTER_ROUTES_MAX_GSI
  virtio-ccw: support VIRTIO_QUEUE_MAX virtqueues

 hw/intc/s390_flic.c          |  28 +++++++++++
 hw/intc/s390_flic_kvm.c      |   6 ++-
 hw/s390x/s390-virtio-ccw.c   |   9 +++-
 hw/s390x/s390-virtio.c       |  10 ----
 hw/s390x/virtio-ccw.c        | 109 +++++++++++++++++++++++++++++++++++++++----
 hw/s390x/virtio-ccw.h        |  13 ++++++
 include/hw/s390x/s390_flic.h |  11 ++++-
 target/s390x/arch_dump.c     |  66 +++++++++++++++-----------
 target/s390x/kvm.c           |  43 +++++++++++++++--
 9 files changed, 241 insertions(+), 54 deletions(-)

-- 
2.11.0
