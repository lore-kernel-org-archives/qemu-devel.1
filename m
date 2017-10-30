Received: from eggs.gnu.org ([2001:4830:134:3::10]:50491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e99qG-00074H-5c
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e99qC-0001kc-8F
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:11:00 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 30 Oct 2017 14:10:25 +0100
Message-Id: <cover.1509368614.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] Don't write headers if BDS is INACTIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, aik@ozlabs.ru, mreitz@redhat.com, den@openvz.org, stefanha@redhat.com


Changes from v1->v2:

* Drop previous parallels patches, just check BDRV_O_INACTIVE now
  (Kevin)

git-backport-diff -r qemu/master.. -u github/master
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/3:[----] [--] 'block/vhdx.c: Don't blindly update the header'
002/3:[down] 'block/parallals: Do not update header or truncate image when INMIGRATE'
003/3:[----] [--] 'qemu-iotests: update unsupported image formats in 194'


v1:

VHDX and Parallels both blindly write headers to the image file
if the images are opened R/W.  This causes an assert if the QEMU run
state is INMIGRATE.

Jeff Cody (3):
  block/vhdx.c: Don't blindly update the header
  block/parallals: Do not update header or truncate image when INMIGRATE
  qemu-iotests: update unsupported image formats in 194

 block/parallels.c      | 7 ++-----
 block/vhdx.c           | 7 -------
 tests/qemu-iotests/194 | 2 +-
 3 files changed, 3 insertions(+), 13 deletions(-)

-- 
2.13.6
