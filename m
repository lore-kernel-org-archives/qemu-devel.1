Received: from eggs.gnu.org ([2001:4830:134:3::10]:50835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1fLoQh-0005RA-IA
	for qemu-devel@nongnu.org; Thu, 24 May 2018 07:29:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1fLoQc-00015q-D2
	for qemu-devel@nongnu.org; Thu, 24 May 2018 07:29:11 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:39719 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1fLoQb-00014y-NF
	for qemu-devel@nongnu.org; Thu, 24 May 2018 07:29:06 -0400
From: Su Hang <suhang16@mails.ucas.ac.cn>
Date: Thu, 24 May 2018 19:28:58 +0800
Message-Id: <1527161340-3200-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: [Qemu-devel] [PULL 0/2] Implement Hex file loader and add test case
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


The following changes since commit 9cac60db4513f968b56e12720c1ea433be318cc3:

  Merge remote-tracking branch 'remotes/mwalle/tags/lm32-queue/20180521' into staging (2018-05-24 10:25:43 +0100)

are available in the git repository at:

  git://github.com/DarcySail/qemu.git foo.for-upstream

for you to fetch changes up to a9120811a5b9109d79f704e0a79fb851860e9f04:

  Add QTest testcase for the Intel Hexadecimal Object File Loader. (2018-05-24 18:54:02 +0800)

----------------------------------------------------------------
Su Hang (2):
      Implement .hex file loader
      Add QTest testcase for the Intel Hexadecimal Object File Loader.

 MAINTAINERS                          |   6 +
 configure                            |   4 +
 hw/arm/boot.c                        |   7 +-
 hw/core/loader.c                     | 246 +++++++++++++++++++++++++++++++++++
 include/hw/loader.h                  |  12 ++
 tests/Makefile.include               |   2 +
 tests/hex-loader-check-data/test.hex |  12 ++
 tests/hexloader-test.c               |  56 ++++++++
 8 files changed, 344 insertions(+), 1 deletion(-)
 create mode 100644 tests/hex-loader-check-data/test.hex
 create mode 100644 tests/hexloader-test.c
