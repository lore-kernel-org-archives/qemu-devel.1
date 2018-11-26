Received: from eggs.gnu.org ([2001:4830:134:3::10]:53424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gRF4H-0005Wg-Nk
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:28:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gRF4H-0004u8-23
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:28:45 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 26 Nov 2018 12:28:26 +0100
Message-Id: <20181126112828.23047-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.1 0/2] block: Fix crash on migration with
 explicit child nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

Kevin Wolf (2):
  block: Don't inactivate children before parents
  iotests: Test migration with -blockdev

 block.c                    |  22 ++++++++
 tests/qemu-iotests/234     | 105 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/234.out |  27 ++++++++++
 tests/qemu-iotests/group   |   1 +
 4 files changed, 155 insertions(+)
 create mode 100755 tests/qemu-iotests/234
 create mode 100644 tests/qemu-iotests/234.out

--=20
2.19.1
