Received: from eggs.gnu.org ([209.51.188.92]:44649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1giwzr-0006Oi-10
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:49:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1giwzp-0001oO-5J
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:49:22 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:39851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1giwzo-0001mF-PR
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:49:20 -0500
Received: by mail-lf1-x144.google.com with SMTP id n18so14877781lfh.6
	for <qemu-devel@nongnu.org>; Sun, 13 Jan 2019 23:49:19 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 13 Jan 2019 23:48:48 -0800
Message-Id: <20190114074855.16891-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 0/7] target/xtensa: group helpers by
 functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Hello,

this series moves helper functions for FPU, windowed registers, MMU, native
debug, interrupt and exception handling from op_helper.c and helper.c to
separate *_helper.c files.
There's no functional changes.

Max Filippov (7):
  target/xtensa: extract FPU helpers
  target/xtensa: extract windowed registers helpers
  target/xtensa: extract MMU helpers
  target/xtensa: extract debug helpers
  target/xtensa: extract interrupt and exception helpers
  target/xtensa: drop dump_state helper
  target/xtensa: move non-HELPER functions to helper.c

 target/xtensa/Makefile.objs |   5 +
 target/xtensa/dbg_helper.c  | 129 +++++++
 target/xtensa/exc_helper.c  | 258 +++++++++++++
 target/xtensa/fpu_helper.c  | 166 +++++++++
 target/xtensa/helper.c      | 635 ++------------------------------
 target/xtensa/helper.h      |   1 -
 target/xtensa/mmu_helper.c  | 818 +++++++++++++++++++++++++++++++++++++++++
 target/xtensa/op_helper.c   | 870 --------------------------------------------
 target/xtensa/win_helper.c  | 222 +++++++++++
 9 files changed, 1636 insertions(+), 1468 deletions(-)
 create mode 100644 target/xtensa/dbg_helper.c
 create mode 100644 target/xtensa/exc_helper.c
 create mode 100644 target/xtensa/fpu_helper.c
 create mode 100644 target/xtensa/mmu_helper.c
 create mode 100644 target/xtensa/win_helper.c

-- 
2.11.0
