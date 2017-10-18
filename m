Received: from eggs.gnu.org ([2001:4830:134:3::10]:58576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1e4nXU-0005C8-Ho
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1e4nXO-0003sg-FH
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:35 -0400
Received: from mail-lf0-x22b.google.com ([2a00:1450:4010:c07::22b]:53548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1e4nXO-0003rg-7Z
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:30 -0400
Received: by mail-lf0-x22b.google.com with SMTP id l23so5612537lfk.10
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 05:33:28 -0700 (PDT)
From: riku.voipio@linaro.org
Date: Wed, 18 Oct 2017 15:33:14 +0300
Message-Id: <cover.1508329282.git.riku.voipio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/10] linux-user update for 2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@linaro.org>

From: Riku Voipio <riku.voipio@linaro.org>

The following changes since commit 40a1e8ac2e10155b5df13a2508ac080b00cd7e23:

  Merge remote-tracking branch 'remotes/elmarco/tags/vu-pull-request' into staging (2017-10-16 10:22:39 +0100)

are available in the git repository at:

  git://git.linaro.org/people/riku.voipio/qemu.git tags/pull-linux-user-20171018

for you to fetch changes up to f443e3960d9d3340dd286e5fc0b661bb165a8b22:

  linux-user: Fix TARGET_MTIOCTOP/MTIOCGET/MTIOCPOS values (2017-10-17 22:24:02 +0300)

----------------------------------------------------------------
Linux-user updates for Qemu 2.11

----------------------------------------------------------------
Alex Bennée (1):
      linux-user/main: support dfilter

Carlo Marcelo Arenas Belón (1):
      linux-user: remove duplicate break in syscall

Laurent Vivier (1):
      target/m68k,linux-user: manage FP registers in ucontext

Peter Maydell (3):
      linux-user: Allow -R values up to 0xffff0000 for 32-bit ARM guests
      linux-user: Fix target FS_IOC_GETFLAGS and FS_IOC_SETFLAGS numbers
      linux-user: Fix TARGET_MTIOCTOP/MTIOCGET/MTIOCPOS values

Richard Henderson (3):
      tcg: Fix off-by-one in assert in page_set_flags
      linux-user: Tidy and enforce reserved_va initialization
      linux-user/sh4: Reduce TARGET_VIRT_ADDR_SPACE_BITS to 31

Riku Voipio (1):
      linux-user: fix O_TMPFILE handling

 accel/tcg/translate-all.c   |  2 +-
 linux-user/arm/target_cpu.h |  4 ++++
 linux-user/elfload.c        |  2 +-
 linux-user/main.c           | 45 ++++++++++++++++++++++++++++++++-------------
 linux-user/signal.c         | 43 +++++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.c         |  4 ++++
 linux-user/syscall.c        |  4 +++-
 linux-user/syscall_defs.h   | 43 +++++++++++++++++++++++++++++++++++++------
 target/mips/mips-defs.h     |  6 +++++-
 target/nios2/cpu.h          |  6 +++++-
 target/sh4/cpu.h            |  6 +++++-
 11 files changed, 140 insertions(+), 25 deletions(-)
