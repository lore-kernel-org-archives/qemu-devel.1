Received: from eggs.gnu.org ([2001:4830:134:3::10]:43017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dmfcZ-0005VA-Oc
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 08:27:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dmfcY-0002iA-UO
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 08:27:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 29 Aug 2017 13:27:42 +0100
Message-Id: <20170829122745.14309-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] nbd-client: enter read_reply_co during
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
Cc: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

v2:
 * Rewrote Patch 1 following Paolo's suggestion [Paolo]

See Patch 1 for the segfault fix.  Patches 2 & 3 add qemu-iotests coverage.

This is a rare crash that we'll probably only see in testing.  It only seems to
happen with UNIX domain sockets.

Stefan Hajnoczi (3):
  nbd-client: avoid read_reply_co entry if send failed
  qemu-iotests: improve nbd-fault-injector.py startup protocol
  qemu-iotests: test NBD over UNIX domain sockets in 083

 block/nbd-client.c                       |  25 ++----
 tests/qemu-iotests/083                   | 138 ++++++++++++++++++-----------
 tests/qemu-iotests/083.out               | 145 +++++++++++++++++++++++++++----
 tests/qemu-iotests/common.filter         |   4 +-
 tests/qemu-iotests/nbd-fault-injector.py |   4 +
 5 files changed, 228 insertions(+), 88 deletions(-)

-- 
2.13.5
