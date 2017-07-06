Received: from eggs.gnu.org ([2001:4830:134:3::10]:59578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSuan-0007Nj-CB
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSuak-0002Kw-84
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:24:25 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dSuak-0002KN-2E
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:24:22 -0400
Received: by mail-qt0-x243.google.com with SMTP id m54so644925qtb.1
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 17:24:20 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed,  5 Jul 2017 14:23:50 -1000
Message-Id: <20170706002401.10507-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 00/11] target/sh4 improvments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, bruno@clisp.org

This fixes two problems with atomic operations on sh4,
including an attempt at supporting the user-space atomics
technique used by most sh-linux-user binaries.

This is good enough to run the one occurrence in linux-user-test-0.3.
I'm still downloading enough of a cross environment to be able to run
more recent sh4 binaries.  Including the one in the LP bug report.

Thoughts and more extensive testing appreciated.


r~


Richard Henderson (11):
  target/sh4: Use cmpxchg for movco
  target/sh4: Consolidate end-of-TB tests
  target/sh4: Handle user-space atomics
  target/sh4: Recognize common gUSA sequences
  linux-user/sh4: Notice gUSA regions during signal delivery
  target/sh4: Hoist register bank selection
  target/sh4: Unify cpu_fregs into FREG
  target/sh4: Pass DisasContext to fpr64 routines
  target/sh4: Avoid a potential translator crash for malformed FPR64
  target/sh4: Hoist fp bank selection
  target/sh4: Eliminate DREG macro

 target/sh4/cpu.h       |  24 +-
 target/sh4/helper.h    |   1 +
 linux-user/signal.c    |  21 ++
 target/sh4/op_helper.c |   6 +
 target/sh4/translate.c | 724 ++++++++++++++++++++++++++++++++++++++-----------
 5 files changed, 621 insertions(+), 155 deletions(-)

-- 
2.9.4
