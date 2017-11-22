Received: from eggs.gnu.org ([2001:4830:134:3::10]:39854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eHLTC-0001dJ-02
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 22:13:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eHLT9-0006r7-DZ
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 22:13:01 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:49268
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eHLT8-0006n9-Vg
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 22:12:59 -0500
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Wed, 22 Nov 2017 11:08:42 +0800
Message-ID: <cover.1511317952.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 0/4] Convert to realize and improve error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S.
	Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

This series mainly implements the conversions of ide, floppy and nvme
device to realize. Add some error handling messages and remove the local
variable local_err, use errp to propagate the error directly. Also
fix the unusual function name.

v4:
  -rebased it on top of block-next branch

v3:
  -patch1: update the test output in 051  [John Snow]
  -patch2: update the test putput in 172  [John Snow]

v2:
  -use bool as the return type instead of int. [Markus Armbruster & Stefan Hajnoczi]

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>

Mao Zhongyi (4):
  hw/block/nvme: Convert to realize
  hw/block: Fix the return type
  hw/block: Use errp directly rather than local_err
  dev-storage: Fix the unusual function name

 hw/block/block.c                | 15 +++++++++------
 hw/block/dataplane/virtio-blk.c | 12 +++++++-----
 hw/block/dataplane/virtio-blk.h |  2 +-
 hw/block/fdc.c                  | 17 ++++++-----------
 hw/block/nvme.c                 | 23 +++++++++++------------
 hw/block/virtio-blk.c           | 18 ++++++------------
 hw/ide/qdev.c                   | 12 ++++--------
 hw/scsi/scsi-disk.c             | 13 ++++---------
 hw/usb/dev-storage.c            | 29 +++++++++++++----------------
 include/hw/block/block.h        |  4 ++--
 10 files changed, 63 insertions(+), 82 deletions(-)

-- 
2.9.4
