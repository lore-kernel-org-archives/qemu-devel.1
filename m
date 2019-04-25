Received: from eggs.gnu.org ([209.51.188.92]:35062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJi8w-0006e1-5V
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJi8v-00039k-5Y
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:26:42 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJi8u-00038v-Uk
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:26:41 -0400
Received: by mail-pf1-x441.google.com with SMTP id b3so257317pfd.1
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 10:26:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 25 Apr 2019 10:26:34 -0700
Message-Id: <20190425172636.11128-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] target/riscv fixup and reserved argument
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: palmer@sifive.com

Based-on: https://github.com/palmer-dabbelt/qemu/tree/for-master

The first patch is my (interim) solution for compilation with clang.
I'm still open to Thomas' suggestion to add -Wno-typedef-redefinition
in the configure script.  I had intended to squash this into the
indicated patch when I got around to re-sending the patch set, but
Palmer has started queueing patches already.

The second patch handles the C.LWSP reserved operand case that Palmer
pointed out during review, and 4 others that I found while double
checking against the RVC instruction set listings.


r~


Richard Henderson (2):
  fixup! target/riscv: Name the argument sets for all of insn32 formats
  target/riscv: Add checks for several RVC reserved operands

 target/riscv/translate.c      | 13 ++++++++++---
 target/riscv/insn16-64.decode | 10 ++++++++--
 target/riscv/insn16.decode    |  7 ++++++-
 3 files changed, 24 insertions(+), 6 deletions(-)

-- 
2.17.1
