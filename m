Received: from eggs.gnu.org ([2001:4830:134:3::10]:33083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fG35J-0004DA-WE
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fG35E-00021W-5j
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:55:17 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  8 May 2018 14:54:34 +0100
Message-Id: <20180508135436.30140-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] qemu-iotests: post-QEMU 2.12 fixes for
 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

v2:
 * Rebase onto Jeff's block tree to get mirror ratelimit fix [Jeff, Vladimir]
 * Update comments in 185 since drain no longer causes a spurious iteration

The 185 qemu-iotests test case was in a bad state for the QEMU 2.12 release.
We fudged the expected test output to make it pass, except for
non-deterministic behavior.

These patches get us back to pre-QEMU 2.12.  Notably the offsets reported in
block job events now correspond to smaller buffer sizes because the job doesn't
iterate during drain.

It's worth mentioning that the test case is still non-deterministic.  For more
on that, see the first patch.

Stefan Hajnoczi (2):
  qemu-iotests: reduce chance of races in 185
  blockjob: do not cancel timer in resume

 blockjob.c                 | 22 +++++++++++++++-------
 tests/qemu-iotests/185     | 17 +++++++++++++----
 tests/qemu-iotests/185.out | 12 +++++-------
 3 files changed, 33 insertions(+), 18 deletions(-)

-- 
2.14.3
