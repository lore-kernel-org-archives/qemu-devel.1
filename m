Received: from eggs.gnu.org ([2001:4830:134:3::10]:56688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fdeVg-0004cR-IA
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fdeVf-00063W-LY
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:32:04 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 12 Jul 2018 18:31:45 +0200
Message-Id: <20180712163152.12521-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 0/7] Block layer fixes for 3.0-rc1
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

The following changes since commit dc3c89d612252fc461a65f54885a1fe108e9ec05:

  ui/cocoa.m: replace scrollingDeltaY with deltaY (2018-07-12 16:03:50 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 8dcd3c9b91a300c86e315d7e5427dce1383f7387:

  qemu-img: align result of is_allocated_sectors (2018-07-12 18:24:08 +0200)

----------------------------------------------------------------
Block layer patches:

- file-posix: Check correct file type (regular file for 'file',
  character or block device for 'host_device'/'host_cdrom')
- scsi-disk: Block Device Characteristics emulation fix
- qemu-img: Consider required alignment for sparse area detection
- Documentation and test improvements

----------------------------------------------------------------
Daniel Henrique Barboza (1):
      scsi-disk: Block Device Characteristics emulation fix

Fam Zheng (3):
      iotests: 153: Fix dead code
      iotests: nbd: Stop qemu-nbd before remaking image
      qemu-img: Document copy offloading implications with -S and -c

John Snow (2):
      file-posix: specify expected filetypes
      iotests: add test 226 for file driver types

Peter Lieven (1):
      qemu-img: align result of is_allocated_sectors

 block/file-posix.c           | 39 ++++++++++++++++++++------
 hw/scsi/scsi-disk.c          |  7 +++--
 qemu-img.c                   | 44 +++++++++++++++++++++++++----
 qemu-doc.texi                |  6 ++++
 qemu-img.texi                |  6 ++--
 tests/qemu-iotests/122.out   | 18 ++++++------
 tests/qemu-iotests/153       |  2 ++
 tests/qemu-iotests/153.out   | 25 +++++++++++++++++
 tests/qemu-iotests/226       | 66 ++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/226.out   | 26 +++++++++++++++++
 tests/qemu-iotests/common.rc | 21 ++++++++++----
 tests/qemu-iotests/group     |  1 +
 12 files changed, 226 insertions(+), 35 deletions(-)
 create mode 100755 tests/qemu-iotests/226
 create mode 100644 tests/qemu-iotests/226.out
