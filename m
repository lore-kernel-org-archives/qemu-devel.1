Received: from eggs.gnu.org ([2001:4830:134:3::10]:53568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dIf6D-0001qa-Gn
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:50:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dIf6C-0005tW-ON
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:50:29 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  7 Jun 2017 19:50:11 +0200
Message-Id: <1496857819-12466-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/8] Block layer patches
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

The following changes since commit b55a69fe5f0a504dac6359bb7e99a72b130c36=
61:

  Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20170=
607' into staging (2017-06-07 15:06:42 +0100)

are available in the git repository at:


  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 2cb8f869e43406ce829ebe3b16fecc78d367dc7f:

  block: fix external snapshot abort permission error (2017-06-07 18:51:5=
1 +0200)

----------------------------------------------------------------
Block layer patches

----------------------------------------------------------------
Jeff Cody (1):
      block: fix external snapshot abort permission error

Kevin Wolf (6):
      block: Fix anonymous BBs in blk_root_inactivate()
      migration: Inactivate images after .save_live_complete_precopy()
      migration/block: Clean up BBs in block_save_complete()
      qemu-iotests: Block migration test
      commit: Fix use after free in completion
      qemu-iotests: Test automatic commit job cancel on hot unplug

Peter Maydell (1):
      block/qcow.c: Fix memory leak in qcow_create()

 block/block-backend.c      |   2 +-
 block/commit.c             |   7 +++
 block/qcow.c               |   1 +
 blockdev.c                 |   4 ++
 migration/block.c          |  22 +++++--
 migration/migration.c      |  12 ++--
 tests/qemu-iotests/040     |  35 +++++++++++-
 tests/qemu-iotests/040.out |   4 +-
 tests/qemu-iotests/183     | 140 +++++++++++++++++++++++++++++++++++++++=
++++++
 tests/qemu-iotests/183.out |  46 +++++++++++++++
 tests/qemu-iotests/group   |   1 +
 11 files changed, 259 insertions(+), 15 deletions(-)
 create mode 100755 tests/qemu-iotests/183
 create mode 100644 tests/qemu-iotests/183.out
