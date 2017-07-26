Received: from eggs.gnu.org ([2001:4830:134:3::10]:34118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1daL2i-0001If-IR
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1daL2h-0008W4-M2
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:03:56 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Wed, 26 Jul 2017 20:02:49 +0800
Message-ID: <20170726120255.14292-1-maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/6] Convert to realize and improve error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

This series mainly implements the conversions of ide, floppy and nvme
device to realize. Add some error handling messages and remove the local
variable local_err, use errp to propagate the error directly. Also
fix the unusual function name.

Cc: John Snow <jsnow@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>

Mao Zhongyi (6):
  hw/ide: Convert DeviceClass init to realize
  hw/block/fdc: Convert to realize
  hw/block/nvme: Convert to realize
  hw/block: Fix the return type
  hw/block: Use errp directly rather than local_err
  dev-storage: Fix the unusual function name

 hw/block/block.c                | 21 +++++----
 hw/block/dataplane/virtio-blk.c | 16 ++++---
 hw/block/dataplane/virtio-blk.h |  6 +--
 hw/block/fdc.c                  | 48 +++++++++------------
 hw/block/nvme.c                 | 24 +++++------
 hw/block/virtio-blk.c           | 17 +++-----
 hw/ide/core.c                   |  7 +--
 hw/ide/qdev.c                   | 94 +++++++++++++++++++----------------------
 hw/scsi/scsi-disk.c             | 13 ++----
 hw/usb/dev-storage.c            | 29 ++++++-------
 include/hw/block/block.h        | 10 ++---
 include/hw/ide/internal.h       |  5 ++-
 12 files changed, 135 insertions(+), 155 deletions(-)

-- 
2.9.4
