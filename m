Received: from eggs.gnu.org ([2001:4830:134:3::10]:53510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d2YOm-0003vL-Gj
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d2YOl-0006uv-Hy
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d2YOl-0006ub-8e
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B95FC059756
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 07:27:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-149.ams2.redhat.com
	[10.36.116.149])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 087FA7BB0F
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 07:27:02 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 24 Apr 2017 09:26:45 +0200
Message-Id: <1493018820-23445-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 00/15] Error reporting patches for 2017-04-24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 32c7e0ab755745e961f1772e95cac381cc68769d:

  Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20170421' into staging (2017-04-21 15:59:27 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-error-2017-04-24

for you to fetch changes up to 021c9d25b30f53f3e97ed3198f0a85c7db025174:

  error: Apply error_propagate_null.cocci again (2017-04-24 09:13:45 +0200)

----------------------------------------------------------------
Error reporting patches for 2017-04-24

----------------------------------------------------------------
Fam Zheng (14):
      socket: Make errp the last parameter of socket_connect
      socket: Make errp the last parameter of inet_connect_saddr
      socket: Make errp the last parameter of unix_connect_saddr
      socket: Make errp the last parameter of vsock_connect_saddr
      block: Make errp the last parameter of bdrv_img_create
      crypto: Make errp the last parameter of functions
      mirror: Make errp the last parameter of mirror_start_job
      block: Make errp the last parameter of commit_active_start
      nfs: Make errp the last parameter of nfs_client_open
      fdc: Make errp the last parameter of fdctrl_connect_drives
      scsi: Make errp the last parameter of virtio_scsi_common_realize
      migration: Make errp the last parameter of local functions
      qga: Make errp the last parameter of qga_vss_fsfreeze
      error: Apply error_propagate_null.cocci again

Max Reitz (1):
      util/error: Fix leak in error_vprepend()

 block.c                         |  4 ++--
 block/crypto.c                  | 12 ++++++------
 block/mirror.c                  | 17 +++++++++--------
 block/nfs.c                     |  6 +++---
 block/replication.c             |  2 +-
 block/sheepdog.c                |  2 +-
 block/ssh.c                     |  2 +-
 blockdev.c                      | 12 ++++++------
 crypto/block-luks.c             | 21 +++++++++------------
 hw/block/fdc.c                  |  6 +++---
 hw/i386/pc.c                    |  4 +---
 hw/s390x/virtio-ccw.c           |  4 +---
 hw/scsi/vhost-scsi.c            |  6 ++++--
 hw/scsi/virtio-scsi.c           | 11 +++++++----
 hw/usb/bus.c                    |  4 +---
 include/block/block.h           |  2 +-
 include/block/block_int.h       |  6 +++---
 include/crypto/block.h          | 12 ++++++------
 include/hw/virtio/virtio-scsi.h |  8 +++++---
 include/qemu/sockets.h          |  9 +++++----
 io/channel-socket.c             |  2 +-
 migration/rdma.c                | 12 ++++++------
 net/socket.c                    |  2 +-
 qemu-img.c                      |  4 ++--
 qga/commands-win32.c            |  4 ++--
 qga/vss-win32.c                 |  2 +-
 qga/vss-win32.h                 |  2 +-
 tests/test-crypto-block.c       | 12 ++++++------
 tests/test-replication.c        |  8 ++++----
 util/error.c                    |  1 +
 util/qemu-sockets.c             | 38 +++++++++++++++++++++-----------------
 31 files changed, 121 insertions(+), 116 deletions(-)

-- 
2.7.4
