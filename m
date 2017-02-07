Received: from eggs.gnu.org ([2001:4830:134:3::10]:60101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cbAab-0004tO-UN
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:34:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cbAaX-0001Td-ON
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:34:05 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:50666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cbAaX-0001Rz-E4
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:34:01 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  7 Feb 2017 19:33:51 +0100
Message-Id: <20170207183356.17840-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 0/5] risu: add m68k target support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>

This series add the files needed to test the m68k target.

For the moment, it doesn't support FPU instructions.

Laurent Vivier (5):
  m68k: implement risugen module
  m68k: implement server and client side
  m68k: add risufile with m68k instructions.
  m68k: add instruction needing an extended word
  m68k: manage memory block

 configure           |   6 +-
 m68k.risu           | 369 +++++++++++++++++++++++++++++++++++++++++++++++++
 risu.h              |   1 +
 risu_m68k.c         | 158 +++++++++++++++++++++
 risu_reginfo_m68k.c | 151 ++++++++++++++++++++
 risu_reginfo_m68k.h |  32 +++++
 risugen             |   2 +-
 risugen_m68k.pm     | 390 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 test_m68k.s         |  28 ++++
 9 files changed, 1134 insertions(+), 3 deletions(-)
 create mode 100644 m68k.risu
 create mode 100644 risu_m68k.c
 create mode 100644 risu_reginfo_m68k.c
 create mode 100644 risu_reginfo_m68k.h
 create mode 100644 risugen_m68k.pm
 create mode 100644 test_m68k.s

-- 
2.9.3
