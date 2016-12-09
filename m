Received: from eggs.gnu.org ([2001:4830:134:3::10]:47778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK89-0007TN-Fy
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK88-0003Bs-1L
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cFK87-0003BN-P2
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:23 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  9 Dec 2016 13:17:34 +0100
Message-Id: <1481285870-3396-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1481285870-3396-1-git-send-email-thuth@redhat.com>
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 04/20] alpha: Move CPU files to target/ folder
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
 MAINTAINERS                                  | 2 +-
 hw/alpha/alpha_sys.h                         | 2 +-
 {target-alpha => target/alpha}/Makefile.objs | 0
 {target-alpha => target/alpha}/STATUS        | 0
 {target-alpha => target/alpha}/cpu-qom.h     | 0
 {target-alpha => target/alpha}/cpu.c         | 0
 {target-alpha => target/alpha}/cpu.h         | 0
 {target-alpha => target/alpha}/fpu_helper.c  | 0
 {target-alpha => target/alpha}/gdbstub.c     | 0
 {target-alpha => target/alpha}/helper.c      | 0
 {target-alpha => target/alpha}/helper.h      | 0
 {target-alpha => target/alpha}/int_helper.c  | 0
 {target-alpha => target/alpha}/machine.c     | 0
 {target-alpha => target/alpha}/mem_helper.c  | 0
 {target-alpha => target/alpha}/sys_helper.c  | 0
 {target-alpha => target/alpha}/translate.c   | 0
 {target-alpha => target/alpha}/vax_helper.c  | 0
 17 files changed, 2 insertions(+), 2 deletions(-)
 rename {target-alpha => target/alpha}/Makefile.objs (100%)
 rename {target-alpha => target/alpha}/STATUS (100%)
 rename {target-alpha => target/alpha}/cpu-qom.h (100%)
 rename {target-alpha => target/alpha}/cpu.c (100%)
 rename {target-alpha => target/alpha}/cpu.h (100%)
 rename {target-alpha => target/alpha}/fpu_helper.c (100%)
 rename {target-alpha => target/alpha}/gdbstub.c (100%)
 rename {target-alpha => target/alpha}/helper.c (100%)
 rename {target-alpha => target/alpha}/helper.h (100%)
 rename {target-alpha => target/alpha}/int_helper.c (100%)
 rename {target-alpha => target/alpha}/machine.c (100%)
 rename {target-alpha => target/alpha}/mem_helper.c (100%)
 rename {target-alpha => target/alpha}/sys_helper.c (100%)
 rename {target-alpha => target/alpha}/translate.c (100%)
 rename {target-alpha => target/alpha}/vax_helper.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ce1ee35..37deb43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -106,7 +106,7 @@ F: include/fpu/
 Alpha
 M: Richard Henderson <rth@twiddle.net>
 S: Maintained
-F: target-alpha/
+F: target/alpha/
 F: hw/alpha/
 F: tests/tcg/alpha/
 F: disas/alpha.c
diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
index ed911f2..bdabf41 100644
--- a/hw/alpha/alpha_sys.h
+++ b/hw/alpha/alpha_sys.h
@@ -3,7 +3,7 @@
 #ifndef HW_ALPHA_SYS_H
 #define HW_ALPHA_SYS_H
 
-#include "target-alpha/cpu-qom.h"
+#include "cpu-qom.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "hw/ide.h"
diff --git a/target-alpha/Makefile.objs b/target/alpha/Makefile.objs
similarity index 100%
rename from target-alpha/Makefile.objs
rename to target/alpha/Makefile.objs
diff --git a/target-alpha/STATUS b/target/alpha/STATUS
similarity index 100%
rename from target-alpha/STATUS
rename to target/alpha/STATUS
diff --git a/target-alpha/cpu-qom.h b/target/alpha/cpu-qom.h
similarity index 100%
rename from target-alpha/cpu-qom.h
rename to target/alpha/cpu-qom.h
diff --git a/target-alpha/cpu.c b/target/alpha/cpu.c
similarity index 100%
rename from target-alpha/cpu.c
rename to target/alpha/cpu.c
diff --git a/target-alpha/cpu.h b/target/alpha/cpu.h
similarity index 100%
rename from target-alpha/cpu.h
rename to target/alpha/cpu.h
diff --git a/target-alpha/fpu_helper.c b/target/alpha/fpu_helper.c
similarity index 100%
rename from target-alpha/fpu_helper.c
rename to target/alpha/fpu_helper.c
diff --git a/target-alpha/gdbstub.c b/target/alpha/gdbstub.c
similarity index 100%
rename from target-alpha/gdbstub.c
rename to target/alpha/gdbstub.c
diff --git a/target-alpha/helper.c b/target/alpha/helper.c
similarity index 100%
rename from target-alpha/helper.c
rename to target/alpha/helper.c
diff --git a/target-alpha/helper.h b/target/alpha/helper.h
similarity index 100%
rename from target-alpha/helper.h
rename to target/alpha/helper.h
diff --git a/target-alpha/int_helper.c b/target/alpha/int_helper.c
similarity index 100%
rename from target-alpha/int_helper.c
rename to target/alpha/int_helper.c
diff --git a/target-alpha/machine.c b/target/alpha/machine.c
similarity index 100%
rename from target-alpha/machine.c
rename to target/alpha/machine.c
diff --git a/target-alpha/mem_helper.c b/target/alpha/mem_helper.c
similarity index 100%
rename from target-alpha/mem_helper.c
rename to target/alpha/mem_helper.c
diff --git a/target-alpha/sys_helper.c b/target/alpha/sys_helper.c
similarity index 100%
rename from target-alpha/sys_helper.c
rename to target/alpha/sys_helper.c
diff --git a/target-alpha/translate.c b/target/alpha/translate.c
similarity index 100%
rename from target-alpha/translate.c
rename to target/alpha/translate.c
diff --git a/target-alpha/vax_helper.c b/target/alpha/vax_helper.c
similarity index 100%
rename from target-alpha/vax_helper.c
rename to target/alpha/vax_helper.c
-- 
1.8.3.1
