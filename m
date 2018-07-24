Received: from eggs.gnu.org ([2001:4830:134:3::10]:60481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fhsz7-0006jy-TS
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 04:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fhsz7-0000T8-5n
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 04:47:58 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 24 Jul 2018 16:47:37 +0800
Message-Id: <20180724084739.580-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] iotests: Fix 226 on _my_ system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com

Something has locked /dev/null on my system (I still don't know what to do with
the annoying incapability of lslocks, or more precisely /proc/locks, on
inspecting OFD lock information), and as a result 226 cannot pass due to the
unexpected image locking error.

Fix the test case by disabling locking, and add a doc text about using test
images.

Fam Zheng (2):
  docs: Describe using images in writing iotests
  iotests: Don't lock /dev/null in 226

 docs/devel/testing.rst | 11 +++++++++++
 tests/qemu-iotests/226 |  4 ++--
 2 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.17.1
