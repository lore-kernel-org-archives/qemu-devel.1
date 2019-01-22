Received: from eggs.gnu.org ([209.51.188.92]:60834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gm3wA-0007Jt-1N
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:50:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gm3w4-0007o3-Ua
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:50:22 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:42970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gm3w2-0007gI-Tu
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:50:20 -0500
Received: by mail-wr1-x42b.google.com with SMTP id q18so61372wrx.9
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 13:50:18 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 22 Jan 2019 21:50:05 +0000
Message-Id: <20190122215016.18697-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/11] current fpu/next queue (tests & build
 fix)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>


Hi,

The last softfloat PR failed on a number of big endian machines. This
has been fixed with a patch to the fp-test platform.h. In the meantime
there have been a few fixes to the check-softfloat rules to improve
re-building and reporting of failing tests.

The following patches need review
  patch 0009/tests Makefile add floating point tests.patch

I'll send out a proper pull request once all the automated testing has
completed. Anyone with access to big endian hardware it would be cool
if you could give the series a spin as well.

Alex Bennée (3):
  tests/Makefile: add floating point tests
  scripts/archive-source: include softfloat tests
  tests/Makfile: add check-softfloat rule

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

 fpu/softfloat.c                |  33 ++++++++
 include/fpu/softfloat-macros.h |   2 +-
 scripts/archive-source.sh      |   2 +-
 tests/Makefile.include         | 137 ++++++++++++++++++++++++++++++++-
 tests/fp/Makefile              |   3 +-
 tests/fp/berkeley-testfloat-3  |   2 +-
 tests/fp/fp-bench.c            |  15 ++--
 tests/fp/fp-test.c             |   4 +-
 tests/fp/platform.h            |   1 +
 9 files changed, 183 insertions(+), 16 deletions(-)

-- 
2.17.1
