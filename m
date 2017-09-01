Received: from eggs.gnu.org ([2001:4830:134:3::10]:52285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dno2l-0007zK-QU
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dno2i-0002UN-OM
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:39:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dno2i-0002Sg-JB
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:39:36 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  1 Sep 2017 12:39:28 -0300
Message-Id: <20170901153928.17058-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Update git URLs for my trees
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

List the branches where I queue patches for Machine Core, NUMA,
Memory Backends, and X86.  Update the NUMA section to list the
"numa-next" branch instead of "numa".

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 MAINTAINERS | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ccee28b12d..d72d8183bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -250,6 +250,7 @@ S: Maintained
 F: target/i386/
 F: hw/i386/
 F: disas/i386.c
+T: git git://github.com/ehabkost/qemu.git x86-next
 
 Xtensa
 M: Max Filippov <jcmvbkbc@gmail.com>
@@ -858,6 +859,7 @@ S: Supported
 F: hw/core/machine.c
 F: hw/core/null-machine.c
 F: include/hw/boards.h
+T: git git://github.com/ehabkost/qemu.git machine-next
 
 Xtensa Machines
 ---------------
@@ -1368,7 +1370,7 @@ M: Eduardo Habkost <ehabkost@redhat.com>
 S: Maintained
 F: numa.c
 F: include/sysemu/numa.h
-T: git git://github.com/ehabkost/qemu.git numa
+T: git git://github.com/ehabkost/qemu.git numa-next
 
 Host Memory Backends
 M: Eduardo Habkost <ehabkost@redhat.com>
@@ -1376,6 +1378,7 @@ M: Igor Mammedov <imammedo@redhat.com>
 S: Maintained
 F: backends/hostmem*.c
 F: include/sysemu/hostmem.h
+T: git git://github.com/ehabkost/qemu.git machine-next
 
 Cryptodev Backends
 M: Gonglei <arei.gonglei@huawei.com>
-- 
2.13.5
