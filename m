Received: from eggs.gnu.org ([2001:4830:134:3::10]:41972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dks90-0003JP-G3
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dks8w-0003UF-Gz
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:25:58 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 24 Aug 2017 16:24:42 +0300
Message-Id: <cover.1503580370.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 0/7] Misc throttle fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>

Hi,

here's the new version of my patch series with misc fixes for the
throttling code.

Stefan, once this is reviewed, can you please remove the "Make
LeakyBucket.avg and LeakyBucket.max integer types" commit (id
218f470639117a8e39) from your block-next branch? This series contains
a new version of that patch that replaces the one that you have.

v2:
- Patch 3: Make the code a bit more concise
- Patch 5: LeakyBucket.avg and LeakyBucket.max are now unsigned
- Patch 6: Make burst_length 64bit and check its range
- Patch 7: Add unit tests

v1: https://lists.gnu.org/archive/html/qemu-block/2017-08/msg00753.html
- Initial version

Output of backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/7:[----] [--] 'throttle: Fix wrong variable name in the header documentation'
002/7:[----] [--] 'throttle: Update the throttle_fix_bucket() documentation'
003/7:[down] 'throttle: Make throttle_is_valid() a bit less verbose'
004/7:[----] [--] 'throttle: Remove throttle_fix_bucket() / throttle_unfix_bucket()'
005/7:[0010] [FC] 'throttle: Make LeakyBucket.avg and LeakyBucket.max integer types'
006/7:[down] 'throttle: Make burst_length 64bit and add range checks'
007/7:[down] 'throttle: Test the valid range of config values'

Alberto Garcia (7):
  throttle: Fix wrong variable name in the header documentation
  throttle: Update the throttle_fix_bucket() documentation
  throttle: Make throttle_is_valid() a bit less verbose
  throttle: Remove throttle_fix_bucket() / throttle_unfix_bucket()
  throttle: Make LeakyBucket.avg and LeakyBucket.max integer types
  throttle: Make burst_length 64bit and add range checks
  throttle: Test the valid range of config values

 include/qemu/throttle.h |  8 ++---
 tests/test-throttle.c   | 80 ++++++++++++++++++++++++++++++++++++++++++++-
 util/throttle.c         | 86 +++++++++++++++++++------------------------------
 3 files changed, 117 insertions(+), 57 deletions(-)

-- 
2.11.0
