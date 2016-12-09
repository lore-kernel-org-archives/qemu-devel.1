Received: from eggs.gnu.org ([2001:4830:134:3::10]:47942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK8e-0000nG-NV
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK8a-0003KS-JA
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cFK8a-0003Jx-Ax
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:52 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  9 Dec 2016 13:17:39 +0100
Message-Id: <1481285870-3396-10-git-send-email-thuth@redhat.com>
In-Reply-To: <1481285870-3396-1-git-send-email-thuth@redhat.com>
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 09/20] mips: Move CPU files to target/ folder
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
 MAINTAINERS                                   | 4 ++--
 include/hw/mips/cpudevs.h                     | 2 +-
 {target-mips => target/mips}/Makefile.objs    | 0
 {target-mips => target/mips}/TODO             | 0
 {target-mips => target/mips}/cpu-qom.h        | 0
 {target-mips => target/mips}/cpu.c            | 0
 {target-mips => target/mips}/cpu.h            | 0
 {target-mips => target/mips}/dsp_helper.c     | 0
 {target-mips => target/mips}/gdbstub.c        | 0
 {target-mips => target/mips}/helper.c         | 0
 {target-mips => target/mips}/helper.h         | 0
 {target-mips => target/mips}/kvm.c            | 0
 {target-mips => target/mips}/kvm_mips.h       | 0
 {target-mips => target/mips}/lmi_helper.c     | 0
 {target-mips => target/mips}/machine.c        | 0
 {target-mips => target/mips}/mips-defs.h      | 0
 {target-mips => target/mips}/mips-semi.c      | 0
 {target-mips => target/mips}/msa_helper.c     | 0
 {target-mips => target/mips}/op_helper.c      | 0
 {target-mips => target/mips}/translate.c      | 0
 {target-mips => target/mips}/translate_init.c | 0
 21 files changed, 3 insertions(+), 3 deletions(-)
 rename {target-mips => target/mips}/Makefile.objs (100%)
 rename {target-mips => target/mips}/TODO (100%)
 rename {target-mips => target/mips}/cpu-qom.h (100%)
 rename {target-mips => target/mips}/cpu.c (100%)
 rename {target-mips => target/mips}/cpu.h (100%)
 rename {target-mips => target/mips}/dsp_helper.c (100%)
 rename {target-mips => target/mips}/gdbstub.c (100%)
 rename {target-mips => target/mips}/helper.c (100%)
 rename {target-mips => target/mips}/helper.h (100%)
 rename {target-mips => target/mips}/kvm.c (100%)
 rename {target-mips => target/mips}/kvm_mips.h (100%)
 rename {target-mips => target/mips}/lmi_helper.c (100%)
 rename {target-mips => target/mips}/machine.c (100%)
 rename {target-mips => target/mips}/mips-defs.h (100%)
 rename {target-mips => target/mips}/mips-semi.c (100%)
 rename {target-mips => target/mips}/msa_helper.c (100%)
 rename {target-mips => target/mips}/op_helper.c (100%)
 rename {target-mips => target/mips}/translate.c (100%)
 rename {target-mips => target/mips}/translate_init.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index c7b1a3f..fb6c3a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -161,7 +161,7 @@ MIPS
 M: Aurelien Jarno <aurelien@aurel32.net>
 M: Yongbok Kim <yongbok.kim@imgtec.com>
 S: Maintained
-F: target-mips/
+F: target/mips/
 F: hw/mips/
 F: hw/misc/mips_*
 F: hw/intc/mips_gic.c
@@ -274,7 +274,7 @@ F: target/arm/kvm.c
 MIPS
 M: James Hogan <james.hogan@imgtec.com>
 S: Maintained
-F: target-mips/kvm.c
+F: target/mips/kvm.c
 
 PPC
 M: Alexander Graf <agraf@suse.de>
diff --git a/include/hw/mips/cpudevs.h b/include/hw/mips/cpudevs.h
index 8673daa..31f5319 100644
--- a/include/hw/mips/cpudevs.h
+++ b/include/hw/mips/cpudevs.h
@@ -1,7 +1,7 @@
 #ifndef HW_MIPS_CPUDEVS_H
 #define HW_MIPS_CPUDEVS_H
 
-#include "target-mips/cpu-qom.h"
+#include "cpu-qom.h"
 
 /* Definitions for MIPS CPU internal devices.  */
 
diff --git a/target-mips/Makefile.objs b/target/mips/Makefile.objs
similarity index 100%
rename from target-mips/Makefile.objs
rename to target/mips/Makefile.objs
diff --git a/target-mips/TODO b/target/mips/TODO
similarity index 100%
rename from target-mips/TODO
rename to target/mips/TODO
diff --git a/target-mips/cpu-qom.h b/target/mips/cpu-qom.h
similarity index 100%
rename from target-mips/cpu-qom.h
rename to target/mips/cpu-qom.h
diff --git a/target-mips/cpu.c b/target/mips/cpu.c
similarity index 100%
rename from target-mips/cpu.c
rename to target/mips/cpu.c
diff --git a/target-mips/cpu.h b/target/mips/cpu.h
similarity index 100%
rename from target-mips/cpu.h
rename to target/mips/cpu.h
diff --git a/target-mips/dsp_helper.c b/target/mips/dsp_helper.c
similarity index 100%
rename from target-mips/dsp_helper.c
rename to target/mips/dsp_helper.c
diff --git a/target-mips/gdbstub.c b/target/mips/gdbstub.c
similarity index 100%
rename from target-mips/gdbstub.c
rename to target/mips/gdbstub.c
diff --git a/target-mips/helper.c b/target/mips/helper.c
similarity index 100%
rename from target-mips/helper.c
rename to target/mips/helper.c
diff --git a/target-mips/helper.h b/target/mips/helper.h
similarity index 100%
rename from target-mips/helper.h
rename to target/mips/helper.h
diff --git a/target-mips/kvm.c b/target/mips/kvm.c
similarity index 100%
rename from target-mips/kvm.c
rename to target/mips/kvm.c
diff --git a/target-mips/kvm_mips.h b/target/mips/kvm_mips.h
similarity index 100%
rename from target-mips/kvm_mips.h
rename to target/mips/kvm_mips.h
diff --git a/target-mips/lmi_helper.c b/target/mips/lmi_helper.c
similarity index 100%
rename from target-mips/lmi_helper.c
rename to target/mips/lmi_helper.c
diff --git a/target-mips/machine.c b/target/mips/machine.c
similarity index 100%
rename from target-mips/machine.c
rename to target/mips/machine.c
diff --git a/target-mips/mips-defs.h b/target/mips/mips-defs.h
similarity index 100%
rename from target-mips/mips-defs.h
rename to target/mips/mips-defs.h
diff --git a/target-mips/mips-semi.c b/target/mips/mips-semi.c
similarity index 100%
rename from target-mips/mips-semi.c
rename to target/mips/mips-semi.c
diff --git a/target-mips/msa_helper.c b/target/mips/msa_helper.c
similarity index 100%
rename from target-mips/msa_helper.c
rename to target/mips/msa_helper.c
diff --git a/target-mips/op_helper.c b/target/mips/op_helper.c
similarity index 100%
rename from target-mips/op_helper.c
rename to target/mips/op_helper.c
diff --git a/target-mips/translate.c b/target/mips/translate.c
similarity index 100%
rename from target-mips/translate.c
rename to target/mips/translate.c
diff --git a/target-mips/translate_init.c b/target/mips/translate_init.c
similarity index 100%
rename from target-mips/translate_init.c
rename to target/mips/translate_init.c
-- 
1.8.3.1
