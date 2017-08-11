Received: from eggs.gnu.org ([2001:4830:134:3::10]:39953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dgIIt-0008Pb-Tl
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 18:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dgIIs-0007Im-Ri
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 18:21:15 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 11 Aug 2017 15:17:33 -0700
Message-ID: <cover.1502488636.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 0/3]  Fixup exclusive store logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com, qemu-arm@nongnu.org

I found some issues with the way exclusive store was working. This patch
series seems to fix the test cases that were failing for me.

The first patch is just a simple adjustment.

The third patch fixes the main bug I was seeing.

The second patch is left over from the RFC that seems like it is still a
good idea.

Changes from RFC:
 - Rewrite the third patch to correctly fix the issue.

Alistair Francis (3):
  target/arm: Update the memops for exclusive load
  tcg/tcg-op: Expose the tcg_gen_ext_i* functions
  target/arm: Correct exclusive store cmpxchg memop mask

 target/arm/translate-a64.c | 4 ++--
 tcg/tcg-op.c               | 4 ++--
 tcg/tcg-op.h               | 2 ++
 3 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.11.0
