Received: from eggs.gnu.org ([2001:4830:134:3::10]:54237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eK4G0-0001mP-Bb
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:26:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eK4Fw-0007Sl-J7
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:26:40 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 29 Nov 2017 16:26:18 +0100
Message-Id: <20171129152628.14906-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/10] Block layer fixes for 2.11.0-rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

The following changes since commit e7b47c22e2df14d55e3e4426688c929bf8e3f7=
fb:

  osdep.h: Make TIME_MAX handle different time_t types (2017-11-24 13:23:=
36 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 5591c001a1056910afd903df3fc3c03f30746623:

  Merge remote-tracking branch 'mreitz/tags/pull-block-2017-11-29' into q=
ueue-block (2017-11-29 15:37:31 +0100)

----------------------------------------------------------------
Block layer patches for 2.11.0-rc3

----------------------------------------------------------------
Alberto Garcia (1):
      blockjob: Remove the job from the list earlier in block_job_unref()

Fam Zheng (2):
      docs: Add image locking subsection
      qemu-options: Mention locking option of file driver

John Snow (1):
      iotests: fix 075 and 078

Kashyap Chamarthy (1):
      QAPI & interop: Clarify events emitted by 'block-job-cancel'

Kevin Wolf (2):
      block: Expect graph changes in bdrv_parent_drained_begin/end
      Merge remote-tracking branch 'mreitz/tags/pull-block-2017-11-29' in=
to queue-block

Paolo Bonzini (3):
      blockjob: remove clock argument from block_job_sleep_ns
      blockjob: introduce block_job_do_yield
      blockjob: reimplement block_job_sleep_ns to allow cancellation

Peter Lieven (1):
      block/nfs: fix nfs_client_open for filesize greater than 1TB

 qapi/block-core.json                   |  6 +++
 include/block/blockjob.h               |  8 +++-
 include/block/blockjob_int.h           |  7 ++-
 block/backup.c                         |  4 +-
 block/commit.c                         |  2 +-
 block/io.c                             |  8 ++--
 block/mirror.c                         |  6 +--
 block/nfs.c                            |  7 ++-
 block/stream.c                         |  2 +-
 blockjob.c                             | 84 +++++++++++++++++++++++++++-=
------
 tests/test-blockjob-txn.c              |  2 +-
 docs/interop/live-block-operations.rst | 50 ++++++++++++--------
 docs/qemu-block-drivers.texi           | 36 +++++++++++++++
 qemu-doc.texi                          |  1 +
 qemu-options.hx                        |  4 ++
 tests/qemu-iotests/075                 | 18 ++++----
 tests/qemu-iotests/078                 | 14 +++---
 17 files changed, 187 insertions(+), 72 deletions(-)
