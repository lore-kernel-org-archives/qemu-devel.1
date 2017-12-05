Received: from eggs.gnu.org ([2001:4830:134:3::10]:41213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eMEcQ-00017s-0j
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:54:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eMEcP-0005Vw-6r
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:54:46 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  5 Dec 2017 15:54:20 +0100
Message-Id: <20171205145424.24598-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] block: Fix BlockDriver callbacks in
 bdrv_drain_all_begin()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org

I was looking into the drain functions in order to develop them a bit in
the direction that Fam suggested, to unify the code between bdrv_drain()
and bdrv_drain_all() a bit more, and maybe to find a place to take
coroutine locks for graph changes.

The first thing I found is a bug in bdrv_drain_all(), so I'm already
sending this part before I have made much progress with my actual plan.

Kevin Wolf (4):
  block: Make bdrv_drain_invoke() recursive
  block: Call .drain_begin only once in bdrv_drain_all_begin()
  test-bdrv-drain: Test BlockDriver callbacks for drain
  block: bdrv_drain_recurse(): Remove unused begin parameter

 block/io.c              |  25 +++++----
 tests/test-bdrv-drain.c | 137 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include  |   2 +
 3 files changed, 155 insertions(+), 9 deletions(-)
 create mode 100644 tests/test-bdrv-drain.c

-- 
2.13.6
