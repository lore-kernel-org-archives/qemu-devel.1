Received: from eggs.gnu.org ([2001:4830:134:3::10]:38521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1d3nNc-00049P-Pf
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 13:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1d3nNb-0005FY-VD
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 13:39:00 -0400
From: Wei Huang <wei@redhat.com>
Date: Thu, 27 Apr 2017 12:38:45 -0500
Message-Id: <1493314727-6951-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Fix compilation dependency issues of
 CONFIG_ARM_V7M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

CONFIG_ARM_V7M is used to control the compilation of NVIC and SysTick
Timer in QEMU. These two devices are not available when CONFIG_ARM_V7M
is un-defined. This can cause problems with ARMv7M code as it is tightly
integrated with NVIC for processing IRQ and exception.

This patchset addresses the problem by introducing stub functions when
CONFIG_ARM_V7M is not defined. It also makes the compilation of several
existing v7M-profile SoCs depedent on CONFIG_ARM_V7M.

Thanks,
-Wei

Wei Huang (2):
  armv7m: Make armv7m SoC compilation dependent on CONFIG_ARM_V7M
  armv7m: Use stub functions if CONFIG_ARM_V7M is not defined

 default-configs/arm-softmmu.mak |  2 --
 hw/arm/Makefile.objs            |  7 +++----
 target/arm/Makefile.objs        |  1 +
 target/arm/armv7m-stub.c        | 43 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 47 insertions(+), 6 deletions(-)
 create mode 100644 target/arm/armv7m-stub.c

-- 
1.8.3.1
