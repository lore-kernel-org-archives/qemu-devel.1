Received: from eggs.gnu.org ([2001:4830:134:3::10]:39321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dJrTW-00006e-F9
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 21:15:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dJrTV-00035x-M4
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 21:15:30 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Sun, 11 Jun 2017 04:14:25 +0300
Message-Id: <20170611011427.6713-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH RFC v2 0/2] IO throttling block filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

  block: move ThrottleGroup membership to ThrottleGroupMember
  block: add throttle block filter driver

 block/Makefile.objs             |   1 +
 block/block-backend.c           |  75 +++++----
 block/qapi.c                    |   8 +-
 block/throttle-groups.c         | 315 +++++++++++++++-------------------
 block/throttle.c                | 364 ++++++++++++++++++++++++++++++++++++++++
 blockdev.c                      |   4 +-
 include/block/throttle-groups.h |  21 ++-
 include/qemu/throttle-options.h |  60 ++++---
 include/qemu/throttle.h         |  64 +++++++
 include/sysemu/block-backend.h  |  22 +--
 tests/test-throttle.c           |  53 +++---
 util/throttle.c                 |   5 +
 12 files changed, 709 insertions(+), 283 deletions(-)
 create mode 100644 block/throttle.c

-- 
2.11.0
