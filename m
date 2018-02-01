Received: from eggs.gnu.org ([2001:4830:134:3::10]:39785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ehBo1-00007k-VR
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:09:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ehBnw-0001qW-Ax
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:09:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ehBnw-0001pQ-50
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:09:16 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  1 Feb 2018 11:09:09 +0100
Message-Id: <1517479750-16770-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1517479750-16770-1-git-send-email-thuth@redhat.com>
References: <1517479750-16770-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] tests/boot-serial: Add tests for PowerPC
 Mac machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

OpenBIOS prints out the CPU type on these machine types, so we can use
this string to test whether the CPU detection is working correctly.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/boot-serial-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index abc7f2d..12bf6ec 100644
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
