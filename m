Received: from eggs.gnu.org ([2001:4830:134:3::10]:47747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evOyE-0004ZM-Em
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evOyD-0002nY-KB
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:02:38 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 12 Mar 2018 16:02:12 +0100
Message-Id: <20180312150218.1314-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/6] luks: Implement .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This series implements the .bdrv_co_create callback for luks, adds an
image creation test for it and contains some bonus fixes for bugs that
the test triggered.

v2:
- Use QCryptoBlockCreateOptionsLUKS as the base type for
  BlockdevCreateOptionsLUKS [Dan]
- Use INT64_MAX instead of UINT64_MAX as the maximum image size [Eric]
- Use iter_time=3D10 in tests where the creation succeeds [Dan]


Kevin Wolf (6):
  luks: Separate image file creation from formatting
  luks: Create block_crypto_co_create_generic()
  luks: Support .bdrv_co_create
  luks: Turn invalid assertion into check
  luks: Catch integer overflow for huge sizes
  qemu-iotests: Test luks QMP image creation

 qapi/block-core.json         |  17 +++-
 block/crypto.c               | 150 ++++++++++++++++++++++---------
 tests/qemu-iotests/209       | 210 +++++++++++++++++++++++++++++++++++++=
++++++
 tests/qemu-iotests/209.out   | 136 ++++++++++++++++++++++++++++
 tests/qemu-iotests/common.rc |   2 +-
 tests/qemu-iotests/group     |   1 +
 6 files changed, 472 insertions(+), 44 deletions(-)
 create mode 100755 tests/qemu-iotests/209
 create mode 100644 tests/qemu-iotests/209.out

--=20
2.13.6
