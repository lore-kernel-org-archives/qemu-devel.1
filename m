Received: from eggs.gnu.org ([2001:4830:134:3::10]:48696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fDEzm-0003ja-8I
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 16:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fDEzj-0005pt-4d
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 16:01:58 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:38011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fDEzi-0005pJ-Tx
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 16:01:55 -0400
Received: by mail-wr0-x244.google.com with SMTP id 94-v6so7812122wrf.5
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 13:01:54 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Mon, 30 Apr 2018 23:02:16 +0300
Message-Id: <20180430200223.4119-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH 0/7] hw/rdma: coverity fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel.apfelbaum@gmail.com, yuval.shaia@oracle.com, peter.maydell@linaro.org

From: Marcel Apfelbaum <marcel@redhat.com>

Various fixes that were found by coverity. (run by Peter, thanks!)

Thanks,
Marcel

Marcel Apfelbaum (3):
  hw/rdma: Fix possible munmap call on a NULL pointer
  hw/rdma: Fix possible usage of a NULL pointer
  hw/rdma: Fix possible out of bounds access to port GID index

Yuval Shaia (4):
  hw/rdma: Delete port's pkey table
  hw/rdma: Fix possible out of bounds access to GID table
  hw/rdma: Fix possible out of bounds access to regs array
  hw/rdma: Delete duplicate definition of MAX_RM_TBL_NAME

 hw/rdma/rdma_backend.c      |  2 +-
 hw/rdma/rdma_rm.c           |  2 --
 hw/rdma/rdma_rm_defs.h      |  9 ++++-----
 hw/rdma/vmw/pvrdma.h        |  6 +++---
 hw/rdma/vmw/pvrdma_cmd.c    | 10 +++++++---
 hw/rdma/vmw/pvrdma_main.c   | 19 ++-----------------
 hw/rdma/vmw/pvrdma_qp_ops.c |  1 +
 7 files changed, 18 insertions(+), 31 deletions(-)

-- 
2.14.3
