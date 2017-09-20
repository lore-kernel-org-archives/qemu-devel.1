Received: from eggs.gnu.org ([2001:4830:134:3::10]:41618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dufAQ-0001zq-SI
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dufAQ-000108-04
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:35:54 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Wed, 20 Sep 2017 13:23:08 +0300
Message-Id: <20170920102311.25736-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH 0/3] add bdrv_co_drain_begin/end BlockDriver
 callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>

This patch series renames bdrv_co_drain to bdrv_co_drain_begin and adds a new 
bdrv_co_drain_end callback to match bdrv_drained_begin/end and 
drained_begin/end of BdrvChild. This is needed because the throttle driver 
(block/throttle.c) needs a way to mark the end of the drain in order to toggle 
io_limits_disabled correctly.

Based-on: <20170918202529.28379-1-el13635@mail.ntua.gr>
    "block/throttle-groups.c: allocate RestartData on the heap"
    Which fixes a coroutine crash in block/throttle-groups.c

Manos Pitsidianakis (3):
  block: add bdrv_co_drain_end callback
  block: rename bdrv_co_drain to bdrv_co_drain_begin
  block/throttle.c: add bdrv_co_drain_begin/end callbacks

 include/block/block_int.h |  4 +++-
 block/io.c                | 42 ++++++++++++++++++++++++++++++------------
 block/qed.c               |  6 +++---
 block/throttle.c          | 18 ++++++++++++++++++
 4 files changed, 54 insertions(+), 16 deletions(-)

-- 
2.11.0
