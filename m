Received: from eggs.gnu.org ([2001:4830:134:3::10]:51271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dGtrx-0008W3-8Q
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 17:12:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dGtrw-0003Cy-Hn
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 17:12:29 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  2 Jun 2017 23:12:08 +0200
Message-Id: <1496437930-12654-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] commit: Fix use after free in completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

Kevin Wolf (2):
  commit: Fix use after free in completion
  qemu-iotests: Test automatic commit job cancel on hot unplug

 block/commit.c             |  7 +++++++
 tests/qemu-iotests/040     | 35 +++++++++++++++++++++++++++++++++--
 tests/qemu-iotests/040.out |  4 ++--
 3 files changed, 42 insertions(+), 4 deletions(-)

-- 
1.8.3.1
