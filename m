Received: from eggs.gnu.org ([2001:4830:134:3::10]:53585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCXs8-0001Td-Gb
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCXs4-0005CS-U7
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:31:28 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:44716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCXs1-0004zh-D9
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:31:23 -0400
Received: by mail-pf1-x42c.google.com with SMTP id r9-v6so12138807pff.11
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 15:31:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Oct 2018 15:31:07 -0700
Message-Id: <20181016223115.24100-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 0/8] target/arm: Rely on id regs instead of
 features
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

This edition moves some of the system registers into a substructure,
which is then shared with "normal" runtime and the translators.
This is seen as a better solution than letting the entire translator
have access to the main ARMCPU structure.

Also after rebasing on mainline, there was a new cortex-m33 failure
caused by v8m implying v7ve implying arm_div.


r~


Richard Henderson (8):
  target/arm: Move some system registers into a substructure
  target/arm: V8M should not imply V7VE
  target/arm: Convert v8 extensions from feature bits to isar tests
  target/arm: Convert division from feature bits to isar0 tests
  target/arm: Convert jazelle from feature bit to isar1 test
  target/arm: Convert t32ee from feature bit to isar3 test
  target/arm: Convert sve from feature bit to aa64pfr0 test
  target/arm: Convert v8.2-fp16 from feature bit to aa64pfr0 test

 target/arm/cpu.h            | 220 +++++++++++++++++++++++++++-----
 target/arm/translate.h      |   7 ++
 hw/intc/armv7m_nvic.c       |  12 +-
 linux-user/aarch64/signal.c |   4 +-
 linux-user/elfload.c        |  60 +++++----
 linux-user/syscall.c        |  10 +-
 target/arm/cpu.c            | 242 +++++++++++++++++++-----------------
 target/arm/cpu64.c          | 148 ++++++++++++----------
 target/arm/helper.c         |  41 +++---
 target/arm/machine.c        |   6 +-
 target/arm/translate-a64.c  | 145 +++++++++++----------
 target/arm/translate.c      |  48 ++++---
 12 files changed, 570 insertions(+), 373 deletions(-)

-- 
2.17.2
