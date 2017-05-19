Received: from eggs.gnu.org ([2001:4830:134:3::10]:46452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBXic-0001hV-F1
	for qemu-devel@nongnu.org; Thu, 18 May 2017 22:32:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBXib-0002OY-Lj
	for qemu-devel@nongnu.org; Thu, 18 May 2017 22:32:42 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 18 May 2017 21:32:29 -0500
Message-Id: <20170519023233.24461-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] more blkdebug tweaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, mreitz@redhat.com

I found a crasher and some odd behavior while rebasing my
bdrv_get_block_status series, so I figured I'd get these things
fixed first.  This is based on top of Max's block branch.

Eric Blake (4):
  qemu-io: Don't die on second open
  block: Guarantee that *file is set on bdrv_get_block_status()
  block: Simplify use of BDRV_BLOCK_RAW.
  blkdebug: Support .bdrv_co_get_block_status

 block/blkdebug.c           | 11 +++++++++++
 block/commit.c             |  2 +-
 block/io.c                 |  4 +++-
 block/mirror.c             |  2 +-
 block/raw-format.c         |  2 +-
 block/vpc.c                |  2 +-
 qemu-io.c                  |  2 +-
 tests/qemu-iotests/177     |  3 +++
 tests/qemu-iotests/177.out |  5 +++++
 9 files changed, 27 insertions(+), 6 deletions(-)

-- 
2.9.4
