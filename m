Received: from eggs.gnu.org ([2001:4830:134:3::10]:48416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1crPtn-000353-W9
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:09:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1crPtj-0006uu-Us
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:09:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1crPtj-0006ul-Pf
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:08:59 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 24 Mar 2017 14:08:50 +0000
Message-Id: <20170324140854.28134-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 0/3] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit 08329701199449bde497570dcfdb9c86062baf20:

  qom: Fix regression with 'qom-type' (2017-03-23 17:59:40 +0000)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 0d3ef78829332f2fdc323d1b625b60fe9c89119c:

  trace: Avoid abuse of amdvi_mmio_read (2017-03-24 09:21:42 +0000)

----------------------------------------------------------------

----------------------------------------------------------------

Eric Blake (3):
  trace: Fix backwards mirror_yield parameters
  trace: Fix incorrect megasas trace parameters
  trace: Avoid abuse of amdvi_mmio_read

 block/mirror.c       | 5 +++--
 hw/i386/amd_iommu.c  | 3 +--
 hw/scsi/megasas.c    | 6 +++---
 hw/i386/trace-events | 1 +
 4 files changed, 8 insertions(+), 7 deletions(-)

-- 
2.9.3
