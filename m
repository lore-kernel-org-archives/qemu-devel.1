Received: from eggs.gnu.org ([2001:4830:134:3::10]:48182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK9F-0002oz-JW
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:19:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK99-0003bX-Bh
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:19:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cFK99-0003bF-3j
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:19:27 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  9 Dec 2016 13:17:45 +0100
Message-Id: <1481285870-3396-16-git-send-email-thuth@redhat.com>
In-Reply-To: <1481285870-3396-1-git-send-email-thuth@redhat.com>
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 15/20] openrisc: Move CPU files to target/
 folder
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
 MAINTAINERS                                             | 2 +-
 {target-openrisc => target/openrisc}/Makefile.objs      | 0
 {target-openrisc => target/openrisc}/cpu.c              | 0
 {target-openrisc => target/openrisc}/cpu.h              | 0
 {target-openrisc => target/openrisc}/exception.c        | 0
 {target-openrisc => target/openrisc}/exception.h        | 0
 {target-openrisc => target/openrisc}/exception_helper.c | 0
 {target-openrisc => target/openrisc}/fpu_helper.c       | 0
 {target-openrisc => target/openrisc}/gdbstub.c          | 0
 {target-openrisc => target/openrisc}/helper.h           | 0
 {target-openrisc => target/openrisc}/int_helper.c       | 0
 {target-openrisc => target/openrisc}/interrupt.c        | 0
 {target-openrisc => target/openrisc}/interrupt_helper.c | 0
 {target-openrisc => target/openrisc}/machine.c          | 0
 {target-openrisc => target/openrisc}/mmu.c              | 0
 {target-openrisc => target/openrisc}/mmu_helper.c       | 0
 {target-openrisc => target/openrisc}/sys_helper.c       | 0
 {target-openrisc => target/openrisc}/translate.c        | 0
 18 files changed, 1 insertion(+), 1 deletion(-)
 rename {target-openrisc => target/openrisc}/Makefile.objs (100%)
 rename {target-openrisc => target/openrisc}/cpu.c (100%)
 rename {target-openrisc => target/openrisc}/cpu.h (100%)
 rename {target-openrisc => target/openrisc}/exception.c (100%)
 rename {target-openrisc => target/openrisc}/exception.h (100%)
 rename {target-openrisc => target/openrisc}/exception_helper.c (100%)
 rename {target-openrisc => target/openrisc}/fpu_helper.c (100%)
 rename {target-openrisc => target/openrisc}/gdbstub.c (100%)
 rename {target-openrisc => target/openrisc}/helper.h (100%)
 rename {target-openrisc => target/openrisc}/int_helper.c (100%)
 rename {target-openrisc => target/openrisc}/interrupt.c (100%)
 rename {target-openrisc => target/openrisc}/interrupt_helper.c (100%)
 rename {target-openrisc => target/openrisc}/machine.c (100%)
 rename {target-openrisc => target/openrisc}/mmu.c (100%)
 rename {target-openrisc => target/openrisc}/mmu_helper.c (100%)
 rename {target-openrisc => target/openrisc}/sys_helper.c (100%)
 rename {target-openrisc => target/openrisc}/translate.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index f172df9..d4d5605 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -184,7 +184,7 @@ F: default-configs/moxie-softmmu.mak
 OpenRISC
 M: Jia Liu <proljc@gmail.com>
 S: Maintained
-F: target-openrisc/
+F: target/openrisc/
 F: hw/openrisc/
 F: tests/tcg/openrisc/
 
diff --git a/target-openrisc/Makefile.objs b/target/openrisc/Makefile.objs
similarity index 100%
rename from target-openrisc/Makefile.objs
rename to target/openrisc/Makefile.objs
diff --git a/target-openrisc/cpu.c b/target/openrisc/cpu.c
similarity index 100%
rename from target-openrisc/cpu.c
rename to target/openrisc/cpu.c
diff --git a/target-openrisc/cpu.h b/target/openrisc/cpu.h
similarity index 100%
rename from target-openrisc/cpu.h
rename to target/openrisc/cpu.h
diff --git a/target-openrisc/exception.c b/target/openrisc/exception.c
similarity index 100%
rename from target-openrisc/exception.c
rename to target/openrisc/exception.c
diff --git a/target-openrisc/exception.h b/target/openrisc/exception.h
similarity index 100%
rename from target-openrisc/exception.h
rename to target/openrisc/exception.h
diff --git a/target-openrisc/exception_helper.c b/target/openrisc/exception_helper.c
similarity index 100%
rename from target-openrisc/exception_helper.c
rename to target/openrisc/exception_helper.c
diff --git a/target-openrisc/fpu_helper.c b/target/openrisc/fpu_helper.c
similarity index 100%
rename from target-openrisc/fpu_helper.c
rename to target/openrisc/fpu_helper.c
diff --git a/target-openrisc/gdbstub.c b/target/openrisc/gdbstub.c
similarity index 100%
rename from target-openrisc/gdbstub.c
rename to target/openrisc/gdbstub.c
diff --git a/target-openrisc/helper.h b/target/openrisc/helper.h
similarity index 100%
rename from target-openrisc/helper.h
rename to target/openrisc/helper.h
diff --git a/target-openrisc/int_helper.c b/target/openrisc/int_helper.c
similarity index 100%
rename from target-openrisc/int_helper.c
rename to target/openrisc/int_helper.c
diff --git a/target-openrisc/interrupt.c b/target/openrisc/interrupt.c
similarity index 100%
rename from target-openrisc/interrupt.c
rename to target/openrisc/interrupt.c
diff --git a/target-openrisc/interrupt_helper.c b/target/openrisc/interrupt_helper.c
similarity index 100%
rename from target-openrisc/interrupt_helper.c
rename to target/openrisc/interrupt_helper.c
diff --git a/target-openrisc/machine.c b/target/openrisc/machine.c
similarity index 100%
rename from target-openrisc/machine.c
rename to target/openrisc/machine.c
diff --git a/target-openrisc/mmu.c b/target/openrisc/mmu.c
similarity index 100%
rename from target-openrisc/mmu.c
rename to target/openrisc/mmu.c
diff --git a/target-openrisc/mmu_helper.c b/target/openrisc/mmu_helper.c
similarity index 100%
rename from target-openrisc/mmu_helper.c
rename to target/openrisc/mmu_helper.c
diff --git a/target-openrisc/sys_helper.c b/target/openrisc/sys_helper.c
similarity index 100%
rename from target-openrisc/sys_helper.c
rename to target/openrisc/sys_helper.c
diff --git a/target-openrisc/translate.c b/target/openrisc/translate.c
similarity index 100%
rename from target-openrisc/translate.c
rename to target/openrisc/translate.c
-- 
1.8.3.1
