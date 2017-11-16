Received: from eggs.gnu.org ([2001:4830:134:3::10]:40182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eFNRm-0001R5-4g
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:55:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eFNRh-0007ML-OY
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:55:25 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Thu, 16 Nov 2017 19:54:54 +0300
Message-Id: <1510851298-59922-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/4] compressed block-stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

v2:
  - 1st patch omitted (applied to 2.11)
  - remarks applied

v1: http://lists.nongnu.org/archive/html/qemu-devel/2017-11/msg02515.html

It might be useful to compress images during block-stream;
this way the user can merge compressed images of a backing chain and
the result will remain compressed.

Anton Nefedov (3):
  block: support compressed write for copy-on-read
  block-stream: add compress option
  iotests: 030: add compressed block-stream test

Pavel Butsykin (1):
  qcow2: multiple clusters write compressed

 qapi/block-core.json       |  4 +++
 include/block/block_int.h  |  4 ++-
 block/io.c                 | 23 +++++++++++----
 block/qcow2.c              | 73 +++++++++++++++++++++++++++++++++-------------
 block/stream.c             | 16 +++++++---
 blockdev.c                 | 13 ++++++++-
 hmp.c                      |  2 ++
 block/trace-events         |  2 +-
 hmp-commands.hx            |  4 +--
 tests/qemu-iotests/030     | 66 ++++++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/030.out |  4 +--
 11 files changed, 172 insertions(+), 39 deletions(-)

-- 
2.7.4
