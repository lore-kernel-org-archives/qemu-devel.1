Received: from eggs.gnu.org ([2001:4830:134:3::10]:58276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ftGEc-0003oF-0z
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ftGEb-0001sy-1d
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:50:57 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:42761)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ftGEa-0001qU-Mu
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:50:56 -0400
Received: by mail-lj1-x243.google.com with SMTP id f1-v6so7490629ljc.9
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 10:50:56 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 24 Aug 2018 10:50:43 -0700
Message-Id: <20180824175043.23003-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PULL 0/5] target/xtensa updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Hi Peter,

please pull the following batch of target/xtensa updates.

The following changes since commit 0abaa41d936becd914a16ee1fe2a981d96d19428:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-08-17 09:46:00 +0100)

are available in the git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20180824-xtensa

for you to fetch changes up to 4e16a9cad82be9caa8d58a5c5c99cb5fa15ee833:

  tests/tcg/xtensa: add test for failed memory transactions (2018-08-19 20:21:50 -0700)

----------------------------------------------------------------
target/xtensa updates:

- fix gdbstub register counts;
- add big-endian core test_kc705_be;
- convert to do_transaction_failed and add test for failed memory
  transactions.

----------------------------------------------------------------
Max Filippov (5):
      target/xtensa: fix gdbstub register counts
      target/xtensa: clean up gdbstub register handling
      target/xtensa: add test_kc705_be core
      target/xtensa: convert to do_transaction_failed
      tests/tcg/xtensa: add test for failed memory transactions

 target/xtensa/Makefile.objs                        |     1 +
 target/xtensa/core-test_kc705_be.c                 |    52 +
 target/xtensa/core-test_kc705_be/core-isa.h        |   575 +
 target/xtensa/core-test_kc705_be/gdb-config.inc.c  |   259 +
 .../xtensa/core-test_kc705_be/xtensa-modules.inc.c | 45117 +++++++++++++++++++
 target/xtensa/cpu.c                                |     2 +-
 target/xtensa/cpu.h                                |     9 +-
 target/xtensa/gdbstub.c                            |    60 +-
 target/xtensa/helper.c                             |    10 +-
 target/xtensa/op_helper.c                          |    12 +-
 tests/tcg/xtensa/Makefile                          |     1 +
 tests/tcg/xtensa/test_phys_mem.S                   |    68 +
 12 files changed, 46136 insertions(+), 30 deletions(-)
 create mode 100644 target/xtensa/core-test_kc705_be.c
 create mode 100644 target/xtensa/core-test_kc705_be/core-isa.h
 create mode 100644 target/xtensa/core-test_kc705_be/gdb-config.inc.c
 create mode 100644 target/xtensa/core-test_kc705_be/xtensa-modules.inc.c
 create mode 100644 tests/tcg/xtensa/test_phys_mem.S

Thanks.
-- Max
