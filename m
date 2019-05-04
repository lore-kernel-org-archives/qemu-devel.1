Received: from eggs.gnu.org ([209.51.188.92]:50353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQ8-00078z-Km
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQ6-0001C1-TA
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:36 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  4 May 2019 06:05:18 -0600
Message-Id: <20190504120528.6389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/9] Assembly coroutine backend and x86 CET
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com, richard.henderson@linaro.org

*** BLURB HERE ***

Paolo Bonzini (10):
  qemugdb: allow adding support for other coroutine backends
  qemugdb: allow adding support for other architectures
  coroutine: add host specific coroutine backend for 64-bit x86
  coroutine: add host specific coroutine backend for 64-bit ARM
  coroutine: add host specific coroutine backend for 64-bit s390
  configure: add control-flow protection support
  tcg: add tcg_out_start
  tcg/i386: add support for IBT
  linux-user: add IBT support to x86 safe-syscall.S
  coroutine-asm: add x86 CET shadow stack support

 Makefile.target                           |   5 +
 configure                                 |  62 ++++
 include/qemu/cpuid.h                      |   5 +
 linux-user/host/i386/safe-syscall.inc.S   |  19 ++
 linux-user/host/x86_64/safe-syscall.inc.S |  19 ++
 scripts/qemugdb/coroutine.py              | 107 ++----
 scripts/qemugdb/coroutine_asm.py          |  24 ++
 scripts/qemugdb/coroutine_ucontext.py     |  69 ++++
 tcg/aarch64/tcg-target.inc.c              |   4 +
 tcg/arm/tcg-target.inc.c                  |   4 +
 tcg/i386/tcg-target.inc.c                 |  23 ++
 tcg/mips/tcg-target.inc.c                 |   4 +
 tcg/ppc/tcg-target.inc.c                  |   4 +
 tcg/riscv/tcg-target.inc.c                |   4 +
 tcg/s390/tcg-target.inc.c                 |   4 +
 tcg/sparc/tcg-target.inc.c                |   4 +
 tcg/tcg.c                                 |   2 +
 tcg/tci/tcg-target.inc.c                  |   4 +
 util/Makefile.objs                        |  10 +
 util/coroutine-asm.c                      | 387 ++++++++++++++++++++++
 20 files changed, 689 insertions(+), 75 deletions(-)
 create mode 100644 scripts/qemugdb/coroutine_asm.py
 create mode 100644 scripts/qemugdb/coroutine_ucontext.py
 create mode 100644 util/coroutine-asm.c

-- 
2.21.0
