Received: from eggs.gnu.org ([2001:4830:134:3::10]:33900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duezw-0001Ea-KP
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:26:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dueys-0001mF-GT
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:25:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dueyq-0001eY-4J
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:23:56 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 20 Sep 2017 16:36:47 +0800
Message-Id: <20170920083647.14599-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] seccomp: Don't include libseccomp from QEMU
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Otubo <otubo@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Peter Maydell <peter.maydell@linaro.org>

The only prototype doesn't need anything from the lib header, and not
including it here allows files that include this header, for example
vl.c, to compile without the libseccomp cflags.

The breakage is since c3883e1f93 for environments where `pkg-config
--cflags libseccomp" is non-empty.

Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Fam Zheng <famz@redhat.com>

---

This is an alternative for

https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg04470.html
([Qemu-devel] [PATCH] seccomp: Fix build)
---
 include/sysemu/seccomp.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/sysemu/seccomp.h b/include/sysemu/seccomp.h
index e67c2dc840..9b092aa23f 100644
--- a/include/sysemu/seccomp.h
+++ b/include/sysemu/seccomp.h
@@ -21,7 +21,5 @@
 #define QEMU_SECCOMP_SET_SPAWN       (1 << 3)
 #define QEMU_SECCOMP_SET_RESOURCECTL (1 << 4)
 
-#include <seccomp.h>
-
 int seccomp_start(uint32_t seccomp_opts);
 #endif
-- 
2.13.5
