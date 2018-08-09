Received: from eggs.gnu.org ([2001:4830:134:3::10]:58545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1fnrjm-0000La-Vy
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 16:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1fnrjW-0006Tc-TD
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 16:40:50 -0400
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Thu,  9 Aug 2018 22:40:10 +0200
Message-Id: <20180809204010.3579-3-hpoussin@reactos.org>
In-Reply-To: <20180809204010.3579-1-hpoussin@reactos.org>
References: <20180809204010.3579-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] hw/ppc: deprecate the machine type 'prep',
 replaced by '40p'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

- prep machine is a fictional machine, so has no specifications. Which
  devices can be changed/added/removed without impact? Are interrupts
  correctly mapped?
- prep firmware (OHW) has support only for IDE drives (no SCSI).
  Booting from IDE has been broken approximatively 3 years ago, and nobody complained.
- OHW is limited on IDE boot to a specific set of OS loaders.
  These operating systems are of the 2004 time frame.
- OHW can use -kernel. Linux kernel freezes a long time after PS/2 mouse
  detection, and then screen becomes garbage. This was already broken in
  QEMU v2.7, 2 years ago, and nobody complained.

On the other side:
- 40p is a real machine, so emulation can be checked against
  hardware specifications
- OpenBIOS has support for SCSI block devices, including 40p LSI adapter
- OpenBIOS can start mostly all Linux kernels (including recent ones)
  and recent operating system (like NetBSD 7.1.2)

Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/ppc/prep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 1558855247..fbcaebabc0 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -676,6 +676,7 @@ static void ppc_prep_init(MachineState *machine)
 
 static void prep_machine_init(MachineClass *mc)
 {
+    mc->deprecation_reason = "use 40p machine type instead";
     mc->desc = "PowerPC PREP platform";
     mc->init = ppc_prep_init;
     mc->block_default_type = IF_IDE;
-- 
2.11.0
