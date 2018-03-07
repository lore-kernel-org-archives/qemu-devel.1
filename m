Received: from eggs.gnu.org ([2001:4830:134:3::10]:48000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etXye-0001dZ-6o
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:15:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etXyZ-0003ue-A9
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:15:24 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  7 Mar 2018 13:15:15 +0100
Message-Id: <1520424915-9794-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] tests/boot-serial: Check the 40p machine, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org

The "40p" machine is using the Open Hack'Ware BIOS, just like the "prep"
machine, so we can test it accordingly with the boot-serial tester, too.
While we're at it, also change the strings that we are using for the
"prep" machine, so that this test now also checks some CLI parameters.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 NB: The 40p machine is currently broken - when the emulator is quit,
 there is a rcu_read_unlock assertion message printed out. This test
 here succeeds anyway since the qtest framework does not care about
 errors in the shutdown path yet.

 tests/boot-serial-test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index ece25c6..5b24cd2 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -75,11 +75,13 @@ typedef struct testdef {
 static testdef_t tests[] = {
     { "alpha", "clipper", "", "PCI:" },
     { "ppc", "ppce500", "", "U-Boot" },
-    { "ppc", "prep", "", "Open Hack'Ware BIOS" },
+    { "ppc", "prep", "-m 96", "Memory size: 96 MB" },
+    { "ppc", "40p", "-boot d", "Booting from device d" },
     { "ppc", "g3beige", "", "PowerPC,750" },
     { "ppc", "mac99", "", "PowerPC,G4" },
     { "ppc64", "ppce500", "", "U-Boot" },
-    { "ppc64", "prep", "", "Open Hack'Ware BIOS" },
+    { "ppc64", "prep", "-boot e", "Booting from device e" },
+    { "ppc64", "40p", "-m 192", "Memory size: 192 MB" },
     { "ppc64", "mac99", "", "PowerPC,970FX" },
     { "ppc64", "pseries", "", "Open Firmware" },
     { "ppc64", "powernv", "-cpu POWER8", "OPAL" },
-- 
1.8.3.1
