Received: from eggs.gnu.org ([2001:4830:134:3::10]:44269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1elzcu-00049z-8l
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1elzcq-0008I4-7i
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:09:44 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed, 14 Feb 2018 19:09:18 +0300
Message-Id: <1518624560-38060-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 0/2] block: fix write with zero flag set and
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
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, eblake@redhat.com, berto@igalia.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

v3: patch 1: image cluster size reduced to get away with a smaller test image
    (the cluster size can be as small as 512 bytes for qcow2,
     but the test runs for all generic formats and minimum for qed is 4k)

v2: http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg03016.html

Anton Nefedov (2):
  iotest 033: add misaligned write-zeroes test via truncate
  block: fix write with zero flag set and iovector provided

 block/io.c                 |  2 +-
 tests/qemu-iotests/033     | 29 +++++++++++++++++++++++++++++
 tests/qemu-iotests/033.out | 13 +++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

-- 
2.7.4
