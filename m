Received: from eggs.gnu.org ([209.51.188.92]:47938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggu8e-0004E6-Vi
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:22:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggu8e-0000a2-7r
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:22:00 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:45801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ggu8d-0000Nm-V2
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:22:00 -0500
Received: by mail-wr1-x42e.google.com with SMTP id t6so4612073wrr.12
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 08:21:57 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  8 Jan 2019 16:21:48 +0000
Message-Id: <20190108162154.22259-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH  v1 0/6] current fpu/next queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>


Hi,

This is the current queue of fixes for our softfloat implementation. I
ended up taking Emilio's more complete dynamic probe approach for
broken FMA implementations (direct from git). There is also a fix for
the fp-bench. Finally a couple of patches to roll check-softfloat into
the main make system. It skips some f128 and extF80 float operations
which trigger faults but hopefully we can fix those up in a later
re-factor of the extended size floats.

The following patches need review
  patch 0003/softfloat enforce softfloat if the host s FMA is .patch
  patch 0004/tests Makefile add floating point tests.patch
  patch 0005/scripts archive source include softfloat tests.patch
  patch 0006/tests Makfile add check softfloat rule.patch

Alex Bennée (3):
  tests/Makefile: add floating point tests
  scripts/archive-source: include softfloat tests
  tests/Makfile: add check-softfloat rule

Emilio G. Cota (3):
  fp-bench: fix update_random_ops
  fp-bench: remove wrong exponent raise in fill_random
  softfloat: enforce softfloat if the host's FMA is broken

 fpu/softfloat.c           |  85 ++++++++++++++++++++++++
 include/qemu/cpuid.h      |   6 ++
 scripts/archive-source.sh |   2 +-
 tests/Makefile.include    | 132 +++++++++++++++++++++++++++++++++++++-
 tests/fp/fp-bench.c       |  15 +++--
 5 files changed, 230 insertions(+), 10 deletions(-)

-- 
2.17.1
