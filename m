Received: from eggs.gnu.org ([2001:4830:134:3::10]:49309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1difhQ-00025e-6D
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1difhN-0007Db-Jm
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1difhN-0007DG-DP
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:21 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 18 Aug 2017 13:43:42 +0200
Message-Id: <20170818114353.13455-8-david@redhat.com>
In-Reply-To: <20170818114353.13455-1-david@redhat.com>
References: <20170818114353.13455-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-2.11 07/18] s390x: drop inclusion of
 sysemu/kvm.h from some files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

s390-stattrib.c needs definition of TARGET_PAGE_SIZE, solve it via cpu.h.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-stattrib.c | 2 +-
 hw/s390x/sclp.c          | 1 -
 hw/s390x/sclpcpu.c       | 1 -
 target/s390x/arch_dump.c | 1 -
 4 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index d14923f..14a0271 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -11,12 +11,12 @@
 
 #include "qemu/osdep.h"
 #include "hw/boards.h"
+#include "cpu.h"
 #include "qmp-commands.h"
 #include "migration/qemu-file.h"
 #include "migration/register.h"
 #include "hw/s390x/storage-attributes.h"
 #include "qemu/error-report.h"
-#include "sysemu/kvm.h"
 #include "exec/ram_addr.h"
 #include "qapi/error.h"
 
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 8dd1109..0b45b74 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -15,7 +15,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "sysemu/kvm.h"
 #include "exec/memory.h"
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
diff --git a/hw/s390x/sclpcpu.c b/hw/s390x/sclpcpu.c
index b1f3ef8..023d059 100644
--- a/hw/s390x/sclpcpu.c
+++ b/hw/s390x/sclpcpu.c
@@ -18,7 +18,6 @@
 #include "hw/s390x/event-facility.h"
 #include "cpu.h"
 #include "sysemu/cpus.h"
-#include "sysemu/kvm.h"
 
 typedef struct ConfigMgtData {
     EventBufferHeader ebh;
diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index 96c9fb9..399030d 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -16,7 +16,6 @@
 #include "elf.h"
 #include "exec/cpu-all.h"
 #include "sysemu/dump.h"
-#include "sysemu/kvm.h"
 
 
 struct S390xUserRegsStruct {
-- 
2.9.4
