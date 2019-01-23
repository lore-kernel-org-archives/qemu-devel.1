Received: from eggs.gnu.org ([209.51.188.92]:33436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gmGvP-00054i-Hr
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:42:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gmGvM-0003Gr-9j
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:42:31 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:52240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gmGvH-0003Fg-P0
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:42:25 -0500
Received: by mail-wm1-x32f.google.com with SMTP id m1so1670179wml.2
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 03:42:22 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 23 Jan 2019 11:42:20 +0000
Message-Id: <20190123114220.16972-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 00/11] check-softfloat,
 fp-bench and clang compile fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The following changes since commit 952bc8b3c2cbba78261923a1e8ca55cda261dee9:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-01-21' into staging (2019-01-22 17:56:21 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-fpu-next-230119-2

for you to fetch changes up to 7617010250822677348af2bd98f048be10e7f334:

  tests/Makefile: add check-softfloat rule (2019-01-23 08:30:01 +0000)

----------------------------------------------------------------
Some more softfloat/fpu fixes

   - make check-softfloat
   - fixes for fp-bench
   - workaround broken host fma
   - compile fix for s390x/clang
   - fixed for bigendian (v2)
   - minor makefile tweaks (v2)

----------------------------------------------------------------
Alex Bennée (3):
      tests/Makefile: add floating point tests
      scripts/archive-source: include softfloat tests
      tests/Makefile: add check-softfloat rule

Emilio G. Cota (7):
      fp-bench: fix update_random_ops
      fp-bench: remove wrong exponent raise in fill_random
      berkeley-testfloat-3: pull changes
      tests/fp/Makefile: do not use gcc-only -W flags
      fp-test: fix signature of slow_clear_flags and qemu_clear_flags
      tests/fp/platform.h: include config-host.h
      softfloat: enforce softfloat if the host's FMA is broken

Thomas Huth (1):
      include/fpu/softfloat: Fix compilation with Clang on s390x

 fpu/softfloat.c                |  33 ++++++++++
 include/fpu/softfloat-macros.h |   2 +-
 scripts/archive-source.sh      |   2 +-
 tests/Makefile.include         | 137 ++++++++++++++++++++++++++++++++++++++++-
 tests/fp/Makefile              |   3 +-
 tests/fp/berkeley-testfloat-3  |   2 +-
 tests/fp/fp-bench.c            |  15 ++---
 tests/fp/fp-test.c             |   4 +-
 tests/fp/platform.h            |   1 +
 9 files changed, 183 insertions(+), 16 deletions(-)

--
2.17.1
