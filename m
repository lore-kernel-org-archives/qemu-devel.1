Received: from eggs.gnu.org ([2001:4830:134:3::10]:39877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dNmkC-0001jU-BM
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 17:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dNmk8-0006RT-GC
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 17:00:56 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:58215)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dNmk8-0006Qe-4l
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 17:00:52 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 21 Jun 2017 23:00:42 +0200
Message-Id: <20170621210047.24083-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/5] M68k for 2.10 patches
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

The following changes since commit 8dfaf23ae1f2273a9730a9b309cc8471269bb524:

  tcg/tci: fix tcg-interpreter build (2017-06-20 18:39:15 +0100)

are available in the git repository at:

  git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.10-pull-request

for you to fetch changes up to ba62494483ab51ee31c70952b6ce5171a31860b1:

  target-m68k: add FPCR and FPSR (2017-06-21 22:11:55 +0200)

----------------------------------------------------------------

----------------------------------------------------------------

Laurent Vivier (5):
  target-m68k: move fmove CR to a function
  target-m68k: initialize FPU registers
  target-m68k: use floatx80 internally
  target-m68k: define 96bit FP registers for gdb on 680x0
  target-m68k: add FPCR and FPSR

 configure                |   2 +-
 gdb-xml/m68k-fp.xml      |  21 +
 target/m68k/cpu.c        |   9 +-
 target/m68k/cpu.h        |  58 ++-
 target/m68k/fpu_helper.c | 180 ++++++---
 target/m68k/helper.c     |  77 +++-
 target/m68k/helper.h     |  38 +-
 target/m68k/qregs.def    |   1 -
 target/m68k/translate.c  | 983 ++++++++++++++++++++++++++++++++---------------
 9 files changed, 984 insertions(+), 385 deletions(-)
 create mode 100644 gdb-xml/m68k-fp.xml

-- 
2.9.4
