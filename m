Received: from eggs.gnu.org ([209.51.188.92]:48055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gpC5X-00075D-MW
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:09:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gpC5W-0000Fr-Pv
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:09:03 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:60708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gpC5W-0000EH-Fz
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:09:02 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Thu, 31 Jan 2019 15:08:40 +0200
Message-Id: <20190131130850.6850-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH 00/10] Misc fixes to pvrdma device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, armbru@redhat.com, qemu-devel@nongnu.org

Hi,
Please review the following patch-set which consist of cosmetics fixes to
device's user interface (traces, error_report and monitor) and some bug
fixes.

Thanks,
Yuval

Yuval Shaia (10):
  hw/rdma: Switch to generic error reporting way
  hw/rdma: Introduce locked qlist
  hw/rdma: Warn when too many consecutive poll CQ triggered on an empty
    CQ
  hw/rdma: Protect against concurrent execution of poll_cq
  hw/pvrdma: Add device statistics counters
  hw/pvrdma: Dump device statistics counters to file
  monitor: Expose pvrdma device statistics counters
  hw/rdma: Free all MAD receive buffers when device is closed
  hw/rdma: Free all receive buffers when QP is destroyed
  hw/pvrdma: Delete unneeded function argument

 hmp-commands-info.hx          |  14 +
 hw/rdma/rdma_backend.c        | 474 +++++++++++++++++-----------------
 hw/rdma/rdma_backend.h        |   6 +-
 hw/rdma/rdma_backend_defs.h   |   9 +-
 hw/rdma/rdma_rm.c             | 134 +++++-----
 hw/rdma/rdma_rm_defs.h        |  28 +-
 hw/rdma/rdma_utils.c          |  50 +++-
 hw/rdma/rdma_utils.h          |  52 ++--
 hw/rdma/trace-events          |  32 ++-
 hw/rdma/vmw/pvrdma.h          |   8 +-
 hw/rdma/vmw/pvrdma_cmd.c      | 113 +++-----
 hw/rdma/vmw/pvrdma_dev_ring.c |  26 +-
 hw/rdma/vmw/pvrdma_main.c     | 207 +++++++++------
 hw/rdma/vmw/pvrdma_qp_ops.c   |  76 +++---
 hw/rdma/vmw/trace-events      |  16 +-
 monitor.c                     |   6 +
 16 files changed, 655 insertions(+), 596 deletions(-)

-- 
2.17.2
