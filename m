Received: from eggs.gnu.org ([2001:4830:134:3::10]:60567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCbnN-0002yd-Fi
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 20:38:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCbnM-00046f-C4
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 20:38:17 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Thu,  9 Nov 2017 02:37:59 +0100
Message-Id: <20171109013804.14488-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] iotests: Make some tests less flaky
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

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


"All tests have passed, let's ship it!"
-- Me, 2:36 am


(Editor's note: "all" means raw/file, qcow2/file, and raw/nbd.)


Max Reitz (5):
  iotests: Make 030 less flaky
  iotests: Add missing 'blkdebug::' in 040
  iotests: Make 055 less flaky
  iotests: Make 083 less flaky
  iotests: Make 136 less flaky

 tests/qemu-iotests/030 |  8 ++++++--
 tests/qemu-iotests/040 |  2 +-
 tests/qemu-iotests/055 | 25 ++++++++++++++++---------
 tests/qemu-iotests/083 |  3 ++-
 tests/qemu-iotests/136 | 14 +++++++++++++-
 5 files changed, 38 insertions(+), 14 deletions(-)

-- 
2.13.6
