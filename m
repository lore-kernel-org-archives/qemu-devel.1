Received: from eggs.gnu.org ([2001:4830:134:3::10]:34898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=877c75a5a=Paul.Durrant@citrix.com>)
	id 1gX2VF-0006oD-UA
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:16:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=877c75a5a=Paul.Durrant@citrix.com>)
	id 1gX2VC-0002kF-OE
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:16:33 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Wed, 12 Dec 2018 11:16:23 +0000
Message-ID: <1544613386-22045-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 0/3] Performance improvements for
 xen_disk^Wxen-block
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

This series is a re-base of Tim's v2 series [1] on top of my series [2].

[1] https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg00243.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02271.html

Tim Smith (3):
  xen-block: improve batching behaviour
  xen-block: improve response latency
  xen-block: avoid repeated memory allocation

 hw/block/dataplane/xen-block.c | 105 ++++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 43 deletions(-)
---
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
-- 
2.1.4
