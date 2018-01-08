Received: from eggs.gnu.org ([2001:4830:134:3::10]:43622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eYbYx-0005Wf-Lf
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:51:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eYbY8-00080S-4L
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:50:19 -0500
Received: from mail-lf0-x22e.google.com ([2a00:1450:4010:c07::22e]:46927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eYbY7-0007zW-M3
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:49:27 -0500
Received: by mail-lf0-x22e.google.com with SMTP id a12so12980633lfe.13
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 09:49:27 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon,  8 Jan 2018 09:49:09 -0800
Message-Id: <1515433749-5839-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PULL v2 00/16] target/xtensa updates
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
Changes v1->v2:
- Drop no longer used function option_bits_enabled.

The following changes since commit 0a0dc59d27527b78a195c2d838d28b7b49e5a639:

  Update version for v2.11.0 release (2017-12-13 14:31:09 +0000)

are available in the git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20180108-xtensa

for you to fetch changes up to 7ffb3123b24e42a3a94e865434b4180025b9f9ca:

  target/xtensa: implement disassembler (2018-01-08 09:37:32 -0800)

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
 target/xtensa/translate.c                  |  5900 +++++++----
 target/xtensa/xtensa-isa-internal.h        |   231 +
 target/xtensa/xtensa-isa.c                 |  1745 +++
 target/xtensa/xtensa-isa.h                 |     1 +
 tests/tcg/xtensa/test_sr.S                 |     2 +-
 22 files changed, 45955 insertions(+), 2184 deletions(-)
 create mode 100644 disas/xtensa.c
 create mode 100644 include/hw/xtensa/xtensa-isa.h
 create mode 100644 target/xtensa/core-dc232b/xtensa-modules.c
 create mode 100644 target/xtensa/core-dc233c/xtensa-modules.c
 create mode 100644 target/xtensa/core-fsf/xtensa-modules.c
 create mode 100644 target/xtensa/xtensa-isa-internal.h
 create mode 100644 target/xtensa/xtensa-isa.c
 create mode 100644 target/xtensa/xtensa-isa.h

-- 
Thanks.
-- Max
