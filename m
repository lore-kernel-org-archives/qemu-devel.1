Received: from eggs.gnu.org ([2001:4830:134:3::10]:43664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eUFnZ-0002cf-83
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 12:47:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eUFnY-0007JJ-5m
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 12:47:25 -0500
Received: from mail-lf0-x232.google.com ([2a00:1450:4010:c07::232]:40305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eUFnX-0007Gt-SH
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 12:47:24 -0500
Received: by mail-lf0-x232.google.com with SMTP id u84so23065170lff.7
	for <qemu-devel@nongnu.org>; Wed, 27 Dec 2017 09:47:23 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 27 Dec 2017 09:46:59 -0800
Message-Id: <1514396819-29997-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 00/16] target/xtensa updates
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

please pull the following batch of updates for the target/xtensa.

The following changes since commit 0a0dc59d27527b78a195c2d838d28b7b49e5a639:

  Update version for v2.11.0 release (2017-12-13 14:31:09 +0000)

are available in the git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20171227-xtensa

for you to fetch changes up to d462b6b6b79f092327927b3fb3ac20505c90a706:

  target/xtensa: implement disassembler (2017-12-18 21:26:20 -0800)

----------------------------------------------------------------
target/xtensa updates:

- add libisa to the xtensa target;
- change xtensa instruction translator to use it;
- switch existing xtensa cores to use it;
- add support for a number of instructions: salt/saltu, const16,
  GPIO32 group, debug mode and MMU-related;
- add disassembler for Xtensa.

----------------------------------------------------------------
Max Filippov (16):
      target/xtensa: pass actual frame size to the entry helper
      target/xtensa: import libisa source
      target/xtensa: extract core opcode translators
      target/xtensa: extract FPU2000 opcode translators
      target/xtensa: update import_core.sh script for libisa
      target/xtensa: switch dc232b to libisa
      target/xtensa: switch dc233c to libisa
      target/xtensa: switch fsf to libisa
      target/xtensa: use libisa for instruction decoding
      target/xtensa: tests: fix memctl SR test
      target/xtensa: drop DisasContext::litbase
      target/xtensa: add internal/noop SRs and opcodes
      target/xtensa: implement salt/saltu
      target/xtensa: implement GPIO32
      target/xtensa: implement const16
      target/xtensa: implement disassembler

 MAINTAINERS                                |     1 +
 disas/Makefile.objs                        |     1 +
 disas/xtensa.c                             |   133 +
 include/disas/bfd.h                        |     1 +
 include/hw/xtensa/xtensa-isa.h             |   838 ++
 target/xtensa/Makefile.objs                |     1 +
 target/xtensa/core-dc232b.c                |     4 +
 target/xtensa/core-dc232b/xtensa-modules.c | 14105 +++++++++++++++++++++++++
 target/xtensa/core-dc233c.c                |     4 +
 target/xtensa/core-dc233c/xtensa-modules.c | 15232 +++++++++++++++++++++++++++
 target/xtensa/core-fsf.c                   |     5 +
 target/xtensa/core-fsf/xtensa-modules.c    |  9841 +++++++++++++++++
 target/xtensa/cpu.c                        |     9 +
 target/xtensa/cpu.h                        |    31 +
 target/xtensa/helper.c                     |    37 +
 target/xtensa/import_core.sh               |    15 +
 target/xtensa/op_helper.c                  |     2 +-
 target/xtensa/translate.c                  |  5883 +++++++----
 target/xtensa/xtensa-isa-internal.h        |   231 +
 target/xtensa/xtensa-isa.c                 |  1745 +++
 target/xtensa/xtensa-isa.h                 |     1 +
 tests/tcg/xtensa/test_sr.S                 |     2 +-
 22 files changed, 45949 insertions(+), 2173 deletions(-)
 create mode 100644 disas/xtensa.c
 create mode 100644 include/hw/xtensa/xtensa-isa.h
 create mode 100644 target/xtensa/core-dc232b/xtensa-modules.c
 create mode 100644 target/xtensa/core-dc233c/xtensa-modules.c
 create mode 100644 target/xtensa/core-fsf/xtensa-modules.c
 create mode 100644 target/xtensa/xtensa-isa-internal.h
 create mode 100644 target/xtensa/xtensa-isa.c
 create mode 100644 target/xtensa/xtensa-isa.h

-- 
2.1.4
