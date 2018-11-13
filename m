Received: from eggs.gnu.org ([2001:4830:134:3::10]:41891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMhuE-0005DY-Bz
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 18:15:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMhik-0003xO-T5
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 18:03:51 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue, 13 Nov 2018 17:03:16 -0600
Message-Id: <20181113230319.1008531-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for 3.1 v3 0/3] minor qcow2 compression
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berto@igalia.com, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

As the added iotests shows, we have a (corner case) data corruption
that is user triggerable, therefore, this is still appropriate for
inclusion in 3.1.

v6 was here:
https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg08497.html

since then:
- don't reduce constraints on reftable [Kevin]
- rebase to recent iotests changes
- drop patches that might conflict with Vladimir's work now on Kevin's
block-next branch

001/3:[0042] [FC] 'qcow2: Document some maximum size constraints'
002/3:[0003] [FC] 'qcow2: Don't allow overflow during cluster allocation'
003/3:[0003] [FC] 'iotests: Add new test 220 for max compressed cluster offset'

Eric Blake (3):
  qcow2: Document some maximum size constraints
  qcow2: Don't allow overflow during cluster allocation
  iotests: Add new test 220 for max compressed cluster offset

 docs/interop/qcow2.txt     | 30 +++++++++++-
 block/qcow2.h              |  6 +++
 block/qcow2-refcount.c     | 20 +++++---
 tests/qemu-iotests/220     | 96 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/220.out | 54 +++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 6 files changed, 198 insertions(+), 9 deletions(-)
 create mode 100755 tests/qemu-iotests/220
 create mode 100644 tests/qemu-iotests/220.out

-- 
2.17.2
