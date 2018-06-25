Received: from eggs.gnu.org ([2001:4830:134:3::10]:52849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fXTub-0004yU-HU
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:00:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fXTuX-00052C-LL
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:00:17 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:52884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fXTuX-00051N-FH
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:00:13 -0400
Received: by mail-wm0-x244.google.com with SMTP id p126-v6so9909272wmb.2
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 09:00:13 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 25 Jun 2018 17:00:04 +0100
Message-Id: <20180625160009.17437-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/5] support reading some CPUID/CNT
 registers from user-space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

This expands on the previous version by adding the additional CPUID
registers as exposed by the HWCAP_CPUID kernel feature. Most of the
work involves judicious use of macros. There is a easily extensible
test case that uses the shiny new check-tcg infrastructure ;-)

Alex Bennée (5):
  target/arm: support reading of CNT[VCT|FRQ]_EL0 from user-space
  target/arm: relax permission checks for HWCAP_CPUID registers
  target/arm: expose CPUID registers to userspace
  linux-user/elfload: enable HWCAP_CPUID for AArch64
  tests/tcg/aarch64: userspace system register test

 linux-user/elfload.c              |  1 +
 target/arm/cpu.h                  |  7 +++
 target/arm/helper.c               | 80 +++++++++++++++++++------
 tests/tcg/aarch64/Makefile.target |  2 +-
 tests/tcg/aarch64/sysregs.c       | 99 +++++++++++++++++++++++++++++++
 5 files changed, 170 insertions(+), 19 deletions(-)
 create mode 100644 tests/tcg/aarch64/sysregs.c

-- 
2.17.1
