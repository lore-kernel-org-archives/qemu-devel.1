Received: from eggs.gnu.org ([2001:4830:134:3::10]:45353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f0TEM-0002wv-Jf
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f0TEL-0003t5-85
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:36:14 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 26 Mar 2018 16:35:41 +0200
Message-Id: <20180326143600.7724-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/19] Block layer patches
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

The following changes since commit 7b1db0908d88f0c9cfac24e214ff72a860692e=
23:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
80323' into staging (2018-03-25 13:51:33 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 0b7e7f66813a7e346e12d47be977a32a530a6316:

  qemu-iotests: Test vhdx image creation with QMP (2018-03-26 12:17:43 +0=
200)

----------------------------------------------------------------
Block layer patches

----------------------------------------------------------------
Alberto Garcia (1):
      qcow2: Reset free_cluster_index when allocating a new refcount bloc=
k

Eric Blake (1):
      iotests: 163 is not quick

Fabiano Rosas (5):
      block/replication: Remove protocol_name field
      block/quorum: Remove protocol-related fields
      block/throttle: Remove protocol-related fields
      block/blkreplay: Remove protocol-related fields
      include/block/block_int: Document protocol related functions

Kevin Wolf (12):
      vdi: Change 'static' create option to 'preallocation' in QMP
      vdi: Fix build with CONFIG_VDI_DEBUG
      qemu-iotests: Test vdi image creation with QMP
      qemu-iotests: Enable 025 for luks
      luks: Turn another invalid assertion into check
      qemu-iotests: Test invalid resize on luks
      parallels: Check maximum cluster size on create
      qemu-iotests: Test parallels image creation with QMP
      vhdx: Require power-of-two block size on create
      vhdx: Don't use error_setg_errno() with constant errno
      vhdx: Check for 4 GB maximum log size on creation
      qemu-iotests: Test vhdx image creation with QMP

 qapi/block-core.json       |   7 +-
 include/block/block_int.h  |   8 ++
 replication.h              |   1 -
 block/blkreplay.c          |   3 +-
 block/crypto.c             |   6 +-
 block/parallels.c          |   5 +
 block/qcow2-refcount.c     |   7 +
 block/quorum.c             |   3 +-
 block/replication.c        |   1 -
 block/throttle.c           |   3 +-
 block/vdi.c                |  46 ++++--
 block/vhdx.c               |  17 ++-
 tests/qemu-iotests/025     |   9 +-
 tests/qemu-iotests/026.out |   6 +-
 tests/qemu-iotests/121     |  20 +++
 tests/qemu-iotests/121.out |  10 ++
 tests/qemu-iotests/210     |  37 +++++
 tests/qemu-iotests/210.out |  16 +++
 tests/qemu-iotests/211     | 246 ++++++++++++++++++++++++++++++++
 tests/qemu-iotests/211.out |  97 +++++++++++++
 tests/qemu-iotests/212     | 326 +++++++++++++++++++++++++++++++++++++++=
+++
 tests/qemu-iotests/212.out | 111 ++++++++++++++
 tests/qemu-iotests/213     | 349 +++++++++++++++++++++++++++++++++++++++=
++++++
 tests/qemu-iotests/213.out | 121 ++++++++++++++++
 tests/qemu-iotests/group   |   5 +-
 25 files changed, 1423 insertions(+), 37 deletions(-)
 create mode 100755 tests/qemu-iotests/211
 create mode 100644 tests/qemu-iotests/211.out
 create mode 100755 tests/qemu-iotests/212
 create mode 100644 tests/qemu-iotests/212.out
 create mode 100755 tests/qemu-iotests/213
 create mode 100644 tests/qemu-iotests/213.out
