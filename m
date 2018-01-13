Received: from eggs.gnu.org ([2001:4830:134:3::10]:47190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eaN7N-0000RX-Mt
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 09:49:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eaN7K-0007HC-Lm
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 09:49:09 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:49263)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eaN7K-0007GI-CE
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 09:49:06 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sat, 13 Jan 2018 15:48:44 +0100
Message-Id: <20180113144847.8403-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/3] linux-user: select CPU type according ELF
 header values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: YunQiang Su <syq@debian.org>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Aaron Sierra <asierra@xes-inc.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Laurent Vivier <laurent@vivier.eu>

This idea has been suggested to me before by Philippe
Mathieu-Daudé, and recently YunQiang Su has proposed a
patch to manage the MIPS r6 case.

Based on this, this series tries to clean-up the original
patch, and introduces the use for m68k architecture and
port the patch from YunQiang Su.

Laurent Vivier (1):
  linux-user,m68k: select CPU according to ELF header values

YunQiang Su (2):
  linux-user: introduce functions to detect CPU type
  linux-user: MIPS set cpu to r6 CPU if binary is R6

 include/elf.h        |   4 ++
 linux-user/elfload.c |  37 ++++++++++++++++
 linux-user/main.c    | 121 +++++++++++++++++++++++++++++++--------------------
 linux-user/qemu.h    |   1 +
 4 files changed, 115 insertions(+), 48 deletions(-)

-- 
2.14.3
