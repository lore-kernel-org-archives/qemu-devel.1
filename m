Received: from eggs.gnu.org ([2001:4830:134:3::10]:58461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1fnrjj-0000KY-WA
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 16:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1fnrjV-0006Rp-3V
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 16:40:48 -0400
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Thu,  9 Aug 2018 22:40:09 +0200
Message-Id: <20180809204010.3579-2-hpoussin@reactos.org>
In-Reply-To: <20180809204010.3579-1-hpoussin@reactos.org>
References: <20180809204010.3579-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/2] hw/ppc: on 40p machine,
 change default firmware to OpenBIOS
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

OpenBIOS gained 40p support in 5b20e4cacecb62fb2bdc6867c11d44cddd77c4ff
Use it, instead of relying on the presence of a proprietary firmware.

Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/ppc/prep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 3401570d98..1558855247 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -736,7 +736,7 @@ static void ibm_40p_init(MachineState *machine)
     /* PCI host */
     dev = qdev_create(NULL, "raven-pcihost");
     if (!bios_name) {
-        bios_name = BIOS_FILENAME;
+        bios_name = "openbios-ppc";
     }
     qdev_prop_set_string(dev, "bios-name", bios_name);
     qdev_prop_set_uint32(dev, "elf-machine", PPC_ELF_MACHINE);
-- 
2.11.0
