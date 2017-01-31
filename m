Received: from eggs.gnu.org ([2001:4830:134:3::10]:39383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1cYYwO-000159-A8
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:57:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1cYYwL-000288-AE
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:57:48 -0500
From: Nir Soffer <nirsof@gmail.com>
Date: Tue, 31 Jan 2017 15:57:01 +0200
Message-Id: <20170131135703.5638-1-nirsof@gmail.com>
Subject: [Qemu-devel] [PATCH v4 0/2] Fix qemu-io return value on failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Nir Soffer <nirsof@gmail.com>

This series fix qemu-io to fail with non zero exit code when failing to open
the file.

Changes since v3:
- Add cover letter
- Squash the tests fix with the behavior change, so git bisect landing on the
  change in behavior does not hit unnecessarily-broken tests.

Tested by running qemu-io manually and by running tests/check-block.sh.
Note that test 059 has one unrelated test failure.

Nir Soffer (2):
  qemu-io: Return non-zero exit code on failure
  qemu-io: Add regression tests

 qemu-io.c                  |  8 +++++--
 tests/qemu-iotests/059.out |  3 ---
 tests/qemu-iotests/070.out |  1 -
 tests/qemu-iotests/075.out |  7 ------
 tests/qemu-iotests/076.out |  3 ---
 tests/qemu-iotests/078.out |  6 -----
 tests/qemu-iotests/080.out | 18 --------------
 tests/qemu-iotests/083.out | 17 -------------
 tests/qemu-iotests/088.out |  6 -----
 tests/qemu-iotests/092.out | 12 ----------
 tests/qemu-iotests/116.out |  7 ------
 tests/qemu-iotests/131.out |  1 -
 tests/qemu-iotests/140.out |  1 -
 tests/qemu-iotests/173     | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/173.out |  9 +++++++
 tests/qemu-iotests/group   |  1 +
 16 files changed, 75 insertions(+), 84 deletions(-)
 create mode 100755 tests/qemu-iotests/173
 create mode 100644 tests/qemu-iotests/173.out

-- 
2.9.3
