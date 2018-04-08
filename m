Received: from eggs.gnu.org ([2001:4830:134:3::10]:51121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f50T6-00063s-5B
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 22:54:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f50T3-0004fW-2o
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 22:54:12 -0400
Received: from smtp20.cstnet.cn ([159.226.251.20]:54970 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f50T2-0004dz-DU
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 22:54:08 -0400
From: Su Hang <suhang16@mails.ucas.ac.cn>
Date: Sun,  8 Apr 2018 10:54:04 +0800
Message-Id: <1523156046-5586-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: [Qemu-devel] [PATCH v3 0/2] Implement Hex file loader and add test
 case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com, eblake@redhat.com, jim@groklearning.com, joel@jms.id.au, qemu-devel@nongnu.org

These series of patchs implement Intel Hexadecimal File loader and
add QTest testcase to verify the correctness of Loader.

v1: Basic version.
v2: Replace `do{}while(cond);` block with `for(;;)` block.
v3: Add two new files information in MAINTAINERS.

Su Hang (2):
  Implement .hex file loader
  Add QTest testcase for the Intel Hexadecimal Object File Loader.

 MAINTAINERS                          |   6 +
 hw/arm/boot.c                        |   9 +-
 hw/core/loader.c                     | 280 +++++++++++++++++++++++++++++++++++
 include/hw/loader.h                  |  17 +++
 tests/Makefile.include               |   2 +
 tests/hex-loader-check-data/test.hex |  11 ++
 tests/hexloader-test.c               |  56 +++++++
 7 files changed, 380 insertions(+), 1 deletion(-)
 create mode 100644 tests/hex-loader-check-data/test.hex
 create mode 100644 tests/hexloader-test.c

-- 
2.7.4
