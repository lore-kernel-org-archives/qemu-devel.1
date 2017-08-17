Received: from eggs.gnu.org ([2001:4830:134:3::10]:36152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1diLnT-0005hG-Aa
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 10:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1diLnQ-0006uZ-5s
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 10:29:19 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 17 Aug 2017 17:28:11 +0300
Message-Id: <cover.1502979710.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 0/4] Misc throttle fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>

Hi all,

this series contains a few small changes to the throttling code and
its documentation.

Stefan, once this is reviewed, can you please remove the "Make
LeakyBucket.avg and LeakyBucket.max integer types" commit (id
1744e9a12cbcebff2e) from your block-next branch? This series contains
a new version of that patch that replaces the one that you have.

Regards,

Berto

Alberto Garcia (4):
  throttle: Fix wrong variable name in the header documentation
  throttle: Update the throttle_fix_bucket() documentation
  throttle: Remove throttle_fix_bucket() / throttle_unfix_bucket()
  throttle: Make LeakyBucket.avg and LeakyBucket.max integer types

 include/qemu/throttle.h |  6 ++---
 util/throttle.c         | 67 +++++++++++++++++--------------------------------
 2 files changed, 26 insertions(+), 47 deletions(-)

-- 
2.11.0
