Received: from eggs.gnu.org ([2001:4830:134:3::10]:34077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYZ1T-0005K8-GF
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:39:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYZ1S-0006nC-R4
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:39:51 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 28 Jun 2018 17:39:34 +0200
Message-Id: <20180628153937.26097-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] qcow2: Fix cluster leaks on write error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, berto@igalia.com, qemu-devel@nongnu.org

Kevin Wolf (3):
  qemu-iotests: Update 026.out.nocache reference output
  qcow2: Free allocated clusters on write error
  qemu-iotests: Test qcow2 not leaking clusters on write error

 block/qcow2.h                      |  1 +
 block/qcow2-cluster.c              | 11 +++++++++++
 block/qcow2.c                      |  2 ++
 tests/qemu-iotests/026             | 17 +++++++++++++++++
 tests/qemu-iotests/026.out         |  8 ++++++++
 tests/qemu-iotests/026.out.nocache | 14 +++++++++++---
 6 files changed, 50 insertions(+), 3 deletions(-)

-- 
2.13.6
