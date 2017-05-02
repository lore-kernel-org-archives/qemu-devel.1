Received: from eggs.gnu.org ([2001:4830:134:3::10]:45222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5a8l-0003c4-V3
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:55:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5a8l-0002ax-2b
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:55:04 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  2 May 2017 16:54:47 +0100
Message-Id: <20170502155452.7033-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/5] Improve I/O tests coverage of LUKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The main goal of this series is to get the I/O tests passing
100% with LUKS when run with './check -luks'. It also adds a
few more combinations to the LUKS/dmcrypt interoperability
test.

To make LUKS testing not quite as slow, we drop the PBKDF
iteration count down to a very small value. This doesn't
remove all overhead, as formatting the volume will always
measure PBKDF timing over a 1 second interval.

Changed in v4:

 - Fix misc mistakes in syntax conversion (Max)
 - Drop changes to 120 & mark it unsupported (Max)
 - Use _unsupported_fmt (Max)

Changed in v3:

 - Fix some typos in commit message(s) (Eric)

Changed in v2:

 - Split off patch that change check.time recording since
   it was not a direct dependancy
 - Skip new 159 & 170 tests which don't work due to qemu-img
   dd limitations


Daniel P. Berrange (5):
  iotests: skip 159 & 170 with luks format
  iotests: fix remainining tests to work with LUKS
  iotests: reduce PBKDF iterations when testing LUKS
  iotests: add more LUKS hash combination tests
  iotests: chown LUKS device before qemu-io launches

 tests/qemu-iotests/033           |   12 +-
 tests/qemu-iotests/120           |    1 +
 tests/qemu-iotests/140           |   15 +-
 tests/qemu-iotests/145           |   18 +-
 tests/qemu-iotests/149           |   26 +-
 tests/qemu-iotests/149.out       | 1002 ++++++++++++++++++++++++++++----------
 tests/qemu-iotests/157           |   17 +-
 tests/qemu-iotests/157.out       |   16 +-
 tests/qemu-iotests/159           |    1 +
 tests/qemu-iotests/170           |    1 +
 tests/qemu-iotests/174           |    2 +-
 tests/qemu-iotests/common.filter |    3 +-
 tests/qemu-iotests/common.rc     |    3 +
 13 files changed, 825 insertions(+), 292 deletions(-)

-- 
2.9.3
