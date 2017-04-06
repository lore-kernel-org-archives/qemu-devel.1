Received: from eggs.gnu.org ([2001:4830:134:3::10]:47908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwAzP-0004GD-Vz
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 13:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwAzP-00009a-62
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 13:14:31 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  6 Apr 2017 19:14:09 +0200
Message-Id: <1491498851-16709-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 0/2] commit: Fix commit_top_bs problems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

The same problem that Fam's patch "mirror: Fix aio context of
mirror_top_bs" fixes for the mirror block job also exists for the
commit block job and the 'commit' HMP command. While comparing the
respective places in mirror.c and commit.c, I also noticed that
commit neglects to set an image size.

This series fixes both problems.

Kevin Wolf (2):
  commit: Set commit_top_bs->aio_context
  commit: Set commit_top_bs->total_sectors

 block/commit.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
1.8.3.1
