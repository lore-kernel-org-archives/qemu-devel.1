Received: from eggs.gnu.org ([2001:4830:134:3::10]:35191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eK6by-0002Vz-RU
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:57:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eK6bv-00011W-Oq
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:57:30 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Wed, 29 Nov 2017 19:56:33 +0200
Message-Id: <cover.1511978000.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH for-2.11 0/1] blockjob: Make
 block_job_pause_all() keep a reference to the jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>

Hi,

this patch fixes the crash reported by Anton Nefedov here:

   https://lists.gnu.org/archive/html/qemu-block/2017-11/msg00159.html

I can reproduce it easily with the change he mentions there, or by
tweaking iotest 030 as I show here:

   https://lists.gnu.org/archive/html/qemu-block/2017-11/msg00934.html

I'm not convinced that this is the best solution, though. As Fam says
the block layer is getting complex and I think this can be solved in a
different way if the code is properly rewritten. Even with this
solution I think it would make sense to assert that the block job's
pause count is always 0 when the job is about to be destroyed and
perhaps keep a reference while it's being paused. But that's a bigger
change and we're close to the release so I opted for this more
conservative approach.

Regards,

Berto

Alberto Garcia (1):
  blockjob: Make block_job_pause_all() keep a reference to the jobs

 blockjob.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.11.0
