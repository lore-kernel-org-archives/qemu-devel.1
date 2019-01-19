Received: from eggs.gnu.org ([209.51.188.92]:55202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gknTW-0001KW-OD
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gknTT-0007yp-Pu
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:38 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gknTI-0007nD-DQ
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:30 -0500
Received: by mail-wr1-x444.google.com with SMTP id p4so17905560wrt.7
	for <qemu-devel@nongnu.org>; Sat, 19 Jan 2019 02:03:20 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 19 Jan 2019 12:03:05 +0200
Message-Id: <20190119100315.23985-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel]  [PATCH PULL 00/10] RDMA queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, kamalheib1@gmail.com, liq3ea@163.com, cohuck@redhat.com, philmd@redhat.com

The following changes since commit a8d2b0685681e2f291faaa501efbbd76875f8ec8:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190118' into staging (2019-01-18 16:56:15 +0000)

are available in the Git repository at:

  https://github.com/marcel-apf/qemu tags/rdma-pull-request

for you to fetch changes up to 0f645ba16c6b76ccf2076d38460aa998198893bc:

  contrib/rdmacm-mux: fix clang compilation (2019-01-19 11:01:57 +0200)

----------------------------------------------------------------
RDMA queue
 * Clang compilation fix
 * Coverity fix
 * Various fixes for the pvrdma device

----------------------------------------------------------------
Kamal Heib (1):
      docs/pvrdma: Update rdmacm-mux documentation

Li Qiang (1):
      hw: rdma: fix an off-by-one issue

Marcel Apfelbaum (3):
      contrib/rdmacm-mux: remove Wno-format-truncation flag
      hw/rdma: modify struct initialization
      contrib/rdmacm-mux: fix clang compilation

Yuval Shaia (5):
      hw/pvrdma: Remove max-sge command-line param
      hw/rdma: Delete unused struct member
      hw/pvrdma: Post CQE when receive invalid gid index
      hw/pvrdma: Make function pvrdma_qp_send/recv return void.
      hw/rdma: Verify that ptr is not NULL before freeing

 Makefile                         |  2 ++
 contrib/rdmacm-mux/Makefile.objs |  1 -
 contrib/rdmacm-mux/main.c        | 12 ++++----
 docs/pvrdma.txt                  |  4 ++-
 hw/rdma/rdma_backend.c           | 63 +++++++++++++++-------------------------
 hw/rdma/rdma_backend.h           | 12 ++++++++
 hw/rdma/rdma_backend_defs.h      |  1 -
 hw/rdma/rdma_rm.c                |  9 ++++--
 hw/rdma/vmw/pvrdma_main.c        | 10 +++----
 hw/rdma/vmw/pvrdma_qp_ops.c      | 44 +++++++++++++++++++++-------
 hw/rdma/vmw/pvrdma_qp_ops.h      |  4 +--
 11 files changed, 96 insertions(+), 66 deletions(-)
-- 
2.17.1
