Received: from eggs.gnu.org ([2001:4830:134:3::10]:36307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1flEu8-00026r-Ps
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1flEu8-0008Tq-0w
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:48:40 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu,  2 Aug 2018 09:48:30 -0500
Message-Id: <20180802144834.520904-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4 for-3.0?] NBD fixes for unaligned images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, rjones@redhat.com

Rich reported a bug when using qemu as client to nbdkit serving
a non-sector-aligned image; in turn, I found a second bug with
qemu as server of such an image.

Both bugs were present in 2.12, and thus are not new regressions
in 3.0. If there is a reason to spin -rc4, then these could be
included; but this series alone is not a driving reason to cause
-rc4.

Eric Blake (4):
  block: Add bdrv_get_request_alignment()
  nbd/server: Advertise actual minimum block size
  iotests: Add 228 to test NBD on unaligned images
  nbd/client: Deal with unaligned size from server

 include/sysemu/block-backend.h |  1 +
 block/block-backend.c          |  7 +++
 block/nbd.c                    | 11 ++++-
 nbd/server.c                   | 10 +++--
 tests/qemu-iotests/228         | 96 ++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/228.out     |  8 ++++
 tests/qemu-iotests/group       |  1 +
 7 files changed, 129 insertions(+), 5 deletions(-)
 create mode 100755 tests/qemu-iotests/228
 create mode 100644 tests/qemu-iotests/228.out

-- 
2.14.4
