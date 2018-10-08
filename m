Received: from eggs.gnu.org ([2001:4830:134:3::10]:58531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9d4T-0005Fr-Vf
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9cyi-00085r-Eq
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:22:16 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:38005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g9cyg-00084F-Mt
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:22:11 -0400
Received: by mail-pl1-x62a.google.com with SMTP id b5-v6so10613595plr.5
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 14:22:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  8 Oct 2018 14:21:55 -0700
Message-Id: <20181008212205.17752-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/10] target/arm: Rely on id regs instead
 of features
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

This edition fixes a number of conflicts with master, and adds
a few field definitions from ARMv8.5, courtesy of Philippe.

It also fixes a big think-o in a last-minute change to the
sve system mode patch set that was applied to master today.
That would be patch 1.  Sorry for not testing the original
more thoroughly.


r~


Richard Henderson (10):
  target/arm: Fix aarch64_sve_change_el wrt EL0
  target/arm: Define fields of ISAR registers
  target/arm: Convert v8 extensions from feature bits to isar tests
  target/arm: Align cortex-r5 id_isar0
  target/arm: Fix cortex-a7 id_isar0
  target/arm: Convert division from feature bits to isar0 tests
  target/arm: Convert jazelle from feature bit to isar1 test
  target/arm: Convert t32ee from feature bit to isar3 test
  target/arm: Convert sve from feature bit to aa64pfr0 test
  target/arm: Convert v8.2-fp16 from feature bit to aa64pfr0 test

 target/arm/cpu.h            | 275 +++++++++++++++++++++++++++++++++---
 target/arm/translate-a64.h  |  22 +++
 target/arm/translate.h      |  20 +++
 linux-user/aarch64/signal.c |   4 +-
 linux-user/elfload.c        |  60 ++++----
 linux-user/syscall.c        |  10 +-
 target/arm/cpu.c            |  65 +++++----
 target/arm/cpu64.c          |  66 +++++----
 target/arm/helper.c         |  29 ++--
 target/arm/machine.c        |   6 +-
 target/arm/op_helper.c      |   6 +-
 target/arm/translate-a64.c  | 145 ++++++++++---------
 target/arm/translate.c      |  48 +++----
 13 files changed, 538 insertions(+), 218 deletions(-)

-- 
2.17.1
