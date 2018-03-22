Received: from eggs.gnu.org ([2001:4830:134:3::10]:51037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ez4f3-0001aR-Rn
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:10:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ez4f2-0002dL-TK
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:10:01 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:37602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ez4f2-0002ca-M4
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:10:00 -0400
Received: by mail-lf0-x244.google.com with SMTP id m16-v6so10810029lfc.4
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 11:10:00 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 22 Mar 2018 11:09:37 -0700
Message-Id: <20180322180940.8253-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 0/3] target/xtensa: improvements for
 core-specific files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Hello,

this series adds .inc. to the names of non-top level xtensa core-specific
files and fixes script import_core.sh so that it does it automatically.
It also adds a fixup to the script that changes #include <xtensa-isa.h>
to #include "xtensa-isa.h".

Max Filippov (3):
  target/xtensa: add .inc. to non-top level source file names
  target/xtensa/import_core.sh: fix names of non-top level files
  target/xtensa/import_core.sh: fix #include <xtensa-isa.h>

 target/xtensa/core-dc232b.c                                      | 4 ++--
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
 15 files changed, 14 insertions(+), 13 deletions(-)
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
2.11.0
