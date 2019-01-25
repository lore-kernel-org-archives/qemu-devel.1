Received: from eggs.gnu.org ([209.51.188.92]:36030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnAeD-0004QJ-Sf
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:12:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnAPX-0005Go-Kb
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:57:20 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnAPX-0005EV-5j
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:57:19 -0500
Received: by mail-pg1-x542.google.com with SMTP id m1so4784270pgq.8
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 14:57:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 25 Jan 2019 14:57:07 -0800
Message-Id: <20190125225714.10234-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/6] target/arm: Complete ARMv8.3-PAuth
 linux-user
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

(1) Fix a bug I introduced at the last moment in the last
    patch set -- enable pac keys during reset, not before.
(2) Add the HWCAP bits.
(3) Add the new prctl
(4) Add a smoke test so that (1) doesn't happen again.


r~


Richard Henderson (6):
  target/arm: Always enable pac keys for user-only
  aarch64-linux-user: Update HWCAP bits from linux 5.0-rc1
  aarch64-linux-user: Enable HWCAP bits for PAuth
  linux-user: Initialize aarch64 pac keys
  linux-user: Implement PR_PAC_RESET_KEYS
  tests/tcg/aarch64: Add pauth smoke tests

 linux-user/aarch64/target_syscall.h |  9 +++++
 linux-user/aarch64/cpu_loop.c       | 31 ++++++++++++++-
 linux-user/elfload.c                | 10 +++++
 linux-user/syscall.c                | 33 ++++++++++++++++
 target/arm/cpu.c                    |  3 ++
 target/arm/cpu64.c                  | 60 -----------------------------
 tests/tcg/aarch64/pauth-1.c         | 23 +++++++++++
 tests/tcg/aarch64/Makefile.target   |  7 +++-
 8 files changed, 113 insertions(+), 63 deletions(-)
 create mode 100644 tests/tcg/aarch64/pauth-1.c

-- 
2.17.2
