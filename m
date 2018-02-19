Received: from eggs.gnu.org ([2001:4830:134:3::10]:56892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1enjrO-00056V-87
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 06:43:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1enjrM-0002ZX-TX
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 06:43:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54874 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1enjrM-0002ZN-NR
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 06:43:52 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Mon, 19 Feb 2018 13:43:22 +0200
Message-Id: <20180219114332.70443-1-marcel@redhat.com>
Subject: [Qemu-devel]  [PATCH PULL v2 00/10] RDMA patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, yuval.shaia@oracle.com, marcel@redhat.com

Hi Peter,

Changes from V1:
 * split the rdma patch into several patches.
 * fixed license issues.
 * moved Linux headers to standard-headers and fixed the used types.
 * R-B tags on all code files (patch 4/10 doesn't have an R-B tag,
   but is an automatic import of Linux kernel headers).

The following changes since commit e5ecc287a7bd24a1364e23e263cb60cfc8d21eb5:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20180216' into staging (2018-02-16 18:39:05 +0000)

are available in the git repository at:

  https://github.com/marcel-apf/qemu tags/rdma-pull-request

for you to fetch changes up to a3defabbb58b7c1c060e7698def237a31a4cc161:

  MAINTAINERS: add entry for hw/rdma (2018-02-19 13:03:24 +0200)

----------------------------------------------------------------
PVRDMA implementation

----------------------------------------------------------------
Marcel Apfelbaum (5):
  mem: add share parameter to memory-backend-ram
  docs: add pvrdma device documentation.
  scripts/update-linux-headers: import pvrdma headers
  include/standard-headers: add pvrdma related headers
  MAINTAINERS: add entry for hw/rdma

Yuval Shaia (5):
  hw/rdma: Add wrappers and macros
  hw/rdma: Definitions for rdma device and rdma resource manager
  hw/rdma: Implementation of generic rdma device layers
  hw/rdma: PVRDMA commands and data-path ops
  hw/rdma: Implementation of PVRDMA device

 MAINTAINERS                                        |   8 +
 Makefile.objs                                      |   2 +
 backends/hostmem-file.c                            |  25 +-
 backends/hostmem-ram.c                             |   4 +-
 backends/hostmem.c                                 |  21 +
 configure                                          |   9 +-
 docs/pvrdma.txt                                    | 255 +++++++
 exec.c                                             |  26 +-
 hw/Makefile.objs                                   |   1 +
 hw/rdma/Makefile.objs                              |   5 +
 hw/rdma/rdma_backend.c                             | 818 +++++++++++++++++++++
 hw/rdma/rdma_backend.h                             |  98 +++
 hw/rdma/rdma_backend_defs.h                        |  62 ++
 hw/rdma/rdma_rm.c                                  | 544 ++++++++++++++
 hw/rdma/rdma_rm.h                                  |  69 ++
 hw/rdma/rdma_rm_defs.h                             | 104 +++
 hw/rdma/rdma_utils.c                               |  51 ++
 hw/rdma/rdma_utils.h                               |  43 ++
 hw/rdma/trace-events                               |   5 +
 hw/rdma/vmw/pvrdma.h                               | 122 +++
 hw/rdma/vmw/pvrdma_cmd.c                           | 673 +++++++++++++++++
 hw/rdma/vmw/pvrdma_dev_ring.c                      | 155 ++++
 hw/rdma/vmw/pvrdma_dev_ring.h                      |  42 ++
 hw/rdma/vmw/pvrdma_main.c                          | 670 +++++++++++++++++
 hw/rdma/vmw/pvrdma_qp_ops.c                        | 222 ++++++
 hw/rdma/vmw/pvrdma_qp_ops.h                        |  27 +
 hw/rdma/vmw/trace-events                           |   5 +
 include/exec/memory.h                              |  23 +
 include/exec/ram_addr.h                            |   3 +-
 include/hw/pci/pci_ids.h                           |   3 +
 include/qemu/osdep.h                               |   2 +-
 .../infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h      | 667 +++++++++++++++++
 .../drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h | 114 +++
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h        | 383 ++++++++++
 include/standard-headers/rdma/vmw_pvrdma-abi.h     | 293 ++++++++
 include/sysemu/hostmem.h                           |   2 +-
 include/sysemu/kvm.h                               |   2 +-
 memory.c                                           |  16 +-
 qemu-options.hx                                    |  10 +-
 scripts/update-linux-headers.sh                    |  30 +
 target/s390x/kvm.c                                 |   4 +-
 util/oslib-posix.c                                 |   4 +-
 util/oslib-win32.c                                 |   2 +-
 43 files changed, 5570 insertions(+), 54 deletions(-)
 create mode 100644 docs/pvrdma.txt
 create mode 100644 hw/rdma/Makefile.objs
 create mode 100644 hw/rdma/rdma_backend.c
 create mode 100644 hw/rdma/rdma_backend.h
 create mode 100644 hw/rdma/rdma_backend_defs.h
 create mode 100644 hw/rdma/rdma_rm.c
 create mode 100644 hw/rdma/rdma_rm.h
 create mode 100644 hw/rdma/rdma_rm_defs.h
 create mode 100644 hw/rdma/rdma_utils.c
 create mode 100644 hw/rdma/rdma_utils.h
 create mode 100644 hw/rdma/trace-events
 create mode 100644 hw/rdma/vmw/pvrdma.h
 create mode 100644 hw/rdma/vmw/pvrdma_cmd.c
 create mode 100644 hw/rdma/vmw/pvrdma_dev_ring.c
 create mode 100644 hw/rdma/vmw/pvrdma_dev_ring.h
 create mode 100644 hw/rdma/vmw/pvrdma_main.c
 create mode 100644 hw/rdma/vmw/pvrdma_qp_ops.c
 create mode 100644 hw/rdma/vmw/pvrdma_qp_ops.h
 create mode 100644 hw/rdma/vmw/trace-events
 create mode 100644 include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
 create mode 100644 include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h
 create mode 100644 include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
 create mode 100644 include/standard-headers/rdma/vmw_pvrdma-abi.h

-- 
2.13.5
