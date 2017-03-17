Received: from eggs.gnu.org ([2001:4830:134:3::10]:52692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1corjX-0004RM-1a
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1corjV-0000dM-Q5
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:15:54 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 17 Mar 2017 14:15:38 +0100
Message-Id: <1489756546-27142-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 0/8] Block layer fixes for 2.9.0-rc1
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

The following changes since commit 272d7dee5951f926fad1911f2f072e5915cdcba0:

  Merge remote-tracking branch 'remotes/kraxel/tags/pull-cirrus-20170316-1' into staging (2017-03-16 16:40:44 +0000)

are available in the git repository at:


  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 11f0f5e553cff93d5fc77d67b98c40adba12b729:

  Merge remote-tracking branch 'mreitz/tags/pull-block-2017-03-17' into queue-block (2017-03-17 13:03:44 +0100)

----------------------------------------------------------------

Block layer fixes for 2.9.0-rc1

----------------------------------------------------------------
Changlong Xie (1):
      replication: clarify permissions

Fam Zheng (3):
      file-posix: Don't leak fd in hdev_get_max_segments
      block: Always call bdrv_child_check_perm first
      block: Propagate error in bdrv_open_backing_file

John Snow (1):
      blockdev: fix bitmap clear undo

Kevin Wolf (1):
      Merge remote-tracking branch 'mreitz/tags/pull-block-2017-03-17' into queue-block

Paolo Bonzini (1):
      block: quiesce AioContext when detaching from it

Peter Lieven (1):
      thread-pool: add missing qemu_bh_cancel in completion function

Stefan Hajnoczi (1):
      file-posix: clean up max_segments buffer termination

 block.c                   | 21 +++++++++++++++++----
 block/file-posix.c        |  5 ++++-
 block/mirror.c            |  6 ++++--
 block/replication.c       | 14 +++++++++++++-
 blockdev.c                |  4 +++-
 include/block/block_int.h |  4 ----
 util/thread-pool.c        |  7 +++++++
 7 files changed, 48 insertions(+), 13 deletions(-)
