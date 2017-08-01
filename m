Received: from eggs.gnu.org ([2001:4830:134:3::10]:60260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dcXYt-0005e8-Sz
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dcXYt-0005DP-0V
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:50:15 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Tue,  1 Aug 2017 16:49:04 +0300
Message-Id: <20170801134907.31253-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH 0/3] block: remove legacy I/O throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>

This series depends on my other series 'add throttle block driver filter'
currently on v3, which as the name suggests adds a throttle filter driver.

Replacing the current I/O interface means the user will use the same options as
before and QEMU will create a hidden throttle filter node beneath the device's
BlockBackend. 

Manos Pitsidianakis (3):
  block: add options parameter to bdrv_new_open_driver()
  block: skip implicit nodes in snapshots, blockjobs
  block: remove legacy I/O throttling

 block.c                         |  41 ++++++++++-
 block/block-backend.c           | 149 +++++++++++++++++++++++++---------------
 block/commit.c                  |   4 +-
 block/mirror.c                  |   2 +-
 block/qapi.c                    |  14 ++--
 block/throttle.c                |   8 +++
 block/vvfat.c                   |   2 +-
 blockdev.c                      |  67 ++++++++++++++----
 include/block/block.h           |   2 +-
 include/block/block_int.h       |  15 ++++
 include/block/throttle-groups.h |   2 +
 include/sysemu/block-backend.h  |   8 +--
 tests/test-throttle.c           |  15 ++--
 13 files changed, 235 insertions(+), 94 deletions(-)

-- 
2.11.0
