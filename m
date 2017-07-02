Received: from eggs.gnu.org ([2001:4830:134:3::10]:56712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dRbnB-0008CG-PY
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 06:07:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dRbnB-000208-0O
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 06:07:49 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Sun,  2 Jul 2017 13:06:44 +0300
Message-Id: <20170702100646.20656-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH 0/2] ThrottleGroup configuration fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Since in the future ThrottleGroup configuration will be done even if it
has no members, we need to separate the two.

Manos Pitsidianakis (2):
  block: add clock_type field to ThrottleGroup
  block: remove timer canceling in throttle_config()

 block/throttle-groups.c     | 27 ++++++++++-----------------
 fsdev/qemu-fsdev-throttle.c |  2 +-
 include/qemu/throttle.h     |  2 +-
 tests/test-throttle.c       |  4 ++--
 util/throttle.c             | 18 +++---------------
 5 files changed, 17 insertions(+), 36 deletions(-)

-- 
2.11.0
