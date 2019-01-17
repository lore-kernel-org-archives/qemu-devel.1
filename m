Received: from eggs.gnu.org ([209.51.188.92]:58250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gk7mL-0008Vv-NV
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:32:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gk7hN-0002VS-5a
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:27:10 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:42440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gk7hM-0002Qm-4j
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:27:08 -0500
Received: by mail-wr1-x42f.google.com with SMTP id q18so10976037wrx.9
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 05:27:07 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 17 Jan 2019 13:26:56 +0000
Message-Id: <20190117132703.17790-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/7] check-softfloat,
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

The following changes since commit 4b9f0b0f7c84eea2dfb0d5be3e0254bc91319dbc:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-01-15 17:24:00 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-fpu-next-170119-1

for you to fetch changes up to f722d6877d4e91e984480a4b687cf12971b6c931:

  tests/Makfile: add check-softfloat rule (2019-01-17 09:12:33 +0000)

----------------------------------------------------------------
Some more softfloat/fpu fixes

   - make check-softfloat
   - fixes for fp-bench
   - workaround broken host fma
   - compile fix for s390x/clang

----------------------------------------------------------------
Alex Bennée (3):
      tests/Makefile: add floating point tests
      scripts/archive-source: include softfloat tests
      tests/Makfile: add check-softfloat rule

Emilio G. Cota (3):
      fp-bench: fix update_random_ops
      fp-bench: remove wrong exponent raise in fill_random
      softfloat: enforce softfloat if the host's FMA is broken

Thomas Huth (1):
      include/fpu/softfloat: Fix compilation with Clang on s390x

 fpu/softfloat.c                |  33 +++++++++++
 include/fpu/softfloat-macros.h |   2 +-
 scripts/archive-source.sh      |   2 +-
 tests/Makefile.include         | 132 ++++++++++++++++++++++++++++++++++++++++-
 tests/fp/fp-bench.c            |  15 ++---
 5 files changed, 173 insertions(+), 11 deletions(-)

-- 
2.17.1
