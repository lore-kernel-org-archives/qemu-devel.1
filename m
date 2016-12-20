Received: from eggs.gnu.org ([2001:4830:134:3::10]:57508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cJPso-0007tD-2C
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 14:15:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cJPsk-0007Hg-3N
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 14:15:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cJPsj-0007H8-Ua
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 14:15:26 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5376991D2B
	for <qemu-devel@nongnu.org>; Tue, 20 Dec 2016 19:15:24 +0000 (UTC)
Received: from red.redhat.com (ovpn-117-53.rdu2.redhat.com [10.10.117.53])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id uBKJFNIe004510
	for <qemu-devel@nongnu.org>; Tue, 20 Dec 2016 14:15:23 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue, 20 Dec 2016 13:15:16 -0600
Message-Id: <20161220191523.5779-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/7] add blkdebug tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Based on Kevin's block-next branch:
http://repo.or.cz/qemu/kevin.git/shortlog/refs/heads/block-next

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git nbd-blkdebug-v4

v3 was:
https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg00278.html

Since then:
- Address comments from Max and Kevin
  - typo cleanups
  - no longer force 512-byte alignment
  - better naming
- Merge two series into one

001/7:[down] 'qcow2: Assert that cluster operations are aligned'
002/7:[down] 'qcow2: Discard/zero clusters by byte count'
003/7:[----] [--] 'blkdebug: Sanity check block layer guarantees'
004/7:[0015] [FC] 'blkdebug: Add pass-through write_zero and discard support'
005/7:[0002] [FC] 'blkdebug: Simplify override logic'
006/7:[0046] [FC] 'blkdebug: Add ability to override unmap geometries'
007/7:[0015] [FC] 'tests: Add coverage for recent block geometry fixes'

Eric Blake (7):
  qcow2: Assert that cluster operations are aligned
  qcow2: Discard/zero clusters by byte count
  blkdebug: Sanity check block layer guarantees
  blkdebug: Add pass-through write_zero and discard support
  blkdebug: Simplify override logic
  blkdebug: Add ability to override unmap geometries
  tests: Add coverage for recent block geometry fixes

 qapi/block-core.json       |  24 +++++-
 block/qcow2.h              |   9 +-
 block/blkdebug.c           | 204 +++++++++++++++++++++++++++++++++++++++++++--
 block/qcow2-cluster.c      |  29 ++++---
 block/qcow2-snapshot.c     |   7 +-
 block/qcow2.c              |  21 ++---
 tests/qemu-iotests/173     | 114 +++++++++++++++++++++++++
 tests/qemu-iotests/173.out |  49 +++++++++++
 tests/qemu-iotests/group   |   1 +
 9 files changed, 413 insertions(+), 45 deletions(-)
 create mode 100755 tests/qemu-iotests/173
 create mode 100644 tests/qemu-iotests/173.out

-- 
2.9.3
