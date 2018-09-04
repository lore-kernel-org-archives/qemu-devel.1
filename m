Received: from eggs.gnu.org ([2001:4830:134:3::10]:40713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1fxHKF-00025N-JC
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 15:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1fxHKC-0007yJ-DC
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 15:49:23 -0400
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Tue,  4 Sep 2018 21:49:03 +0200
Message-Id: <20180904194903.20712-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] hw/ppc: on 40p machine,
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
Use it, instead of relying on an unmaintained and very limited firmware.

Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/ppc/prep.c            | 2 +-
 tests/boot-serial-test.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

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
diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 952a2e7ead..276ca14c97 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -76,13 +76,13 @@ static testdef_t tests[] = {
     { "alpha", "clipper", "", "PCI:" },
     { "ppc", "ppce500", "", "U-Boot" },
     { "ppc", "prep", "-m 96", "Memory size: 96 MB" },
-    { "ppc", "40p", "-boot d", "Booting from device d" },
+    { "ppc", "40p", "-vga none -boot d", "Trying cd:," },
     { "ppc", "g3beige", "", "PowerPC,750" },
     { "ppc", "mac99", "", "PowerPC,G4" },
     { "ppc", "sam460ex", "-m 256", "DRAM:  256 MiB" },
     { "ppc64", "ppce500", "", "U-Boot" },
     { "ppc64", "prep", "-boot e", "Booting from device e" },
-    { "ppc64", "40p", "-m 192", "Memory size: 192 MB" },
+    { "ppc64", "40p", "-m 192", "Memory: 192M" },
     { "ppc64", "mac99", "", "PowerPC,970FX" },
     { "ppc64", "pseries", "", "Open Firmware" },
     { "ppc64", "powernv", "-cpu POWER8", "OPAL" },
-- 
2.11.0
