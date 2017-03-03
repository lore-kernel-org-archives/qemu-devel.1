Received: from eggs.gnu.org ([2001:4830:134:3::10]:33402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cjnPh-0008DS-Cj
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:38:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cjnPg-0001Bu-Hk
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:38:29 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri,  3 Mar 2017 21:38:14 +0800
Message-Id: <20170303133816.30303-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] block: More robust error handling around
 perm check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

These are a couple cases added with the op blocker changes, where errp is
available but we still use error_abort. Fix them for obvious reasons.

Fam Zheng (2):
  block: Don't use error_abort in blk_new_open
  commit: Don't use error_abort in commit_start

 block/block-backend.c |  6 +++++-
 block/commit.c        | 12 ++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.9.3
