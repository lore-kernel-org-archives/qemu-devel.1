Received: from eggs.gnu.org ([2001:4830:134:3::10]:38387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fLnYl-0003SZ-Ts
	for qemu-devel@nongnu.org; Thu, 24 May 2018 06:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fLnYi-000536-QN
	for qemu-devel@nongnu.org; Thu, 24 May 2018 06:33:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:6492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1fLnYi-00052U-H7
	for qemu-devel@nongnu.org; Thu, 24 May 2018 06:33:24 -0400
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Thu, 24 May 2018 18:33:30 +0800
Message-Id: <20180524103336.21233-1-tiwei.bie@intel.com>
Subject: [Qemu-devel] [PATCH 0/6] Support host notifiers in vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: tiwei.bie@intel.com

This patch set depends on below patch set:

http://lists.gnu.org/archive/html/qemu-devel/2018-05/msg05335.html

More details about this patch set can be found from:

http://lists.gnu.org/archive/html/qemu-devel/2018-04/msg01779.html
http://lists.gnu.org/archive/html/qemu-devel/2018-04/msg04626.html

Best regards,
Tiwei Bie

Tiwei Bie (6):
  vhost: allow backends to filter memory sections
  vhost-user: allow slave to send fds via slave channel
  vhost-user: introduce shared vhost-user state
  vhost-user: support registering external host notifiers
  libvhost-user: support host notifier
  vhost-user-bridge: support host notifier

 backends/cryptodev-vhost-user.c       |  20 ++-
 contrib/libvhost-user/libvhost-user.c |  81 ++++++++++--
 contrib/libvhost-user/libvhost-user.h |  32 +++++
 docs/interop/vhost-user.txt           |  38 ++++++
 hw/block/vhost-user-blk.c             |  22 +++-
 hw/scsi/vhost-user-scsi.c             |  20 ++-
 hw/virtio/Makefile.objs               |   2 +-
 hw/virtio/vhost-stub.c                |  10 ++
 hw/virtio/vhost-user.c                | 182 +++++++++++++++++++++++---
 hw/virtio/vhost.c                     |   9 +-
 include/hw/virtio/vhost-backend.h     |   4 +
 include/hw/virtio/vhost-user-blk.h    |   2 +
 include/hw/virtio/vhost-user-scsi.h   |   2 +
 include/hw/virtio/vhost-user.h        |  28 ++++
 net/vhost-user.c                      |  44 +++++--
 tests/vhost-user-bridge.c             |  98 +++++++++++++-
 16 files changed, 550 insertions(+), 44 deletions(-)
 create mode 100644 include/hw/virtio/vhost-user.h

-- 
2.17.0
