Received: from eggs.gnu.org ([2001:4830:134:3::10]:41939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cUc5S-0000rN-EI
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:30:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cUc5O-0003aU-E2
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:30:50 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:41395)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Julian_Brown@mentor.com>)
	id 1cUc5O-0003ZW-56
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:30:46 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=SVR-IES-MBX-04.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1cUc5L-0004za-Ty from Julian_Brown@mentor.com
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:30:44 -0800
From: Julian Brown <julian@codesourcery.com>
Date: Fri, 20 Jan 2017 08:30:25 -0800
Message-ID: <cover.1484929304.git.julian@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 0/7] ARM BE8/BE32 big-endian system-mode
 fixes (semihosting, gdbstub)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is the third iteration of a series of patches to implement
semihosting/gdbstub support for big-endian ARM system mode. The previous
series started here:

  http://lists.nongnu.org/archive/html/qemu-devel/2016-12/msg00972.html

I've (hopefully!) addressed all the comments from the second round of
reviews, apologies in advance if I've missed anything.

Thanks,

Julian

Julian Brown (7):
  Add cfgend parameter for ARM CPU selection.
  Honour reset_sctlr EE/B bits during reset.
  Move target_memory_rw_debug function.
  ARM big-endian semihosting support.
  ARM big-endian system-mode gdbstub support.
  Fix Thumb-1 BE32 execution and disassembly.
  ARM BE32 watchpoint fix.

 disas.c                         |   1 +
 exec.c                          |   1 +
 gdbstub.c                       |  11 ----
 hw/arm/boot.c                   |  27 +++++++++
 hw/arm/integratorcp.c           |  19 +++++-
 include/disas/bfd.h             |   7 +++
 include/exec/cpu-all.h          |  22 +++++++
 include/exec/softmmu-arm-semi.h | 131 ++++++++++++++++++++++++++++++++++++++++
 include/qom/cpu.h               |   3 +
 qom/cpu.c                       |   6 ++
 target/arm/arm-semi.c           |   4 +-
 target/arm/arm_ldst.h           |  10 ++-
 target/arm/cpu.c                |  64 ++++++++++++++++++++
 target/arm/cpu.h                |  13 ++++
 target/arm/gdbstub.c            |  42 +++++++++++++
 target/arm/internals.h          |   5 ++
 target/arm/op_helper.c          |  22 +++++++
 17 files changed, 372 insertions(+), 16 deletions(-)
 create mode 100644 include/exec/softmmu-arm-semi.h

-- 
2.8.1
