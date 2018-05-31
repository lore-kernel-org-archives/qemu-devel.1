Received: from eggs.gnu.org ([2001:4830:134:3::10]:58353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8G-0003PG-K0
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8F-0008KR-HU
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57292 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOR8F-0008Jo-C2
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:12:59 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:04 +0200
Message-Id: <20180531171253.21012-5-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/53] target: Do not include
 "exec/address-spaces.h" if it is not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Code change produced with:
    $ git grep '#include "exec/address-spaces.h"' target | \
      cut -d: -f-1 | \
      xargs egrep -L "(get_system_|address_space_)" | \
      xargs sed -i.bak '/#include "exec\/address-spaces.h"/d'

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180528232719.4721-4-f4bug@amsat.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_task.c | 1 -
 target/s390x/kvm.c         | 1 -
 target/s390x/mem_helper.c  | 1 -
 target/s390x/misc_helper.c | 1 -
 target/sparc/mmu_helper.c  | 1 -
 5 files changed, 5 deletions(-)

diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index 4abf3db25e..c3ead2ca73 100644
--- a/target/i386/hvf/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -26,7 +26,6 @@
 #include <Hypervisor/hv.h>
 #include <Hypervisor/hv_vmx.h>
=20
-#include "exec/address-spaces.h"
 #include "exec/exec-all.h"
 #include "exec/ioport.h"
 #include "hw/i386/apic_internal.h"
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 58e4380ae3..ac370da281 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -39,7 +39,6 @@
 #include "hw/hw.h"
 #include "sysemu/device_tree.h"
 #include "exec/gdbstub.h"
-#include "exec/address-spaces.h"
 #include "trace.h"
 #include "hw/s390x/s390-pci-inst.h"
 #include "hw/s390x/s390-pci-bus.h"
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index a0e28bd124..e21a47fb4d 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internal.h"
-#include "exec/address-spaces.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 1f834f35ef..de1ced2082 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -26,7 +26,6 @@
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 #include "qemu/timer.h"
-#include "exec/address-spaces.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
=20
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index f8886ae039..135a9c9d9b 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -21,7 +21,6 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "trace.h"
-#include "exec/address-spaces.h"
=20
 /* Sparc MMU emulation */
=20
--=20
2.17.0
