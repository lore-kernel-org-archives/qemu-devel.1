Received: from eggs.gnu.org ([209.51.188.92]:53683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kamalheib1@gmail.com>) id 1hBe9h-0002Y7-IU
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 07:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kamalheib1@gmail.com>) id 1hBe9f-0006N8-66
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 07:34:09 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kamalheib1@gmail.com>)
	id 1hBe9Z-0006Ac-Dm
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 07:34:03 -0400
Received: by mail-wr1-x444.google.com with SMTP id w1so20885331wrp.2
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 04:33:58 -0700 (PDT)
From: Kamal Heib <kamalheib1@gmail.com>
Date: Wed,  3 Apr 2019 14:33:39 +0300
Message-Id: <20190403113343.26384-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/4] pvrdma: Add support for SRQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Yuval Shaia <yuval.shaia@oracle.com>, Kamal Heib <kamalheib1@gmail.com>

This series implements the SRQ (Shared Receive Queue) for the pvrdma
device, It also includes all the needed functions and definitions for
support SRQ in the backend and resource management layers.

Changes from v2->3:
- Patch #1:
-- Fix commit message.
-- Remove initialization of backend_qp from rdma_backend_post_srq_recv().
-- Add rx_srq counter.
- Patch #2:
-- Add checks for srq attrs.
- Patch #3:
-- Move initialization of recv_cq_handle to be under is_srq.
-- Rearrange destroy_qp() to avoid use after free.
- Patch #4:
-- Avoid use after free.
-- Fix indentation.

Changes from v1->v2:
- Handle checkpatch.pl warnings. 

Kamal Heib (4):
  hw/rdma: Add SRQ support to backend layer
  hw/rdma: Add support for managing SRQ resource
  hw/rdma: Modify create/destroy QP to support SRQ
  hw/pvrdma: Add support for SRQ

 hw/rdma/rdma_backend.c      | 125 +++++++++++++++++++++-
 hw/rdma/rdma_backend.h      |  18 +++-
 hw/rdma/rdma_backend_defs.h |   5 +
 hw/rdma/rdma_rm.c           | 117 +++++++++++++++++++-
 hw/rdma/rdma_rm.h           |  13 ++-
 hw/rdma/rdma_rm_defs.h      |  10 ++
 hw/rdma/vmw/pvrdma_cmd.c    | 206 ++++++++++++++++++++++++++++++++----
 hw/rdma/vmw/pvrdma_main.c   |  16 +++
 hw/rdma/vmw/pvrdma_qp_ops.c |  46 +++++++-
 hw/rdma/vmw/pvrdma_qp_ops.h |   1 +
 10 files changed, 521 insertions(+), 36 deletions(-)

-- 
2.20.1
