Received: from eggs.gnu.org ([2001:4830:134:3::10]:60860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNRYE-0006n6-Fc
	for qemu-devel@nongnu.org; Mon, 28 May 2018 19:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNRYD-0000b7-Di
	for qemu-devel@nongnu.org; Mon, 28 May 2018 19:27:42 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 28 May 2018 20:27:01 -0300
Message-Id: <20180528232719.4721-4-f4bug@amsat.org>
In-Reply-To: <20180528232719.4721-1-f4bug@amsat.org>
References: <20180528232719.4721-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 03/21] target: Do not include
 "exec/address-spaces.h" if it is not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, "open list:S390" <qemu-s390x@nongnu.org>

Code change produced with:
    $ git grep '#include "exec/address-spaces.h"' target | \
      cut -d: -f-1 | \
      xargs egrep -L "(get_system_|address_space_)" | \
      xargs sed -i.bak '/#include "exec\/address-spaces.h"/d'

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
 
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index f8886ae039..135a9c9d9b 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -21,7 +21,6 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "trace.h"
-#include "exec/address-spaces.h"
 
 /* Sparc MMU emulation */
 
-- 
2.17.0
