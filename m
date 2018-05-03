Received: from eggs.gnu.org ([2001:4830:134:3::10]:57643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGU-00039O-Kk
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGR-0003D2-Gt
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54324 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKGR-0003CU-Ci
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:39 -0400
Date: Thu, 3 May 2018 22:51:38 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-58-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 57/67] kvm: use include "kvm_i386.h"
 consistently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

Some places include kvm_i386.h, others target/i386/kvm_i386.h.
Let's be consistent.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/kvm/apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 1df6d26..ce43c3c 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -16,7 +16,7 @@
 #include "hw/pci/msi.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
-#include "target/i386/kvm_i386.h"
+#include "kvm_i386.h"
 
 static inline void kvm_apic_set_reg(struct kvm_lapic_state *kapic,
                                     int reg_id, uint32_t val)
-- 
MST
