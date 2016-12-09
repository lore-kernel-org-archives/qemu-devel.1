Received: from eggs.gnu.org ([2001:4830:134:3::10]:48221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK9P-0003IQ-Tt
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:19:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK9L-0003gb-0O
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:19:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cFK9K-0003gD-Nf
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:19:38 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  9 Dec 2016 13:17:47 +0100
Message-Id: <1481285870-3396-18-git-send-email-thuth@redhat.com>
In-Reply-To: <1481285870-3396-1-git-send-email-thuth@redhat.com>
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 17/20] tricore: Move CPU files to target/ folder
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
 MAINTAINERS                                          | 2 +-
 {target-tricore => target/tricore}/Makefile.objs     | 0
 {target-tricore => target/tricore}/cpu-qom.h         | 0
 {target-tricore => target/tricore}/cpu.c             | 0
 {target-tricore => target/tricore}/cpu.h             | 0
 {target-tricore => target/tricore}/csfr.def          | 0
 {target-tricore => target/tricore}/fpu_helper.c      | 0
 {target-tricore => target/tricore}/helper.c          | 0
 {target-tricore => target/tricore}/helper.h          | 0
 {target-tricore => target/tricore}/op_helper.c       | 0
 {target-tricore => target/tricore}/translate.c       | 0
 {target-tricore => target/tricore}/tricore-defs.h    | 0
 {target-tricore => target/tricore}/tricore-opcodes.h | 0
 13 files changed, 1 insertion(+), 1 deletion(-)
 rename {target-tricore => target/tricore}/Makefile.objs (100%)
 rename {target-tricore => target/tricore}/cpu-qom.h (100%)
 rename {target-tricore => target/tricore}/cpu.c (100%)
 rename {target-tricore => target/tricore}/cpu.h (100%)
 rename {target-tricore => target/tricore}/csfr.def (100%)
 rename {target-tricore => target/tricore}/fpu_helper.c (100%)
 rename {target-tricore => target/tricore}/helper.c (100%)
 rename {target-tricore => target/tricore}/helper.h (100%)
 rename {target-tricore => target/tricore}/op_helper.c (100%)
 rename {target-tricore => target/tricore}/translate.c (100%)
 rename {target-tricore => target/tricore}/tricore-defs.h (100%)
 rename {target-tricore => target/tricore}/tricore-opcodes.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 31597bc..7733ccc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -250,7 +250,7 @@ F: tests/tcg/xtensa/
 TriCore
 M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
 S: Maintained
-F: target-tricore/
+F: target/tricore/
 F: hw/tricore/
 F: include/hw/tricore/
 
diff --git a/target-tricore/Makefile.objs b/target/tricore/Makefile.objs
similarity index 100%
rename from target-tricore/Makefile.objs
rename to target/tricore/Makefile.objs
diff --git a/target-tricore/cpu-qom.h b/target/tricore/cpu-qom.h
similarity index 100%
rename from target-tricore/cpu-qom.h
rename to target/tricore/cpu-qom.h
diff --git a/target-tricore/cpu.c b/target/tricore/cpu.c
similarity index 100%
rename from target-tricore/cpu.c
rename to target/tricore/cpu.c
diff --git a/target-tricore/cpu.h b/target/tricore/cpu.h
similarity index 100%
rename from target-tricore/cpu.h
rename to target/tricore/cpu.h
diff --git a/target-tricore/csfr.def b/target/tricore/csfr.def
similarity index 100%
rename from target-tricore/csfr.def
rename to target/tricore/csfr.def
diff --git a/target-tricore/fpu_helper.c b/target/tricore/fpu_helper.c
similarity index 100%
rename from target-tricore/fpu_helper.c
rename to target/tricore/fpu_helper.c
diff --git a/target-tricore/helper.c b/target/tricore/helper.c
similarity index 100%
rename from target-tricore/helper.c
rename to target/tricore/helper.c
diff --git a/target-tricore/helper.h b/target/tricore/helper.h
similarity index 100%
rename from target-tricore/helper.h
rename to target/tricore/helper.h
diff --git a/target-tricore/op_helper.c b/target/tricore/op_helper.c
similarity index 100%
rename from target-tricore/op_helper.c
rename to target/tricore/op_helper.c
diff --git a/target-tricore/translate.c b/target/tricore/translate.c
similarity index 100%
rename from target-tricore/translate.c
rename to target/tricore/translate.c
diff --git a/target-tricore/tricore-defs.h b/target/tricore/tricore-defs.h
similarity index 100%
rename from target-tricore/tricore-defs.h
rename to target/tricore/tricore-defs.h
diff --git a/target-tricore/tricore-opcodes.h b/target/tricore/tricore-opcodes.h
similarity index 100%
rename from target-tricore/tricore-opcodes.h
rename to target/tricore/tricore-opcodes.h
-- 
1.8.3.1
