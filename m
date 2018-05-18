Received: from eggs.gnu.org ([2001:4830:134:3::10]:55310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJnNf-0000FS-6t
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJnNb-0003Wm-1C
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:57:43 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:40855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJnNa-0003We-RF
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:57:38 -0400
Received: by mail-pg0-x242.google.com with SMTP id l2-v6so3847294pgc.7
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 14:57:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 18 May 2018 14:57:26 -0700
Message-Id: <20180518215734.18833-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/8] Honor CPU_DUMP_FPU
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

With Peter's new patch for "-d fpu", it makes sense to honor
this setting in as many targets as currently dump the fpu.


r~


The following changes since commit 5bcf917ee37a5efbef99f091a96db54a5276becb:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180518' into staging (2018-05-18 18:25:29 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-fpu-20180518

for you to fetch changes up to f29c0b170fa9e0568f2d02e764e18b00cad3a27f:

  target/xtensa: Honor CPU_DUMP_FPU (2018-05-18 14:52:38 -0700)

----------------------------------------------------------------
Honor CPU_DUMP_FPU

----------------------------------------------------------------
Richard Henderson (8):
      target/alpha: Honor CPU_DUMP_FPU
      target/mips: Honor CPU_DUMP_FPU
      target/ppc: Honor CPU_DUMP_FPU
      target/riscv: Honor CPU_DUMP_FPU
      target/s390x: Honor CPU_DUMP_FPU
      target/sparc: Honor CPU_DUMP_FPU
      target/unicore32: Honor CPU_DUMP_FPU
      target/xtensa: Honor CPU_DUMP_FPU

 target/alpha/helper.c        | 17 ++++++++---------
 target/mips/translate.c      |  3 ++-
 target/ppc/translate.c       | 20 +++++++++++++-------
 target/riscv/cpu.c           | 12 +++++++-----
 target/s390x/helper.c        | 23 ++++++++++++-----------
 target/sparc/cpu.c           | 17 ++++++++++-------
 target/unicore32/translate.c |  4 +++-
 target/xtensa/translate.c    |  3 ++-
 8 files changed, 57 insertions(+), 42 deletions(-)
