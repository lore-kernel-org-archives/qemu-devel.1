Received: from eggs.gnu.org ([2001:4830:134:3::10]:45005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dr3N2-0007dV-PU
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 10:38:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dr3Mz-0000UN-N8
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 10:38:00 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 10 Sep 2017 15:37:34 +0100
Message-Id: <1505054255-2990-4-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 3/4] ppc: add CPU access_type into the
 migration stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, aik@ozlabs.ru, lvivier@redhat.com

This is referenced in cpu_ppc_handle_mmu_fault() and so should be included
in the migration stream.

Note: the vmstate_ppc version number has already been bumped by the previous
patch in this series.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/machine.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 8fec1a4..10b3c41 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -676,7 +676,7 @@ const VMStateDescription vmstate_ppc_cpu = {
 
         /* Internal state */
         VMSTATE_UINTTL(env.hflags_nmsr, PowerPCCPU),
-        /* FIXME: access_type? */
+        VMSTATE_UINT8_V(env.access_type, PowerPCCPU, 6),
 
         /* Interrupt state */
         VMSTATE_UINT32_V(env.pending_interrupts, PowerPCCPU, 6),
-- 
1.7.10.4
