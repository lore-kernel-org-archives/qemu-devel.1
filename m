Received: from eggs.gnu.org ([2001:4830:134:3::10]:58555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4XpA-0007fQ-BR
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 15:14:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4Xp9-0006ue-2a
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 15:14:32 -0400
From: Eric Blake <eblake@redhat.com>
Date: Sat, 29 Apr 2017 14:14:10 -0500
Message-Id: <20170429191419.30051-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v11 0/9] add blkdebug tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git nbd-blkdebug-v11

Prerequisites: Kevin's block pull request:
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05799.html

v10 was:
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05227.html

Since then:
- Rebase to Kevin's block branch (patches 7, 8)
- Split series in two - this focuses on just the (relatively stable)
blkdebug enhancements (v10 6-8, 12-17), and saves the qcow2 fixes
(v10 1-5, 9-11) for another day [Max]
- further tweaks to the qemu-io alloc/map commands (patch 1 retitled,
also affecting patch 2-3)

001/9:[down] 'qemu-io: Improve alignment checks'
002/9:[0022] [FC] 'qemu-io: Switch 'alloc' command to byte-based length'
003/9:[0066] [FC] 'qemu-io: Switch 'map' output to byte-based reporting'
004/9:[----] [--] 'blkdebug: Sanity check block layer guarantees'
005/9:[----] [--] 'blkdebug: Refactor error injection'
006/9:[----] [--] 'blkdebug: Add pass-through write_zero and discard supp=
ort'
007/9:[0004] [FC] 'blkdebug: Simplify override logic'
008/9:[0010] [FC] 'blkdebug: Add ability to override unmap geometries'
009/9:[----] [-C] 'tests: Add coverage for recent block geometry fixes'

Eric Blake (9):
  qemu-io: Improve alignment checks
  qemu-io: Switch 'alloc' command to byte-based length
  qemu-io: Switch 'map' output to byte-based reporting
  blkdebug: Sanity check block layer guarantees
  blkdebug: Refactor error injection
  blkdebug: Add pass-through write_zero and discard support
  blkdebug: Simplify override logic
  blkdebug: Add ability to override unmap geometries
  tests: Add coverage for recent block geometry fixes

 qapi/block-core.json              |  33 ++++-
 block/blkdebug.c                  | 266 +++++++++++++++++++++++++++++++-=
------
 qemu-io-cmds.c                    |  61 +++++----
 tests/qemu-iotests/019.out        |   8 +-
 tests/qemu-iotests/102.out        |   4 +-
 tests/qemu-iotests/146.out        |  30 ++---
 tests/qemu-iotests/177            | 114 ++++++++++++++++
 tests/qemu-iotests/177.out        |  49 +++++++
 tests/qemu-iotests/common.pattern |   2 +-
 tests/qemu-iotests/group          |   1 +
 10 files changed, 468 insertions(+), 100 deletions(-)
 create mode 100755 tests/qemu-iotests/177
 create mode 100644 tests/qemu-iotests/177.out

--=20
2.9.3
