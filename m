Received: from eggs.gnu.org ([2001:4830:134:3::10]:52818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1fBhJM-0000n5-TJ
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1fBhJJ-0007id-VF
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:51:48 -0400
Received: from smtp23.cstnet.cn ([159.226.251.23]:49994 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1fBhJJ-0007gt-4K
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:51:45 -0400
From: Su Hang <suhang16@mails.ucas.ac.cn>
Date: Thu, 26 Apr 2018 21:51:36 +0800
Message-Id: <1524750698-16322-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: [Qemu-devel] [PATCH v6 0/2] Implement Hex file loader and add test
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
v6: Call Intel HEX loader after load_uimage_as();
    Remove use of KERNEL_LOAD_ADDR;
    Change (hwaddr) type argument to (hwaddr *) type;
    Use new struct HexParser to contain all arguments needed by
        handle_record_type();
    Enable discontiguous data records (again);
    Remove unnecessary memory clean: bin_buf and HexLine line;
    Correct typo;
    Remove unnecessary check for hex file size;
    Add entry point handle for START_SEG_ADDR_RECORD and
        START_LINEAR_ADDR_RECORD record type;
    Use hwaddr * type to store entry point;

Su Hang (2):
  Implement .hex file loader
  Add QTest testcase for the Intel Hexadecimal Object File Loader.

 MAINTAINERS                          |   6 +
 hw/arm/boot.c                        |  17 ++-
 hw/core/loader.c                     | 241 +++++++++++++++++++++++++++++++++++
 include/hw/loader.h                  |  16 +++
 tests/Makefile.include               |   2 +
 tests/hex-loader-check-data/test.hex |  12 ++
 tests/hexloader-test.c               |  56 ++++++++
 7 files changed, 345 insertions(+), 5 deletions(-)
 create mode 100644 tests/hex-loader-check-data/test.hex
 create mode 100644 tests/hexloader-test.c

--
2.7.4
