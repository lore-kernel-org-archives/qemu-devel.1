Received: from eggs.gnu.org ([2001:4830:134:3::10]:46805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ecE6T-0004LM-6T
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:35:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ecE6S-0007uZ-5W
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:35:53 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 18 Jan 2018 18:33:57 +0100
Message-Id: <1516296842-136976-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC v2 0/5] generalize parsing of cpu_model (part 4)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org

Based in feedback I've got on v1
   https://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg04036.html

v2:
  - implemented new approach only for x86/ARM (will be done for all targets
    if approach seems acceptable)
  - add test case for '-M none -cpu FOO' case
  - redefine TARGET_DEFAULT_CPU_TYPE into CPU_RESOLVING_TYPE
  - scrape off default cpu_model refactoring, so it would cause
    less conflicts with Laurent's series where he tries to rework
    defaults to use ELF hints of executed program

End goal of series is still the same as v1, i.e. get rid of cpu_init() API
and limit cpu_model handling only to places where it must be done.

CC: Laurent Vivier <laurent@vivier.eu>
CC: Peter Maydell <peter.maydell@linaro.org>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: qemu-s390x@nongnu.org
CC: qemu-ppc@nongnu.org
CC: qemu-arm@nongnu.org

Igor Mammedov (5):
  tests: add machine 'none' with -cpu test
  machine: prepare machine 'none' to gradually switch to cpu_create()
    API
  linux-user: prepare for switching to cpu_create() API
  arm: cpu: add CPU_RESOLVING_TYPE macro
  x86: cpu: add CPU_RESOLVING_TYPE macro

 target/arm/cpu.h       |  3 ++
 target/i386/cpu.h      |  3 ++
 hw/core/null-machine.c | 13 ++++++++-
 linux-user/main.c      | 15 ++++++++--
 tests/Makefile.include |  2 ++
 tests/machine-none.c   | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++
 vl.c                   |  8 +++++-
 7 files changed, 114 insertions(+), 5 deletions(-)
 create mode 100644 tests/machine-none.c

-- 
2.7.4
