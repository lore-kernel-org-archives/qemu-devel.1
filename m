Received: from eggs.gnu.org ([2001:4830:134:3::10]:42399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWx1N-0000NY-Oj
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWx1K-0004VU-LA
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dWx1K-0004Tn-Ea
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:30 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 17 Jul 2017 11:48:10 +0800
Message-Id: <20170717034825.1524-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/15] Block and testing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

The following changes since commit 4871b51b9241b10f4fd8e04bbb21577886795e=
25:

  vmgenid-test: use boot-sector infrastructure (2017-07-14 17:03:03 +0100=
)

are available in the git repository at:

  git://github.com/famz/qemu.git tags/block-and-testing-pull-request

for you to fetch changes up to 978373143cf9965a6ae1dec73b046fbf3d9f9689:

  travis: add no-TCG build (2017-07-17 11:34:20 +0800)

----------------------------------------------------------------

----------------------------------------------------------------

Daniel P. Berrange (1):
  docker: Don't enable networking as a side-effect of DEBUG=3D1

Fam Zheng (2):
  docker.py: Drop infile parameter
  docker.py: Improve subprocess exit code handling

Paolo Bonzini (12):
  qcow2: call CoQueue APIs under CoMutex
  coroutine-lock: add qemu_co_rwlock_downgrade and
    qemu_co_rwlock_upgrade
  vdi: make it thread-safe
  vpc: make it thread-safe
  vvfat: make it thread-safe
  qed: move tail of qed_aio_write_main to qed_aio_write_{cow, alloc}
  block: invoke .bdrv_drain callback in coroutine context and from
    AioContext
  qed: introduce bdrv_qed_init_state
  qed: protect table cache with CoMutex
  sheepdog: add queue_lock
  ssh: support I/O from any AioContext
  travis: add no-TCG build

 .travis.yml                   |   3 +
 block/io.c                    |  42 ++++++--
 block/qcow2.c                 |   4 +-
 block/qed-cluster.c           |   4 +-
 block/qed-l2-cache.c          |   6 ++
 block/qed-table.c             |  24 +++--
 block/qed.c                   | 218 ++++++++++++++++++++++++++----------=
------
 block/qed.h                   |  11 ++-
 block/sheepdog.c              |  21 +++-
 block/ssh.c                   |  24 +++--
 block/vdi.c                   |  48 +++++-----
 block/vpc.c                   |  20 ++--
 block/vvfat.c                 |   8 +-
 include/block/block_int.h     |   2 +-
 include/qemu/coroutine.h      |  18 ++++
 tests/docker/Makefile.include |   5 +-
 tests/docker/docker.py        |  23 +++--
 util/qemu-coroutine-lock.c    |  35 +++++++
 18 files changed, 355 insertions(+), 161 deletions(-)

--=20
2.9.4
