Received: from eggs.gnu.org ([2001:4830:134:3::10]:34727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1epEpb-000699-I6
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:00:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1epEpV-0005EI-SX
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:00:15 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:57415)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1epEpV-0005BZ-Hk
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:00:09 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 23 Feb 2018 15:59:55 +0100
Message-Id: <20180223145959.18761-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v3 0/4] target/m68k: implement 680x0 FPU (part
 3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>

Implement fmod, frem, fscale, fgetman and fgetexp.

Instead of using functions of libm (v1 of this series)
and converting between host long double and floatx80 type
the new version (v2) adds new floatx80 functions in softfloat.

All the floatx80 functions are copied from "Previous",
the NeXT Computer Emulator, and written by Andreas Grabher.

v3: Move all new functions to target/m68k/softfloat.c
    Exports needed functions from fpu/softfloat.c

Laurent Vivier (4):
  softfloat: export some functions
  target/m68k: add fmod/frem
  softfloat: use floatx80_infinity in softfloat
  target/m68k: add fscale, fgetman and fgetexp

 fpu/softfloat-specialize.h              |  17 ++-
 fpu/softfloat.c                         | 129 +++++------------
 {fpu => include/fpu}/softfloat-macros.h |  10 +-
 include/fpu/softfloat.h                 | 129 ++++++++++++++++-
 target/m68k/Makefile.objs               |   3 +-
 target/m68k/cpu.h                       |   1 +
 target/m68k/fpu_helper.c                |  50 ++++++-
 target/m68k/helper.h                    |   5 +
 target/m68k/softfloat.c                 | 249 ++++++++++++++++++++++++++++++++
 target/m68k/softfloat.h                 |  29 ++++
 target/m68k/translate.c                 |  15 ++
 11 files changed, 533 insertions(+), 104 deletions(-)
 rename {fpu => include/fpu}/softfloat-macros.h (98%)
 create mode 100644 target/m68k/softfloat.c
 create mode 100644 target/m68k/softfloat.h

-- 
2.14.3
