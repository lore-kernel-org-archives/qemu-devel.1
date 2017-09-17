Received: from eggs.gnu.org ([2001:4830:134:3::10]:52394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtb8o-0007ye-Bd
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtb8j-00086T-Db
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:05:50 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:55366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dtb8i-00084j-UE
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:05:45 -0400
Received: by mail-oi0-x22f.google.com with SMTP id g128so3679669oic.12
	for <qemu-devel@nongnu.org>; Sun, 17 Sep 2017 08:05:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 17 Sep 2017 08:05:18 -0700
Message-Id: <20170917150535.8284-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/17] TCG queued patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

One build fix (ppc32), a collection of minor cleanups, and
extracts from some of my other tcg-related patch sets.


r~


The following changes since commit 5ee53d1593dfc071275b13b1228c70bb88f4aaee:

  Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2017-09-16 14:36:16 +0100)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20170917

for you to fetch changes up to 89b2e37e6506d92b00ac478e7953be6ddd7a86a9:

  tcg/mips: Fully convert tcg_target_op_def (2017-09-17 06:52:19 -0700)

----------------------------------------------------------------
tcg queued patches

----------------------------------------------------------------
Philippe Mathieu-Daudé (5):
      tcg/ppc: disable atomic write check on ppc32
      accel/tcg: move user-exec to accel/tcg/
      accel/tcg: move tcg-runtime to accel/tcg/
      accel/tcg: move atomic_template.h to accel/tcg/
      accel/tcg: move USER code to user-exec.c

Richard Henderson (11):
      tcg: Add tcg_op_supported
      tcg: Remove tcg_regset_clear
      tcg: Remove tcg_regset_set
      tcg: Remove tcg_regset_{or,and,andnot,not}
      tcg: Remove tcg_regset_set32
      tcg: Fix types in tcg_regset_{set,reset}_reg
      tcg/aarch64: Fully convert tcg_target_op_def
      tcg/arm: Fully convert tcg_target_op_def
      tcg/ppc: Fully convert tcg_target_op_def
      tcg/sparc: Fully convert tcg_target_op_def
      tcg/mips: Fully convert tcg_target_op_def

Thomas Huth (1):
      accel/tcg: move softmmu_template.h to accel/tcg/

 Makefile.target                                    |   6 +-
 atomic_template.h => accel/tcg/atomic_template.h   |   0
 softmmu_template.h => accel/tcg/softmmu_template.h |   0
 {tcg => accel/tcg}/tcg-runtime.h                   |   0
 tcg/tcg.h                                          |  15 +-
 {tcg => accel/tcg}/tcg-runtime.c                   |  54 ---
 user-exec-stub.c => accel/tcg/user-exec-stub.c     |   0
 user-exec.c => accel/tcg/user-exec.c               |  52 +++
 tcg/aarch64/tcg-target.inc.c                       | 319 +++++++++---------
 tcg/arm/tcg-target.inc.c                           | 211 +++++++-----
 tcg/i386/tcg-target.inc.c                          |  30 +-
 tcg/mips/tcg-target.inc.c                          | 371 +++++++++++----------
 tcg/ppc/tcg-target.inc.c                           | 366 ++++++++++----------
 tcg/s390/tcg-target.inc.c                          |  22 +-
 tcg/sparc/tcg-target.inc.c                         | 291 +++++++++-------
 tcg/tcg.c                                          | 242 +++++++++++++-
 tcg/tci/tcg-target.inc.c                           |  13 +-
 MAINTAINERS                                        |   4 +-
 accel/tcg/Makefile.objs                            |   4 +
 19 files changed, 1160 insertions(+), 840 deletions(-)
 rename atomic_template.h => accel/tcg/atomic_template.h (100%)
 rename softmmu_template.h => accel/tcg/softmmu_template.h (100%)
 rename {tcg => accel/tcg}/tcg-runtime.h (100%)
 rename {tcg => accel/tcg}/tcg-runtime.c (75%)
 rename user-exec-stub.c => accel/tcg/user-exec-stub.c (100%)
 rename user-exec.c => accel/tcg/user-exec.c (92%)
