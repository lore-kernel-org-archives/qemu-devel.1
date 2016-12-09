Received: from eggs.gnu.org ([2001:4830:134:3::10]:48060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK8t-0001ZQ-EF
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:19:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK8s-0003Tn-8D
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:19:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cFK8r-0003TO-Vw
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:19:10 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  9 Dec 2016 13:17:42 +0100
Message-Id: <1481285870-3396-13-git-send-email-thuth@redhat.com>
In-Reply-To: <1481285870-3396-1-git-send-email-thuth@redhat.com>
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 12/20] cris: Move CPU files to target/ folder
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
 MAINTAINERS                                   | 2 +-
 disas/cris.c                                  | 4 +---
 {target-cris => target/cris}/Makefile.objs    | 0
 {target-cris => target/cris}/cpu-qom.h        | 0
 {target-cris => target/cris}/cpu.c            | 0
 {target-cris => target/cris}/cpu.h            | 0
 {target-cris => target/cris}/crisv10-decode.h | 0
 {target-cris => target/cris}/crisv32-decode.h | 0
 {target-cris => target/cris}/gdbstub.c        | 0
 {target-cris => target/cris}/helper.c         | 0
 {target-cris => target/cris}/helper.h         | 0
 {target-cris => target/cris}/machine.c        | 0
 {target-cris => target/cris}/mmu.c            | 0
 {target-cris => target/cris}/mmu.h            | 0
 {target-cris => target/cris}/op_helper.c      | 0
 {target-cris => target/cris}/opcode-cris.h    | 0
 {target-cris => target/cris}/translate.c      | 0
 {target-cris => target/cris}/translate_v10.c  | 0
 18 files changed, 2 insertions(+), 4 deletions(-)
 rename {target-cris => target/cris}/Makefile.objs (100%)
 rename {target-cris => target/cris}/cpu-qom.h (100%)
 rename {target-cris => target/cris}/cpu.c (100%)
 rename {target-cris => target/cris}/cpu.h (100%)
 rename {target-cris => target/cris}/crisv10-decode.h (100%)
 rename {target-cris => target/cris}/crisv32-decode.h (100%)
 rename {target-cris => target/cris}/gdbstub.c (100%)
 rename {target-cris => target/cris}/helper.c (100%)
 rename {target-cris => target/cris}/helper.h (100%)
 rename {target-cris => target/cris}/machine.c (100%)
 rename {target-cris => target/cris}/mmu.c (100%)
 rename {target-cris => target/cris}/mmu.h (100%)
 rename {target-cris => target/cris}/op_helper.c (100%)
 rename {target-cris => target/cris}/opcode-cris.h (100%)
 rename {target-cris => target/cris}/translate.c (100%)
 rename {target-cris => target/cris}/translate_v10.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index f8959d8..ccb841f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -126,7 +126,7 @@ F: disas/libvixl/
 CRIS
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
-F: target-cris/
+F: target/cris/
 F: hw/cris/
 F: include/hw/cris/
 F: tests/tcg/cris/
diff --git a/disas/cris.c b/disas/cris.c
index 7f35bc0..08161d1 100644
--- a/disas/cris.c
+++ b/disas/cris.c
@@ -21,9 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "disas/bfd.h"
-//#include "sysdep.h"
-#include "target-cris/opcode-cris.h"
-//#include "libiberty.h"
+#include "target/cris/opcode-cris.h"
 
 #define CONST_STRNEQ(STR1,STR2) (strncmp ((STR1), (STR2), sizeof (STR2) - 1) == 0)
 
diff --git a/target-cris/Makefile.objs b/target/cris/Makefile.objs
similarity index 100%
rename from target-cris/Makefile.objs
rename to target/cris/Makefile.objs
diff --git a/target-cris/cpu-qom.h b/target/cris/cpu-qom.h
similarity index 100%
rename from target-cris/cpu-qom.h
rename to target/cris/cpu-qom.h
diff --git a/target-cris/cpu.c b/target/cris/cpu.c
similarity index 100%
rename from target-cris/cpu.c
rename to target/cris/cpu.c
diff --git a/target-cris/cpu.h b/target/cris/cpu.h
similarity index 100%
rename from target-cris/cpu.h
rename to target/cris/cpu.h
diff --git a/target-cris/crisv10-decode.h b/target/cris/crisv10-decode.h
similarity index 100%
rename from target-cris/crisv10-decode.h
rename to target/cris/crisv10-decode.h
diff --git a/target-cris/crisv32-decode.h b/target/cris/crisv32-decode.h
similarity index 100%
rename from target-cris/crisv32-decode.h
rename to target/cris/crisv32-decode.h
diff --git a/target-cris/gdbstub.c b/target/cris/gdbstub.c
similarity index 100%
rename from target-cris/gdbstub.c
rename to target/cris/gdbstub.c
diff --git a/target-cris/helper.c b/target/cris/helper.c
similarity index 100%
rename from target-cris/helper.c
rename to target/cris/helper.c
diff --git a/target-cris/helper.h b/target/cris/helper.h
similarity index 100%
rename from target-cris/helper.h
rename to target/cris/helper.h
diff --git a/target-cris/machine.c b/target/cris/machine.c
similarity index 100%
rename from target-cris/machine.c
rename to target/cris/machine.c
diff --git a/target-cris/mmu.c b/target/cris/mmu.c
similarity index 100%
rename from target-cris/mmu.c
rename to target/cris/mmu.c
diff --git a/target-cris/mmu.h b/target/cris/mmu.h
similarity index 100%
rename from target-cris/mmu.h
rename to target/cris/mmu.h
diff --git a/target-cris/op_helper.c b/target/cris/op_helper.c
similarity index 100%
rename from target-cris/op_helper.c
rename to target/cris/op_helper.c
diff --git a/target-cris/opcode-cris.h b/target/cris/opcode-cris.h
similarity index 100%
rename from target-cris/opcode-cris.h
rename to target/cris/opcode-cris.h
diff --git a/target-cris/translate.c b/target/cris/translate.c
similarity index 100%
rename from target-cris/translate.c
rename to target/cris/translate.c
diff --git a/target-cris/translate_v10.c b/target/cris/translate_v10.c
similarity index 100%
rename from target-cris/translate_v10.c
rename to target/cris/translate_v10.c
-- 
1.8.3.1
