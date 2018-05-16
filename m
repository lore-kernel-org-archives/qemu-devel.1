Received: from eggs.gnu.org ([2001:4830:134:3::10]:52529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fJ3TI-000054-06
	for qemu-devel@nongnu.org; Wed, 16 May 2018 16:56:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fJ3TE-0003uD-TW
	for qemu-devel@nongnu.org; Wed, 16 May 2018 16:56:28 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:36607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fJ3TE-0003ss-Iz
	for qemu-devel@nongnu.org; Wed, 16 May 2018 16:56:24 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 16 May 2018 22:55:35 +0200
Message-Id: <20180516205543.29305-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/8] linux-user: move socket.h definitions
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Yongbok Kim <yongbok.kim@mips.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Splitting out socket.h definitions helps to read the code
and to fix the bugs...

No code change, except for the last one that ports
definitions from linux for sparc as the values are not the
correct ones.

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
 linux-user/generic/sockbits.h    |  60 +++++++
 linux-user/hppa/sockbits.h       |  33 +---
 linux-user/i386/sockbits.h       |   1 +
 linux-user/m68k/sockbits.h       |   1 +
 linux-user/microblaze/sockbits.h |   1 +
 linux-user/mips/sockbits.h       | 110 ++++++++++++
 linux-user/mips64/sockbits.h     |   1 +
 linux-user/nios2/sockbits.h      |   1 +
 linux-user/openrisc/sockbits.h   |   1 +
 linux-user/ppc/sockbits.h        |  20 +++
 linux-user/riscv/sockbits.h      |   1 +
 linux-user/s390x/sockbits.h      |   1 +
 linux-user/sh4/sockbits.h        |   1 +
 linux-user/socket.h              | 377 ++++-----------------------------------
 linux-user/sparc/sockbits.h      | 111 ++++++++++++
 linux-user/sparc64/sockbits.h    |   1 +
 linux-user/tilegx/sockbits.h     |   1 +
 linux-user/x86_64/sockbits.h     |   1 +
 linux-user/xtensa/sockbits.h     |   1 +
 23 files changed, 439 insertions(+), 371 deletions(-)
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
