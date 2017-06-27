Received: from eggs.gnu.org ([2001:4830:134:3::10]:60415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dPzG0-0003eZ-HF
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 18:46:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dPzFz-0008M8-Q7
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 18:46:52 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Wed, 28 Jun 2017 01:46:14 +0300
Message-Id: <20170627224616.18538-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH 0/2] block: block driver callbacks fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

This series makes implementing some of the bdrv_* callbacks easier for block
drivers by passing requests to bs->file if bs->drv doesn't implement it instead
of failing, and adding default bdrv_co_get_block_status() implementations.

This based against Kevin Wolf's block branch, commit
0dd2ec6bc46bd93ea0b9df602962883417f31400

Manos Pitsidianakis (2):
  block: pass bdrv_* methods to bs->file by default
  block: add default implementations for bdrv_co_get_block_status()

 block.c                   | 45 ++++++++++++++++++++++++++++++++++-----------
 block/blkdebug.c          | 12 +-----------
 block/commit.c            | 12 +-----------
 block/io.c                | 28 ++++++++++++++++++++++++++++
 block/mirror.c            | 12 +-----------
 include/block/block_int.h | 16 ++++++++++++++++
 6 files changed, 81 insertions(+), 44 deletions(-)

-- 
2.11.0
