Received: from eggs.gnu.org ([209.51.188.92]:40502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9940f4835=Paul.Durrant@citrix.com>)
	id 1hDW17-0002n7-52
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9940f4835=Paul.Durrant@citrix.com>)
	id 1hDW11-0001Mx-Dy
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:16:57 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Mon, 8 Apr 2019 16:16:14 +0100
Message-ID: <20190408151617.13025-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/3] Support IOThread polling for PV shared
 rings
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

Currently xen-block uses an IOThread to handle AIO but the event channels
are dealt with on QEMU's main thread. This series allows them to be
dealt with in the same context.

Paul Durrant (3):
  xen-bus: use a separate fd for each event channel
  xen-bus: allow AioContext to be specified for each event channel
  xen-bus / xen-block: add support for event channel polling

 hw/block/dataplane/xen-block.c | 19 +++----
 hw/xen/xen-bus.c               | 92 +++++++++++++++++++---------------
 include/hw/xen/xen-bus.h       |  9 ++--
 3 files changed, 66 insertions(+), 54 deletions(-)
---
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
--
2.20.1.2.gb21ebb6
