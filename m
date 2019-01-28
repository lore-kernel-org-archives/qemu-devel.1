Received: from eggs.gnu.org ([209.51.188.92]:60134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1goAst-000247-8X
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:39:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1goAss-0003WT-2L
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:39:47 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1goAsr-0003Tk-LF
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:39:45 -0500
Received: by mail-wr1-x442.google.com with SMTP id f7so19113730wrp.1
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 09:39:43 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 28 Jan 2019 17:39:36 +0000
Message-Id: <20190128173940.25813-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH  v1 0/4] HWCAP_CPUID registers for aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>


Hi,

I posted a series to expose some of the CPU registers to user-space.
The counter registers got merged at the time but the HW_CPUID had some
comments that needed addressing. I've re-spun the series and cleaned
it up, hopefully addressing the comments at the same time. The test
case has been expanded.

The ABI is described in the kernel document:

  https://www.kernel.org/doc/Documentation/arm64/cpu-feature-registers.txt

but from QEMU's point of view we just need to ensure the correct
values are reported for CONFIG_USER_ONLY.

Alex Bennée (4):
  target/arm: relax permission checks for HWCAP_CPUID registers
  target/arm: expose CPUID registers to userspace
  linux-user/elfload: enable HWCAP_CPUID for AArch64
  tests/tcg/aarch64: userspace system register test

 linux-user/elfload.c              |   1 +
 target/arm/cpu.h                  |  12 +++
 target/arm/helper.c               |  57 ++++++++++----
 tests/tcg/aarch64/Makefile.target |   2 +-
 tests/tcg/aarch64/sysregs.c       | 120 ++++++++++++++++++++++++++++++
 5 files changed, 175 insertions(+), 17 deletions(-)
 create mode 100644 tests/tcg/aarch64/sysregs.c

-- 
2.17.1
