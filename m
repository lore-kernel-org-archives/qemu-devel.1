Received: from eggs.gnu.org ([2001:4830:134:3::10]:57035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eChdr-0002W4-18
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 02:52:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eChdo-0000Vl-G1
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 02:52:51 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:48074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eChdo-0000VF-8u
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 02:52:48 -0500
Received: by mail-wm0-x241.google.com with SMTP id r196so15119685wmf.2
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 23:52:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  9 Nov 2017 08:52:41 +0100
Message-Id: <20171109075243.4794-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL for-2.11 0/2] Capstone updates
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

One build fix for mingw cross-compiling, one feature regression fix.


r~


The following changes since commit b0fbe46ad82982b289a44ee2495b59b0bad8a842:

  Update version for v2.11.0-rc0 release (2017-11-07 16:05:28 +0000)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-cap-20171109

for you to fetch changes up to 9f81aeb5dadab588920b157a4610e890995ef4b9:

  Makefile: Capstone: Add support for cross compile ranlib (2017-11-09 08:47:14 +0100)

----------------------------------------------------------------
Capstone fixes for 2.11

----------------------------------------------------------------
Alistair Francis (1):
      Makefile: Capstone: Add support for cross compile ranlib

Richard Henderson (1):
      disas: Dump insn bytes along with capstone disassembly

 Makefile            |  2 +-
 include/disas/bfd.h |  2 ++
 disas.c             | 96 ++++++++++++++++++++++++++++++++++++++++++++++-------
 target/arm/cpu.c    |  6 ++++
 target/i386/cpu.c   |  2 ++
 configure           |  3 ++
 6 files changed, 98 insertions(+), 13 deletions(-)
