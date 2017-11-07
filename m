Received: from eggs.gnu.org ([2001:4830:134:3::10]:53918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eBtfn-0000sn-3k
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 21:31:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eBtfm-00080m-BJ
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 21:31:31 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Mon,  6 Nov 2017 21:31:18 -0500
Message-Id: <cover.1510021573.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/4] Don't write headers if BDS is INACTIVE
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

Changes from v2->v3:

Patch 2: Uh... fix that misspelling.  Thanks Stefan :)
Patch 3: New patch to block migration in parallels

git-backport-diff -r qemu/master.. -u 6dc6acb

001/4:[----] [--] 'block/vhdx.c: Don't blindly update the header'
002/4:[----] [--] 'block/parallels: Do not update header or truncate image when INMIGRATE'
003/4:[down] 'block/parallels: add migration blocker'
004/4:[----] [--] 'qemu-iotests: update unsupported image formats in 194'


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

Jeff Cody (4):
  block/vhdx.c: Don't blindly update the header
  block/parallels: Do not update header or truncate image when INMIGRATE
  block/parallels: add migration blocker
  qemu-iotests: update unsupported image formats in 194

 block/parallels.c      | 19 ++++++++++++++-----
 block/vhdx.c           |  7 -------
 tests/qemu-iotests/194 |  2 +-
 3 files changed, 15 insertions(+), 13 deletions(-)

-- 
2.9.5
