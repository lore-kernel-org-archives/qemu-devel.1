Received: from eggs.gnu.org ([2001:4830:134:3::10]:51569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cHVIU-0006YL-3a
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 07:38:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cHVIP-0003QU-Qr
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 07:38:05 -0500
Received: from mail-wj0-f179.google.com ([209.85.210.179]:34302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cHVIP-0003Px-Ii
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 07:38:01 -0500
Received: by mail-wj0-f179.google.com with SMTP id tg4so64782802wjb.1
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 04:38:01 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 15 Dec 2016 12:36:54 +0000
Message-Id: <20161215123656.27985-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/2] Clean-up tlb_flush and cpu reset
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi Richard,

Nothing much changed in this except:

  - one minor patchew checkpatch.pl fix
  - added your r-b

So I reckon this is ready to go in once the tree re-opens?

Alex Bennée (2):
  qom/cpu: move tlb_flush to cpu_common_reset
  cputlb: drop flush_global flag from tlb_flush

 cputlb.c                           | 21 ++++++---------------
 exec.c                             |  4 ++--
 hw/sh4/sh7750.c                    |  2 +-
 include/exec/exec-all.h            | 14 ++++++--------
 qom/cpu.c                          | 10 ++++++++--
 target-alpha/cpu.c                 |  2 +-
 target-alpha/sys_helper.c          |  2 +-
 target-arm/cpu.c                   |  5 ++---
 target-arm/cpu.h                   |  5 ++++-
 target-arm/helper.c                | 26 +++++++++++++-------------
 target-cris/cpu.c                  |  3 +--
 target-cris/cpu.h                  |  9 ++++++---
 target-i386/cpu.c                  |  2 --
 target-i386/cpu.h                  |  6 ++++--
 target-i386/fpu_helper.c           |  2 +-
 target-i386/helper.c               |  8 ++++----
 target-i386/machine.c              |  2 +-
 target-i386/misc_helper.c          |  2 +-
 target-i386/svm_helper.c           |  2 +-
 target-lm32/cpu.c                  |  3 +--
 target-lm32/cpu.h                  |  3 +++
 target-m68k/cpu.c                  |  3 +--
 target-m68k/cpu.h                  |  3 +++
 target-microblaze/cpu.c            |  3 +--
 target-microblaze/cpu.h            |  3 +++
 target-microblaze/mmu.c            |  2 +-
 target-mips/cpu.c                  |  3 +--
 target-mips/cpu.h                  |  5 ++++-
 target-mips/helper.c               |  6 +++---
 target-mips/op_helper.c            |  8 ++++----
 target-moxie/cpu.c                 |  4 +---
 target-moxie/cpu.h                 |  3 +++
 target-openrisc/cpu.c              |  9 +--------
 target-openrisc/cpu.h              |  3 +++
 target-openrisc/interrupt.c        |  2 +-
 target-openrisc/interrupt_helper.c |  2 +-
 target-openrisc/sys_helper.c       |  2 +-
 target-ppc/helper_regs.h           |  4 ++--
 target-ppc/misc_helper.c           |  4 ++--
 target-ppc/mmu_helper.c            | 32 ++++++++++++++++----------------
 target-ppc/translate_init.c        |  3 ---
 target-s390x/cpu.c                 |  7 ++-----
 target-s390x/cpu.h                 |  5 +++--
 target-s390x/gdbstub.c             |  2 +-
 target-s390x/mem_helper.c          |  8 ++++----
 target-sh4/cpu.c                   |  3 +--
 target-sh4/cpu.h                   |  3 +++
 target-sh4/helper.c                |  2 +-
 target-sparc/cpu.c                 |  3 +--
 target-sparc/cpu.h                 |  3 +++
 target-sparc/ldst_helper.c         | 12 ++++++------
 target-tilegx/cpu.c                |  3 +--
 target-tilegx/cpu.h                |  3 +++
 target-tricore/cpu.c               |  2 --
 target-unicore32/cpu.c             |  2 +-
 target-unicore32/helper.c          |  2 +-
 target-xtensa/op_helper.c          |  2 +-
 57 files changed, 151 insertions(+), 148 deletions(-)

-- 
2.11.0
