Received: from eggs.gnu.org ([209.51.188.92]:51257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqeC2-0000pf-MQ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:21:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqe3P-0002bo-Dh
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:12:52 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gqe3P-00021G-4g
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:12:51 -0500
Received: by mail-wr1-x442.google.com with SMTP id a16so8740470wrv.0
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 05:12:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  4 Feb 2019 13:12:24 +0000
Message-Id: <20190204131228.25949-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 0/4] target/arm: Implement ARMv8.5-BTI
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

One fixup to the set of patches applied to target-arm.next.
One adjustment to what is now patch 3 wrt EXCP_SEMIHOST.


r~


Richard Henderson (4):
  fixup! target/arm: Cache the GP bit for a page in MemTxAttrs
  target/arm: Add x-guarded-pages cpu property for user-only
  linux-user/aarch64: Reset btype for syscalls and signals
  tests/tcg/aarch64: Add bti smoke test

 target/arm/cpu.h                  |  4 ++
 linux-user/aarch64/cpu_loop.c     | 14 +++++++
 target/arm/cpu64.c                | 20 ++++++++++
 target/arm/helper.c               |  2 +-
 target/arm/translate-a64.c        |  8 +++-
 tests/tcg/aarch64/bti-1.c         | 61 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/bti-crt.inc.c   | 51 ++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  7 +++-
 8 files changed, 164 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/aarch64/bti-1.c
 create mode 100644 tests/tcg/aarch64/bti-crt.inc.c

-- 
2.17.2
