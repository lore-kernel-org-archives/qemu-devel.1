Received: from eggs.gnu.org ([2001:4830:134:3::10]:52779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1faMmG-0000Gm-Fh
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1faMmB-000564-LF
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:59:36 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  3 Jul 2018 16:59:10 +0200
Message-Id: <20180703145915.32607-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 0/5] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

The following changes since commit a395717cbd26e7593d3c3fe81faca121ec6d13e8:

  Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2018-07-03 11:49:51 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 59738025a1674bb7e07713c3c93ff4fb9c5079f5:

  block: Add blklogwrites (2018-07-03 16:09:48 +0200)

----------------------------------------------------------------
Block layer patches:

- qcow2: Use worker threads for compression to improve performance of
  'qemu-img convert -W' and compressed backup jobs
- blklogwrites: New filter driver to log write requests to an image in
  the dm-log-writes format

----------------------------------------------------------------
Aapo Vienamo (1):
      block: Add blklogwrites

Ari Sundholm (1):
      block: Move two block permission constants to the relevant enum

Vladimir Sementsov-Ogievskiy (3):
      qemu-img: allow compressed not-in-order writes
      qcow2: refactor data compression
      qcow2: add compress threads

 qapi/block-core.json  |  33 ++++-
 block/qcow2.h         |   3 +
 include/block/block.h |   7 +
 block.c               |   6 -
 block/blklogwrites.c  | 392 ++++++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c         | 136 ++++++++++++++----
 qemu-img.c            |   5 -
 MAINTAINERS           |   6 +
 block/Makefile.objs   |   1 +
 9 files changed, 545 insertions(+), 44 deletions(-)
 create mode 100644 block/blklogwrites.c
