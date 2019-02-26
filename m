Received: from eggs.gnu.org ([209.51.188.92]:52705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gydSo-00087l-Op
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:12:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gydSn-0003JI-Nx
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:12:06 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:44134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gydSn-0003FO-77
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:12:05 -0500
Received: by mail-wr1-x429.google.com with SMTP id w2so14092855wrt.11
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 06:12:04 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 26 Feb 2019 14:11:54 +0000
Message-Id: <20190226141201.16999-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/7] softfloat updates, mostly for s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, david@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The following changes since commit ef80b99ce7ffbd66b3efd493f4ca99f8abf59e79:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-220219-1' into staging (2019-02-25 14:04:20 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-fpu-next-260219-1

for you to fetch changes up to bf30e8662cd2ee8b750945591cb34a31784fb994:

  tests/Makefile.include: test all rounding modes of softfloat (2019-02-26 14:08:03 +0000)

----------------------------------------------------------------
Softloat updates, mostly in preparation for s390x usage

----------------------------------------------------------------
Alex Bennée (3):
      tests/fp: add wrapping for f128_to_ui32
      tests/fp: enable f128_to_ui[32/64] tests in float-to-uint
      tests/Makefile.include: test all rounding modes of softfloat

David Hildenbrand (2):
      softfloat: add float128_is_{normal,denormal}
      softfloat: Implement float128_to_uint32

Eric Blake (1):
      tests: Ignore fp test outputs

Richard Henderson (1):
      softfloat: Support float_round_to_odd more places

 fpu/softfloat.c         | 94 ++++++++++++++++++++++++++++++++++++++++++++++---
 include/fpu/softfloat.h | 15 ++++++--
 tests/.gitignore        |  1 +
 tests/Makefile.include  | 15 ++++----
 tests/fp/fp-test.c      | 46 ++++++++++++++++++------
 tests/fp/wrap.inc.c     |  1 +
 6 files changed, 148 insertions(+), 24 deletions(-)

-- 
2.20.1
