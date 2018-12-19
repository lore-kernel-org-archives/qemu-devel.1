Received: from eggs.gnu.org ([2001:4830:134:3::10]:43247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZR2V-00005X-9s
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 20:52:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZR2U-0004Rl-9j
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 20:52:47 -0500
From: John Snow <jsnow@redhat.com>
Date: Tue, 18 Dec 2018 20:52:25 -0500
Message-Id: <20181219015230.18652-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/5] bitmaps: remove x- prefix from QMP api
 Part2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

Add testing to test the bitmap-merge API.

V4:
 - Removed patches 1-5 which have been staged
 - Rewrite qmp_log entirely, split into three patches
 - Pretty-printing has been extended to log() as well as qmp_log()
 - Adjust iotest 236 to be format generic instead of qcow2 [Vladimir]
 - Adjust iotest 236 to not reduplicate serialization work [Vladimir]
 - Many other small touchups

V3:
 - Reworked qmp_log to pretty-print the outgoing command, too [Vladimir]
 - Modified test to log only bitmap information [Vladimir]
 - Test disable/enable transaction toggle [Eric]

John Snow (5):
  iotests: add qmp recursive sorting function
  iotests: remove default filters from qmp_log
  iotests: change qmp_log filters to expect QMP objects only
  iotests: implement pretty-print for log and qmp_log
  iotests: add iotest 236 for testing bitmap merge

 tests/qemu-iotests/206        |   8 +-
 tests/qemu-iotests/236        | 131 ++++++++++++++++++++++
 tests/qemu-iotests/236.out    | 198 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |  53 +++++++--
 5 files changed, 381 insertions(+), 10 deletions(-)
 create mode 100755 tests/qemu-iotests/236
 create mode 100644 tests/qemu-iotests/236.out

-- 
2.17.2
