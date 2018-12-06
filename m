Received: from eggs.gnu.org ([2001:4830:134:3::10]:45274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gUzHd-0000SB-GH
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 14:26:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gUzHZ-0003rD-Kk
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 14:25:59 -0500
From: John Snow <jsnow@redhat.com>
Date: Thu,  6 Dec 2018 14:25:41 -0500
Message-Id: <20181206192544.3987-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] bitmaps: remove x- prefix from QMP api
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, eblake@redhat.com, Markus Armbruster <armbru@redhat.com>, vsementov@virtuozzo.com, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

Touch up a few last things and remove the x- prefix.

Test on the way, thoughts?

John Snow (3):
  blockdev: abort transactions in reverse order
  blockdev: n-ary bitmap merge
  block: remove 'x' prefix from experimental bitmap APIs

 blockdev.c             | 96 +++++++++++++++++++++++++-----------------
 qapi/block-core.json   | 56 ++++++++++++------------
 qapi/transaction.json  | 12 +++---
 tests/qemu-iotests/223 |  4 +-
 4 files changed, 94 insertions(+), 74 deletions(-)

-- 
2.17.2
