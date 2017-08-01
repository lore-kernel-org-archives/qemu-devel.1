Received: from eggs.gnu.org ([2001:4830:134:3::10]:54553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcYRb-0000B7-Ay
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:46:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcYRa-0005Nl-BU
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:46:47 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  1 Aug 2017 16:46:17 +0200
Message-Id: <20170801144632.3831-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 00/15] Block layer patches for 2.10.0-rc1
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

The following changes since commit 5619c179057e24195ff19c8fe6d6a6cbcb16ed28:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170731' into staging (2017-07-31 14:45:42 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 9ae03670701fea9124f4f1a6d4b6d1badbf9e485:

  block/qapi: Remove redundant NULL check to silence Coverity (2017-08-01 15:26:04 +0200)

----------------------------------------------------------------
Block layer patches for 2.10.0-rc1

----------------------------------------------------------------
Eric Blake (2):
      iotests: Check dirty bitmap statistics in 124
      iotests: Add test of recent fix to 'qemu-img measure'

Kevin Wolf (8):
      qemu-iotests/041: Fix leaked scratch images
      qemu-iotests: Remove blkdebug.conf after tests
      qemu-iotests/141: Fix image cleanup
      qemu-iotests/153: Fix leaked scratch images
      qemu-iotests/162: Fix leaked temporary files
      qemu-iotests/063: Fix leaked image
      qemu-iotests/059: Fix leaked image files
      block/qapi: Remove redundant NULL check to silence Coverity

Manos Pitsidianakis (2):
      block: fix dangling bs->explicit_options in block.c
      block: fix leaks in bdrv_open_driver()

Max Reitz (2):
      iotests: Fix test 156
      iotests: Redirect stderr to stdout in 186

Stefan Hajnoczi (1):
      docs: add qemu-block-drivers(7) man page

 block.c                      |  24 +-
 block/qapi.c                 |   3 +-
 Makefile                     |  23 +-
 docs/qemu-block-drivers.texi | 799 +++++++++++++++++++++++++++++++++++++++++++
 qemu-doc.texi                | 780 +-----------------------------------------
 tests/qemu-iotests/041       |   4 +-
 tests/qemu-iotests/059       |  11 +-
 tests/qemu-iotests/059.out   |  22 +-
 tests/qemu-iotests/063       |   4 +-
 tests/qemu-iotests/074       |   1 +
 tests/qemu-iotests/124       |   7 +-
 tests/qemu-iotests/141       |   2 +-
 tests/qemu-iotests/153       |   1 +
 tests/qemu-iotests/156       |   4 +-
 tests/qemu-iotests/162       |   7 +
 tests/qemu-iotests/179       |   1 +
 tests/qemu-iotests/186       |   2 +-
 tests/qemu-iotests/186.out   |  12 +-
 tests/qemu-iotests/190       |  59 ++++
 tests/qemu-iotests/190.out   |  11 +
 tests/qemu-iotests/common.rc |   3 +
 tests/qemu-iotests/group     |   1 +
 22 files changed, 958 insertions(+), 823 deletions(-)
 create mode 100644 docs/qemu-block-drivers.texi
 create mode 100755 tests/qemu-iotests/190
 create mode 100644 tests/qemu-iotests/190.out
