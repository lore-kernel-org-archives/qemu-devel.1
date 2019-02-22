Received: from eggs.gnu.org ([209.51.188.92]:38780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gxHrn-000362-07
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 15:56:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gxHgt-0006qx-N6
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 15:45:04 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:32775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gxHgs-0006nz-T9
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 15:45:03 -0500
Received: by mail-wm1-x344.google.com with SMTP id h22so9678944wmb.0
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 12:45:02 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Feb 2019 20:44:54 +0000
Message-Id: <20190222204500.24434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH  v1 0/6] fpu/next,
 mostly bits s390x tcg will need
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

Here is the current status of fpu/next. I intend to send the PR in
next week as there are bits in it blocking work for s390. This is the
last chance to pipe up with any objections.

The following patches need review
  0004/tests fp add wrapping for f128_to_ui32.patch
  0005/tests fp enable f128_to_ui 32 64 tests in float t.patch

Alex Bennée (2):
  tests/fp: add wrapping for f128_to_ui32
  tests/fp: enable f128_to_ui[32/64] tests in float-to-uint

David Hildenbrand (2):
  softfloat: add float128_is_{normal,denormal}
  softfloat: Implement float128_to_uint32

Eric Blake (1):
  tests: Ignore fp test outputs

Richard Henderson (1):
  softfloat: Support float_round_to_odd more places

 fpu/softfloat.c         | 93 ++++++++++++++++++++++++++++++++++++++---
 include/fpu/softfloat.h | 15 ++++++-
 tests/.gitignore        |  1 +
 tests/Makefile.include  |  7 ++--
 tests/fp/fp-test.c      | 46 +++++++++++++++-----
 tests/fp/wrap.inc.c     |  1 +
 6 files changed, 143 insertions(+), 20 deletions(-)

-- 
2.20.1
