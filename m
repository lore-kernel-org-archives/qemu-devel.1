Received: from eggs.gnu.org ([2001:4830:134:3::10]:48606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f4Vy4-0003kT-MS
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f4Vy0-0000QV-7T
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:20:08 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri,  6 Apr 2018 14:19:43 -0400
Message-Id: <1523038800-2494-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 00/17] Translation loop conversion for
 sh4/sparc/mips/s390x/openrisc/riscv targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org, Stafford Horne <shorne@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

v1: https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg00445.html

Changes since v1:

- Rebase onto master

- Add R-b's

- Add riscv conversion

- s390x:
  + fix comment in s390x_tr_breakpoint_check

You can fetch this series from:
  https://github.com/cota/qemu/tree/trloop-conv-v2

Thanks,

		Emilio
---
 accel/tcg/translator.c      |   21 +-
 include/exec/translator.h   |    8 +-
 target/alpha/translate.c    |    6 +-
 target/arm/translate-a64.c  |    8 +-
 target/arm/translate.c      |    9 +-
 target/hppa/translate.c     |    7 +-
 target/i386/translate.c     |    5 +-
 target/mips/translate.c     |  623 +++++-----
 target/openrisc/translate.c |  226 ++--
 target/ppc/translate.c      |    5 +-
 target/riscv/translate.c    |  255 ++---
 target/s390x/translate.c    | 1529 ++++++++++++-------------
 target/sh4/translate.c      |  171 +--
 target/sparc/translate.c    |  207 ++--
 14 files changed, 1522 insertions(+), 1558 deletions(-)
