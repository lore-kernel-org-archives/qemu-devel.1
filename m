Received: from eggs.gnu.org ([2001:4830:134:3::10]:45476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dZePM-0001eu-CS
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:32:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dZePL-00076a-G6
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:32:28 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 24 Jul 2017 16:32:05 +0200
Message-Id: <1500906730-26467-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 0/5] Block layer patches for 2.10.0-rc0
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

The following changes since commit 5dd8990841a9e331d9d4838a116291698208cbb6:

  util: Introduce include/qemu/cpuid.h (2017-07-24 12:42:55 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 2c93c5cb43fd992038711f84ea34c9373273cda6:

  qemu-iotests: Avoid unnecessary sleeps (2017-07-24 15:06:04 +0200)

----------------------------------------------------------------
Block layer patches for 2.10.0-rc0

----------------------------------------------------------------
Eric Blake (3):
      iotests: Remove a few tests from 'quick' group
      dirty-bitmap: Report BlockDirtyInfo.count in bytes, as documented
      qcow2: Fix sector calculation in qcow2_measure()

Kevin Wolf (2):
      block: Skip implicit nodes in query-block/blockstats
      qemu-iotests: Avoid unnecessary sleeps

 block.c                       | 13 -----------
 block/commit.c                |  3 +++
 block/dirty-bitmap.c          |  2 +-
 block/mirror.c                |  3 +++
 block/qapi.c                  | 33 ++++++++++++++++++++++------
 block/qcow2.c                 |  4 ++--
 include/block/block.h         |  1 -
 include/block/block_int.h     |  1 +
 qapi/block-core.json          |  6 ++++--
 tests/qemu-iotests/030        |  7 +++---
 tests/qemu-iotests/040        | 30 +++++++++++++++++++++++++-
 tests/qemu-iotests/040.out    |  4 ++--
 tests/qemu-iotests/041        | 50 +++++++++++++++++++++++++++++++++++--------
 tests/qemu-iotests/041.out    |  4 ++--
 tests/qemu-iotests/055        | 15 +++++++------
 tests/qemu-iotests/group      |  4 ++--
 tests/qemu-iotests/iotests.py | 27 +++++++++++++++++++++++
 17 files changed, 157 insertions(+), 50 deletions(-)
