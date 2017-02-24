Received: from eggs.gnu.org ([2001:4830:134:3::10]:48781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1chC5n-00035z-TV
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:23:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1chC5i-0004PX-Vf
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:23:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1chC5i-0004PL-Lb
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:23:06 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1O9JDCc036579
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 04:23:05 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28td8c3byb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 04:23:04 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 24 Feb 2017 09:23:02 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Fri, 24 Feb 2017 10:22:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20170224092259.16483-1-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 00/13] s390x patches for 2.9
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

The following changes since commit 10f25e4844cb9b3f02fb032f88051dd5b65b4206:

  Merge remote-tracking branch 'remotes/yongbok/tags/mips-20170222' into staging (2017-02-23 09:59:40 +0000)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20170224

for you to fetch changes up to 9f94f84ce7df633142953806cc4c102765cabc0e:

  s390x/css: handle format-0 TIC CCW correctly (2017-02-24 10:15:18 +0100)

----------------------------------------------------------------
A selection of s390x patches:
- cleanups, fixes and improvements
- program check loop detection (useful with the corresponding kernel
  patch)
- wire up virtio-crypto for ccw
- and finally support many virtqueues for virtio-ccw

----------------------------------------------------------------

Christian Borntraeger (3):
  s390x/kvm: detect some program check loops
  s390x/arch_dump: use proper note name and note size
  s390x/arch_dump: pass cpuid into notes sections

Cornelia Huck (2):
  s390x/s390-virtio: get rid of DPRINTF
  s390x/flic: fail migration on source already

Dong Jia Shi (1):
  s390x/css: handle format-0 TIC CCW correctly

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
 hw/s390x/css.c               |  15 +++---
 hw/s390x/s390-virtio-ccw.c   |   9 +++-
 hw/s390x/s390-virtio.c       |  10 ----
 hw/s390x/virtio-ccw.c        | 109 +++++++++++++++++++++++++++++++++++++++----
 hw/s390x/virtio-ccw.h        |  13 ++++++
 include/hw/s390x/s390_flic.h |  11 ++++-
 target/s390x/arch_dump.c     |  66 +++++++++++++++-----------
 target/s390x/kvm.c           |  43 +++++++++++++++--
 10 files changed, 250 insertions(+), 60 deletions(-)

-- 
2.11.0
