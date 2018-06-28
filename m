Received: from eggs.gnu.org ([2001:4830:134:3::10]:53168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYcGm-0001kG-BU
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYcGd-0001TY-Ry
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:07:52 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 28 Jun 2018 14:07:17 -0500
Message-Id: <20180628190723.276458-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 0/6] minor qcow2 compression improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, berto@igalia.com

v5 was here:
https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg04542.html

since then:
- 5/6: update iotest number, add R-b

(git-backport-diff doesn't handle renames well)

001/6:[----] [--] 'qcow2: Prefer byte-based calls into bs->file'
002/6:[----] [--] 'qcow2: Document some maximum size constraints'
003/6:[----] [--] 'qcow2: Reduce REFT_OFFSET_MASK'
004/6:[----] [--] 'qcow2: Don't allow overflow during cluster allocation'
005/6:[down] 'iotests: Add new test 220 for max compressed cluster offset'
006/6:[----] [--] 'qcow2: Avoid memory over-allocation on compressed images'

Eric Blake (6):
  qcow2: Prefer byte-based calls into bs->file
  qcow2: Document some maximum size constraints
  qcow2: Reduce REFT_OFFSET_MASK
  qcow2: Don't allow overflow during cluster allocation
  iotests: Add new test 220 for max compressed cluster offset
  qcow2: Avoid memory over-allocation on compressed images

 docs/interop/qcow2.txt     | 40 +++++++++++++++++--
 block/qcow2.h              |  8 +++-
 block/qcow2-cluster.c      | 32 +++++++++------
 block/qcow2-refcount.c     | 27 ++++++++-----
 block/qcow2.c              |  2 +-
 tests/qemu-iotests/220     | 97 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/220.out | 54 ++++++++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 8 files changed, 234 insertions(+), 27 deletions(-)
 create mode 100755 tests/qemu-iotests/220
 create mode 100644 tests/qemu-iotests/220.out

-- 
2.14.4
