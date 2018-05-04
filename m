Received: from eggs.gnu.org ([2001:4830:134:3::10]:52468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fEcya-0004UR-Li
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:50:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fEcya-0002O8-15
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:50:28 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  4 May 2018 16:50:12 +0100
Message-Id: <20180504155014.10311-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] qemu-iotests: post-QEMU 2.12 fixes for 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

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
 tests/qemu-iotests/185     | 12 ++++++++++++
 tests/qemu-iotests/185.out | 10 +++++-----
 3 files changed, 32 insertions(+), 12 deletions(-)

-- 
2.14.3
