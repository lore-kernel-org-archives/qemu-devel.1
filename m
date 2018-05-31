Received: from eggs.gnu.org ([2001:4830:134:3::10]:58386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8I-0003Pj-5d
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8H-0008M9-A2
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41448 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOR8H-0008Lh-5p
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:01 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:06 +0200
Message-Id: <20180531171253.21012-7-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/53] target/i386: Do not include
 "exec/ioport.h" if it is not necessary
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
    $ git grep '#include "exec/ioport.h"' target | \
      cut -d: -f-1 | \
      xargs egrep -Li "(portio|cpu_(in|out).\()" | \
      xargs sed -i.bak '/#include "exec\/ioport.h"/d'

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180528232719.4721-6-f4bug@amsat.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
=20
 #include "qemu-common.h"
 #include "hax-i386.h"
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index c36753954b..f6c872e678 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -66,7 +66,6 @@
=20
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
=20
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
=20
-#include "exec/ioport.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
--=20
2.17.0
