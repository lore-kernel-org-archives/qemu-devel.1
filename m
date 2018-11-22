Received: from eggs.gnu.org ([2001:4830:134:3::10]:37008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPsFM-0001eQ-LD
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:54:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPsFK-0000iU-L5
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:54:32 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 22 Nov 2018 17:54:04 +0100
Message-Id: <20181122165417.23894-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/13] Block layer patches
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

The following changes since commit 47c1cc30e440860aa695358f7c2dd0b9d7b53d=
16:

  Update version for v3.1.0-rc2 release (2018-11-20 18:10:26 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 924956b1efc50af7cc334b7a14f56aa213ca27ef:

  iotests: Enhance 223 to cover multiple bitmap granularities (2018-11-22=
 16:43:52 +0100)

----------------------------------------------------------------
Block layer patches:

- block: Fix update of BDRV_O_AUTO_RDONLY in update_flags_from_options()
- qemu-img: Fix memory leak and typo in error message
- nvme: Fixes for lockups and crashes
- scsi-disk: Fix crash if underlying host file or disk returns error
- Several qemu-iotests fixes and improvements

----------------------------------------------------------------
Alberto Garcia (1):
      block: Fix update of BDRV_O_AUTO_RDONLY in update_flags_from_option=
s()

Daniel P. Berrang=C3=A9 (1):
      iotests: fix nbd test 233 to work correctly with raw images

Eric Blake (2):
      iotests: Skip 233 if certtool not installed
      iotests: Enhance 223 to cover multiple bitmap granularities

Igor Druzhinin (1):
      nvme: call blk_drain in NVMe reset code to avoid lockups

Kevin Wolf (3):
      iotests: Replace time.clock() with Timeout
      iotests: Replace assertEquals() with assertEqual()
      Revert "nvme: fix oob access issue(CVE-2018-16847)"

Logan Gunthorpe (1):
      nvme: fix bug with PCI IRQ pins on teardown

Max Reitz (2):
      qemu-img: Fix typo
      qemu-img: Fix leak

Paolo Bonzini (1):
      nvme: fix out-of-bounds access to the CMB

Richard W.M. Jones (1):
      scsi-disk: Fix crash if underlying host file or disk returns error

 block.c                       |  4 +--
 hw/block/nvme.c               | 12 +++-----
 hw/scsi/scsi-disk.c           |  2 +-
 qemu-img.c                    |  3 +-
 tests/nvme-test.c             | 68 ++++++++++++++++++++++++++++++++++++-=
------
 tests/Makefile.include        |  2 +-
 tests/qemu-iotests/041        |  6 ++--
 tests/qemu-iotests/118        | 20 +++++--------
 tests/qemu-iotests/223        | 43 ++++++++++++++++++++++-----
 tests/qemu-iotests/223.out    | 32 +++++++++++++++-----
 tests/qemu-iotests/233        |  9 ++++--
 tests/qemu-iotests/common.tls |  3 ++
 tests/qemu-iotests/iotests.py |  2 +-
 13 files changed, 148 insertions(+), 58 deletions(-)
