Received: from eggs.gnu.org ([2001:4830:134:3::10]:55395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fO3T6-0007VY-Sd
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fO3T5-0006pj-UH
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:56:56 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 30 May 2018 17:56:30 +0200
Message-Id: <20180530155647.14090-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 00/17] Block layer patches
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

  Merge remote-tracking branch 'remotes/edgar/tags/edgar/xilinx-next-2018-05-29-v1.for-upstream' into staging (2018-05-29 13:01:11 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 3fb588a0f2c006122c34e1960a15c87ae2b927eb:

  block/create: Mark blockdev-create stable (2018-05-30 13:31:18 +0200)

----------------------------------------------------------------
Block layer patches:

- Add blockdev-create job
- qcow2: Silence Coverity false positive

----------------------------------------------------------------
Alberto Garcia (1):
      qcow2: Fix Coverity warning when calculating the refcount cache size

Kevin Wolf (16):
      vdi: Fix vdi_co_do_create() return value
      vhdx: Fix vhdx_co_create() return value
      job: Add error message for failing jobs
      block/create: Make x-blockdev-create a job
      qemu-iotests: Add VM.get_qmp_events_filtered()
      qemu-iotests: Add VM.qmp_log()
      qemu-iotests: Add iotests.img_info_log()
      qemu-iotests: Add VM.run_job()
      qemu-iotests: iotests.py helper for non-file protocols
      qemu-iotests: Rewrite 206 for blockdev-create job
      qemu-iotests: Rewrite 207 for blockdev-create job
      qemu-iotests: Rewrite 210 for blockdev-create job
      qemu-iotests: Rewrite 211 for blockdev-create job
      qemu-iotests: Rewrite 212 for blockdev-create job
      qemu-iotests: Rewrite 213 for blockdev-create job
      block/create: Mark blockdev-create stable

 qapi/block-core.json          |  18 +-
 qapi/job.json                 |   4 +-
 include/qemu/job.h            |   7 +-
 block/backup.c                |   2 +-
 block/commit.c                |   2 +-
 block/create.c                |  67 +++--
 block/mirror.c                |   2 +-
 block/qcow2.c                 |   5 +-
 block/stream.c                |   2 +-
 block/vdi.c                   |   1 +
 block/vhdx.c                  |   2 +-
 job-qmp.c                     |   9 +-
 job.c                         |  16 +-
 tests/test-bdrv-drain.c       |   2 +-
 tests/test-blockjob-txn.c     |   2 +-
 tests/test-blockjob.c         |   2 +-
 tests/qemu-iotests/206        | 680 ++++++++++++++++--------------------------
 tests/qemu-iotests/206.out    | 253 +++++++++-------
 tests/qemu-iotests/207        | 440 ++++++++++++---------------
 tests/qemu-iotests/207.out    | 107 +++----
 tests/qemu-iotests/210        | 393 ++++++++++--------------
 tests/qemu-iotests/210.out    | 197 ++++++++----
 tests/qemu-iotests/211        | 381 ++++++++++-------------
 tests/qemu-iotests/211.out    | 133 +++++----
 tests/qemu-iotests/212        | 483 +++++++++++-------------------
 tests/qemu-iotests/212.out    | 191 +++++++-----
 tests/qemu-iotests/213        | 520 ++++++++++++--------------------
 tests/qemu-iotests/213.out    | 208 ++++++++-----
 tests/qemu-iotests/iotests.py |  78 +++++
 29 files changed, 1981 insertions(+), 2226 deletions(-)
