Received: from eggs.gnu.org ([2001:4830:134:3::10]:54000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Xeg-00028V-Tr
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Xed-0000aA-Q0
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d1Xed-0000Zp-Ju
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E077568410
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 12:27:13 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Fri, 21 Apr 2017 20:26:56 +0800
Message-Id: <20170421122710.15373-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 00/14] Trivial cleanups around error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

These are patches to:

1) reorder the function parameters so that Error **errp comes
last.

Error pointer in the middle of a function parameter list is very uncommon, and
does caused mistakes, thus is not a good style. Change to the usual way.

2) apply the error_propagate_null.cocci semantics patch again.

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
 util/qemu-sockets.c             | 38 +++++++++++++++++++++-----------------
 30 files changed, 120 insertions(+), 116 deletions(-)

-- 
2.9.3
