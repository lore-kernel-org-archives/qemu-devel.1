Received: from eggs.gnu.org ([2001:4830:134:3::10]:53239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fEIqX-00023f-3F
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fEIqT-0008GI-S1
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:20:49 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:54104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fEIqT-0008Fs-D9
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:20:45 -0400
Received: by mail-wm0-x243.google.com with SMTP id a67so440174wmf.3
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 11:20:45 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Thu,  3 May 2018 21:21:17 +0300
Message-Id: <20180503182125.20310-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PULL 0/8] RDMA queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel.apfelbaum@gmail.com, yuval.shaia@oracle.com, peter.maydell@linaro.org, f4bug@amsat.org

The following changes since commit 59255887e6cafeff747250d2613003a41d1d9dff:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180502' into staging (2018-05-03 11:25:14 +0100)

are available in the Git repository at:

  https://github.com/marcel-apf/qemu tags/rdma-pull-request

for you to fetch changes up to fe355cbda28b5e3dfc6a70b902343b84c466aa17:

  MAINTAINERS: update Marcel Apfelbaum email (2018-05-03 20:52:29 +0300)

----------------------------------------------------------------
* fix PVRDMA coverity errors
* update MAINTAINERS file

----------------------------------------------------------------
Marcel Apfelbaum (4):
      hw/rdma: Fix possible munmap call on a NULL pointer
      hw/rdma: Fix possible usage of a NULL pointer
      hw/rdma: Fix possible out of bounds access to port GID index
      MAINTAINERS: update Marcel Apfelbaum email

Yuval Shaia (4):
      hw/rdma: Delete port's pkey table
      hw/rdma: Fix possible out of bounds access to GID table
      hw/rdma: Fix possible out of bounds access to regs array
      hw/rdma: Delete duplicate definition of MAX_RM_TBL_NAME

 MAINTAINERS                 |  8 ++++----
 hw/rdma/rdma_backend.c      |  2 +-
 hw/rdma/rdma_rm.c           |  2 --
 hw/rdma/rdma_rm_defs.h      |  9 ++++-----
 hw/rdma/vmw/pvrdma.h        |  6 +++---
 hw/rdma/vmw/pvrdma_cmd.c    | 10 +++++++---
 hw/rdma/vmw/pvrdma_main.c   | 19 ++-----------------
 hw/rdma/vmw/pvrdma_qp_ops.c |  1 +
 8 files changed, 22 insertions(+), 35 deletions(-)

-- 
2.14.3
