Received: from eggs.gnu.org ([2001:4830:134:3::10]:39733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fmL4b-00071g-5n
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 11:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fmL4W-0006Mw-8p
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 11:36:01 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1fmL4V-0006Ml-VH
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 11:35:56 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Sun,  5 Aug 2018 18:35:05 +0300
Message-Id: <20180805153518.2983-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel]  [PATCH v2 00/13] Misc fixes for pvrdma device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com

Hi,
Please review some changes i've made for pvrdma device.

v1 -> v2:
	* Fix various stuff pointed by Marcel
	* Add Marcel's r-b

Yuval Shaia (13):
  hw/rdma: Make distinction between device init and start modes
  hw/pvrdma: Bugfix - provide the correct attr_mask to query_qp
  hw/rdma: Modify debug macros
  hw/pvrdma: Clean CQE before use
  hw/pvrdma: Make default pkey 0xFFFF
  hw/rdma: Delete useless structure RdmaRmUserMR
  hw/rdma: Do not allocate memory for non-dma MR
  hw/rdma: Reorder resource cleanup
  hw/pvrdma: Cosmetic change - indent right
  hw/rdma: Cosmetic change - move to generic function
  hw/rdma: Print backend QP number in hex format
  hw/rdma: Bugfix - Support non-aligned buffers
  hw/rdma: Add reference to pci_dev in backend_dev

 hw/rdma/rdma_backend.c      | 105 +++++++++++++++++++++------
 hw/rdma/rdma_backend.h      |   4 +-
 hw/rdma/rdma_backend_defs.h |   3 +-
 hw/rdma/rdma_rm.c           |  69 ++++++++----------
 hw/rdma/rdma_rm_defs.h      |  10 +--
 hw/rdma/rdma_utils.c        |   4 ++
 hw/rdma/rdma_utils.h        |  16 +++--
 hw/rdma/vmw/pvrdma.h        |   3 +
 hw/rdma/vmw/pvrdma_cmd.c    |   8 ++-
 hw/rdma/vmw/pvrdma_main.c   | 137 +++++++++++++++++++++---------------
 hw/rdma/vmw/pvrdma_qp_ops.c |   5 +-
 11 files changed, 228 insertions(+), 136 deletions(-)

-- 
2.17.1
