Received: from eggs.gnu.org ([209.51.188.92]:59347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMnB-0005bz-DO
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:14:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMnA-0004yA-Br
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:14:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hHMnA-0004xa-6V
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:14:32 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 19 Apr 2019 03:14:22 -0300
Message-Id: <20190419061429.17695-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/7] Delete 16 *_cpu_class_by_name() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>

This series adds a new CPUClass::class_name_format field, which
allows us to delete 16 of the 21 *_cpu_class_by_name() functions
that exist today.

Eduardo Habkost (7):
  cpu: Change return type of cpu_class_by_name() to CPUClass
  riscv: Don't split CPU model string
  arm: Don't split CPU model string
  arm: Remove special case for "any" CPU model
  cpu: Let architectures set CPU class name format
  cpu: Set class name format for some architectures
  cpu: Set fixed class name on some architectures

 include/qom/cpu.h         | 14 +++++++++++++-
 target/s390x/internal.h   |  1 -
 exec.c                    |  8 +++-----
 qom/cpu.c                 | 20 +++++++++++++++++---
 target/arm/cpu.c          | 30 +-----------------------------
 target/hppa/cpu.c         |  8 ++------
 target/i386/cpu.c         | 11 +----------
 target/lm32/cpu.c         | 17 +----------------
 target/m68k/cpu.c         | 17 +----------------
 target/microblaze/cpu.c   |  8 ++------
 target/mips/cpu.c         | 13 +------------
 target/moxie/cpu.c        | 17 +----------------
 target/nios2/cpu.c        |  8 ++------
 target/openrisc/cpu.c     | 17 +----------------
 target/riscv/cpu.c        | 20 +-------------------
 target/s390x/cpu.c        |  2 +-
 target/s390x/cpu_models.c | 20 +++++---------------
 target/tilegx/cpu.c       |  8 ++------
 target/tricore/cpu.c      | 17 +----------------
 target/unicore32/cpu.c    | 17 +----------------
 target/xtensa/cpu.c       | 17 +----------------
 21 files changed, 58 insertions(+), 232 deletions(-)

-- 
2.18.0.rc1.1.g3f1ff2140
