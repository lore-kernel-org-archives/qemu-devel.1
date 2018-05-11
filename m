Received: from eggs.gnu.org ([2001:4830:134:3::10]:52239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGz6t-0004df-Vm
	for qemu-devel@nongnu.org; Thu, 10 May 2018 23:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGz6q-00067X-RM
	for qemu-devel@nongnu.org; Thu, 10 May 2018 23:52:47 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:43571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGz6q-00067H-LP
	for qemu-devel@nongnu.org; Thu, 10 May 2018 23:52:44 -0400
Received: by mail-pl0-x244.google.com with SMTP id a39-v6so2495863pla.10
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 20:52:44 -0700 (PDT)
Received: from cloudburst.twiddle.net (97-113-2-170.tukw.qwest.net.
	[97.113.2.170]) by smtp.gmail.com with ESMTPSA id
	e18-v6sm3495636pfi.100.2018.05.10.20.52.41
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 10 May 2018 20:52:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 May 2018 20:52:31 -0700
Message-Id: <20180511035240.4016-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/9] Honor CPU_DUMP_FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

With Peter's new patch for "-d fpu", it makes sense to honor
this setting in as many targets as currently dump the fpu.


r~


Richard Henderson (9):
  target/alpha: Honor CPU_DUMP_FPU
  target/mips: Honor CPU_DUMP_FPU
  target/ppc: Honor CPU_DUMP_FPU
  target/riscv: Introduce cpu_riscv_get_fcsr
  target/riscv: Honor CPU_DUMP_FPU
  target/s390x: Honor CPU_DUMP_FPU
  target/sparc: Honor CPU_DUMP_FPU
  target/unicore32: Honor CPU_DUMP_FPU
  target/xtensa: Honor CPU_DUMP_FPU

 target/riscv/cpu.h           |  1 +
 target/alpha/helper.c        | 17 ++++++++---------
 target/mips/translate.c      |  3 ++-
 target/ppc/translate.c       | 20 +++++++++++++-------
 target/riscv/cpu.c           | 16 +++++++++++-----
 target/riscv/fpu_helper.c    |  6 ++++++
 target/riscv/op_helper.c     |  3 +--
 target/s390x/helper.c        | 23 ++++++++++++-----------
 target/sparc/cpu.c           | 17 ++++++++++-------
 target/unicore32/translate.c |  4 +++-
 target/xtensa/translate.c    |  3 ++-
 11 files changed, 69 insertions(+), 44 deletions(-)

-- 
2.17.0
