Received: from eggs.gnu.org ([2001:4830:134:3::10]:49068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1elDwE-0003Ra-Gi
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 08:14:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1elDwB-00087y-8E
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 08:14:30 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 12 Feb 2018 16:13:59 +0300
Message-Id: <1518441241-32557-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/2] block: fix write with zero flag set and
 iovector provided
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, berto@igalia.com, eblake@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

v2:
  patch 1: commit message fixed
  test added (patch 2)

v1: http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg00131.html

Anton Nefedov (2):
  iotest 033: add misaligned write-zeroes test via truncate
  block: fix write with zero flag set and iovector provided

 block/io.c                 |  2 +-
 tests/qemu-iotests/033     | 28 ++++++++++++++++++++++++++++
 tests/qemu-iotests/033.out | 13 +++++++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

-- 
2.7.4
