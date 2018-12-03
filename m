Received: from eggs.gnu.org ([2001:4830:134:3::10]:54030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gTrYE-0007d9-9M
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:58:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gTrYD-0008Jj-8R
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:58:30 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  3 Dec 2018 17:58:08 +0100
Message-Id: <20181203165810.14509-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

The following changes since commit 83ea23cd207a03c5736be0231acbf7f8b05dbf=
52:

  i386: hvf: Fix overrun of _decode_tbl1 (2018-12-03 15:09:55 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to db5e8210adbafe9c6383d8364345a8c545d38e62:

  iotests: simple mirror test with kvm on 1G image (2018-12-03 16:51:53 +=
0100)

----------------------------------------------------------------
Block layer patches:

- mirror: Fix deadlock

----------------------------------------------------------------
Vladimir Sementsov-Ogievskiy (2):
      mirror: fix dead-lock
      iotests: simple mirror test with kvm on 1G image

 block/mirror.c             | 13 +++-----
 tests/qemu-iotests/235     | 76 ++++++++++++++++++++++++++++++++++++++++=
++++++
 tests/qemu-iotests/235.out |  3 ++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 85 insertions(+), 8 deletions(-)
 create mode 100755 tests/qemu-iotests/235
 create mode 100644 tests/qemu-iotests/235.out
