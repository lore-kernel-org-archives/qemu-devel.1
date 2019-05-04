Received: from eggs.gnu.org ([209.51.188.92]:43972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hMuyu-00021C-NK
	for qemu-devel@nongnu.org; Sat, 04 May 2019 09:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hMuyt-0002JP-Oc
	for qemu-devel@nongnu.org; Sat, 04 May 2019 09:45:36 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hMuyt-0002HV-JC
	for qemu-devel@nongnu.org; Sat, 04 May 2019 09:45:35 -0400
Received: by mail-wm1-x344.google.com with SMTP id f2so4892068wmj.3
	for <qemu-devel@nongnu.org>; Sat, 04 May 2019 06:45:34 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat,  4 May 2019 16:45:25 +0300
Message-Id: <20190504134529.4755-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel]  [PATCH PULL 0/4] RDMA queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, kamalheib1@gmail.com

The following changes since commit a6ae23831b05a11880b40f7d58e332c45a6b04f7:

  Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2019-05-03 15:26:09 +0100)

are available in the Git repository at:

  https://github.com/marcel-apf/qemu tags/rdma-pull-request

for you to fetch changes up to 355b7cf356b7f506ca1b716647cc0cf19d312fd2:

  hw/pvrdma: Add support for SRQ (2019-05-04 15:55:56 +0300)

----------------------------------------------------------------
RDMA queue

* pvrdma: Add support for SRQ

----------------------------------------------------------------
Kamal Heib (4):
      hw/rdma: Add SRQ support to backend layer
      hw/rdma: Add support for managing SRQ resource
      hw/rdma: Modify create/destroy QP to support SRQ
      hw/pvrdma: Add support for SRQ

 hw/rdma/rdma_backend.c      | 125 +++++++++++++++++++++++++--
 hw/rdma/rdma_backend.h      |  18 +++-
 hw/rdma/rdma_backend_defs.h |   5 ++
 hw/rdma/rdma_rm.c           | 117 ++++++++++++++++++++++++-
 hw/rdma/rdma_rm.h           |  13 ++-
 hw/rdma/rdma_rm_defs.h      |  10 +++
 hw/rdma/vmw/pvrdma_cmd.c    | 206 +++++++++++++++++++++++++++++++++++++++-----
 hw/rdma/vmw/pvrdma_main.c   |  16 ++++
 hw/rdma/vmw/pvrdma_qp_ops.c |  46 +++++++++-
 hw/rdma/vmw/pvrdma_qp_ops.h |   1 +
 10 files changed, 521 insertions(+), 36 deletions(-)

-- 
2.17.1
