Received: from eggs.gnu.org ([2001:4830:134:3::10]:36213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f3NtJ-00043p-RK
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f3NtG-0002aT-Jb
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:30:33 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:39000 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f3NtF-0002Ya-U9
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:30:30 -0400
From: Su Hang <suhang16@mails.ucas.ac.cn>
Date: Tue,  3 Apr 2018 23:30:24 +0800
Message-Id: <1522769426-6056-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: [Qemu-devel] [PATCH 0/2 RFC] Implement Hex file loader and add test
 case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au, qemu-devel@nongnu.org

These series of patchs implement Intel Hexadecimal File loader and
add QTest testcase to verify the correctness of Loader.  

Su Hang (2):
  Implement .hex file loader
  Add QTest testcase for the Intel Hexadecimal Object File Loader.

 hw/arm/boot.c          |   9 +-
 hw/core/loader.c       | 280 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/loader.h    |  17 +++
 tests/Makefile.include |   2 +
 tests/hexloader-test.c |  56 ++++++++++
 tests/test.hex         |  11 ++
 6 files changed, 374 insertions(+), 1 deletion(-)
 create mode 100644 tests/hexloader-test.c
 create mode 100644 tests/test.hex

-- 
2.7.4
