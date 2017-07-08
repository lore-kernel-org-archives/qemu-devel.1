Received: from eggs.gnu.org ([2001:4830:134:3::10]:43599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTfpf-0001SY-0f
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 22:50:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTfpb-0004w5-Vv
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 22:50:55 -0400
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri,  7 Jul 2017 16:50:27 -1000
Message-Id: <20170708025030.15845-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 0/3] linux-user fixes for va mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, qemu-arm@nongnu.org, aurelien@aurel32.net

At first I was simply going to add TARGET_SH to the existing
set of defines that trigger a 31-bit address space.  But then
I realized that one could create non-working va configurations
from the command-line.


r~


Richard Henderson (3):
  tcg: Fix off-by-one in assert in page_set_flags
  linux-user: Tidy and enforce reserved_va initialization
  linux-user/sh4: Reduce TARGET_VIRT_ADDR_SPACE_BITS to 31

 linux-user/arm/target_cpu.h |  4 ++++
 target/mips/mips-defs.h     |  6 +++++-
 target/nios2/cpu.h          |  6 +++++-
 target/sh4/cpu.h            |  6 +++++-
 accel/tcg/translate-all.c   |  2 +-
 linux-user/main.c           | 38 +++++++++++++++++++++++++-------------
 6 files changed, 45 insertions(+), 17 deletions(-)

-- 
2.9.4
