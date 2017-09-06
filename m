Received: from eggs.gnu.org ([2001:4830:134:3::10]:50018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpav3-0005O7-Mv
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpaux-0000nJ-Pc
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:03:05 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  6 Sep 2017 16:02:32 +0200
Message-Id: <20170906140246.7326-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/14] Block layer patches
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

The following changes since commit 98bfaac788be0ca63d7d010c8d4ba100ff1d82=
78:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-09-01-=
v3' into staging (2017-09-04 13:28:09 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 83a8c775a8bf134eb18a719322939b74a818d750:

  qcow2: move qcow2_store_persistent_dirty_bitmaps() before cache flushin=
g (2017-09-06 14:40:18 +0200)

----------------------------------------------------------------
Block layer patches

----------------------------------------------------------------
Daniel P. Berrange (1):
      block: document semantics of bdrv_co_preadv|pwritev

Eric Blake (2):
      qcow: Change signature of get_cluster_offset()
      qcow: Check failure of bdrv_getlength() and bdrv_truncate()

Manos Pitsidianakis (10):
      block: pass bdrv_* methods to bs->file by default in block filters
      block: remove unused bdrv_media_changed
      block: remove bdrv_truncate callback in blkdebug
      block: add default implementations for bdrv_co_get_block_status()
      block: move ThrottleGroup membership to ThrottleGroupMember
      block: add aio_context field in ThrottleGroupMember
      block: tidy ThrottleGroupMember initializations
      block: convert ThrottleGroup to object with QOM
      block: add throttle block filter driver
      qemu-iotests: add 184 for throttle filter driver

Pavel Butsykin (1):
      qcow2: move qcow2_store_persistent_dirty_bitmaps() before cache flu=
shing

 qapi/block-core.json            |  66 +++-
 include/block/block.h           |   1 -
 include/block/block_int.h       |  56 ++-
 include/block/throttle-groups.h |  52 ++-
 include/qemu/throttle-options.h |  60 +++-
 include/qemu/throttle.h         |   3 +
 include/sysemu/block-backend.h  |  20 +-
 block.c                         |  35 +-
 block/blkdebug.c                |  20 +-
 block/block-backend.c           |  62 ++--
 block/commit.c                  |  12 +-
 block/io.c                      |  26 ++
 block/mirror.c                  |  12 +-
 block/qapi.c                    |   8 +-
 block/qcow.c                    | 153 ++++----
 block/qcow2.c                   |  16 +-
 block/raw-format.c              |   6 -
 block/throttle-groups.c         | 750 ++++++++++++++++++++++++++++++----=
------
 block/throttle.c                | 237 +++++++++++++
 blockdev.c                      |   4 +-
 tests/test-throttle.c           | 111 +++---
 util/throttle.c                 | 151 ++++++++
 block/Makefile.objs             |   1 +
 tests/qemu-iotests/184          | 205 +++++++++++
 tests/qemu-iotests/184.out      | 302 ++++++++++++++++
 tests/qemu-iotests/group        |   1 +
 26 files changed, 1917 insertions(+), 453 deletions(-)
 create mode 100644 block/throttle.c
 create mode 100755 tests/qemu-iotests/184
 create mode 100644 tests/qemu-iotests/184.out
