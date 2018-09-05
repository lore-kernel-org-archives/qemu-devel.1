Received: from eggs.gnu.org ([2001:4830:134:3::10]:57709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMrp-0005r5-Tp
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMro-0006a4-KJ
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:25 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:39487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fxMrl-0006U1-Ap
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:22 -0400
Received: by mail-lj1-x243.google.com with SMTP id l15-v6so4803875lji.6
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 18:44:19 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue,  4 Sep 2018 18:43:37 -0700
Message-Id: <20180905014352.970-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 00/15] target/xtensa: preparation for FLIX
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
Cc: Max Filippov <jcmvbkbc@gmail.com>

Hello,

this series prepares target/xtensa for FLIX (flexible length instruction
extensions) support. FLIX allows bundling multiple existing opcodes in a
single instruction, so this series separates generation of per-instruction
code (such as raising exceptions and terminating TB) from per-opcode code.

Max Filippov (15):
  target/xtensa: extract test for an illegal instruction
  target/xtensa: extract test for privileged instruction
  target/xtensa: extract test for syscall instruction
  target/xtensa: extract test for debug exception
  target/xtensa: extract test for window overflow exception
  target/xtensa: extract test for window underflow exception
  target/xtensa: extract test for alloca exception
  target/xtensa: extract test for cpdisabled exception
  target/xtensa: extract test for division by zero
  target/xtensa: extract unconditional TB termination
  target/xtensa: change SR number checks to assertions
  target/xtensa: always end TB on CCOUNT access/CCOMPARE write
  target/xtensa: extract unconditional TB termination via slot 0
  target/xtensa: make rsr/wsr helpers return void
  target/xtensa: extract gen_check_interrupts call

 target/xtensa/cpu.h       |   37 +-
 target/xtensa/helper.c    |    6 +
 target/xtensa/helper.h    |    2 +
 target/xtensa/op_helper.c |   73 +-
 target/xtensa/translate.c | 2673 +++++++++++++++++++++++++++++----------------
 5 files changed, 1817 insertions(+), 974 deletions(-)

-- 
2.11.0
