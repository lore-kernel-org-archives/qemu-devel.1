Received: from eggs.gnu.org ([2001:4830:134:3::10]:48828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fMAWQ-0003iu-AT
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fMAWP-0000Xl-8V
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:04:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:54809)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1fMAWO-0000MF-VY
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:04:33 -0400
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Fri, 25 May 2018 19:04:36 +0800
Message-Id: <20180525110441.7185-1-tiwei.bie@intel.com>
Subject: [Qemu-devel] [PATCH v2 0/5] Support host notifiers in vhost-user
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

More details about this patch set can be found from:

http://lists.gnu.org/archive/html/qemu-devel/2018-04/msg01779.html
http://lists.gnu.org/archive/html/qemu-devel/2018-04/msg04626.html

v1 -> v2:
- Drop the VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD patch; (MST)
- In PATCH 2/5, for net/vhost-user, only save VhostUserState
  in queue index 0, i.e. where `chr` is saved;
- In PATCH 4/5, check VHOST_USER_PROTOCOL_F_HOST_NOTIFIER
  before sending msg (including fd) to master; (MST)

Tiwei Bie (5):
  vhost: allow backends to filter memory sections
  vhost-user: introduce shared vhost-user state
  vhost-user: support registering external host notifiers
  libvhost-user: support host notifier
  vhost-user-bridge: support host notifier

 backends/cryptodev-vhost-user.c       |  20 +++-
 contrib/libvhost-user/libvhost-user.c |  80 +++++++++++--
 contrib/libvhost-user/libvhost-user.h |  31 +++++
 docs/interop/vhost-user.txt           |  33 ++++++
 hw/block/vhost-user-blk.c             |  22 +++-
 hw/scsi/vhost-user-scsi.c             |  20 +++-
 hw/virtio/Makefile.objs               |   2 +-
 hw/virtio/vhost-stub.c                |  10 ++
 hw/virtio/vhost-user.c                | 165 ++++++++++++++++++++++++--
 hw/virtio/vhost.c                     |   9 +-
 include/hw/virtio/vhost-backend.h     |   4 +
 include/hw/virtio/vhost-user-blk.h    |   2 +
 include/hw/virtio/vhost-user-scsi.h   |   2 +
 include/hw/virtio/vhost-user.h        |  28 +++++
 net/vhost-user.c                      |  57 ++++++---
 tests/vhost-user-bridge.c             |  98 ++++++++++++++-
 16 files changed, 542 insertions(+), 41 deletions(-)
 create mode 100644 include/hw/virtio/vhost-user.h

-- 
2.17.0
