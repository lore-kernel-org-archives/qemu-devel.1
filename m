Received: from eggs.gnu.org ([2001:4830:134:3::10]:58888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euIyp-0000v5-2m
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:26:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euIyl-0007Aw-5I
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:26:43 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:39649)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1euIyk-0007AI-RK
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:26:39 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri,  9 Mar 2018 15:26:22 +0100
Message-Id: <20180309142630.2170-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 0/8] M68k for 2.12 patches
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

The following changes since commit e1ee9ee139ed7091c2c592d5b784fbb7227bfc0d:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.12-20180306' into staging (2018-03-06 10:21:35 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.12-pull-request

for you to fetch changes up to 2c7c1717175c9a522746fb43316a63e16a636c7b:

  target/m68k: implement ftentox (2018-03-09 15:10:42 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Laurent Vivier (8):
  target/m68k: define floatx80_move()
  target/m68k: implement flognp1
  target/m68k: implement flogn
  target/m68k: implement flog10
  target/m68k: implement flog2
  target/m68k: implement fetox
  target/m68k: implement ftwotox
  target/m68k: implement ftentox

 target/m68k/fpu_helper.c            |   35 ++
 target/m68k/helper.h                |    7 +
 target/m68k/softfloat.c             | 1019 +++++++++++++++++++++++++++++++++++
 target/m68k/softfloat.h             |    8 +
 target/m68k/softfloat_fpsp_tables.h |  374 +++++++++++++
 target/m68k/translate.c             |   21 +
 6 files changed, 1464 insertions(+)
 create mode 100755 target/m68k/softfloat_fpsp_tables.h

-- 
2.14.3
