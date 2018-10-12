Received: from eggs.gnu.org ([2001:4830:134:3::10]:37904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gAw2o-0007WL-IF
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gAw2n-0005Ys-Jd
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:55:50 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 12 Oct 2018 13:55:24 +0200
Message-Id: <20181012115532.12645-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/8] block: Add auto-read-only option
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

See patch 2 for an explanation of the motivation.

v2:
- Turn bdrv_set_read_only() into bdrv_apply_auto_read_only()
- Support the option in a lot more block drivers

Kevin Wolf (8):
  block: Update flags in bdrv_set_read_only()
  block: Add auto-read-only option
  block: Require auto-read-only for existing fallbacks
  nbd: Support auto-read-only option
  file-posix: Support auto-read-only option
  curl: Support auto-read-only option
  gluster: Support auto-read-only option
  iscsi: Support auto-read-only option

 qapi/block-core.json  |  6 +++++
 include/block/block.h |  5 +++-
 block.c               | 53 +++++++++++++++++++++++++++++++++++--------
 block/bochs.c         | 17 +++++---------
 block/cloop.c         | 16 ++++---------
 block/curl.c          |  8 +++----
 block/dmg.c           | 16 ++++---------
 block/file-posix.c    | 13 +++++++++++
 block/gluster.c       |  9 ++++++++
 block/iscsi.c         |  8 ++++---
 block/nbd-client.c    | 10 ++++----
 block/rbd.c           | 14 ++++--------
 block/vvfat.c         | 13 ++++-------
 13 files changed, 114 insertions(+), 74 deletions(-)

--=20
2.19.1
