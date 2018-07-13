Received: from eggs.gnu.org ([2001:4830:134:3::10]:60245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fdz01-0000HP-QQ
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 10:24:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fdz01-0001RK-5F
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 10:24:45 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jul 2018 15:16:34 +0100
Message-Id: <20180713141636.18665-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.0 0/2] accel/tcg: fix
 get_page_addr_code() victim TLB lookups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>

This patchset fixes a bug in get_page_addr_code()'s
lookup of the address in the victim TLB, which was another
source of "we end up with an invalid TLB entry even after
we've done a TLB fill for it".

The second patch then removes a check that we had that was
working around the existence of the bug patch 1 fixes and
the bug that commit 68fea038553039e fixes, and instead
puts in an assertion that we definitely do have a valid TLB.

Tested with Laurent's m68k image to check we didn't regress that.

thanks
-- PMM

Peter Maydell (2):
  accel/tcg: Use correct test when looking in victim TLB for code
  accel/tcg: Assert that tlb fill gave us a valid TLB entry

 accel/tcg/cputlb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.17.1
