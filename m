Received: from eggs.gnu.org ([2001:4830:134:3::10]:44753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwUF3-0005hy-Sh
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwUF2-0003MX-Vz
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:47:57 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Apr 2017 15:47:35 +0200
Message-Id: <1491572865-8549-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/10] Block layer fixes for 2.9.0-rc4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

The following changes since commit 5fe2339e6b09da7d6f48b9bef0f1a7360392b4=
89:

  Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-201704=
06.0' into staging (2017-04-07 10:29:56 +0100)

are available in the git repository at:


  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 19dd29e8a77cd820515de5289f566508e0ed4926:

  mirror: Fix aio context of mirror_top_bs (2017-04-07 14:44:06 +0200)

----------------------------------------------------------------
Block layer fixes for 2.9.0-rc4

----------------------------------------------------------------
Fam Zheng (3):
      block: Fix unpaired aio_disable_external in external snapshot
      block: Assert attached child node has right aio context
      mirror: Fix aio context of mirror_top_bs

Jeff Cody (1):
      qemu-img: img_create does not support image-opts, fix docs

Kevin Wolf (4):
      block: Ignore guest dev permissions during incoming migration
      commit: Set commit_top_bs->aio_context
      commit: Set commit_top_bs->total_sectors
      block: Don't check permissions for copy on read

Max Reitz (2):
      block/mirror: Fix use-after-free
      iotests: Add mirror tests for orphaned source

 block.c                       |  4 ++++
 block/block-backend.c         | 40 ++++++++++++++++++++++++++++++++++++-
 block/commit.c                |  3 +++
 block/io.c                    |  9 ++++++++-
 block/mirror.c                | 13 ++++++++++--
 blockdev.c                    |  4 ++--
 include/block/block.h         |  2 ++
 migration/migration.c         |  8 ++++++++
 qemu-img-cmds.hx              |  4 ++--
 qmp.c                         |  6 ++++++
 tests/qemu-iotests/041        | 46 +++++++++++++++++++++++++++++++++++++=
++++++
 tests/qemu-iotests/041.out    |  4 ++--
 tests/qemu-iotests/iotests.py | 15 ++++++++++++++
 13 files changed, 148 insertions(+), 10 deletions(-)
