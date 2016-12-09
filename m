Received: from eggs.gnu.org ([2001:4830:134:3::10]:47882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK8V-0000KH-Tu
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK8U-0003IL-Rb
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cFK8U-0003I8-JD
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:46 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  9 Dec 2016 13:17:38 +0100
Message-Id: <1481285870-3396-9-git-send-email-thuth@redhat.com>
In-Reply-To: <1481285870-3396-1-git-send-email-thuth@redhat.com>
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 08/20] microblaze: Move CPU files to target/
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
 MAINTAINERS                                                  | 2 +-
 {target-microblaze => target/microblaze}/Makefile.objs       | 0
 {target-microblaze => target/microblaze}/cpu-qom.h           | 0
 {target-microblaze => target/microblaze}/cpu.c               | 0
 {target-microblaze => target/microblaze}/cpu.h               | 0
 {target-microblaze => target/microblaze}/gdbstub.c           | 0
 {target-microblaze => target/microblaze}/helper.c            | 0
 {target-microblaze => target/microblaze}/helper.h            | 0
 {target-microblaze => target/microblaze}/microblaze-decode.h | 0
 {target-microblaze => target/microblaze}/mmu.c               | 0
 {target-microblaze => target/microblaze}/mmu.h               | 0
 {target-microblaze => target/microblaze}/op_helper.c         | 0
 {target-microblaze => target/microblaze}/translate.c         | 0
 13 files changed, 1 insertion(+), 1 deletion(-)
 rename {target-microblaze => target/microblaze}/Makefile.objs (100%)
 rename {target-microblaze => target/microblaze}/cpu-qom.h (100%)
 rename {target-microblaze => target/microblaze}/cpu.c (100%)
 rename {target-microblaze => target/microblaze}/cpu.h (100%)
 rename {target-microblaze => target/microblaze}/gdbstub.c (100%)
 rename {target-microblaze => target/microblaze}/helper.c (100%)
 rename {target-microblaze => target/microblaze}/helper.h (100%)
 rename {target-microblaze => target/microblaze}/microblaze-decode.h (100%)
 rename {target-microblaze => target/microblaze}/mmu.c (100%)
 rename {target-microblaze => target/microblaze}/mmu.h (100%)
 rename {target-microblaze => target/microblaze}/op_helper.c (100%)
 rename {target-microblaze => target/microblaze}/translate.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b064ac..c7b1a3f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -153,7 +153,7 @@ F: disas/m68k.c
 MicroBlaze
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
-F: target-microblaze/
+F: target/microblaze/
 F: hw/microblaze/
 F: disas/microblaze.c
 
diff --git a/target-microblaze/Makefile.objs b/target/microblaze/Makefile.objs
similarity index 100%
rename from target-microblaze/Makefile.objs
rename to target/microblaze/Makefile.objs
diff --git a/target-microblaze/cpu-qom.h b/target/microblaze/cpu-qom.h
similarity index 100%
rename from target-microblaze/cpu-qom.h
rename to target/microblaze/cpu-qom.h
diff --git a/target-microblaze/cpu.c b/target/microblaze/cpu.c
similarity index 100%
rename from target-microblaze/cpu.c
rename to target/microblaze/cpu.c
diff --git a/target-microblaze/cpu.h b/target/microblaze/cpu.h
similarity index 100%
rename from target-microblaze/cpu.h
rename to target/microblaze/cpu.h
diff --git a/target-microblaze/gdbstub.c b/target/microblaze/gdbstub.c
similarity index 100%
rename from target-microblaze/gdbstub.c
rename to target/microblaze/gdbstub.c
diff --git a/target-microblaze/helper.c b/target/microblaze/helper.c
similarity index 100%
rename from target-microblaze/helper.c
rename to target/microblaze/helper.c
diff --git a/target-microblaze/helper.h b/target/microblaze/helper.h
similarity index 100%
rename from target-microblaze/helper.h
rename to target/microblaze/helper.h
diff --git a/target-microblaze/microblaze-decode.h b/target/microblaze/microblaze-decode.h
similarity index 100%
rename from target-microblaze/microblaze-decode.h
rename to target/microblaze/microblaze-decode.h
diff --git a/target-microblaze/mmu.c b/target/microblaze/mmu.c
similarity index 100%
rename from target-microblaze/mmu.c
rename to target/microblaze/mmu.c
diff --git a/target-microblaze/mmu.h b/target/microblaze/mmu.h
similarity index 100%
rename from target-microblaze/mmu.h
rename to target/microblaze/mmu.h
diff --git a/target-microblaze/op_helper.c b/target/microblaze/op_helper.c
similarity index 100%
rename from target-microblaze/op_helper.c
rename to target/microblaze/op_helper.c
diff --git a/target-microblaze/translate.c b/target/microblaze/translate.c
similarity index 100%
rename from target-microblaze/translate.c
rename to target/microblaze/translate.c
-- 
1.8.3.1
