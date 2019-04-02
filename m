Received: from eggs.gnu.org ([209.51.188.92]:59437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBIqt-0002Ed-Uj
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:49:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBIqr-0002tQ-R3
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:49:19 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  2 Apr 2019 14:48:58 +0200
Message-Id: <20190402124907.24421-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] Block layer patches
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

The following changes since commit d61d1a1fb2f1db6c54651844a28389c523f3f8=
c7:

  Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20190402-pull-r=
equest' into staging (2019-04-02 08:18:24 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to f18957b854495129f2e8d6838df3bf47d1c1479c:

  tests/qemu-iotests/235: Allow fallback to tcg (2019-04-02 12:04:56 +020=
0)

----------------------------------------------------------------
Block layer patches:

- file-posix: Ignore unlock failure instead of crashing
- gluster: Limit the transfer size to 512 MiB
- stream: Fix backing chain freezing
- qemu-img: Enable BDRV_REQ_MAY_UNMAP for zero writes in convert
- iotests fixes

----------------------------------------------------------------
Alberto Garcia (3):
      block: continue until base is found in bdrv_freeze_backing_chain() =
et al
      block: freeze the backing chain earlier in stream_start()
      block: test block-stream with a base node that is used by block-com=
mit

Nir Soffer (1):
      qemu-img: Enable BDRV_REQ_MAY_UNMAP in convert

Stefano Garzarella (1):
      block/gluster: limit the transfer size to 512 MiB

Thomas Huth (3):
      iotests: Fix test 200 on s390x without virtio-pci
      tests/qemu-iotests: Remove redundant COPYING file
      tests/qemu-iotests/235: Allow fallback to tcg

Vladimir Sementsov-Ogievskiy (1):
      block/file-posix: do not fail on unlock bytes

 block.c                    |  21 ++-
 block/file-posix.c         |  12 ++
 block/gluster.c            |  16 +++
 block/stream.c             |  13 +-
 qemu-img.c                 |   3 +-
 tests/qemu-iotests/030     |  17 +++
 tests/qemu-iotests/030.out |   4 +-
 tests/qemu-iotests/200     |  14 +-
 tests/qemu-iotests/235     |   2 +-
 tests/qemu-iotests/COPYING | 339 ---------------------------------------=
------
 10 files changed, 82 insertions(+), 359 deletions(-)
 delete mode 100644 tests/qemu-iotests/COPYING
