Received: from eggs.gnu.org ([2001:4830:134:3::10]:60871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1eFNAd-0003lD-7C
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:37:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1eFNAY-0006vK-B1
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:37:43 -0500
From: Stefan Weil <sw@weilnetz.de>
Date: Thu, 16 Nov 2017 17:37:32 +0100
Message-Id: <20171116163732.31584-1-sw@weilnetz.de>
Subject: [Qemu-devel] [PATCH for-2.11] Fix build of console and GUI
 executables for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>

It was broken by commit 8ecc89f6e792152496eccb684d6c8c48aba8027d which
moved the SDL linker flags from macro libs_softmmu to macro SDL_LIBS.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---

Peter, can you apply this fix directly, or do you need a pull request?

Regards
Stefan

 Makefile.target | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.target b/Makefile.target
index e4244c188a..f9a9da7e7c 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -22,7 +22,7 @@ QEMU_PROG_BUILD = $(QEMU_PROG)
 else
 # system emulator name
 QEMU_PROG=qemu-system-$(TARGET_NAME)$(EXESUF)
-ifneq (,$(findstring -mwindows,$(libs_softmmu)))
+ifneq (,$(findstring -mwindows,$(SDL_LIBS)))
 # Terminate program name with a 'w' because the linker builds a windows executable.
 QEMU_PROGW=qemu-system-$(TARGET_NAME)w$(EXESUF)
 $(QEMU_PROG): $(QEMU_PROGW)
-- 
2.11.0
