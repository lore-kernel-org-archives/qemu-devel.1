Received: from eggs.gnu.org ([2001:4830:134:3::10]:33399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f9Pnj-0000hk-7Y
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f9Pne-0004EY-7X
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:45:43 -0400
Received: from smtp15.cstnet.cn ([159.226.251.15]:37079 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f9Pnd-0004B8-IE
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:45:38 -0400
From: Su Hang <suhang16@mails.ucas.ac.cn>
Date: Fri, 20 Apr 2018 14:45:30 +0800
Message-Id: <1524206732-7729-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: [Qemu-devel] [PATCH v5 0/2] Implement Hex file loader and add test
 case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au
Cc: qemu-devel@nongnu.org

These series of patchs implement Intel Hexadecimal File loader and
add QTest testcase to verify the correctness of Loader.

v1: Basic version.
v2: Replace `do{}while(cond);` block with `for(;;)` block.
v3: Add two new files information in MAINTAINERS.
v4: Correct the 'test.hex' path in hexloader-test.c.
v5: Split huge parse_hex_blob() function into four small function;
    Add check for memory bounds;
    Check validation for Record type;
    Replace function ctoh() with glib function g_ascii_xdigit_value();
    Remove check for '.hex' suffix;
    Remove unnecessary type cast;
    Remove duplicate zero-initialization;
    Correct typos;

Su Hang (2):
  Implement .hex file loader
  Add QTest testcase for the Intel Hexadecimal Object File Loader.

 MAINTAINERS                          |   6 +
 hw/arm/boot.c                        |  18 ++-
 hw/core/loader.c                     | 253 +++++++++++++++++++++++++++++++++++
 include/hw/loader.h                  |  14 ++
 tests/Makefile.include               |   2 +
 tests/hex-loader-check-data/test.hex |  11 ++
 tests/hexloader-test.c               |  56 ++++++++
 7 files changed, 355 insertions(+), 5 deletions(-)
 create mode 100644 tests/hex-loader-check-data/test.hex
 create mode 100644 tests/hexloader-test.c

-- 
2.7.4
