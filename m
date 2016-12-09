Received: from eggs.gnu.org ([2001:4830:134:3::10]:48197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK9G-0002sV-Ne
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:19:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK9F-0003e0-2b
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:19:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cFK9E-0003dg-Pv
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:19:32 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  9 Dec 2016 13:17:46 +0100
Message-Id: <1481285870-3396-17-git-send-email-thuth@redhat.com>
In-Reply-To: <1481285870-3396-1-git-send-email-thuth@redhat.com>
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 16/20] sh4: Move CPU files to target/ folder
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
 MAINTAINERS                              | 2 +-
 hw/sh4/shix.c                            | 2 +-
 include/hw/sh4/sh.h                      | 2 +-
 {target-sh4 => target/sh4}/Makefile.objs | 0
 {target-sh4 => target/sh4}/README.sh4    | 2 +-
 {target-sh4 => target/sh4}/cpu-qom.h     | 0
 {target-sh4 => target/sh4}/cpu.c         | 0
 {target-sh4 => target/sh4}/cpu.h         | 0
 {target-sh4 => target/sh4}/gdbstub.c     | 0
 {target-sh4 => target/sh4}/helper.c      | 0
 {target-sh4 => target/sh4}/helper.h      | 0
 {target-sh4 => target/sh4}/monitor.c     | 0
 {target-sh4 => target/sh4}/op_helper.c   | 0
 {target-sh4 => target/sh4}/translate.c   | 0
 14 files changed, 4 insertions(+), 4 deletions(-)
 rename {target-sh4 => target/sh4}/Makefile.objs (100%)
 rename {target-sh4 => target/sh4}/README.sh4 (98%)
 rename {target-sh4 => target/sh4}/cpu-qom.h (100%)
 rename {target-sh4 => target/sh4}/cpu.c (100%)
 rename {target-sh4 => target/sh4}/cpu.h (100%)
 rename {target-sh4 => target/sh4}/gdbstub.c (100%)
 rename {target-sh4 => target/sh4}/helper.c (100%)
 rename {target-sh4 => target/sh4}/helper.h (100%)
 rename {target-sh4 => target/sh4}/monitor.c (100%)
 rename {target-sh4 => target/sh4}/op_helper.c (100%)
 rename {target-sh4 => target/sh4}/translate.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index d4d5605..31597bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -209,7 +209,7 @@ F: disas/s390.c
 SH4
 M: Aurelien Jarno <aurelien@aurel32.net>
 S: Odd Fixes
-F: target-sh4/
+F: target/sh4/
 F: hw/sh4/
 F: disas/sh4.c
 F: include/hw/sh4/
diff --git a/hw/sh4/shix.c b/hw/sh4/shix.c
index 14d4007..fd00cc5 100644
--- a/hw/sh4/shix.c
+++ b/hw/sh4/shix.c
@@ -25,7 +25,7 @@
    Shix 2.0 board by Alexis Polti, described at
    https://web.archive.org/web/20070917001736/perso.enst.fr/~polti/realisations/shix20
 
-   More information in target-sh4/README.sh4
+   More information in target/sh4/README.sh4
 */
 #include "qemu/osdep.h"
 #include "qapi/error.h"
diff --git a/include/hw/sh4/sh.h b/include/hw/sh4/sh.h
index 070312d..e50651a 100644
--- a/include/hw/sh4/sh.h
+++ b/include/hw/sh4/sh.h
@@ -3,7 +3,7 @@
 /* Definitions for SH board emulation.  */
 
 #include "hw/sh4/sh_intc.h"
-#include "target-sh4/cpu-qom.h"
+#include "cpu-qom.h"
 
 #define A7ADDR(x) ((x) & 0x1fffffff)
 #define P4ADDR(x) ((x) | 0xe0000000)
diff --git a/target-sh4/Makefile.objs b/target/sh4/Makefile.objs
similarity index 100%
rename from target-sh4/Makefile.objs
rename to target/sh4/Makefile.objs
diff --git a/target-sh4/README.sh4 b/target/sh4/README.sh4
similarity index 98%
rename from target-sh4/README.sh4
rename to target/sh4/README.sh4
index ece0464..a192ca7 100644
--- a/target-sh4/README.sh4
+++ b/target/sh4/README.sh4
@@ -8,7 +8,7 @@ file describes the current state of implementation.
 Most places requiring attention and/or modification can be detected by
 looking for "XXXXX" or "abort()".
 
-The sh4 core is located in target-sh4/*, while the 7750 peripheral
+The sh4 core is located in target/sh4/*, while the 7750 peripheral
 features (IO ports for example) are located in hw/sh7750.[ch]. The
 main board description is in hw/shix.c, and the NAND flash in
 hw/tc58128.[ch].
diff --git a/target-sh4/cpu-qom.h b/target/sh4/cpu-qom.h
similarity index 100%
rename from target-sh4/cpu-qom.h
rename to target/sh4/cpu-qom.h
diff --git a/target-sh4/cpu.c b/target/sh4/cpu.c
similarity index 100%
rename from target-sh4/cpu.c
rename to target/sh4/cpu.c
diff --git a/target-sh4/cpu.h b/target/sh4/cpu.h
similarity index 100%
rename from target-sh4/cpu.h
rename to target/sh4/cpu.h
diff --git a/target-sh4/gdbstub.c b/target/sh4/gdbstub.c
similarity index 100%
rename from target-sh4/gdbstub.c
rename to target/sh4/gdbstub.c
diff --git a/target-sh4/helper.c b/target/sh4/helper.c
similarity index 100%
rename from target-sh4/helper.c
rename to target/sh4/helper.c
diff --git a/target-sh4/helper.h b/target/sh4/helper.h
similarity index 100%
rename from target-sh4/helper.h
rename to target/sh4/helper.h
diff --git a/target-sh4/monitor.c b/target/sh4/monitor.c
similarity index 100%
rename from target-sh4/monitor.c
rename to target/sh4/monitor.c
diff --git a/target-sh4/op_helper.c b/target/sh4/op_helper.c
similarity index 100%
rename from target-sh4/op_helper.c
rename to target/sh4/op_helper.c
diff --git a/target-sh4/translate.c b/target/sh4/translate.c
similarity index 100%
rename from target-sh4/translate.c
rename to target/sh4/translate.c
-- 
1.8.3.1
