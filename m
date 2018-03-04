Received: from eggs.gnu.org ([2001:4830:134:3::10]:57137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1esXVN-0003F9-V2
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 12:33:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1esXVJ-0006O4-Sv
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 12:33:01 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:51393)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1esXVJ-0006M2-Ja
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 12:32:57 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sun,  4 Mar 2018 18:32:27 +0100
Message-Id: <20180304173232.22814-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 0/5] M68k for 2.12 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>

The following changes since commit 136c67e07869227b21b3f627316e03679ce7b738:

  Merge remote-tracking branch 'remotes/bkoppelmann/tags/pull-tricore-2018-03-02' into staging (2018-03-02 16:56:20 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.12-pull-request

for you to fetch changes up to 0d379c1709aa6b2d09dd3b493bfdf3a5fe6debcd:

  target/m68k: add fscale, fgetman and fgetexp (2018-03-04 17:27:59 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Laurent Vivier (5):
  target/m68k: TCGv returned by gen_load() must be freed
  softfloat: export some functions
  target/m68k: add fmod/frem
  softfloat: use floatx80_infinity in softfloat
  target/m68k: add fscale, fgetman and fgetexp

 fpu/softfloat-specialize.h              |  17 ++-
 fpu/softfloat.c                         | 130 +++++------------
 {fpu => include/fpu}/softfloat-macros.h |  10 +-
 include/fpu/softfloat.h                 | 134 ++++++++++++++++-
 target/m68k/Makefile.objs               |   3 +-
 target/m68k/cpu.h                       |   1 +
 target/m68k/fpu_helper.c                |  50 ++++++-
 target/m68k/helper.h                    |   5 +
 target/m68k/softfloat.c                 | 249 ++++++++++++++++++++++++++++++++
 target/m68k/softfloat.h                 |  29 ++++
 target/m68k/translate.c                 |  26 ++++
 11 files changed, 548 insertions(+), 106 deletions(-)
 rename {fpu => include/fpu}/softfloat-macros.h (98%)
 create mode 100644 target/m68k/softfloat.c
 create mode 100644 target/m68k/softfloat.h

-- 
2.14.3
