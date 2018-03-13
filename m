Received: from eggs.gnu.org ([2001:4830:134:3::10]:54497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evmLV-0002tY-IM
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:00:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evmLP-0002ud-W7
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:00:13 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:56193)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evmLP-0002tW-MQ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:00:07 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 13 Mar 2018 16:59:07 +0100
Message-Id: <20180313155918.23591-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 00/11] M68k for 2.12 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

The following changes since commit 59667bb167f773965ce6547352f312eff0d4d523:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-03-13 14:02:47 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.12-pull-request

for you to fetch changes up to 02f9124ebe26c36f0f7ed58085bd963e4372b2cd:

  target/m68k: implement fcosh (2018-03-13 16:35:05 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Laurent Vivier (11):
  target/m68k: implement ftan
  target/m68k: implement fsin
  target/m68k: implement fcos
  target/m68k: implement fsincos
  target/m68k: implement fatan
  target/m68k: implement fasin
  target/m68k: implement facos
  target/m68k: implement fatanh
  target/m68k: implement ftanh
  target/m68k: implement fsinh
  target/m68k: implement fcosh

 target/m68k/fpu_helper.c            |   61 ++
 target/m68k/helper.h                |   11 +
 target/m68k/softfloat.c             | 1637 +++++++++++++++++++++++++++++++++++
 target/m68k/softfloat.h             |   11 +
 target/m68k/softfloat_fpsp_tables.h |  267 ++++++
 target/m68k/translate.c             |   38 +
 6 files changed, 2025 insertions(+)

-- 
2.14.3
