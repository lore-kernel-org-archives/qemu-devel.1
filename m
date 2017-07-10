Received: from eggs.gnu.org ([2001:4830:134:3::10]:44258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUWqm-0001rZ-KQ
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUWql-00064K-ED
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:27:36 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 10 Jul 2017 13:27:24 +0200
Message-Id: <1499686044-21721-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/40] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

The following changes since commit 77d472291812cf04f97974dadbda767e59e31f=
de:

  Merge remote-tracking branch 'remotes/sstabellini/tags/xen-20170707-tag=
' into staging (2017-07-10 10:29:11 +0100)

are available in the git repository at:


  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 51b0a488882328f8f02519bb47ca7e0e7fbe12ff:

  block: Make bdrv_is_allocated_above() byte-based (2017-07-10 13:18:07 +=
0200)

----------------------------------------------------------------
Block layer patches

----------------------------------------------------------------
Daniel P. Berrange (1):
      qemu-img: drop -e and -6 options from the 'create' & 'convert' comm=
ands

Eric Blake (25):
      qemu-io: Don't die on second open
      block: Guarantee that *file is set on bdrv_get_block_status()
      block: Simplify use of BDRV_BLOCK_RAW
      blkdebug: Support .bdrv_co_get_block_status
      blockjob: Track job ratelimits via bytes, not sectors
      trace: Show blockjob actions via bytes, not sectors
      stream: Switch stream_populate() to byte-based
      stream: Drop reached_end for stream_complete()
      stream: Switch stream_run() to byte-based
      commit: Switch commit_populate() to byte-based
      commit: Switch commit_run() to byte-based
      mirror: Switch MirrorBlockJob to byte-based
      mirror: Switch mirror_do_zero_or_discard() to byte-based
      mirror: Update signature of mirror_clip_sectors()
      mirror: Switch mirror_cow_align() to byte-based
      mirror: Switch mirror_do_read() to byte-based
      mirror: Switch mirror_iteration() to byte-based
      block: Drop unused bdrv_round_sectors_to_clusters()
      backup: Switch BackupBlockJob to byte-based
      backup: Switch block_backup.h to byte-based
      backup: Switch backup_do_cow() to byte-based
      backup: Switch backup_run() to byte-based
      block: Make bdrv_is_allocated() byte-based
      block: Minimize raw use of bds->total_sectors
      block: Make bdrv_is_allocated_above() byte-based

Herv=C3=A9 Poussineau (13):
      vvfat: fix qemu-img map and qemu-img convert
      vvfat: replace tabs by 8 spaces
      vvfat: fix typos
      vvfat: rename useless enumeration values
      vvfat: introduce offset_to_bootsector, offset_to_fat and offset_to_=
root_dir
      vvfat: fix field names in FAT12/FAT16 and FAT32 boot sectors
      vvfat: always create . and .. entries at first and in that order
      vvfat: correctly create long names for non-ASCII filenames
      vvfat: correctly create base short names for non-ASCII filenames
      vvfat: correctly generate numeric-tail of short file names
      vvfat: limit number of entries in root directory in FAT12/FAT16
      vvfat: handle KANJI lead byte 0xe5
      vvfat: change OEM name to 'MSWIN4.1'

Thomas Huth (1):
      blockdev: Print a warning for legacy drive options that belong to -=
device

 block/backup.c               |  128 +--
 block/blkdebug.c             |   11 +
 block/commit.c               |   56 +-
 block/io.c                   |  102 +-
 block/mirror.c               |  310 +++---
 block/raw-format.c           |    2 +-
 block/replication.c          |   29 +-
 block/stream.c               |   37 +-
 block/trace-events           |   14 +-
 block/vpc.c                  |    2 +-
 block/vvfat.c                | 2336 ++++++++++++++++++++++--------------=
------
 blockdev.c                   |   14 +
 include/block/block.h        |   16 +-
 include/block/block_backup.h |   11 +-
 include/qemu/ratelimit.h     |    3 +-
 migration/block.c            |   16 +-
 qemu-img.c                   |   41 +-
 qemu-io-cmds.c               |   70 +-
 qemu-io.c                    |    7 +-
 qemu-options.hx              |    9 +-
 tests/qemu-iotests/060.out   |    1 +
 tests/qemu-iotests/114.out   |    5 +-
 tests/qemu-iotests/153.out   |    6 +
 tests/qemu-iotests/177       |    3 +
 tests/qemu-iotests/177.out   |    5 +
 25 files changed, 1675 insertions(+), 1559 deletions(-)
