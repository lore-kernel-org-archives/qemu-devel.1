Received: from eggs.gnu.org ([2001:4830:134:3::10]:41276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1cYiqf-0003zm-5j
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 19:32:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1cYiqc-0001LP-2i
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 19:32:33 -0500
From: Nir Soffer <nirsof@gmail.com>
Date: Wed,  1 Feb 2017 02:31:17 +0200
Message-Id: <20170201003120.23378-1-nirsof@gmail.com>
Subject: [Qemu-devel] [PATCH v5 0/3] Fix qemu-io return value on failure
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

Changes since v4:
- Added _unsupported_fmt helper
- Test any format except raw, instead of only raw
- Don't test stderr content, depends on the format
- New test move to 174 since 173 is pending
- Private copyright for new test
- Fix commit message issues

Changes since v3:
- Add cover letter
- Squash the tests fix with the behavior change, so git bisect landing on the
  change in behavior does not hit unnecessarily-broken tests.

Tested by running qemu-io manually and by running tests/check-block.sh.
Note that test 059 has one unrelated test failure.

Nir Soffer (3):
  qemu-io: Return non-zero exit code on failure
  qemu-iotests: Add _unsupported_fmt helper
  qemu-io: Add failure regression tests

 qemu-io.c                    |  8 ++++--
 tests/qemu-iotests/059.out   |  3 ---
 tests/qemu-iotests/070.out   |  1 -
 tests/qemu-iotests/075.out   |  7 ------
 tests/qemu-iotests/076.out   |  3 ---
 tests/qemu-iotests/078.out   |  6 -----
 tests/qemu-iotests/080.out   | 18 --------------
 tests/qemu-iotests/083.out   | 17 -------------
 tests/qemu-iotests/088.out   |  6 -----
 tests/qemu-iotests/092.out   | 12 ---------
 tests/qemu-iotests/116.out   |  7 ------
 tests/qemu-iotests/131.out   |  1 -
 tests/qemu-iotests/140.out   |  1 -
 tests/qemu-iotests/174       | 59 ++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/174.out   |  7 ++++++
 tests/qemu-iotests/common.rc | 11 +++++++++
 tests/qemu-iotests/group     |  1 +
 17 files changed, 84 insertions(+), 84 deletions(-)
 create mode 100755 tests/qemu-iotests/174
 create mode 100644 tests/qemu-iotests/174.out

-- 
2.9.3
