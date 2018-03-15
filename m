Received: from eggs.gnu.org ([2001:4830:134:3::10]:40664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ewKMJ-00074B-Da
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 00:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ewKMI-00044A-ES
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 00:19:19 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 15 Mar 2018 15:19:02 +1100
Message-Id: <20180315041903.10046-9-david@gibson.dropbear.id.au>
In-Reply-To: <20180315041903.10046-1-david@gibson.dropbear.id.au>
References: <20180315041903.10046-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 8/9] tests/boot-serial: Test the sam460ex board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, lvivier@redhat.com, surajjs@au1.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

We've got a U-Boot firmware for this board in our repository, and
the firmware prints some output to the serial console, so we can
check this board in the boot-serial tester, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 tests/boot-serial-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 5b24cd26c1..011525d8cf 100644
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
2.14.3
