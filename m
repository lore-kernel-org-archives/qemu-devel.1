Received: from eggs.gnu.org ([2001:4830:134:3::10]:60942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNRYM-0006vi-Kd
	for qemu-devel@nongnu.org; Mon, 28 May 2018 19:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNRYK-0000jX-QZ
	for qemu-devel@nongnu.org; Mon, 28 May 2018 19:27:50 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 28 May 2018 20:27:03 -0300
Message-Id: <20180528232719.4721-6-f4bug@amsat.org>
In-Reply-To: <20180528232719.4721-1-f4bug@amsat.org>
References: <20180528232719.4721-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 05/21] target/i386: Do not include
 "exec/ioport.h" if it is not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, "open list:X86" <kvm@vger.kernel.org>

Code change produced with:
    $ git grep '#include "exec/ioport.h"' target | \
      cut -d: -f-1 | \
      xargs egrep -Li "(portio|cpu_(in|out).\()" | \
      xargs sed -i.bak '/#include "exec\/ioport.h"/d'

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/i386/hax-all.c      | 1 -
 target/i386/hvf/hvf.c      | 1 -
 target/i386/hvf/x86_task.c | 1 -
 target/i386/kvm.c          | 1 -
 4 files changed, 4 deletions(-)

diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index cad7531406..c5856bbdc3 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -27,7 +27,6 @@
 #include "cpu.h"
 #include "exec/address-spaces.h"
 #include "exec/exec-all.h"
-#include "exec/ioport.h"
 
 #include "qemu-common.h"
 #include "hax-i386.h"
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index c36753954b..f6c872e678 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -66,7 +66,6 @@
 
 #include "exec/address-spaces.h"
 #include "exec/exec-all.h"
-#include "exec/ioport.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/boards.h"
 #include "qemu/main-loop.h"
diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index c3ead2ca73..7610d85802 100644
--- a/target/i386/hvf/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -27,7 +27,6 @@
 #include <Hypervisor/hv_vmx.h>
 
 #include "exec/exec-all.h"
-#include "exec/ioport.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/boards.h"
 #include "qemu/main-loop.h"
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 6511329d11..9d8f80f4c0 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -40,7 +40,6 @@
 #include "hw/i386/intel_iommu.h"
 #include "hw/i386/x86-iommu.h"
 
-#include "exec/ioport.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
-- 
2.17.0
