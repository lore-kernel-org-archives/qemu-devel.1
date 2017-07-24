Received: from eggs.gnu.org ([2001:4830:134:3::10]:60348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZfSj-0007eG-Ib
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:40:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZfSi-0006Ut-OE
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:40:01 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 24 Jul 2017 10:39:50 -0500
Message-Id: <20170724153952.26510-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 0/2] Test for bug fixes from
 byte-based block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

Kevin is correct, and I need tests of my recent bug fixes :)

https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg07235.html

Eric Blake (2):
  iotests: Check dirty bitmap statistics in 124
  iotests: Add test of recent fix to 'qemu-img measure'

 tests/qemu-iotests/124     |  7 +++++-
 tests/qemu-iotests/190     | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/190.out | 11 +++++++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100755 tests/qemu-iotests/190
 create mode 100644 tests/qemu-iotests/190.out

-- 
2.13.3
