Received: from eggs.gnu.org ([2001:4830:134:3::10]:39760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXwgN-0000p7-Jk
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 18:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXwgL-0002d0-Hx
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 18:15:47 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 14 Dec 2018 18:15:05 -0500
Message-Id: <20181214231512.5295-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/7] bitmaps: remove x- prefix from QMP api
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

Touch up a few last things and remove the x- prefix.

V3:
 - Reworked qmp_log to pretty-print the outgoing command, too [Vladimir]
 - Modified test to log only bitmap information [Vladimir]
 - Test disable/enable transaction toggle [Eric]

Note that the filter I added is now unused, but I think we will want it
and it's small enough, so I'm going to check it in anyway. If you disagree,
I'll just drop the patch instead.

--js

John Snow (7):
  blockdev: abort transactions in reverse order
  blockdev: n-ary bitmap merge
  block: remove 'x' prefix from experimental bitmap APIs
  iotests.py: don't abort if IMGKEYSECRET is undefined
  iotests: add filter_generated_node_ids
  iotests: allow pretty-print for qmp_log
  iotests: add iotest 236 for testing bitmap merge

 blockdev.c                    |  96 +++++++++-------
 qapi/block-core.json          |  56 +++++-----
 qapi/transaction.json         |  12 +-
 tests/qemu-iotests/223        |   4 +-
 tests/qemu-iotests/236        | 124 +++++++++++++++++++++
 tests/qemu-iotests/236.out    | 200 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |  22 +++-
 8 files changed, 436 insertions(+), 79 deletions(-)
 create mode 100755 tests/qemu-iotests/236
 create mode 100644 tests/qemu-iotests/236.out

-- 
2.17.2
