Received: from eggs.gnu.org ([2001:4830:134:3::10]:47744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK85-0007GE-UU
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK82-00039P-Kt
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cFK82-00038m-DE
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:18 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  9 Dec 2016 13:17:33 +0100
Message-Id: <1481285870-3396-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1481285870-3396-1-git-send-email-thuth@redhat.com>
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 03/20] m68k: Move CPU files to target/ folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Jia Liu <proljc@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, James Hogan <james.hogan@imgtec.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                | 2 +-
 include/hw/m68k/mcf.h                      | 2 +-
 {target-m68k => target/m68k}/Makefile.objs | 0
 {target-m68k => target/m68k}/cpu-qom.h     | 0
 {target-m68k => target/m68k}/cpu.c         | 0
 {target-m68k => target/m68k}/cpu.h         | 0
 {target-m68k => target/m68k}/gdbstub.c     | 0
 {target-m68k => target/m68k}/helper.c      | 0
 {target-m68k => target/m68k}/helper.h      | 0
 {target-m68k => target/m68k}/m68k-semi.c   | 0
 {target-m68k => target/m68k}/op_helper.c   | 0
 {target-m68k => target/m68k}/qregs.def     | 0
 {target-m68k => target/m68k}/translate.c   | 0
 13 files changed, 2 insertions(+), 2 deletions(-)
 rename {target-m68k => target/m68k}/Makefile.objs (100%)
 rename {target-m68k => target/m68k}/cpu-qom.h (100%)
 rename {target-m68k => target/m68k}/cpu.c (100%)
 rename {target-m68k => target/m68k}/cpu.h (100%)
 rename {target-m68k => target/m68k}/gdbstub.c (100%)
 rename {target-m68k => target/m68k}/helper.c (100%)
 rename {target-m68k => target/m68k}/helper.h (100%)
 rename {target-m68k => target/m68k}/m68k-semi.c (100%)
 rename {target-m68k => target/m68k}/op_helper.c (100%)
 rename {target-m68k => target/m68k}/qregs.def (100%)
 rename {target-m68k => target/m68k}/translate.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a60579..ce1ee35 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -147,7 +147,7 @@ F: tests/tcg/lm32/
 M68K
 M: Laurent Vivier <laurent@vivier.eu>
 S: Maintained
-F: target-m68k/
+F: target/m68k/
 F: disas/m68k.c
 
 MicroBlaze
diff --git a/include/hw/m68k/mcf.h b/include/hw/m68k/mcf.h
index 0f0d228..ef8963d 100644
--- a/include/hw/m68k/mcf.h
+++ b/include/hw/m68k/mcf.h
@@ -2,7 +2,7 @@
 #define HW_MCF_H
 /* Motorola ColdFire device prototypes.  */
 
-#include "target-m68k/cpu-qom.h"
+#include "cpu-qom.h"
 
 struct MemoryRegion;
 
diff --git a/target-m68k/Makefile.objs b/target/m68k/Makefile.objs
similarity index 100%
rename from target-m68k/Makefile.objs
rename to target/m68k/Makefile.objs
diff --git a/target-m68k/cpu-qom.h b/target/m68k/cpu-qom.h
similarity index 100%
rename from target-m68k/cpu-qom.h
rename to target/m68k/cpu-qom.h
diff --git a/target-m68k/cpu.c b/target/m68k/cpu.c
similarity index 100%
rename from target-m68k/cpu.c
rename to target/m68k/cpu.c
diff --git a/target-m68k/cpu.h b/target/m68k/cpu.h
similarity index 100%
rename from target-m68k/cpu.h
rename to target/m68k/cpu.h
diff --git a/target-m68k/gdbstub.c b/target/m68k/gdbstub.c
similarity index 100%
rename from target-m68k/gdbstub.c
rename to target/m68k/gdbstub.c
diff --git a/target-m68k/helper.c b/target/m68k/helper.c
similarity index 100%
rename from target-m68k/helper.c
rename to target/m68k/helper.c
diff --git a/target-m68k/helper.h b/target/m68k/helper.h
similarity index 100%
rename from target-m68k/helper.h
rename to target/m68k/helper.h
diff --git a/target-m68k/m68k-semi.c b/target/m68k/m68k-semi.c
similarity index 100%
rename from target-m68k/m68k-semi.c
rename to target/m68k/m68k-semi.c
diff --git a/target-m68k/op_helper.c b/target/m68k/op_helper.c
similarity index 100%
rename from target-m68k/op_helper.c
rename to target/m68k/op_helper.c
diff --git a/target-m68k/qregs.def b/target/m68k/qregs.def
similarity index 100%
rename from target-m68k/qregs.def
rename to target/m68k/qregs.def
diff --git a/target-m68k/translate.c b/target/m68k/translate.c
similarity index 100%
rename from target-m68k/translate.c
rename to target/m68k/translate.c
-- 
1.8.3.1
