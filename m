Received: from eggs.gnu.org ([209.51.188.92]:56766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLBF2-0003Hg-3E
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLBF1-0002Qt-2w
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:43:03 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Mon, 29 Apr 2019 20:42:35 +0200
Message-Id: <cover.1556562150.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 0/5] Remove bdrv_read() and bdrv_write()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

Hi,

this API only had a few users left so it can be easily removed.

Regards,

Berto

Alberto Garcia (5):
  qcow2: Replace bdrv_write() with bdrv_pwrite()
  vdi: Replace bdrv_{read,write}() with bdrv_{pread,pwrite}()
  vvfat: Replace bdrv_{read,write}() with bdrv_{pread,pwrite}()
  block: Remove bdrv_read() and bdrv_write()
  qcow2: Remove BDRVQcow2State.cluster_sectors

 block/io.c             | 36 ------------------------------------
 block/qcow2-refcount.c |  4 ++--
 block/qcow2.c          |  1 -
 block/qcow2.h          |  1 -
 block/vdi.c            | 11 ++++++-----
 block/vvfat.c          | 10 ++++++----
 include/block/block.h  |  4 ----
 7 files changed, 14 insertions(+), 53 deletions(-)

-- 
2.11.0
