Received: from eggs.gnu.org ([2001:4830:134:3::10]:42693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duOzy-0005fW-Kh
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:20:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duOzw-0004vZ-6d
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:20:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1duOzw-0004v8-0p
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:20:00 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 19 Sep 2017 17:18:50 -0300
Message-Id: <20170919201850.14772-13-ehabkost@redhat.com>
In-Reply-To: <20170919201850.14772-1-ehabkost@redhat.com>
References: <20170919201850.14772-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 12/12] MAINTAINERS: Update git URLs for my trees
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

List the branches where I queue patches for Machine Core, NUMA,
Memory Backends, and X86.  Update the NUMA section to list the
"machine-next" branch instead of "numa".

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170901153928.17058-1-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 MAINTAINERS | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4bd1797330..5ba7cf056a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -249,6 +249,7 @@ S: Maintained
 F: target/i386/
 F: hw/i386/
 F: disas/i386.c
+T: git git://github.com/ehabkost/qemu.git x86-next
 
 Xtensa
 M: Max Filippov <jcmvbkbc@gmail.com>
@@ -857,6 +858,7 @@ S: Supported
 F: hw/core/machine.c
 F: hw/core/null-machine.c
 F: include/hw/boards.h
+T: git git://github.com/ehabkost/qemu.git machine-next
 
 Xtensa Machines
 ---------------
@@ -1374,7 +1376,7 @@ M: Eduardo Habkost <ehabkost@redhat.com>
 S: Maintained
 F: numa.c
 F: include/sysemu/numa.h
-T: git git://github.com/ehabkost/qemu.git numa
+T: git git://github.com/ehabkost/qemu.git machine-next
 
 Host Memory Backends
 M: Eduardo Habkost <ehabkost@redhat.com>
@@ -1382,6 +1384,7 @@ M: Igor Mammedov <imammedo@redhat.com>
 S: Maintained
 F: backends/hostmem*.c
 F: include/sysemu/hostmem.h
+T: git git://github.com/ehabkost/qemu.git machine-next
 
 Cryptodev Backends
 M: Gonglei <arei.gonglei@huawei.com>
-- 
2.13.5
