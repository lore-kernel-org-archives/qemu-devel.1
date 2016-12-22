Received: from eggs.gnu.org ([2001:4830:134:3::10]:36521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1cJvq9-0002lz-UO
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 00:22:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1cJvq5-00015L-1V
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 00:22:53 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 22 Dec 2016 16:22:10 +1100
Message-Id: <20161222052212.49006-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu 0/2] exec,
 spapr_pci: Advertise huge IOMMU pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

These are to enable 16mb pages for IOMMU which should reduce
the amount of memory used for TCE tables in 256 times (compared
to 64k pages case). Please comment. Thanks!

Alexey Kardashevskiy (2):
  exec, kvm, target-ppc: Move getrampagesize() to common code
  spapr_pci: Advertise 16M IOMMU pages when available

 include/exec/ram_addr.h   |   1 +
 include/qemu/mmap-alloc.h |   2 +
 exec.c                    |  82 ++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_pci.c        |   3 ++
 target-ppc/kvm.c          | 105 ++--------------------------------------------
 util/mmap-alloc.c         |  25 +++++++++++
 6 files changed, 116 insertions(+), 102 deletions(-)

-- 
2.11.0
