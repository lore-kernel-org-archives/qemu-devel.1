Received: from eggs.gnu.org ([2001:4830:134:3::10]:48303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK9b-0003tQ-0r
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:20:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK9W-0003lw-Eo
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:19:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cFK9W-0003lc-6G
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:19:50 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  9 Dec 2016 13:17:49 +0100
Message-Id: <1481285870-3396-20-git-send-email-thuth@redhat.com>
In-Reply-To: <1481285870-3396-1-git-send-email-thuth@redhat.com>
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 19/20] xtensa: Move CPU files to target/ folder
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
 MAINTAINERS                                               | 2 +-
 {target-xtensa => target/xtensa}/Makefile.objs            | 0
 {target-xtensa => target/xtensa}/core-dc232b.c            | 0
 {target-xtensa => target/xtensa}/core-dc232b/core-isa.h   | 0
 {target-xtensa => target/xtensa}/core-dc232b/gdb-config.c | 0
 {target-xtensa => target/xtensa}/core-dc233c.c            | 0
 {target-xtensa => target/xtensa}/core-dc233c/core-isa.h   | 0
 {target-xtensa => target/xtensa}/core-dc233c/gdb-config.c | 0
 {target-xtensa => target/xtensa}/core-fsf.c               | 0
 {target-xtensa => target/xtensa}/core-fsf/core-isa.h      | 0
 {target-xtensa => target/xtensa}/cpu-qom.h                | 0
 {target-xtensa => target/xtensa}/cpu.c                    | 0
 {target-xtensa => target/xtensa}/cpu.h                    | 0
 {target-xtensa => target/xtensa}/gdbstub.c                | 0
 {target-xtensa => target/xtensa}/helper.c                 | 0
 {target-xtensa => target/xtensa}/helper.h                 | 0
 {target-xtensa => target/xtensa}/import_core.sh           | 0
 {target-xtensa => target/xtensa}/monitor.c                | 0
 {target-xtensa => target/xtensa}/op_helper.c              | 0
 {target-xtensa => target/xtensa}/overlay_tool.h           | 0
 {target-xtensa => target/xtensa}/translate.c              | 0
 {target-xtensa => target/xtensa}/xtensa-semi.c            | 0
 tests/tcg/xtensa/Makefile                                 | 2 +-
 23 files changed, 2 insertions(+), 2 deletions(-)
 rename {target-xtensa => target/xtensa}/Makefile.objs (100%)
 rename {target-xtensa => target/xtensa}/core-dc232b.c (100%)
 rename {target-xtensa => target/xtensa}/core-dc232b/core-isa.h (100%)
 rename {target-xtensa => target/xtensa}/core-dc232b/gdb-config.c (100%)
 rename {target-xtensa => target/xtensa}/core-dc233c.c (100%)
 rename {target-xtensa => target/xtensa}/core-dc233c/core-isa.h (100%)
 rename {target-xtensa => target/xtensa}/core-dc233c/gdb-config.c (100%)
 rename {target-xtensa => target/xtensa}/core-fsf.c (100%)
 rename {target-xtensa => target/xtensa}/core-fsf/core-isa.h (100%)
 rename {target-xtensa => target/xtensa}/cpu-qom.h (100%)
 rename {target-xtensa => target/xtensa}/cpu.c (100%)
 rename {target-xtensa => target/xtensa}/cpu.h (100%)
 rename {target-xtensa => target/xtensa}/gdbstub.c (100%)
 rename {target-xtensa => target/xtensa}/helper.c (100%)
 rename {target-xtensa => target/xtensa}/helper.h (100%)
 rename {target-xtensa => target/xtensa}/import_core.sh (100%)
 rename {target-xtensa => target/xtensa}/monitor.c (100%)
 rename {target-xtensa => target/xtensa}/op_helper.c (100%)
 rename {target-xtensa => target/xtensa}/overlay_tool.h (100%)
 rename {target-xtensa => target/xtensa}/translate.c (100%)
 rename {target-xtensa => target/xtensa}/xtensa-semi.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e9607c..585cd5a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -243,7 +243,7 @@ Xtensa
 M: Max Filippov <jcmvbkbc@gmail.com>
 W: http://wiki.osll.spb.ru/doku.php?id=etc:users:jcmvbkbc:qemu-target-xtensa
 S: Maintained
-F: target-xtensa/
+F: target/xtensa/
 F: hw/xtensa/
 F: tests/tcg/xtensa/
 
diff --git a/target-xtensa/Makefile.objs b/target/xtensa/Makefile.objs
similarity index 100%
rename from target-xtensa/Makefile.objs
rename to target/xtensa/Makefile.objs
diff --git a/target-xtensa/core-dc232b.c b/target/xtensa/core-dc232b.c
similarity index 100%
rename from target-xtensa/core-dc232b.c
rename to target/xtensa/core-dc232b.c
diff --git a/target-xtensa/core-dc232b/core-isa.h b/target/xtensa/core-dc232b/core-isa.h
similarity index 100%
rename from target-xtensa/core-dc232b/core-isa.h
rename to target/xtensa/core-dc232b/core-isa.h
diff --git a/target-xtensa/core-dc232b/gdb-config.c b/target/xtensa/core-dc232b/gdb-config.c
similarity index 100%
rename from target-xtensa/core-dc232b/gdb-config.c
rename to target/xtensa/core-dc232b/gdb-config.c
diff --git a/target-xtensa/core-dc233c.c b/target/xtensa/core-dc233c.c
similarity index 100%
rename from target-xtensa/core-dc233c.c
rename to target/xtensa/core-dc233c.c
diff --git a/target-xtensa/core-dc233c/core-isa.h b/target/xtensa/core-dc233c/core-isa.h
similarity index 100%
rename from target-xtensa/core-dc233c/core-isa.h
rename to target/xtensa/core-dc233c/core-isa.h
diff --git a/target-xtensa/core-dc233c/gdb-config.c b/target/xtensa/core-dc233c/gdb-config.c
similarity index 100%
rename from target-xtensa/core-dc233c/gdb-config.c
rename to target/xtensa/core-dc233c/gdb-config.c
diff --git a/target-xtensa/core-fsf.c b/target/xtensa/core-fsf.c
similarity index 100%
rename from target-xtensa/core-fsf.c
rename to target/xtensa/core-fsf.c
diff --git a/target-xtensa/core-fsf/core-isa.h b/target/xtensa/core-fsf/core-isa.h
similarity index 100%
rename from target-xtensa/core-fsf/core-isa.h
rename to target/xtensa/core-fsf/core-isa.h
diff --git a/target-xtensa/cpu-qom.h b/target/xtensa/cpu-qom.h
similarity index 100%
rename from target-xtensa/cpu-qom.h
rename to target/xtensa/cpu-qom.h
diff --git a/target-xtensa/cpu.c b/target/xtensa/cpu.c
similarity index 100%
rename from target-xtensa/cpu.c
rename to target/xtensa/cpu.c
diff --git a/target-xtensa/cpu.h b/target/xtensa/cpu.h
similarity index 100%
rename from target-xtensa/cpu.h
rename to target/xtensa/cpu.h
diff --git a/target-xtensa/gdbstub.c b/target/xtensa/gdbstub.c
similarity index 100%
rename from target-xtensa/gdbstub.c
rename to target/xtensa/gdbstub.c
diff --git a/target-xtensa/helper.c b/target/xtensa/helper.c
similarity index 100%
rename from target-xtensa/helper.c
rename to target/xtensa/helper.c
diff --git a/target-xtensa/helper.h b/target/xtensa/helper.h
similarity index 100%
rename from target-xtensa/helper.h
rename to target/xtensa/helper.h
diff --git a/target-xtensa/import_core.sh b/target/xtensa/import_core.sh
similarity index 100%
rename from target-xtensa/import_core.sh
rename to target/xtensa/import_core.sh
diff --git a/target-xtensa/monitor.c b/target/xtensa/monitor.c
similarity index 100%
rename from target-xtensa/monitor.c
rename to target/xtensa/monitor.c
diff --git a/target-xtensa/op_helper.c b/target/xtensa/op_helper.c
similarity index 100%
rename from target-xtensa/op_helper.c
rename to target/xtensa/op_helper.c
diff --git a/target-xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
similarity index 100%
rename from target-xtensa/overlay_tool.h
rename to target/xtensa/overlay_tool.h
diff --git a/target-xtensa/translate.c b/target/xtensa/translate.c
similarity index 100%
rename from target-xtensa/translate.c
rename to target/xtensa/translate.c
diff --git a/target-xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
similarity index 100%
rename from target-xtensa/xtensa-semi.c
rename to target/xtensa/xtensa-semi.c
diff --git a/tests/tcg/xtensa/Makefile b/tests/tcg/xtensa/Makefile
index 522a63e..7f9f2d9 100644
--- a/tests/tcg/xtensa/Makefile
+++ b/tests/tcg/xtensa/Makefile
@@ -19,7 +19,7 @@ AS      = $(CROSS)gcc -x assembler-with-cpp
 LD      = $(CROSS)ld
 
 XTENSA_SRC_PATH = $(SRC_PATH)/tests/tcg/xtensa
-INCLUDE_DIRS = $(XTENSA_SRC_PATH) $(SRC_PATH)/target-xtensa/core-$(CORE)
+INCLUDE_DIRS = $(XTENSA_SRC_PATH) $(SRC_PATH)/target/xtensa/core-$(CORE)
 XTENSA_INC = $(addprefix -I,$(INCLUDE_DIRS))
 
 LDFLAGS = -Tlinker.ld
-- 
1.8.3.1
