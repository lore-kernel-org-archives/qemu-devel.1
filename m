Received: from eggs.gnu.org ([2001:4830:134:3::10]:55459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1fSt4X-0001it-VA
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 19:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1fSt4X-0006Y7-AO
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 19:51:34 -0400
From: Bruce Rogers <brogers@suse.com>
Date: Tue, 12 Jun 2018 17:51:01 -0600
Message-Id: <20180612235103.12633-1-brogers@suse.com>
Subject: [Qemu-devel] [PATCH 0/2] xen: add block resize infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: sstabellini@kernel.org, anthony.perard@citrix.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com

Resizing a disk on the fly is useful, including for Xen guests.
Xen has this capability, except in the case of qdisks (Xen QEMU disks).
This patch series intends to provide this capability. With these
patches, the xl command "qemu-monitor-command" can be used in
conjunction with the "info block" and "block_resize" commands to help
identify and then resize a Xen qdisk. It is anticipated that Xen's
libxl will be extended to handle qdisk resizing without resorting to
using the human monitor in this way, with libvirt support eventually
building on top of that.

Bruce Rogers (2):
  xen: add xen disk naming for use in monitor
  xen: add block resize support for xen disks

 block/block-backend.c          | 12 +++++++++++-
 blockdev.c                     |  8 ++++++++
 hw/block/xen_disk.c            | 24 ++++++++++++++++++++++++
 include/hw/xen/xen.h           |  4 ++++
 include/sysemu/block-backend.h |  2 ++
 stubs/xen-common.c             |  9 +++++++++
 6 files changed, 58 insertions(+), 1 deletion(-)

-- 
2.17.1
