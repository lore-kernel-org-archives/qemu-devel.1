Received: from eggs.gnu.org ([2001:4830:134:3::10]:41700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f0Zus-0000NA-MN
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 17:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f0Zur-0001LG-PU
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 17:44:34 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:37783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f0Zur-0001Kb-Hk
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 17:44:33 -0400
Received: by mail-lf0-x242.google.com with SMTP id m16-v6so26584617lfc.4
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 14:44:33 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 26 Mar 2018 14:44:09 -0700
Message-Id: <20180326214409.15326-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/4] target/xtensa fixes for 2.12
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

please pull the following fixes for target/xtensa for 2.12:

The following changes since commit 7b93d78a04aa242d377ae213b79db6c319c71847:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-03-26 15:17:25 +0100)

are available in the git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20180326-xtensa

for you to fetch changes up to d0ce7e9cfc8eda113f872b608fe4a3dd7662997e:

  target/xtensa: fix timers test (2018-03-26 14:17:04 -0700)

----------------------------------------------------------------
target/xtensa fixes for 2.12:

- add .inc. to non-top level source file names under target/xtensa;
- fix #include <xtensa-isa.h> in the import_core.sh script;
- remove stray linux-user/xtensa/syscall.h;
- fix timers test.

----------------------------------------------------------------
Max Filippov (4):
      target/xtensa: add .inc. to non-top level source file names
      target/xtensa/import_core.sh: fix #include <xtensa-isa.h>
      linux-user/xtensa: remove stray syscall.h
      target/xtensa: fix timers test

 linux-user/xtensa/syscall.h                                      | 0
 target/xtensa/core-dc232b.c                                      | 6 +++---
 target/xtensa/core-dc232b/{gdb-config.c => gdb-config.inc.c}     | 0
 .../core-dc232b/{xtensa-modules.c => xtensa-modules.inc.c}       | 0
 target/xtensa/core-dc233c.c                                      | 4 ++--
 target/xtensa/core-dc233c/{gdb-config.c => gdb-config.inc.c}     | 0
 .../core-dc233c/{xtensa-modules.c => xtensa-modules.inc.c}       | 0
 target/xtensa/core-de212.c                                       | 4 ++--
 target/xtensa/core-de212/{gdb-config.c => gdb-config.inc.c}      | 0
 .../xtensa/core-de212/{xtensa-modules.c => xtensa-modules.inc.c} | 0
 target/xtensa/core-fsf.c                                         | 2 +-
 .../xtensa/core-fsf/{xtensa-modules.c => xtensa-modules.inc.c}   | 0
 target/xtensa/core-sample_controller.c                           | 4 ++--
 .../core-sample_controller/{gdb-config.c => gdb-config.inc.c}    | 0
 .../{xtensa-modules.c => xtensa-modules.inc.c}                   | 0
 target/xtensa/import_core.sh                                     | 9 +++++----
 tests/tcg/xtensa/Makefile                                        | 2 +-
 17 files changed, 16 insertions(+), 15 deletions(-)
 delete mode 100644 linux-user/xtensa/syscall.h
 rename target/xtensa/core-dc232b/{gdb-config.c => gdb-config.inc.c} (100%)
 rename target/xtensa/core-dc232b/{xtensa-modules.c => xtensa-modules.inc.c} (100%)
 rename target/xtensa/core-dc233c/{gdb-config.c => gdb-config.inc.c} (100%)
 rename target/xtensa/core-dc233c/{xtensa-modules.c => xtensa-modules.inc.c} (100%)
 rename target/xtensa/core-de212/{gdb-config.c => gdb-config.inc.c} (100%)
 rename target/xtensa/core-de212/{xtensa-modules.c => xtensa-modules.inc.c} (100%)
 rename target/xtensa/core-fsf/{xtensa-modules.c => xtensa-modules.inc.c} (100%)
 rename target/xtensa/core-sample_controller/{gdb-config.c => gdb-config.inc.c} (100%)
 rename target/xtensa/core-sample_controller/{xtensa-modules.c => xtensa-modules.inc.c} (100%)

-- 
Thanks.
-- Max
