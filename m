Received: from eggs.gnu.org ([2001:4830:134:3::10]:35238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSs4i-000683-Qv
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:10:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSs4f-0002oa-MQ
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:10:52 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cSs4f-0002oM-GV
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:10:49 -0500
Received: by mail-pg0-x243.google.com with SMTP id b1so3583149pgc.1
	for <qemu-devel@nongnu.org>; Sun, 15 Jan 2017 13:10:49 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 15 Jan 2017 13:10:10 -0800
Message-Id: <1484514617-11726-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 0/7] target/xtensa: refactor timers
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

this series reimplements xtensa CCOUNT/CCOMPARE features using QEMU
timers, enables support for running with -icount option and updates
timer tests.

Max Filippov (7):
  target/xtensa: refactor CCOUNT/CCOMPARE
  target/xtensa: support icount
  target/xtensa: don't continue translation after exception
  target/xtensa: tests: run tests with icount
  target/xtensa: tests: fix timer tests
  target/xtensa: tests: replace hardcoded interrupt masks
  target/xtensa: tests: add ccount write tests

 hw/xtensa/pic_cpu.c           |  75 +++-----------
 target/xtensa/cpu.h           |  21 +++-
 target/xtensa/helper.h        |   5 +-
 target/xtensa/op_helper.c     |  37 +++++--
 target/xtensa/translate.c     | 225 ++++++++++++++++++++++++++++--------------
 tests/tcg/xtensa/Makefile     |   2 +-
 tests/tcg/xtensa/test_timer.S | 105 +++++++++++++-------
 7 files changed, 284 insertions(+), 186 deletions(-)

-- 
2.1.4
