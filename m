Received: from eggs.gnu.org ([2001:4830:134:3::10]:48162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eEYHL-00036v-Qr
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:17:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eEYHI-00074z-Bw
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:17:15 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 14 Nov 2017 13:16:48 +0300
Message-Id: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/5] compressed block-stream
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

It might be useful to compress images during block-stream;
this way the user can merge compressed images of a backing chain and
the result will remain compressed.

Anton Nefedov (4):
  qcow2: reject unaligned offsets in write compressed
  block: support compressed write for copy-on-read
  block-stream: add compress option
  iotest 030: add compressed block-stream test

Pavel Butsykin (1):
  qcow2: multiple clusters write compressed

 qapi/block-core.json       |  4 +++
 include/block/block_int.h  |  4 ++-
 block/io.c                 | 30 +++++++++++++++----
 block/qcow2.c              | 73 +++++++++++++++++++++++++++++++++++-----------
 block/stream.c             | 16 +++++++---
 blockdev.c                 | 13 ++++++++-
 hmp.c                      |  2 ++
 block/trace-events         |  2 +-
 hmp-commands.hx            |  4 +--
 tests/qemu-iotests/030     | 69 ++++++++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/030.out |  4 +--
 11 files changed, 186 insertions(+), 35 deletions(-)

-- 
2.7.4
