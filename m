Received: from eggs.gnu.org ([2001:4830:134:3::10]:41960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cdfr2-00016Q-LC
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:21:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cdfr1-0004Kj-O4
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:21:24 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 14 Feb 2017 11:21:15 -0500
Message-Id: <cover.1487088544.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] qemu-iotest tweaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

Some minor qemu-iotest tweaks.

The second patch makes it easier to add some upcoming protocols such as VXHS,
that do not support .bdrv_create.

Jeff Cody (2):
  qemu-iotests: Test 137 only supports 'file' protocol
  qemu-iotests: add ability to exclude certain protocols from tests

 tests/qemu-iotests/137       |  2 +-
 tests/qemu-iotests/common.rc | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.9.3
