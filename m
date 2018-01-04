Received: from eggs.gnu.org ([2001:4830:134:3::10]:55286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eX8ba-0007Xm-AW
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:43:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eX8bX-0003US-2j
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:42:58 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:64700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eX8bW-0003Sh-OL
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:42:54 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  4 Jan 2018 17:42:34 +0100
Message-Id: <20180104164251.26494-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/17] M68k for 2.12 patches
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

The following changes since commit 281f327487c9c9b1599f93c589a408bbf4a651b8:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.12-pull-request' into staging (2017-12-22 00:11:36 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.12-pull-request

for you to fetch changes up to cc5230267678c26b7f96157086f45fd8a347eb21:

  target/m68k: fix m68k_cpu_dump_state() (2018-01-04 17:24:35 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Laurent Vivier (17):
  target-m68k: sync CC_OP before gen_jmp_tb()
  target/m68k: fix gen_get_ccr()
  linux-user, m68k: correctly manage SR in context
  target/m68k: use insn_pc to generate instruction fault address
  target/m68k: add CPU_LOG_INT trace
  target/m68k: manage 680x0 stack frames
  target/m68k: add chk and chk2
  target/m68k: add move16
  target/m68k: softmmu cleanup
  target/m68k: add cpush/cinv
  target/m68k: add reset
  target/m68k: implement fsave/frestore
  target/m68k: move CCR/SR functions
  target/m68k: add 680x0 "move to SR" instruction
  target/m68k: add andi/ori/eori to SR/CCR
  target/m68k: add the Interrupt Stack Pointer
  target/m68k: fix m68k_cpu_dump_state()

 linux-user/main.c       |   7 +
 linux-user/signal.c     |   7 +-
 target/m68k/cpu.c       |  20 +-
 target/m68k/cpu.h       |  84 +++++++-
 target/m68k/gdbstub.c   |   2 +-
 target/m68k/helper.c    |  99 +++++++++-
 target/m68k/helper.h    |  11 +-
 target/m68k/monitor.c   |   1 +
 target/m68k/op_helper.c | 338 +++++++++++++++++++++++++++++++-
 target/m68k/translate.c | 497 ++++++++++++++++++++++++++++++++++++++----------
 10 files changed, 937 insertions(+), 129 deletions(-)

-- 
2.14.3
