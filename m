Received: from eggs.gnu.org ([2001:4830:134:3::10]:51753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6S-0003cz-Bh
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6Q-000836-Ua
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:12 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Feb 2017 15:31:30 +0100
Message-Id: <1487255507-106654-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/23] apic: reset apic_delivered global
 variable on machine reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-stable@nongnu.org

From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

This patch adds call to apic_reset_irq_delivered when the virtual
machine is reset.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Message-Id: <20170131114054.276.62201.stgit@PASHA-ISP>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/intc/apic_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 6ce8ef7..7a6e771 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -251,6 +251,8 @@ static void apic_reset_common(DeviceState *dev)
     s->apicbase = APIC_DEFAULT_ADDRESS | bsp | MSR_IA32_APICBASE_ENABLE;
     s->id = s->initial_apic_id;
 
+    apic_reset_irq_delivered();
+
     s->vapic_paddr = 0;
     info->vapic_base_update(s);
 
-- 
1.8.3.1
