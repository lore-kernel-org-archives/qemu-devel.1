Received: from eggs.gnu.org ([2001:4830:134:3::10]:44745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eS2k5-0006Ig-AJ
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 10:26:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eS2k4-0006uH-3z
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 10:26:41 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 21 Dec 2017 16:26:28 +0100
Message-Id: <20171221152628.12942-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/13] Block layer patches
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

The following changes since commit 4da5c51cac8363f86ec92dc99c38f9382d6176=
47:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-12-20'=
 into staging (2017-12-20 20:38:36 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to af65cdae56861d5e163559a53f7ec34142a249f1:

  nvme: Add tracing (2017-12-21 16:02:14 +0100)

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

 qapi/block-core.json             |   4 +
 block/qcow2.h                    |   3 -
 block.c                          |   6 +-
 block/io.c                       |  31 ++--
 block/qcow2.c                    |  51 +-----
 hmp.c                            |   6 -
 hw/block/nvme.c                  | 349 +++++++++++++++++++++++++++++++++=
------
 tests/test-bdrv-drain.c          | 137 +++++++++++++++
 hw/block/trace-events            |  93 +++++++++++
 qemu-img.texi                    |   9 +
 tests/Makefile.include           |   2 +
 tests/qemu-iotests/197           |   4 +
 tests/qemu-iotests/common.filter |   3 +-
 13 files changed, 581 insertions(+), 117 deletions(-)
 create mode 100644 tests/test-bdrv-drain.c
