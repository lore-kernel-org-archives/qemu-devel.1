Received: from eggs.gnu.org ([2001:4830:134:3::10]:44565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUrVs-0003mo-B3
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:31:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUrVp-0007kK-9M
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:31:24 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 11 Jul 2017 11:31:17 +0200
Message-Id: <1499765477-10541-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] trivial: Move softmmu_template.h to the
 accel/tcg/ folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>
Cc: qemu-trivial@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The header is only used by accel/tcg/cputlb.c so we can
move it to the accel/tcg/ folder, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: This patch should be applied after Philippe's "MAINTAINERS:
 update TCG entries" patch here:
 https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg06529.html

 MAINTAINERS                                        | 1 -
 softmmu_template.h => accel/tcg/softmmu_template.h | 0
 2 files changed, 1 deletion(-)
 rename softmmu_template.h => accel/tcg/softmmu_template.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 74b3956..993b12e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -86,7 +86,6 @@ M: Richard Henderson <rth@twiddle.net>
 S: Maintained
 F: cpus.c
 F: exec.c
-F: softmmu_template.h
 F: accel/tcg/
 F: include/exec/cpu*.h
 F: include/exec/exec-all.h
diff --git a/softmmu_template.h b/accel/tcg/softmmu_template.h
similarity index 100%
rename from softmmu_template.h
rename to accel/tcg/softmmu_template.h
-- 
1.8.3.1
