Received: from eggs.gnu.org ([2001:4830:134:3::10]:33670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fvvQF-0006at-UT
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 22:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fvvQF-0002hs-4q
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 22:13:59 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:38804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fvvQB-0002dz-93
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 22:13:57 -0400
Received: by mail-lf1-x142.google.com with SMTP id i7-v6so11346881lfh.5
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 19:13:54 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 31 Aug 2018 19:13:39 -0700
Message-Id: <20180901021341.18066-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 0/2] tests/tcg/xtensa: exception
 vectors/handlers improvement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Hello,

this series generalizes xtensa test vectors and linker script a bit further:
- it extracts exception/IRQ handlers from vectors, as not all core
  configurations have enough space between the vectors;
- it conditionalizes vectors code, so that only handlers for configured
  IRQs and exceptions are generated.

Max Filippov (2):
  tests/tcg/xtensa: move exception handlers to separate section
  tests/tcg/xtensa: only generate defined exception handlers

 tests/tcg/xtensa/linker.ld.S | 37 ++++++++++++++++++++++---------------
 tests/tcg/xtensa/vectors.S   | 16 ++++++++++++++++
 2 files changed, 38 insertions(+), 15 deletions(-)

-- 
2.11.0
