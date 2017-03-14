Received: from eggs.gnu.org ([2001:4830:134:3::10]:53285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cncNE-0002OX-95
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 22:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cncND-0008Ap-F2
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 22:39:44 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 14 Mar 2017 10:39:30 +0800
Message-Id: <20170314023933.12118-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 0/3] block: Backdoor to skip image locking
 in qemu-io/qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Hi Kevin,

This tries to capture your idea to add a explicit command option in qemu-io and
qemu-img for user to specify "expect inconsistent data when reading image".
It's stored as a BDRV_O_ flag internally, I don't know if there is a cleaner
way or not.

It's depended on by image locking series because several test cases need to be
updated to use this flag.

Fam

Fam Zheng (3):
  block: Introduce BDRV_O_UNSAFE_READ
  qemu-img: Add --unsafe-read option to subcommands
  qemu-io: Add --unsafe-read option

 block/block-backend.c |   2 +-
 include/block/block.h |   1 +
 qemu-img.c            | 148 ++++++++++++++++++++++++++++++++++++++------------
 qemu-io.c             |  28 +++++++---
 4 files changed, 137 insertions(+), 42 deletions(-)

-- 
2.9.3
