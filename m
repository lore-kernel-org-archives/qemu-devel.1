Received: from eggs.gnu.org ([209.51.188.92]:50397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gm18Q-0007x3-Uu
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:50:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gm18O-0007q4-RO
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:50:54 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e]:38364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gm18M-0007ir-Pl
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:50:51 -0500
Received: by mail-lf1-x12e.google.com with SMTP id a8so18885559lfk.5
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 10:50:44 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 22 Jan 2019 10:50:20 -0800
Message-Id: <20190122185020.25086-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PULL 0/8] target/xtensa queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Hi Peter,

please pull the following batch of updates for target/xtensa:

The following changes since commit 32a1a94dd324d33578dca1dc96d7896a0244d768:

  Update version for v3.1.0 release (2018-12-11 17:18:37 +0000)

are available in the git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20190122-xtensa

for you to fetch changes up to 9584116f94c75411998703b76cc6a6e9e7fd7a8b:

  target/xtensa: move non-HELPER functions to helper.c (2019-01-13 23:36:31 -0800)

----------------------------------------------------------------
target/xtensa: zero overhead loops rework/helpers split

- change xtensa zero overhead loops implementation to avoid invalidation
  of TBs corresponding to previous loop body when a new loop is
  encountered;
- extract helper function groups from op_helper.c and move them into
  separate source files: exc_helper.c (exception helpers), win_helper.c
  (windowed registers helpers), fpu_helper.c (floating point helpers),
  mmu_helper.c (memory management helpers) and dbg_helper.c (native debug
  helpers).

----------------------------------------------------------------
Max Filippov (8):
      target/xtensa: rework zero overhead loops implementation
      target/xtensa: extract FPU helpers
      target/xtensa: extract windowed registers helpers
      target/xtensa: extract MMU helpers
      target/xtensa: extract debug helpers
      target/xtensa: extract interrupt and exception helpers
      target/xtensa: drop dump_state helper
      target/xtensa: move non-HELPER functions to helper.c

 target/xtensa/Makefile.objs  |   5 +
 target/xtensa/cpu.h          |  32 ++
 target/xtensa/dbg_helper.c   | 129 +++++++
 target/xtensa/exc_helper.c   | 258 +++++++++++++
 target/xtensa/fpu_helper.c   | 166 ++++++++
 target/xtensa/helper.c       | 635 ++----------------------------
 target/xtensa/helper.h       |   3 -
 target/xtensa/mmu_helper.c   | 818 +++++++++++++++++++++++++++++++++++++++
 target/xtensa/op_helper.c    | 894 -------------------------------------------
 target/xtensa/overlay_tool.h |   1 +
 target/xtensa/translate.c    |  53 +--
 target/xtensa/win_helper.c   | 222 +++++++++++
 12 files changed, 1685 insertions(+), 1531 deletions(-)
 create mode 100644 target/xtensa/dbg_helper.c
 create mode 100644 target/xtensa/exc_helper.c
 create mode 100644 target/xtensa/fpu_helper.c
 create mode 100644 target/xtensa/mmu_helper.c
 create mode 100644 target/xtensa/win_helper.c

-- 
Thanks.
-- Max
