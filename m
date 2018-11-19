Received: from eggs.gnu.org ([2001:4830:134:3::10]:46816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gOkZ1-0001Gz-BP
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:30:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gOkYv-0006xX-R1
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:30:11 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 19 Nov 2018 15:29:35 +0100
Message-Id: <20181119142944.29061-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] Block layer patches
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

The following changes since commit 9436e082de18b2fb2ceed2e9d1beef641ae64f=
23:

  MAINTAINERS: clarify some of the tags (2018-11-19 11:19:23 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 6d0a4a0fb5c8f10c8eb68b52cfda0082b00ae963:

  iotests: Test file-posix locking and reopen (2018-11-19 14:32:04 +0100)

----------------------------------------------------------------
Block layer patches:

- file-posix: Fix shared permission locks after reopen
- block: Fix error path for failed .bdrv_reopen_prepare
- qcow2: Catch invalid allocations when the image becomes too large
- vvfat/fdc/nvme: Fix segfaults and leaks

----------------------------------------------------------------
Eric Blake (3):
      qcow2: Document some maximum size constraints
      qcow2: Don't allow overflow during cluster allocation
      iotests: Add new test 220 for max compressed cluster offset

Kevin Wolf (1):
      vvfat: Fix memory leak

Li Qiang (1):
      nvme: fix oob access issue(CVE-2018-16847)

Mark Cave-Ayland (1):
      fdc: fix segfault in fdctrl_stop_transfer() when DMA is disabled

Max Reitz (3):
      block: Always abort reopen after prepare succeeded
      file-posix: Fix shared locks on reopen commit
      iotests: Test file-posix locking and reopen

 docs/interop/qcow2.txt     | 38 +++++++++++++++++-
 block/qcow2.h              |  6 +++
 block.c                    | 12 ++++++
 block/file-posix.c         |  2 +-
 block/qcow2-refcount.c     | 20 ++++++----
 block/vvfat.c              |  6 +--
 hw/block/fdc.c             |  2 +-
 hw/block/nvme.c            |  7 ++++
 tests/qemu-iotests/182     | 71 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/182.out |  9 +++++
 tests/qemu-iotests/220     | 96 ++++++++++++++++++++++++++++++++++++++++=
++++++
 tests/qemu-iotests/220.out | 54 ++++++++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 13 files changed, 310 insertions(+), 14 deletions(-)
 create mode 100755 tests/qemu-iotests/220
 create mode 100644 tests/qemu-iotests/220.out
