Received: from eggs.gnu.org ([2001:4830:134:3::10]:55032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1daBLL-0002o7-Iz
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 21:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1daBLG-0007NK-N8
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 21:42:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:48394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1daBLG-0007Ky-Du
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 21:42:26 -0400
From: Changpeng Liu <changpeng.liu@intel.com>
Date: Thu, 27 Jul 2017 10:00:49 +0800
Message-Id: <1501120851-4314-1-git-send-email-changpeng.liu@intel.com>
Subject: [Qemu-devel] [PATCH 0/2] Introduce a new vhost-user-blk device and
 sample application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, stefanha@redhat.com, felipe@nutanix.com, mst@redhat.com

Since vhost-user-scsi device has been part of Qemu, many users are still
using old virtio_blk device in Guest OS, compared with vhost-user-scsi,
vhost-user-blk can get better performance, because eliminate one SCSI_MOD
kernel module. This patch provides another option for uses to implement
their own I/O stacks.

Due to virtio_blk protocol limitation, Qemu virtio_blk frontend device can't
get Capacity/block size parameters through protocol, users must pass them
when started Qemu. Of course, we can extend exist vhost user messages to add
2 more messages(get_block_config/set_block_config) for vhost-user-blk device.
But for this patch, we choose append parameters to Qemu vhost-user-blk as the
solution.

Changpeng Liu (2):
  vhost-user-blk: introduce a new vhost-user-blk host device
  vhost-user-blk: introduce a vhost-user-blk sample application

 .gitignore                              |   1 +
 Makefile                                |   3 +
 Makefile.objs                           |   2 +
 configure                               |  11 +
 contrib/vhost-user-blk/Makefile.objs    |   1 +
 contrib/vhost-user-blk/vhost-user-blk.c | 695 ++++++++++++++++++++++++++++++++
 hw/block/Makefile.objs                  |   3 +
 hw/block/vhost-user-blk.c               | 352 ++++++++++++++++
 hw/virtio/virtio-pci.c                  |  55 +++
 hw/virtio/virtio-pci.h                  |  18 +
 include/hw/virtio/vhost-user-blk.h      |  46 +++
 11 files changed, 1187 insertions(+)
 create mode 100644 contrib/vhost-user-blk/Makefile.objs
 create mode 100644 contrib/vhost-user-blk/vhost-user-blk.c
 create mode 100644 hw/block/vhost-user-blk.c
 create mode 100644 include/hw/virtio/vhost-user-blk.h

-- 
1.9.3
