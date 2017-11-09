Received: from eggs.gnu.org ([2001:4830:134:3::10]:36966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCtTB-0002KC-2N
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 15:30:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCtT7-0003fd-W2
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 15:30:37 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Thu,  9 Nov 2017 21:30:20 +0100
Message-Id: <20171109203025.27493-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/5] iotests: Make some tests less flaky
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>

There are a couple of tests that fail (on my machine) from time to
time (and by that I mean that recently I've rarely ever had a test run
with both 083 and 136 working on first try).
This series should fix most (at least the issues I am aware of).

Notes:
- 083 might have another issue, but if so it occurs extremely rarely and
  so I was unable to debug it.

- 129 is flaky, too, because it tries to use block jobs with BB
  throttling -- however, block jobs ignore that these days.  Making it
  use a throttle filter node will require quite a bit of work.  See
  http://lists.nongnu.org/archive/html/qemu-block/2017-11/msg00111.html
  for more.

- 194 sometimes hangs because the source VM fails to drain its drive.
  This is probably not an issue with the test, but actually an issue in
  qemu.  See
  http://lists.nongnu.org/archive/html/qemu-block/2017-11/msg00256.html
  for more.


v2:
 - Spelling fixes [Eric]
 - Contract grep | sed to a single sed in 083 [Eric]


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/5:[----] [--] 'iotests: Make 030 less flaky'
002/5:[----] [--] 'iotests: Add missing 'blkdebug::' in 040'
003/5:[----] [--] 'iotests: Make 055 less flaky'
004/5:[0003] [FC] 'iotests: Make 083 less flaky'
005/5:[----] [--] 'iotests: Make 136 less flaky'


Max Reitz (5):
  iotests: Make 030 less flaky
  iotests: Add missing 'blkdebug::' in 040
  iotests: Make 055 less flaky
  iotests: Make 083 less flaky
  iotests: Make 136 less flaky

 tests/qemu-iotests/030 |  8 ++++++--
 tests/qemu-iotests/040 |  2 +-
 tests/qemu-iotests/055 | 25 ++++++++++++++++---------
 tests/qemu-iotests/083 |  4 +++-
 tests/qemu-iotests/136 | 14 +++++++++++++-
 5 files changed, 39 insertions(+), 14 deletions(-)

-- 
2.13.6
