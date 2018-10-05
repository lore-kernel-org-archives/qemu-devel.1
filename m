Received: from eggs.gnu.org ([2001:4830:134:3::10]:38441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8UQS-0000IC-SF
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 14:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8UQR-0003bk-SS
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 14:02:08 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g8UQR-0003XK-LA
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 14:02:07 -0400
Received: by mail-ot1-x342.google.com with SMTP id q50so9392405otd.0
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 11:02:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  5 Oct 2018 13:01:53 -0500
Message-Id: <20181005180201.11387-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/8] softfloat queue
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

The following changes since commit ae7a4c0a4604bcfed40170db6cca576c44d872a2:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20181004' into staging (2018-10-05 16:05:06 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-fpu-20181005

for you to fetch changes up to 27ae5109a2ba8b6b679cce3e03e16570a34390a0:

  softfloat: Specialize udiv_qrnnd for ppc64 (2018-10-05 12:57:41 -0500)

----------------------------------------------------------------
Testing infrastructure for softfpu (not run by default).
Drop countLeadingZeros.
Fix div_floats.
Add udiv_qrnnd specializations for x86_64, s390x, ppc64 hosts.

----------------------------------------------------------------
Emilio G. Cota (3):
      softfloat: remove float64_trunc_to_int
      gitmodules: add berkeley's softfloat + testfloat version 3
      tests/fp/fp-test: add floating point tests

Richard Henderson (4):
      softfloat: Fix division
      softfloat: Specialize udiv_qrnnd for x86_64
      softfloat: Specialize udiv_qrnnd for s390x
      softfloat: Specialize udiv_qrnnd for ppc64

Thomas Huth (1):
      softfloat: Replace countLeadingZeros32/64 with clz32/64

 include/fpu/softfloat-macros.h | 149 +++----
 include/fpu/softfloat.h        |   1 -
 tests/fp/platform.h            |  41 ++
 fpu/softfloat.c                |  68 +--
 tests/fp/fp-test.c             | 992 +++++++++++++++++++++++++++++++++++++++++
 tests/fp/wrap.inc.c            | 653 +++++++++++++++++++++++++++
 .gitmodules                    |   6 +
 configure                      |   4 +
 tests/Makefile.include         |   3 +
 tests/fp/.gitignore            |   1 +
 tests/fp/Makefile              | 597 +++++++++++++++++++++++++
 tests/fp/berkeley-softfloat-3  |   1 +
 tests/fp/berkeley-testfloat-3  |   1 +
 13 files changed, 2392 insertions(+), 125 deletions(-)
 create mode 100644 tests/fp/platform.h
 create mode 100644 tests/fp/fp-test.c
 create mode 100644 tests/fp/wrap.inc.c
 create mode 100644 tests/fp/.gitignore
 create mode 100644 tests/fp/Makefile
 create mode 160000 tests/fp/berkeley-softfloat-3
 create mode 160000 tests/fp/berkeley-testfloat-3
