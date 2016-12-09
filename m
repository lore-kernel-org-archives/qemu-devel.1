Received: from eggs.gnu.org ([2001:4830:134:3::10]:48147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK99-0002Wd-PL
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:19:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK93-0003Yw-Lo
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:19:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:13457)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cFK93-0003Yb-DD
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:19:21 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  9 Dec 2016 13:17:44 +0100
Message-Id: <1481285870-3396-15-git-send-email-thuth@redhat.com>
In-Reply-To: <1481285870-3396-1-git-send-email-thuth@redhat.com>
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 14/20] moxie: Move CPU files to target/ folder
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
 {target-moxie => target/moxie}/Makefile.objs | 0
 {target-moxie => target/moxie}/cpu.c         | 0
 {target-moxie => target/moxie}/cpu.h         | 0
 {target-moxie => target/moxie}/helper.c      | 0
 {target-moxie => target/moxie}/helper.h      | 0
 {target-moxie => target/moxie}/machine.c     | 0
 {target-moxie => target/moxie}/machine.h     | 0
 {target-moxie => target/moxie}/mmu.c         | 0
 {target-moxie => target/moxie}/mmu.h         | 0
 {target-moxie => target/moxie}/translate.c   | 0
 11 files changed, 1 insertion(+), 1 deletion(-)
 rename {target-moxie => target/moxie}/Makefile.objs (100%)
 rename {target-moxie => target/moxie}/cpu.c (100%)
 rename {target-moxie => target/moxie}/cpu.h (100%)
 rename {target-moxie => target/moxie}/helper.c (100%)
 rename {target-moxie => target/moxie}/helper.h (100%)
 rename {target-moxie => target/moxie}/machine.c (100%)
 rename {target-moxie => target/moxie}/machine.h (100%)
 rename {target-moxie => target/moxie}/mmu.c (100%)
 rename {target-moxie => target/moxie}/mmu.h (100%)
 rename {target-moxie => target/moxie}/translate.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d6b5fe..f172df9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -176,7 +176,7 @@ F: disas/mips.c
 Moxie
 M: Anthony Green <green@moxielogic.com>
 S: Maintained
-F: target-moxie/
+F: target/moxie/
 F: disas/moxie.c
 F: hw/moxie/
 F: default-configs/moxie-softmmu.mak
diff --git a/target-moxie/Makefile.objs b/target/moxie/Makefile.objs
similarity index 100%
rename from target-moxie/Makefile.objs
rename to target/moxie/Makefile.objs
diff --git a/target-moxie/cpu.c b/target/moxie/cpu.c
similarity index 100%
rename from target-moxie/cpu.c
rename to target/moxie/cpu.c
diff --git a/target-moxie/cpu.h b/target/moxie/cpu.h
similarity index 100%
rename from target-moxie/cpu.h
rename to target/moxie/cpu.h
diff --git a/target-moxie/helper.c b/target/moxie/helper.c
similarity index 100%
rename from target-moxie/helper.c
rename to target/moxie/helper.c
diff --git a/target-moxie/helper.h b/target/moxie/helper.h
similarity index 100%
rename from target-moxie/helper.h
rename to target/moxie/helper.h
diff --git a/target-moxie/machine.c b/target/moxie/machine.c
similarity index 100%
rename from target-moxie/machine.c
rename to target/moxie/machine.c
diff --git a/target-moxie/machine.h b/target/moxie/machine.h
similarity index 100%
rename from target-moxie/machine.h
rename to target/moxie/machine.h
diff --git a/target-moxie/mmu.c b/target/moxie/mmu.c
similarity index 100%
rename from target-moxie/mmu.c
rename to target/moxie/mmu.c
diff --git a/target-moxie/mmu.h b/target/moxie/mmu.h
similarity index 100%
rename from target-moxie/mmu.h
rename to target/moxie/mmu.h
diff --git a/target-moxie/translate.c b/target/moxie/translate.c
similarity index 100%
rename from target-moxie/translate.c
rename to target/moxie/translate.c
-- 
1.8.3.1
