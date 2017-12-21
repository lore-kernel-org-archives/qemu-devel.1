Received: from eggs.gnu.org ([2001:4830:134:3::10]:60704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eS6e8-00067E-H2
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:36:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eS6e4-0005Zr-BQ
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:36:48 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:51217)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eS6e4-0005Yt-1i
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:36:44 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 21 Dec 2017 20:36:35 +0100
Message-Id: <20171221193640.27418-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/5] M68k for 2.12 patches
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

The following changes since commit 23bafd75cd979ad3a21af10273c5a0c5d67d068b:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-12-21 16:34:23 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.12-pull-request

for you to fetch changes up to 598a29f3606c4c7042a1ca3f1116663d0a60867c:

  tests/boot-serial-test: Add support for the mcf5208evb board (2017-12-21 20:13:18 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Laurent Vivier (4):
  Split adb.c into adb.c, adb-mouse.c and adb-kbd.c
  target/m68k: remove unused variable gen_throws_exception
  target/m68k: add monitor.c
  target/m68k: fix set_cc_op()

Thomas Huth (1):
  tests/boot-serial-test: Add support for the mcf5208evb board

 hw/input/Makefile.objs    |   2 +-
 hw/input/adb-internal.h   |  49 ++++
 hw/input/adb-kbd.c        | 400 +++++++++++++++++++++++++++++
 hw/input/adb-mouse.c      | 254 +++++++++++++++++++
 hw/input/adb.c            | 622 +---------------------------------------------
 hw/input/trace-events     |   8 +
 target/m68k/Makefile.objs |   1 +
 target/m68k/cpu.h         |   2 +-
 target/m68k/monitor.c     |  39 +++
 target/m68k/translate.c   |  11 +-
 tests/Makefile.include    |   2 +
 tests/boot-serial-test.c  |  10 +
 12 files changed, 768 insertions(+), 632 deletions(-)
 create mode 100644 hw/input/adb-internal.h
 create mode 100644 hw/input/adb-kbd.c
 create mode 100644 hw/input/adb-mouse.c
 create mode 100644 target/m68k/monitor.c

-- 
2.14.3
