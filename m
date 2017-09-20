Received: from eggs.gnu.org ([2001:4830:134:3::10]:41743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dufAW-00024X-Fm
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dufAR-00010k-3S
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:36:00 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Wed, 20 Sep 2017 14:43:08 +0300
Message-Id: <20170920114310.13080-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH 0/2] remove blk_pread_unthrottled()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

Cleanups for minor stuff I noticed while looking around blk_root_drained_*

Manos Pitsidianakis (2):
  block/block-backend.c: add blk_check_byte_request call to
    blk_pread/blk_pwrite
  block/block-backend.c: remove blk_pread_unthrottled()

 include/sysemu/block-backend.h |  2 --
 block/block-backend.c          | 27 ++++++---------------------
 hw/block/hd-geometry.c         |  7 +------
 3 files changed, 7 insertions(+), 29 deletions(-)

-- 
2.11.0
