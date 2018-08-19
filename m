Received: from eggs.gnu.org ([2001:4830:134:3::10]:43855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1frjYX-0008Q6-9e
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1frjYU-0000YK-4n
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:13 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:41898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1frjYT-0000VU-Tx
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:10 -0400
Received: by mail-wr1-x42a.google.com with SMTP id z96-v6so4222396wrb.8
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 05:45:09 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sun, 19 Aug 2018 23:22:45 +0300
Message-Id: <20180819202300.10590-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel]  [PATCH PULL 00/15] RDMA queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, thuth@redhat.com, marcel.apfelbaum@gmail.com

The following changes since commit 0abaa41d936becd914a16ee1fe2a981d96d19428:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-08-17 09:46:00 +0100)

are available in the Git repository at:

  https://github.com/marcel-apf/qemu tags/rdma-pull-request

for you to fetch changes up to 21ab34c9543fe1b6d31b3edbd01a397e7e090d00:

  config: split PVRDMA from RDMA (2018-08-18 18:01:34 +0300)

----------------------------------------------------------------
Various pvrdma fixes
Split pvrdma from rdma in config

----------------------------------------------------------------
Marcel Apfelbaum (2):
  hw/pvrdma: remove not needed include
  config: split PVRDMA from RDMA

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

 configure                   |  55 ++++++++++++++-
 hw/rdma/Makefile.objs       |   2 +-
 hw/rdma/rdma_backend.c      | 105 +++++++++++++++++++++------
 hw/rdma/rdma_backend.h      |   4 +-
 hw/rdma/rdma_backend_defs.h |   3 +-
 hw/rdma/rdma_rm.c           |  63 ++++++++---------
 hw/rdma/rdma_rm_defs.h      |  10 +--
 hw/rdma/rdma_utils.c        |   4 ++
 hw/rdma/rdma_utils.h        |  16 +++--
 hw/rdma/vmw/pvrdma.h        |   3 +
 hw/rdma/vmw/pvrdma_cmd.c    |   9 +--
 hw/rdma/vmw/pvrdma_main.c   | 137 +++++++++++++++++++++---------------
 hw/rdma/vmw/pvrdma_qp_ops.c |   5 +-
 13 files changed, 280 insertions(+), 136 deletions(-)

-- 
2.17.1
