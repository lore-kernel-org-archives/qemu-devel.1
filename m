Received: from eggs.gnu.org ([2001:4830:134:3::10]:39570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cYWo1-0001Ir-Bk
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 06:41:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cYWnw-0004E9-GJ
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 06:41:01 -0500
Received: from mail.ispras.ru ([83.149.199.45]:56062)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cYWnw-0004Dt-8y
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 06:40:56 -0500
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Tue, 31 Jan 2017 14:40:54 +0300
Message-ID: <20170131114054.276.62201.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] apic: reset apic_delivered global variable on
 machine reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, dovgaluk@ispras.ru, mst@redhat.com

This patch adds call to apic_reset_irq_delivered when the virtual
machine is reset.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 hw/intc/apic_common.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 17df24c..cda3e9c 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -251,6 +251,8 @@ static void apic_reset_common(DeviceState *dev)
     s->apicbase = APIC_DEFAULT_ADDRESS | bsp | MSR_IA32_APICBASE_ENABLE;
     s->id = s->initial_apic_id;
 
+    apic_reset_irq_delivered();
+
     s->vapic_paddr = 0;
     info->vapic_base_update(s);
 
