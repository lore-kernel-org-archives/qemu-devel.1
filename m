Received: from eggs.gnu.org ([2001:4830:134:3::10]:42198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52B-00005Q-Sc
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df527-0001yP-3R
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:58:59 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  8 Aug 2017 15:58:20 +0200
Message-Id: <20170808135838.11525-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/18] Block layer patches for 2.10.0-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

The following changes since commit b4174c4b08a719e7df7e4f35c29f44b7c25172=
37:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2017-08-08 10:01:49 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 113fe792fd4931dd0538f03859278b8719ee4fa2:

  block/nfs: fix mutex assertion in nfs_file_close() (2017-08-08 15:19:16=
 +0200)

----------------------------------------------------------------
Block layer patches for 2.10.0-rc2

----------------------------------------------------------------
Alberto Garcia (1):
      quorum: Set sectors-count to 0 when reporting a flush error

Cleber Rosa (1):
      qemu-iotests/109: Fix lock race condition

Denis V. Lunev (3):
      block: respect error code from bdrv_getlength in handle_aiocb_write=
_zeroes
      parallels: respect error code of bdrv_getlength() in allocate_clust=
ers()
      parallels: drop check that bdrv_truncate() is working

Fam Zheng (1):
      vmdk: Fix error handling/reporting of vmdk_check

Jeff Cody (5):
      block/vhdx: check error return of bdrv_getlength()
      block/vhdx: check for offset overflow to bdrv_truncate()
      block/vhdx: check error return of bdrv_flush()
      block/vhdx: check error return of bdrv_truncate()
      block/nfs: fix mutex assertion in nfs_file_close()

Kevin Wolf (6):
      block/null: Remove 'filename' option
      block: Fix order in bdrv_replace_child()
      block: Allow reopen rw without BDRV_O_ALLOW_RDWR
      block: Set BDRV_O_ALLOW_RDWR during rw reopen
      qemu-io: Allow reopen read-write
      qemu-iotests: Test reopen between read-only and read-write

Paolo Bonzini (1):
      block: drop bdrv_set_key from BlockDriver

 include/block/block.h      |  3 +-
 include/block/block_int.h  |  1 -
 block.c                    | 20 +++++++++-----
 block/file-posix.c         |  8 +++++-
 block/nfs.c                | 11 ++++++--
 block/null.c               | 31 +++++++++++++++++----
 block/parallels.c          | 12 ++++----
 block/quorum.c             |  3 +-
 block/vhdx-log.c           | 52 +++++++++++++++++++++++++++-------
 block/vhdx.c               | 12 +++++++-
 block/vmdk.c               | 26 +++++++++++------
 qemu-io-cmds.c             | 19 +++++++++++--
 tests/qemu-iotests/109     |  3 +-
 tests/qemu-iotests/109.out | 56 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/136     |  2 +-
 tests/qemu-iotests/187     | 69 ++++++++++++++++++++++++++++++++++++++++=
++++++
 tests/qemu-iotests/187.out | 18 ++++++++++++
 tests/qemu-iotests/group   |  1 +
 18 files changed, 299 insertions(+), 48 deletions(-)
 create mode 100755 tests/qemu-iotests/187
 create mode 100644 tests/qemu-iotests/187.out
