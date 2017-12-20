Received: from eggs.gnu.org ([2001:4830:134:3::10]:55447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eReHp-0004N1-RO
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:19:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eReHo-00068f-Ve
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:19:53 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 20 Dec 2017 14:19:25 +0100
Message-Id: <20171220131939.27543-1-kwolf@redhat.com>
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

The following changes since commit af352675efb7e92a1f5f6461a042a12015ab3d=
12:

  Merge remote-tracking branch 'remotes/aurel/tags/pull-target-sh4-201712=
18' into staging (2017-12-19 19:11:11 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to b4d526c87b26aff6d8b353951aa175a1236ad887:

  nvme: Add tracing (2017-12-20 11:05:49 +0100)

----------------------------------------------------------------
Block layer patches

----------------------------------------------------------------
Doug Gale (1):
      nvme: Add tracing

Edgar Kaziakhmedov (1):
      qcow2: get rid of qcow2_backing_read1 routine

Fam Zheng (1):
      qemu-img: Document --force-share / -U

John Snow (1):
      iotests: fix 197 for vpc

Kevin Wolf (9):
      block: Formats don't need CONSISTENT_READ with NO_IO
      block: Make bdrv_drain_invoke() recursive
      block: Call .drain_begin only once in bdrv_drain_all_begin()
      test-bdrv-drain: Test BlockDriver callbacks for drain
      block: bdrv_drain_recurse(): Remove unused begin parameter
      block: Don't wait for requests in bdrv_drain*_end()
      block: Unify order in drain functions
      block: Don't acquire AioContext in hmp_qemu_io()
      block: Document that x-blockdev-change breaks quorum children list

Mao Zhongyi (1):
      hw/block/nvme: Convert to realize

 qapi/block-core.json             |   4 +
 block/qcow2.h                    |   3 -
 block.c                          |   6 +-
 block/io.c                       |  31 ++--
 block/qcow2.c                    |  51 +-----
 hmp.c                            |   6 -
 hw/block/nvme.c                  | 367 ++++++++++++++++++++++++++++++++-=
------
 tests/test-bdrv-drain.c          | 137 +++++++++++++++
 hw/block/trace-events            |  93 ++++++++++
 qemu-img.texi                    |   9 +
 tests/Makefile.include           |   2 +
 tests/qemu-iotests/197           |   4 +
 tests/qemu-iotests/common.filter |   3 +-
 13 files changed, 591 insertions(+), 125 deletions(-)
 create mode 100644 tests/test-bdrv-drain.c
