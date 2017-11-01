Received: from eggs.gnu.org ([2001:4830:134:3::10]:59838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e9vAt-000716-5e
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:43:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e9vAo-0005aw-63
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:43:27 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  1 Nov 2017 17:42:21 +0200
Message-Id: <cover.1509550787.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 0/4] Misc qcow2 corruption checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>

Misc qcow2 corruption checks

This series contains a few checks that prevent QEMU from crashing
under some scenarios with corrupted qcow2 images.

The first patch solves the crash reported here:

  https://bugs.launchpad.net/qemu/+bug/1728615

And the others solve similar crashes that I detected in the process of
fixing this one.

Regards,

Berto

Alberto Garcia (4):
  qcow2: Prevent allocating refcount blocks at offset 0
  qcow2: Prevent allocating L2 tables at offset 0
  qcow2: Don't open images with header.refcount_table_clusters == 0
  qcow2: Add iotest for an empty refcount table

 block/qcow2-cluster.c      |  7 +++++++
 block/qcow2-refcount.c     |  7 +++++++
 block/qcow2.c              |  6 ++++++
 tests/qemu-iotests/060     | 32 ++++++++++++++++++++++++++++++++
 tests/qemu-iotests/060.out | 25 +++++++++++++++++++++++++
 5 files changed, 77 insertions(+)

-- 
2.11.0
