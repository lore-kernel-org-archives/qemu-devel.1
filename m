Received: from eggs.gnu.org ([2001:4830:134:3::10]:44301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fJyCX-0008SN-0f
	for qemu-devel@nongnu.org; Sat, 19 May 2018 05:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fJyCT-0003Df-1v
	for qemu-devel@nongnu.org; Sat, 19 May 2018 05:30:57 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:58271)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fJyCS-0003CF-Oc
	for qemu-devel@nongnu.org; Sat, 19 May 2018 05:30:52 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Sat, 19 May 2018 11:29:48 +0200
Message-Id: <20180519092956.15134-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/8] linux-user: move socket.h definitions
 to CPU directories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Yongbok Kim <yongbok.kim@mips.com>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Splitting out socket.h definitions helps to read the code
and to fix the bugs...

No code change, except for the last one that ports
definitions from linux for sparc as the values are not the
correct ones.

v3:
  - rework ppc/sockbits.h to include generic/sockbits.h
    and to redefine needed values only.
  - fix definition of TARGET_SOCK_NONBLOCK in linux-user/socket.h

v2:
  - move generic socket.h to generic/sockbits.h
    and include this file from arch without specific
    values
  - for ppc, only define the values that differ and
    include generic/sockbits.h
  - update ARCH_HAS_SOCKET_TYPES use to be like in
    the kernel
  - define TARGET_SO_REUSEPORT

Laurent Vivier (8):
  linux-user: move mips socket.h definitions to mips/sockbits.h
  linux-user: move alpha socket.h definitions to alpha/sockbits.h
  linux-user: move sparc/sparc64 socket.h definitions to
    sparc/sockbits.h
  linux-user: move socket.h generic definitions to generic/sockbits.h
  linux-user: move ppc socket.h definitions to ppc/sockbits.h
  linux-user: update ARCH_HAS_SOCKET_TYPES use
  linux-user: copy sparc/sockbits.h definitions from linux
  linux-user: define TARGET_SO_REUSEPORT

 linux-user/aarch64/sockbits.h    |   1 +
 linux-user/alpha/sockbits.h      |  83 +++++++++
 linux-user/arm/sockbits.h        |   1 +
 linux-user/cris/sockbits.h       |   1 +
 linux-user/generic/sockbits.h    |  58 ++++++
 linux-user/hppa/sockbits.h       |  33 +---
 linux-user/i386/sockbits.h       |   1 +
 linux-user/m68k/sockbits.h       |   1 +
 linux-user/microblaze/sockbits.h |   1 +
 linux-user/mips/sockbits.h       | 110 ++++++++++++
 linux-user/mips64/sockbits.h     |   1 +
 linux-user/nios2/sockbits.h      |   1 +
 linux-user/openrisc/sockbits.h   |   1 +
 linux-user/ppc/sockbits.h        |  26 +++
 linux-user/riscv/sockbits.h      |   1 +
 linux-user/s390x/sockbits.h      |   1 +
 linux-user/sh4/sockbits.h        |   1 +
 linux-user/socket.h              | 377 ++++-----------------------------------
 linux-user/sparc/sockbits.h      | 111 ++++++++++++
 linux-user/sparc64/sockbits.h    |   1 +
 linux-user/tilegx/sockbits.h     |   1 +
 linux-user/x86_64/sockbits.h     |   1 +
 linux-user/xtensa/sockbits.h     |   1 +
 23 files changed, 443 insertions(+), 371 deletions(-)
 create mode 100644 linux-user/aarch64/sockbits.h
 create mode 100644 linux-user/alpha/sockbits.h
 create mode 100644 linux-user/arm/sockbits.h
 create mode 100644 linux-user/cris/sockbits.h
 create mode 100644 linux-user/generic/sockbits.h
 create mode 100644 linux-user/i386/sockbits.h
 create mode 100644 linux-user/m68k/sockbits.h
 create mode 100644 linux-user/microblaze/sockbits.h
 create mode 100644 linux-user/mips/sockbits.h
 create mode 100644 linux-user/mips64/sockbits.h
 create mode 100644 linux-user/nios2/sockbits.h
 create mode 100644 linux-user/openrisc/sockbits.h
 create mode 100644 linux-user/ppc/sockbits.h
 create mode 100644 linux-user/riscv/sockbits.h
 create mode 100644 linux-user/s390x/sockbits.h
 create mode 100644 linux-user/sh4/sockbits.h
 create mode 100644 linux-user/sparc/sockbits.h
 create mode 100644 linux-user/sparc64/sockbits.h
 create mode 100644 linux-user/tilegx/sockbits.h
 create mode 100644 linux-user/x86_64/sockbits.h
 create mode 100644 linux-user/xtensa/sockbits.h

-- 
2.14.3
