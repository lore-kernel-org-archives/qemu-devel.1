Received: from eggs.gnu.org ([209.51.188.92]:42395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gxY6k-0006Po-PA
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 09:16:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gxY6j-0002LH-Rs
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 09:16:50 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gxY6j-0002Kw-KC
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 09:16:49 -0500
Received: by mail-wm1-x344.google.com with SMTP id x7so4335552wmj.0
	for <qemu-devel@nongnu.org>; Sat, 23 Feb 2019 06:16:49 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 23 Feb 2019 16:16:33 +0200
Message-Id: <20190223141644.6609-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel]  [PATCH PULL 00/11] RDMA queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, kamalheib1@gmail.com, philmd@redhat.com, dgilbert@redhat.com

The following changes since commit 8eb29f1bf5a974dc4c11d2d1f5e7c7f7a62be116:

  Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-20190221.0' into staging (2019-02-22 15:48:04 +0000)

are available in the Git repository at:

  https://github.com/marcel-apf/qemu tags/rdma-pull-request

for you to fetch changes up to e1038e22f7b3ade2e46cf168fa7486414c424e94:

  hw/rdma: another clang compilation fix (2019-02-23 15:28:25 +0200)

----------------------------------------------------------------
RDMA queue

 * Another Clang compilation fix
 * Various fixes for the pvrdma device

----------------------------------------------------------------
Marcel Apfelbaum (1):
      hw/rdma: another clang compilation fix

Yuval Shaia (10):
      contrib/rdmacm-mux: Fix out-of-bounds risk
      hw/rdma: Switch to generic error reporting way
      hw/rdma: Introduce protected qlist
      hw/rdma: Protect against concurrent execution of poll_cq
      {monitor, hw/pvrdma}: Expose device internals via monitor interface
      hw/rdma: Free all MAD receive buffers when device is closed
      hw/rdma: Free all receive buffers when QP is destroyed
      hw/pvrdma: Delete unneeded function argument
      hw/pvrdma: Delete pvrdma_exit function
      hw/pvrdma: Unregister from shutdown notifier when device goes down

 contrib/rdmacm-mux/main.c     |  35 ++-
 hmp-commands-info.hx          |  16 ++
 hw/rdma/rdma_backend.c        | 483 +++++++++++++++++++++---------------------
 hw/rdma/rdma_backend.h        |   3 +-
 hw/rdma/rdma_backend_defs.h   |  10 +-
 hw/rdma/rdma_rm.c             | 134 ++++++------
 hw/rdma/rdma_rm_defs.h        |  32 ++-
 hw/rdma/rdma_utils.c          |  79 ++++++-
 hw/rdma/rdma_utils.h          |  61 +++---
 hw/rdma/trace-events          |  32 ++-
 hw/rdma/vmw/pvrdma.h          |   7 +-
 hw/rdma/vmw/pvrdma_cmd.c      | 113 +++-------
 hw/rdma/vmw/pvrdma_dev_ring.c |  26 +--
 hw/rdma/vmw/pvrdma_hmp.h      |  21 ++
 hw/rdma/vmw/pvrdma_main.c     | 217 +++++++++++--------
 hw/rdma/vmw/pvrdma_qp_ops.c   |  52 ++---
 hw/rdma/vmw/trace-events      |  16 +-
 monitor.c                     |  10 +
 18 files changed, 744 insertions(+), 603 deletions(-)
 create mode 100644 hw/rdma/vmw/pvrdma_hmp.h

-- 
2.17.1
