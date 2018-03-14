Received: from eggs.gnu.org ([2001:4830:134:3::10]:38939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1evy2I-0001eh-5m
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 00:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1evy2F-0008DB-1d
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 00:29:10 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 14 Mar 2018 05:28:55 +0100
Message-Id: <1521001735-24149-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] tests/boot-serial: Test the sam460ex board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, balaton@eik.bme.hu

We've got a U-Boot firmware for this board in our repository, and
the firmware prints some output to the serial console, so we can
check this board in the boot-serial tester, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: Patch has to be applied on top of the ppc-for-2.12 branch

 tests/boot-serial-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 5b24cd2..011525d 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -79,12 +79,14 @@ static testdef_t tests[] = {
     { "ppc", "40p", "-boot d", "Booting from device d" },
     { "ppc", "g3beige", "", "PowerPC,750" },
     { "ppc", "mac99", "", "PowerPC,G4" },
+    { "ppc", "sam460ex", "-m 256", "DRAM:  256 MiB" },
     { "ppc64", "ppce500", "", "U-Boot" },
     { "ppc64", "prep", "-boot e", "Booting from device e" },
     { "ppc64", "40p", "-m 192", "Memory size: 192 MB" },
     { "ppc64", "mac99", "", "PowerPC,970FX" },
     { "ppc64", "pseries", "", "Open Firmware" },
     { "ppc64", "powernv", "-cpu POWER8", "OPAL" },
+    { "ppc64", "sam460ex", "-device e1000", "8086  100e" },
     { "i386", "isapc", "-cpu qemu32 -device sga", "SGABIOS" },
     { "i386", "pc", "-device sga", "SGABIOS" },
     { "i386", "q35", "-device sga", "SGABIOS" },
-- 
1.8.3.1
