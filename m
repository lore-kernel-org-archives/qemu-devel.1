Received: from eggs.gnu.org ([209.51.188.92]:59388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGo5R-0007V7-Up
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGo5R-0007Qt-0T
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:11:05 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 17 Apr 2019 12:10:59 -0500
Message-Id: <20190417171101.1254-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/2] Saner printing of large file sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org

since v2: Fix problems pointed out by Max:
vmdk (test 59) output had not actually been tested
32-bit builds of size_to_str() have been been broken since 2.10

Eric Blake (2):
  cutils: Fix size_to_str() on 32-bit platforms
  qemu-img: Saner printing of large file sizes

 block/qapi.c               | 49 +++++++++-----------------------------
 util/cutils.c              |  2 +-
 tests/qemu-iotests/043.out |  6 ++---
 tests/qemu-iotests/053.out |  2 +-
 tests/qemu-iotests/059.out | 10 ++++----
 tests/qemu-iotests/060.out | 10 ++++----
 tests/qemu-iotests/061.out | 12 +++++-----
 tests/qemu-iotests/070.out |  2 +-
 tests/qemu-iotests/082.out | 26 ++++++++++----------
 tests/qemu-iotests/084.out |  8 +++----
 tests/qemu-iotests/089.out |  2 +-
 tests/qemu-iotests/095.out |  4 ++--
 tests/qemu-iotests/104.out |  6 ++---
 tests/qemu-iotests/110.out |  6 ++---
 tests/qemu-iotests/114.out |  2 +-
 tests/qemu-iotests/126.out |  4 ++--
 tests/qemu-iotests/130.out | 10 ++++----
 tests/qemu-iotests/153.out |  2 +-
 tests/qemu-iotests/191.out |  8 +++----
 tests/qemu-iotests/195.out |  4 ++--
 tests/qemu-iotests/198.out |  4 ++--
 tests/qemu-iotests/206.out | 10 ++++----
 tests/qemu-iotests/207.out | 12 +++++-----
 tests/qemu-iotests/210.out |  8 +++----
 tests/qemu-iotests/211.out | 10 ++++----
 tests/qemu-iotests/212.out | 10 ++++----
 tests/qemu-iotests/213.out | 10 ++++----
 tests/qemu-iotests/233.out |  4 ++--
 tests/qemu-iotests/237.out | 22 ++++++++---------
 tests/qemu-iotests/242.out | 10 ++++----
 30 files changed, 124 insertions(+), 151 deletions(-)

--=20
2.20.1
