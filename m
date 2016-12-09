Received: from eggs.gnu.org ([2001:4830:134:3::10]:48271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK9W-0003do-I8
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:19:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK9Q-0003jN-JP
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:19:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cFK9Q-0003id-B3
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:19:44 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  9 Dec 2016 13:17:48 +0100
Message-Id: <1481285870-3396-19-git-send-email-thuth@redhat.com>
In-Reply-To: <1481285870-3396-1-git-send-email-thuth@redhat.com>
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 18/20] unicore32: Move CPU files to target/
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
 MAINTAINERS                                           | 2 +-
 {target-unicore32 => target/unicore32}/Makefile.objs  | 0
 {target-unicore32 => target/unicore32}/cpu-qom.h      | 0
 {target-unicore32 => target/unicore32}/cpu.c          | 0
 {target-unicore32 => target/unicore32}/cpu.h          | 0
 {target-unicore32 => target/unicore32}/helper.c       | 0
 {target-unicore32 => target/unicore32}/helper.h       | 0
 {target-unicore32 => target/unicore32}/op_helper.c    | 0
 {target-unicore32 => target/unicore32}/softmmu.c      | 0
 {target-unicore32 => target/unicore32}/translate.c    | 0
 {target-unicore32 => target/unicore32}/ucf64_helper.c | 0
 11 files changed, 1 insertion(+), 1 deletion(-)
 rename {target-unicore32 => target/unicore32}/Makefile.objs (100%)
 rename {target-unicore32 => target/unicore32}/cpu-qom.h (100%)
 rename {target-unicore32 => target/unicore32}/cpu.c (100%)
 rename {target-unicore32 => target/unicore32}/cpu.h (100%)
 rename {target-unicore32 => target/unicore32}/helper.c (100%)
 rename {target-unicore32 => target/unicore32}/helper.h (100%)
 rename {target-unicore32 => target/unicore32}/op_helper.c (100%)
 rename {target-unicore32 => target/unicore32}/softmmu.c (100%)
 rename {target-unicore32 => target/unicore32}/translate.c (100%)
 rename {target-unicore32 => target/unicore32}/ucf64_helper.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7733ccc..9e9607c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -226,7 +226,7 @@ F: disas/sparc.c
 UniCore32
 M: Guan Xuetao <gxt@mprc.pku.edu.cn>
 S: Maintained
-F: target-unicore32/
+F: target/unicore32/
 F: hw/unicore32/
 F: include/hw/unicore32/
 
diff --git a/target-unicore32/Makefile.objs b/target/unicore32/Makefile.objs
similarity index 100%
rename from target-unicore32/Makefile.objs
rename to target/unicore32/Makefile.objs
diff --git a/target-unicore32/cpu-qom.h b/target/unicore32/cpu-qom.h
similarity index 100%
rename from target-unicore32/cpu-qom.h
rename to target/unicore32/cpu-qom.h
diff --git a/target-unicore32/cpu.c b/target/unicore32/cpu.c
similarity index 100%
rename from target-unicore32/cpu.c
rename to target/unicore32/cpu.c
diff --git a/target-unicore32/cpu.h b/target/unicore32/cpu.h
similarity index 100%
rename from target-unicore32/cpu.h
rename to target/unicore32/cpu.h
diff --git a/target-unicore32/helper.c b/target/unicore32/helper.c
similarity index 100%
rename from target-unicore32/helper.c
rename to target/unicore32/helper.c
diff --git a/target-unicore32/helper.h b/target/unicore32/helper.h
similarity index 100%
rename from target-unicore32/helper.h
rename to target/unicore32/helper.h
diff --git a/target-unicore32/op_helper.c b/target/unicore32/op_helper.c
similarity index 100%
rename from target-unicore32/op_helper.c
rename to target/unicore32/op_helper.c
diff --git a/target-unicore32/softmmu.c b/target/unicore32/softmmu.c
similarity index 100%
rename from target-unicore32/softmmu.c
rename to target/unicore32/softmmu.c
diff --git a/target-unicore32/translate.c b/target/unicore32/translate.c
similarity index 100%
rename from target-unicore32/translate.c
rename to target/unicore32/translate.c
diff --git a/target-unicore32/ucf64_helper.c b/target/unicore32/ucf64_helper.c
similarity index 100%
rename from target-unicore32/ucf64_helper.c
rename to target/unicore32/ucf64_helper.c
-- 
1.8.3.1
