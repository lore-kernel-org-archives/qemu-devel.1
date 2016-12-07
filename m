Received: from eggs.gnu.org ([2001:4830:134:3::10]:60522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cEdWK-0006A8-Mo
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:48:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cEdWF-0001Kt-QZ
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:48:32 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:37295)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Julian_Brown@mentor.com>)
	id 1cEdWF-0001Kg-Ki
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:48:27 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=SVR-IES-MBX-04.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1cEdWD-0002Er-Kf from Julian_Brown@mentor.com
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 06:48:25 -0800
From: Julian Brown <julian@codesourcery.com>
Date: Wed, 7 Dec 2016 06:48:12 -0800
Message-ID: <cover.1481121503.git.julian@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/6] ARM BE8/BE32 big-endian system-mode
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

This is the second iteration of a series of patches to implement
semihosting/gdbstub support for big-endian ARM system mode. The previous
series started here:

  http://lists.nongnu.org/archive/html/qemu-devel/2016-11/msg00646.html

Thanks,

Julian

Julian Brown (6):
  Add cfgend parameter for ARM CPU selection.
  Infer endianness from SCTLR reset value.
  ARM big-endian system-mode semihosting support.
  ARM big-endian system-mode gdbstub support.
  Fix Thumb-1 BE32 execution and disassembly.
  ARM BE32 watchpoint fix.

 disas.c                         |   1 +
 exec.c                          |   1 +
 hw/arm/boot.c                   |  16 ++++-
 include/disas/bfd.h             |   7 ++
 include/exec/softmmu-arm-semi.h | 148 ++++++++++++++++++++++++++++++++++++++++
 include/qom/cpu.h               |   1 +
 qom/cpu.c                       |   6 ++
 target-arm/arm-semi.c           |   4 +-
 target-arm/arm_ldst.h           |  10 ++-
 target-arm/cpu.c                |  87 ++++++++++++++++++++++-
 target-arm/cpu.h                |  13 ++++
 target-arm/gdbstub.c            |  42 ++++++++++++
 target-arm/internals.h          |   5 ++
 target-arm/op_helper.c          |  22 ++++++
 14 files changed, 356 insertions(+), 7 deletions(-)
 create mode 100644 include/exec/softmmu-arm-semi.h

-- 
2.8.1
