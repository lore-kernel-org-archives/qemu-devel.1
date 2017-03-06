Received: from eggs.gnu.org ([2001:4830:134:3::10]:34533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ckygu-0005Uv-GU
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ckygt-0003F5-Oh
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:53:08 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  6 Mar 2017 20:52:52 +0100
Message-Id: <20170306195255.15806-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 0/3] block: Add errp to b{lk,
 drv}_turncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Having an Error parameter for these functions makes sense because we
sometimes want a bit more information than just "Something failed". Some
drivers already use error_report() and the like to emit this additional
information, so it's rather obvious that we do want a real error object
here.

Max Reitz (3):
  block: Add errp to b{lk,drv}_truncate()
  block: Add errp to BD.bdrv_truncate()
  block: Add some bdrv_truncate() error messages

 include/block/block.h          |  2 +-
 include/block/block_int.h      |  2 +-
 include/sysemu/block-backend.h |  2 +-
 block.c                        | 18 +++++++++++++-----
 block/archipelago.c            |  3 ++-
 block/blkdebug.c               |  4 ++--
 block/block-backend.c          |  5 +++--
 block/commit.c                 |  5 +++--
 block/crypto.c                 |  5 +++--
 block/file-posix.c             | 10 ++++++++--
 block/file-win32.c             |  6 +++---
 block/gluster.c                |  3 ++-
 block/iscsi.c                  |  4 ++--
 block/mirror.c                 |  2 +-
 block/nfs.c                    |  2 +-
 block/parallels.c              | 13 ++++++++-----
 block/qcow.c                   |  6 +++---
 block/qcow2-refcount.c         |  5 ++++-
 block/qcow2.c                  | 23 ++++++++++++++---------
 block/qed.c                    |  8 +++++---
 block/raw-format.c             |  6 ++++--
 block/rbd.c                    |  2 +-
 block/sheepdog.c               | 14 ++++++--------
 block/vdi.c                    |  4 ++--
 block/vhdx-log.c               |  2 +-
 block/vhdx.c                   |  6 +++---
 block/vmdk.c                   | 13 +++----------
 block/vpc.c                    |  2 +-
 blockdev.c                     | 21 +--------------------
 qemu-img.c                     | 17 ++++-------------
 qemu-io-cmds.c                 |  2 +-
 31 files changed, 107 insertions(+), 110 deletions(-)

-- 
2.12.0
