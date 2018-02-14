Received: from eggs.gnu.org ([2001:4830:134:3::10]:43582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elv7U-0006Si-2U
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elv7T-0007E0-3o
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:21:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41990 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1elv7S-0007Ds-V6
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:20:59 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 14 Feb 2018 12:20:29 +0100
Message-Id: <1518607234-17739-14-git-send-email-thuth@redhat.com>
In-Reply-To: <1518607234-17739-1-git-send-email-thuth@redhat.com>
References: <1518607234-17739-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 13/18] tests/boot-serial: Add tests for PowerPC
 Mac machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

OpenBIOS prints out the CPU type on these machine types, so we can use
this string to test whether the CPU detection is working correctly.

Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/boot-serial-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 996d3d7..72873ee 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -69,8 +69,11 @@ static testdef_t tests[] = {
     { "alpha", "clipper", "", "PCI:" },
     { "ppc", "ppce500", "", "U-Boot" },
     { "ppc", "prep", "", "Open Hack'Ware BIOS" },
+    { "ppc", "g3beige", "", "PowerPC,750" },
+    { "ppc", "mac99", "", "PowerPC,G4" },
     { "ppc64", "ppce500", "", "U-Boot" },
     { "ppc64", "prep", "", "Open Hack'Ware BIOS" },
+    { "ppc64", "mac99", "", "PowerPC,970FX" },
     { "ppc64", "pseries", "", "Open Firmware" },
     { "ppc64", "powernv", "-cpu POWER8", "OPAL" },
     { "i386", "isapc", "-cpu qemu32 -device sga", "SGABIOS" },
-- 
1.8.3.1
