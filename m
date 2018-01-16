Received: from eggs.gnu.org ([2001:4830:134:3::10]:36884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ebUzR-00007s-8A
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:25:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ebUzO-0001PN-9M
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:25:37 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:59942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ebUzN-0001Nw-GI
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:25:34 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 16 Jan 2018 18:25:06 +0100
Message-Id: <20180116172510.28878-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/4] linux-user: select CPU type according
 ELF header values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: YunQiang Su <syq@debian.org>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Aaron Sierra <asierra@xes-inc.com>, Laurent Vivier <laurent@vivier.eu>

This idea has been suggested to me before by Philippe
Mathieu-Daudé, and recently YunQiang Su has proposed a
patch to manage the MIPS r6 case.

Based on this, this series tries to clean-up the original
patch, and introduces the use for m68k architecture and
port the patch from YunQiang Su.

v2: move cpu_model selection to linux-user/*/target_elf.h
   provide eflags to cpu_get_model() instead of fd
   (and modify other patches accordingly)

Laurent Vivier (2):
  linux-user: Move CPU type name selection to a function
  linux-user,m68k: select CPU according to ELF header values

YunQiang Su (2):
  linux-user: introduce functions to detect CPU type
  linux-user: MIPS set cpu to r6 CPU if binary is R6

 include/elf.h                      |  4 +++
 linux-user/aarch64/target_elf.h    | 14 +++++++++
 linux-user/alpha/target_elf.h      | 14 +++++++++
 linux-user/arm/target_elf.h        | 14 +++++++++
 linux-user/cris/target_elf.h       | 14 +++++++++
 linux-user/elfload.c               | 35 ++++++++++++++++++++++
 linux-user/hppa/target_elf.h       | 14 +++++++++
 linux-user/i386/target_elf.h       | 14 +++++++++
 linux-user/m68k/target_elf.h       | 20 +++++++++++++
 linux-user/main.c                  | 59 +++++++-------------------------------
 linux-user/microblaze/target_elf.h | 14 +++++++++
 linux-user/mips/target_elf.h       | 17 +++++++++++
 linux-user/mips64/target_elf.h     | 17 +++++++++++
 linux-user/nios2/target_elf.h      | 14 +++++++++
 linux-user/openrisc/target_elf.h   | 14 +++++++++
 linux-user/ppc/target_elf.h        | 21 ++++++++++++++
 linux-user/qemu.h                  |  1 +
 linux-user/s390x/target_elf.h      | 14 +++++++++
 linux-user/sh4/target_elf.h        | 14 +++++++++
 linux-user/sparc/target_elf.h      | 14 +++++++++
 linux-user/sparc64/target_elf.h    | 14 +++++++++
 linux-user/tilegx/target_elf.h     | 14 +++++++++
 linux-user/unicore32/target_elf.h  | 14 +++++++++
 linux-user/x86_64/target_elf.h     | 14 +++++++++
 24 files changed, 350 insertions(+), 48 deletions(-)
 create mode 100644 linux-user/aarch64/target_elf.h
 create mode 100644 linux-user/alpha/target_elf.h
 create mode 100644 linux-user/arm/target_elf.h
 create mode 100644 linux-user/cris/target_elf.h
 create mode 100644 linux-user/hppa/target_elf.h
 create mode 100644 linux-user/i386/target_elf.h
 create mode 100644 linux-user/m68k/target_elf.h
 create mode 100644 linux-user/microblaze/target_elf.h
 create mode 100644 linux-user/mips/target_elf.h
 create mode 100644 linux-user/mips64/target_elf.h
 create mode 100644 linux-user/nios2/target_elf.h
 create mode 100644 linux-user/openrisc/target_elf.h
 create mode 100644 linux-user/ppc/target_elf.h
 create mode 100644 linux-user/s390x/target_elf.h
 create mode 100644 linux-user/sh4/target_elf.h
 create mode 100644 linux-user/sparc/target_elf.h
 create mode 100644 linux-user/sparc64/target_elf.h
 create mode 100644 linux-user/tilegx/target_elf.h
 create mode 100644 linux-user/unicore32/target_elf.h
 create mode 100644 linux-user/x86_64/target_elf.h

-- 
2.14.3
