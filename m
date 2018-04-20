Received: from eggs.gnu.org ([2001:4830:134:3::10]:60508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f9bBr-0005cv-Tg
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f9bBo-0001zB-EI
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:55:23 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 20 Apr 2018 14:54:59 -0400
Message-Id: <1524250517-28032-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 00/18] Translation loop conversion for
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

v2: https://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg00837.html

Changes from v2:

- Rebase onto v2.12.0-rc4

- Add R-b's

- mips:
  + Fix comment typo s/intetrupt/interrupt/
  + Fixes suggested by Richard:
    - use lookup_and_goto_ptr for BS_STOP (add a separate patch for this)
    - use DISAS_NORETURN in generate_exception_err
    - define and use DISAS_EXIT

- riscv:
  + Rename ctx->pc_tmp to ctx->pc_succ_insn, as suggested by Bastian.

You can fetch the tree from:
  https://github.com/cota/qemu/tree/trloop-conv-v3

Note that the changes in this series depend on this other branch:
  https://github.com/cota/qemu/tree/next_page_overflow-r-b

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
 target/mips/translate.c     |  625 ++++++++++----------
 target/openrisc/translate.c |  226 ++++----
 target/ppc/translate.c      |    5 +-
 target/riscv/translate.c    |  255 ++++-----
 target/s390x/translate.c    | 1529 ++++++++++++++++++++++++-------------------------
 target/sh4/translate.c      |  171 +++---
 target/sparc/translate.c    |  207 ++++---
 14 files changed, 1524 insertions(+), 1558 deletions(-)
