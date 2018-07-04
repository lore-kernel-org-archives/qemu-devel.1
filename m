Received: from eggs.gnu.org ([2001:4830:134:3::10]:43776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1faj3U-0001UG-2x
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:46:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1faj3T-0007ju-Cb
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:46:52 -0400
From: Ari Sundholm <ari@tuxera.com>
Date: Wed, 4 Jul 2018 17:46:34 +0300
Message-ID: <1530715597-30975-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/3] blklogwrites improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ari Sundholm <ari@tuxera.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

This patch set contains a trivial printf format fix, followed by two
new features for the blklogwrites driver.

The first feature is an option to append to an existing log, adopting
its sector size and other metadata in its superblock. This can be
useful, and was suggested by Kevin Wolf.

The second feature is an option for specifying how often the log
superblock is updated, in terms of number of total write entries
logged. This ensures that the log superblock is relatively up-to-date
even in the face of abnormal QEMU shutdown.

Based-on: <1530629328-10193-1-git-send-email-ari@tuxera.com>

Ari Sundholm (3):
  block/blklogwrites: Change log_sector_size from int64_t to uint64_t
  block/blklogwrites: Add an option for appending to an old log
  block/blklogwrites: Add an option for the update interval of the log
    superblock

 block/blklogwrites.c | 170 +++++++++++++++++++++++++++++++++++++++++++++------
 qapi/block-core.json |   7 ++-
 2 files changed, 157 insertions(+), 20 deletions(-)

-- 
2.7.4
