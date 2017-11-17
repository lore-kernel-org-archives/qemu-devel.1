Received: from eggs.gnu.org ([2001:4830:134:3::10]:46586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFiry-0003DN-OI
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:47:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFirx-00085v-Rm
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:47:54 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 17 Nov 2017 16:47:37 +0100
Message-Id: <20171117154739.32565-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 0/2] block: Fix permissions in image
 activation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, qemu-devel@nongnu.org

Kevin Wolf (1):
  block: Fix permissions in image activation

Vladimir Sementsov-Ogievskiy (1):
  iotests: test clearing unknown autoclear_features by qcow2

 block.c                    | 32 +++++++++++++++-------
 tests/qemu-iotests/196     | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/196.out |  5 ++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 94 insertions(+), 10 deletions(-)
 create mode 100755 tests/qemu-iotests/196
 create mode 100644 tests/qemu-iotests/196.out

-- 
2.13.6
