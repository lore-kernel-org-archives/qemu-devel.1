Received: from eggs.gnu.org ([209.51.188.92]:54480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9420f6528=Paul.Durrant@citrix.com>)
	id 1gugJQ-0001S9-8k
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:26:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9420f6528=Paul.Durrant@citrix.com>)
	id 1gugJP-0007FT-HS
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:26:04 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Fri, 15 Feb 2019 16:25:30 +0000
Message-ID: <20190215162533.19475-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/3] Coverity fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

Paul Durrant (3):
  dataplane/xen-block: remove dead code
  xen-block: remove redundant assignment
  xen-block: report error condition from vbd_name_to_disk()

 hw/block/dataplane/xen-block.c |  5 +----
 hw/block/xen-block.c           | 24 ++++++++++++++++--------
 2 files changed, 17 insertions(+), 12 deletions(-)
---
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
-- 
2.20.1.2.gb21ebb6
