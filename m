Received: from eggs.gnu.org ([2001:4830:134:3::10]:32953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elaFq-0007YX-0I
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 08:04:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elaFp-0006SP-9I
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 08:04:14 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 13 Feb 2018 14:03:49 +0100
Message-Id: <20180213130356.8885-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/7] block: Preallocated truncation for gluster
 and sheepdog
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, sheepdog@lists.wpkg.org, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>

As far as I can see, these are the only protocols beside file-posix that
support preallocated creation.  In contrast to file-posix, however, they
have not supported preallocated truncation so far.  This series brings
their truncation code to feature parity with their creation code in this
regard.

Note that I do not have a test setup for either of the two drivers, so I
do not actually know whether this works.  Anyone with a setup is more
than welcome to test this series.


Max Reitz (7):
  gluster: Move glfs_close() to create's clean-up
  gluster: Pull truncation from qemu_gluster_create
  gluster: Query current size in do_truncate()
  gluster: Add preallocated truncation
  sheepdog: Make sd_prealloc() take a BDS
  sheepdog: Pass old and new size to sd_prealloc()
  sheepdog: Allow fully preallocated truncation

 block/gluster.c  | 116 ++++++++++++++++++++++++++++++-------------------------
 block/sheepdog.c |  56 +++++++++++++++++----------
 2 files changed, 99 insertions(+), 73 deletions(-)

-- 
2.14.3
