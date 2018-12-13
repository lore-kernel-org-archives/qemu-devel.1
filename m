Received: from eggs.gnu.org ([2001:4830:134:3::10]:42560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXG9C-0002RR-Iz
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 20:50:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXG9B-0001Q7-JK
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 20:50:42 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 12 Dec 2018 20:50:06 -0500
Message-Id: <20181213015013.15350-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/7] bitmaps: remove x- prefix from QMP api
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

Touch up a few last things and remove the x- prefix.

V2:
 - Adding R-Bs from Eric and Vladimir.
 - A few trivial patches for iotests...
 - Added quick smoke test.

John Snow (7):
  blockdev: abort transactions in reverse order
  blockdev: n-ary bitmap merge
  block: remove 'x' prefix from experimental bitmap APIs
  iotests.py: don't abort if IMGKEYSECRET is undefined
  iotests: add filter_generated_node_ids
  iotests: allow pretty-print for qmp_log
  iotests: add iotest 236 for testing bitmap merge

 blockdev.c                    |  96 +++++++-----
 qapi/block-core.json          |  56 +++----
 qapi/transaction.json         |  12 +-
 tests/qemu-iotests/223        |   4 +-
 tests/qemu-iotests/236        | 123 ++++++++++++++++
 tests/qemu-iotests/236.out    | 265 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |   9 +-
 8 files changed, 489 insertions(+), 77 deletions(-)
 create mode 100755 tests/qemu-iotests/236
 create mode 100644 tests/qemu-iotests/236.out

-- 
2.17.2
