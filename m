Received: from eggs.gnu.org ([2001:4830:134:3::10]:51502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d1Yth-0004ra-7U
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d1Ytg-0002P0-DL
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:46:53 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Fri, 21 Apr 2017 09:46:32 -0400
Message-Id: <20170421134644.10239-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 00/12] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org

The following changes since commit bfec359afba088aaacc7d316f43302f28c6e642a:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qdev-2017-04-21' into staging (2017-04-21 11:42:03 +0100)

are available in the git repository at:

  git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to 1507631e438930bc07f776f303af127a9cdb4d41:

  qemu-iotests: _cleanup_qemu must be called on exit (2017-04-21 08:32:44 -0400)

----------------------------------------------------------------

Block patches for 2.10

----------------------------------------------------------------

Ashish Mittal (2):
  block/vxhs.c: Add support for a new block device type called "vxhs"
  block/vxhs.c: Add qemu-iotests for new block device type "vxhs"

Jeff Cody (10):
  qemu-iotests: exclude vxhs from image creation via protocol
  block: add bdrv_set_read_only() helper function
  block: do not set BDS read_only if copy_on_read enabled
  block: honor BDRV_O_ALLOW_RDWR when clearing bs->read_only
  block: code movement
  block: introduce bdrv_can_set_read_only()
  block: use bdrv_can_set_read_only() during reopen
  block/rbd - update variable names to more apt names
  block/rbd: Add support for reopen()
  qemu-iotests: _cleanup_qemu must be called on exit

 block.c                          |  56 +++-
 block/Makefile.objs              |   2 +
 block/bochs.c                    |   5 +-
 block/cloop.c                    |   5 +-
 block/dmg.c                      |   6 +-
 block/rbd.c                      |  65 +++--
 block/trace-events               |  17 ++
 block/vvfat.c                    |  19 +-
 block/vxhs.c                     | 575 +++++++++++++++++++++++++++++++++++++++
 configure                        |  39 +++
 include/block/block.h            |   2 +
 qapi/block-core.json             |  23 +-
 tests/qemu-iotests/017           |   1 +
 tests/qemu-iotests/020           |   1 +
 tests/qemu-iotests/028           |   1 +
 tests/qemu-iotests/029           |   1 +
 tests/qemu-iotests/073           |   1 +
 tests/qemu-iotests/094           |  11 +-
 tests/qemu-iotests/102           |   5 +-
 tests/qemu-iotests/109           |   1 +
 tests/qemu-iotests/114           |   1 +
 tests/qemu-iotests/117           |   1 +
 tests/qemu-iotests/130           |   2 +
 tests/qemu-iotests/134           |   1 +
 tests/qemu-iotests/140           |   1 +
 tests/qemu-iotests/141           |   1 +
 tests/qemu-iotests/143           |   1 +
 tests/qemu-iotests/156           |   2 +
 tests/qemu-iotests/158           |   1 +
 tests/qemu-iotests/common        |   6 +
 tests/qemu-iotests/common.config |  13 +
 tests/qemu-iotests/common.filter |   1 +
 tests/qemu-iotests/common.rc     |  19 ++
 33 files changed, 844 insertions(+), 42 deletions(-)
 create mode 100644 block/vxhs.c

-- 
2.9.3
