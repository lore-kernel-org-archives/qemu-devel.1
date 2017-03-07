Received: from eggs.gnu.org ([2001:4830:134:3::10]:51172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1clCxo-0000wb-PM
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 06:07:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1clCxo-0006iA-0n
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 06:07:32 -0500
From: Fam Zheng <famz@redhat.com>
Date: Tue,  7 Mar 2017 19:07:20 +0800
Message-Id: <20170307110722.12583-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] block: More robust error handling
 around perm check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

v2: Fix error handling in both patches. [Kevin]

These are a couple cases added with the op blocker changes, where errp is
available but we still use error_abort. Fix them for obvious reasons.

Fam Zheng (2):
  block: Don't use error_abort in blk_new_open
  commit: Don't use error_abort in commit_start

 block/block-backend.c |  7 ++++++-
 block/commit.c        | 16 ++++++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

-- 
2.9.3
