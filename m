Received: from eggs.gnu.org ([2001:4830:134:3::10]:42274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dku90-0004wX-S5
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dku90-0000BQ-5Z
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:34:06 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 24 Aug 2017 16:33:42 +0100
Message-Id: <20170824153345.2244-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] nbd-client: enter read_reply_co during
 init to avoid crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

See Patch 1 for the segfault fix.  Patches 2 & 3 add qemu-iotests coverage.

This is a rare crash that we'll probably only see in testing.  It only seems to
happen with UNIX domain sockets.

Stefan Hajnoczi (3):
  nbd-client: enter read_reply_co during init to avoid crash
  qemu-iotests: improve nbd-fault-injector.py startup protocol
  qemu-iotests: test NBD over UNIX domain sockets in 083

 block/nbd-client.c                       |   2 +-
 tests/qemu-iotests/083                   | 138 ++++++++++++++++++-----------
 tests/qemu-iotests/083.out               | 145 +++++++++++++++++++++++++++----
 tests/qemu-iotests/common.filter         |   4 +-
 tests/qemu-iotests/nbd-fault-injector.py |   4 +
 5 files changed, 220 insertions(+), 73 deletions(-)

-- 
2.13.5
