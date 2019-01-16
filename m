Received: from eggs.gnu.org ([209.51.188.92]:42784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gjrj9-0006ti-EX
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 15:23:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gjrj7-000601-JV
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 15:23:54 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:36213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gjrj7-0005hj-B6
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 15:23:53 -0500
Received: by mail-wr1-x42f.google.com with SMTP id u4so8494681wrp.3
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 12:23:52 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 16 Jan 2019 20:23:42 +0000
Message-Id: <20190116202349.29272-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH  v2 0/7] current fpu/next queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>


Hi,

I plan to send a pull request for this tomorrow. Two changes were:

 - take Emilio's v2 of the FMA patch
 - add my version of the s390x+clang compile fix

Unless there is a strong performance argument I'm minded to go with my
version. The numbers so far look pretty marginal for all 3 code paths.

It would be nice to get some review on the last few patches:

The following patches need review:
 patch 0004/softfloat fallback to __int128 maths for s390x an.patch
 patch 0005/tests Makefile add floating point tests.patch
 patch 0007/tests Makfile add check softfloat rule.patch

Alex Bennée (4):
  softfloat: fallback to __int128 maths for s390x and others
  tests/Makefile: add floating point tests
  scripts/archive-source: include softfloat tests
  tests/Makfile: add check-softfloat rule

Emilio G. Cota (3):
  fp-bench: fix update_random_ops
  fp-bench: remove wrong exponent raise in fill_random
  softfloat: enforce softfloat if the host's FMA is broken

 fpu/softfloat.c                |  33 +++++++++
 include/fpu/softfloat-macros.h |  10 +--
 scripts/archive-source.sh      |   2 +-
 tests/Makefile.include         | 132 ++++++++++++++++++++++++++++++++-
 tests/fp/fp-bench.c            |  15 ++--
 5 files changed, 176 insertions(+), 16 deletions(-)

-- 
2.17.1
