Received: from eggs.gnu.org ([2001:4830:134:3::10]:41489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1djivb-0007E2-C4
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1djivW-0001oD-5F
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:23:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1djivV-0001nV-UB
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:23:18 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 21 Aug 2017 11:16:04 +0200
Message-Id: <20170821091614.28251-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v4 00/10] zpci detangling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

Just some minor changes from the last one. If nobody complains, I'll
queue to s390-next.

I'd be happy about some acks/r-bs for patches that don't have any yet,
though.

v3->v4:
- add "9pfs: fix dependencies"
- in "kvm: remove hard dependency on pci", do s/assert/g_assert/ and add
  return statements for builds with asserts off

Cornelia Huck (10):
  9pfs: fix dependencies
  kvm: remove hard dependency on pci
  s390x/pci: add stubs
  s390x: chsc nt2 events are pci-only
  s390x/pci: do not advertise pci on non-pci builds
  s390x/ccw: create s390 phb conditionally
  s390x/sclp: properly guard pci-specific functions
  s390x/pci: fence off instructions for non-pci
  s390x/kvm: msi route fixup for non-pci
  s390x: refine pci dependencies

 accel/kvm/kvm-all.c               |  6 ++--
 default-configs/s390x-softmmu.mak |  2 +-
 fsdev/Makefile.objs               |  9 ++---
 hw/9pfs/Makefile.objs             |  2 +-
 hw/Makefile.objs                  |  2 +-
 hw/pci/pci-stub.c                 | 15 ++++++++
 hw/pci/pci.c                      |  2 ++
 hw/s390x/Makefile.objs            |  3 +-
 hw/s390x/s390-pci-bus.c           |  4 +--
 hw/s390x/s390-pci-bus.h           |  4 +--
 hw/s390x/s390-pci-stub.c          | 74 +++++++++++++++++++++++++++++++++++++++
 hw/s390x/s390-virtio-ccw.c        | 14 ++++----
 hw/s390x/sclp.c                   | 19 +++++++---
 include/hw/pci/pci.h              |  2 ++
 target/s390x/ioinst.c             | 16 +++++++++
 target/s390x/kvm.c                | 64 +++++++++++++++++++++++++--------
 16 files changed, 197 insertions(+), 41 deletions(-)
 create mode 100644 hw/s390x/s390-pci-stub.c

-- 
2.13.5
