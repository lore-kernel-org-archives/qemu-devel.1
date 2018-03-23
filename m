Received: from eggs.gnu.org ([2001:4830:134:3::10]:35978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ezP0F-0008Ca-R1
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:53:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ezP0B-0007bV-Ef
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:53:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39822 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ezP0B-0007bA-3c
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:53:11 -0400
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Fri, 23 Mar 2018 18:52:58 +0300
Message-Id: <20180323155306.83812-1-marcel@redhat.com>
Subject: [Qemu-devel]  [PATCH PULL 0/8] RDMA queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, yuval.shaia@oracle.com, mst@redhat.com, marcel@redhat.com, f4bug@amsat.org, eblake@redhat.com, berrange@redhat.com, stefanha@redhat.com

The following changes since commit 4c2c1015905fa1d616750dfe024b4c0b35875950:

  Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20180323' into staging (2018-03-23 10:20:54 +0000)

are available in the git repository at:

  https://github.com/marcel-apf/qemu tags/rdma-pull-request

for you to fetch changes up to 6f559013c86d16255991ca23e47bd161407b95c8:

  hw/rdma: Fix 32-bit compilation (2018-03-23 18:38:55 +0300)

----------------------------------------------------------------
* fix PVRDMA compilation errors and warnings
* implement query_qp for the PVRDMA device
* fix make - switch from -I to -iquote

----------------------------------------------------------------
Marcel Apfelbaum (1):
      hw/rdma: fix clang compilation errors

Michael S. Tsirkin (2):
      rdma: fix up include directives
      make: switch from -I to -iquote

Yuval Shaia (5):
      hw/rdma: Add Query QP operation
      hw/rdma: Add support for Query QP verb to pvrdma device
      hw/rdma: Change host_virt to void *
      hw/rdma: Use correct print format in CHK_ATTR macro
      hw/rdma: Fix 32-bit compilation

 Makefile.target               |  4 ++--
 configure                     | 16 ++++++-------
 hw/rdma/rdma_backend.c        | 51 +++++++++++++++++++++++++----------------
 hw/rdma/rdma_backend.h        |  6 +++--
 hw/rdma/rdma_backend_defs.h   |  2 +-
 hw/rdma/rdma_rm.c             | 38 +++++++++++++++++++++++--------
 hw/rdma/rdma_rm.h             |  5 +++-
 hw/rdma/rdma_rm_defs.h        |  2 +-
 hw/rdma/rdma_utils.c          |  6 ++---
 hw/rdma/rdma_utils.h          |  6 ++---
 hw/rdma/vmw/pvrdma.h          |  8 +++----
 hw/rdma/vmw/pvrdma_cmd.c      | 45 +++++++++++++++++++++++++++---------
 hw/rdma/vmw/pvrdma_dev_ring.c | 14 ++++++------
 hw/rdma/vmw/pvrdma_dev_ring.h |  4 ++--
 hw/rdma/vmw/pvrdma_main.c     | 53 ++++++++++++++++++++++---------------------
 hw/rdma/vmw/pvrdma_qp_ops.c   | 10 ++++----
 rules.mak                     |  2 +-
 17 files changed, 166 insertions(+), 106 deletions(-)
-- 
2.13.5
