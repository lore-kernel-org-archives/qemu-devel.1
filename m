Received: from eggs.gnu.org ([2001:4830:134:3::10]:59576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g9xn2-0001Vf-W3
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g9xn2-0007DM-8y
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:35:32 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  9 Oct 2018 21:35:20 +0200
Message-Id: <20181009193524.19052-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] block: Add auto-read-only option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

Peter, would this provide what libvirt urgently needs for backing files
vs. the commit block job?

Kevin Wolf (4):
  block: Update flags in bdrv_set_read_only()
  block: Add auto-read-only option
  nbd: Support auto-read-only option
  file-posix: Support auto-read-only option

 qapi/block-core.json  |  6 ++++++
 block/nbd-client.h    |  1 +
 include/block/block.h |  2 ++
 block.c               | 28 +++++++++++++++++++++++++++-
 block/file-posix.c    | 13 +++++++++++++
 block/nbd-client.c    | 14 +++++++++++---
 block/nbd.c           |  4 +++-
 block/vvfat.c         |  1 +
 8 files changed, 64 insertions(+), 5 deletions(-)

-- 
2.13.6
