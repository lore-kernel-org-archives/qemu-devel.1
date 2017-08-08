Received: from eggs.gnu.org ([2001:4830:134:3::10]:56194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1df3Rg-0008S1-DL
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:17:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1df3Rb-00036k-KX
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:17:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40637)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1df3Rb-00035Q-ES
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:17:07 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue,  8 Aug 2017 14:17:00 +0200
Message-Id: <20170808121701.18353-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH 0/1] fixup 9pfs dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: aneesh.kumar@linux.vnet.ibm.com, groug@kaod.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

During my work on cleaning up the pci dependencies on s390x (see my
"s390x: zPCI detangling" patch series), I noticed that the 9pfs code
is only built if CONFIG_PCI is set. There's really nothing in there
that should depend on CONFIG_PCI (it is really transport-agnostic);
we do want to make sure that we have a virtio-9p-transport device,
however.

This patch is on top of master; it does not really make a difference
right now, but will be needed after my patch series to avoid an
inconsistent config for s390x with pci off.

Cornelia Huck (1):
  9pfs: fix and simplify dependencies

 configure                         | 2 +-
 default-configs/s390x-softmmu.mak | 1 +
 fsdev/Makefile.objs               | 2 +-
 hw/Makefile.objs                  | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.13.4
