Received: from eggs.gnu.org ([2001:4830:134:3::10]:46122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fGi5V-0002Ei-F2
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fGi5R-0004Rs-Hr
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:42:13 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:38001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fGi5R-0004RA-BK
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:42:09 -0400
Received: by mail-wr0-x243.google.com with SMTP id 94-v6so1334059wrf.5
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 02:42:09 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 10 May 2018 10:42:01 +0100
Message-Id: <20180510094206.15354-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/5] refactor float-to-float and fix AHP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

Hi,

I've not included the test case in the series but you can find it in
my TCG fixup branch:

  https://github.com/stsquad/qemu/blob/testing/tcg-tests-revival-v4/tests/tcg/arm/fcvt.c

Some of the ARMv7 versions are commented out as they where not
supported until later revs. I do have a build that includes that but
unfortunately the Debian compiler it too old to build it.

: patch 0001/fpu softfloat int_to_float ensure r fully initial.patch needs review
: patch 0004/target arm convert conversion helpers to fpst ahp.patch needs review
: patch 0005/target arm squash FZ16 behaviour for conversions.patch needs review

Alex Bennée (5):
  fpu/softfloat: int_to_float ensure r fully initialised
  fpu/softfloat: re-factor float to float conversions
  fpu/softfloat: support ARM Alternative half-precision
  target/arm: convert conversion helpers to fpst/ahp_flag
  target/arm: squash FZ16 behaviour for conversions

 fpu/softfloat-specialize.h |  40 ---
 fpu/softfloat.c            | 546 +++++++++++--------------------------
 include/fpu/softfloat.h    |   8 +-
 target/arm/helper.c        |  66 ++---
 target/arm/helper.h        |  12 +-
 target/arm/translate-a64.c |  38 ++-
 target/arm/translate.c     |  70 +++--
 target/arm/translate.h     |  15 +
 8 files changed, 306 insertions(+), 489 deletions(-)

-- 
2.17.0
