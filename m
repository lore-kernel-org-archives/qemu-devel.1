Received: from eggs.gnu.org ([2001:4830:134:3::10]:42492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f62jQ-00078J-52
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 19:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f62jP-0005XP-6E
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 19:31:20 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:46722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f62jP-0005Vg-00
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 19:31:19 -0400
Received: by mail-pf0-x243.google.com with SMTP id h69so9527248pfe.13
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 16:31:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 11 Apr 2018 09:31:09 +1000
Message-Id: <20180410233110.2573-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL for-2.12 0/1] tcg patch queue
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

The following changes since commit 26d6a7c87b05017ffabffb5e16837a0fccf67e90:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-qapi-2018-04-10' into staging (2018-04-10 22:16:19 +0100)

are available in the Git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20180411

for you to fetch changes up to afd46fcad2dceffda35c0586f5723c127b6e09d8:

  icount: fix cpu_restore_state_from_tb for non-tb-exit cases (2018-04-11 09:05:22 +1000)

----------------------------------------------------------------
Handle read-modify-write i/o with icount

----------------------------------------------------------------
Pavel Dovgalyuk (1):
      icount: fix cpu_restore_state_from_tb for non-tb-exit cases

 include/exec/exec-all.h      |  5 ++++-
 accel/tcg/cpu-exec-common.c  | 10 +++++-----
 accel/tcg/cpu-exec.c         |  1 -
 accel/tcg/translate-all.c    | 27 ++++++++++++++-------------
 accel/tcg/user-exec.c        |  2 +-
 hw/misc/mips_itu.c           |  3 +--
 target/alpha/helper.c        |  2 +-
 target/alpha/mem_helper.c    |  6 ++----
 target/arm/op_helper.c       |  6 +++---
 target/cris/op_helper.c      |  4 ++--
 target/i386/helper.c         |  2 +-
 target/i386/svm_helper.c     |  2 +-
 target/m68k/op_helper.c      |  4 ++--
 target/moxie/helper.c        |  2 +-
 target/openrisc/sys_helper.c |  8 ++++----
 target/tricore/op_helper.c   |  2 +-
 target/xtensa/op_helper.c    |  4 ++--
 17 files changed, 45 insertions(+), 45 deletions(-)
