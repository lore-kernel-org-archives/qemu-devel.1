Received: from eggs.gnu.org ([2001:4830:134:3::10]:45505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ejsWF-0002ZP-Qr
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:10:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ejsWA-0002Pk-6V
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:10:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53836 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ejsWA-0002PU-2K
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:10:02 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B8C64040073
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 20:10:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  8 Feb 2018 21:09:40 +0100
Message-Id: <1518120582-26647-13-git-send-email-thuth@redhat.com>
In-Reply-To: <1518120582-26647-1-git-send-email-thuth@redhat.com>
References: <1518120582-26647-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 12/14] tests/boot-serial: Enable the
 boot-serial test on SPARC machines, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

OpenBIOS prints out the name of the detected CPU here, so looking for
this string is a nice test to verify that the CPU detection is still
working correctly.

Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include   | 2 ++
 tests/boot-serial-test.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 83def69..6609276 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -352,11 +352,13 @@ check-qtest-sh4eb-y = tests/endianness-test$(EXESUF)
 check-qtest-sparc-y = tests/prom-env-test$(EXESUF)
 #check-qtest-sparc-y += tests/m48t59-test$(EXESUF)
 #gcov-files-sparc-y = hw/timer/m48t59.c
+check-qtest-sparc-y += tests/boot-serial-test$(EXESUF)
 
 check-qtest-sparc64-y = tests/endianness-test$(EXESUF)
 #check-qtest-sparc64-y += tests/m48t59-test$(EXESUF)
 #gcov-files-sparc64-y += hw/timer/m48t59.c
 check-qtest-sparc64-y += tests/prom-env-test$(EXESUF)
+check-qtest-sparc64-y += tests/boot-serial-test$(EXESUF)
 
 check-qtest-arm-y = tests/tmp105-test$(EXESUF)
 check-qtest-arm-y += tests/ds1338-test$(EXESUF)
diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index ea87a80..996d3d7 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -78,6 +78,10 @@ static testdef_t tests[] = {
     { "i386", "q35", "-device sga", "SGABIOS" },
     { "x86_64", "isapc", "-cpu qemu32 -device sga", "SGABIOS" },
     { "x86_64", "q35", "-device sga", "SGABIOS" },
+    { "sparc", "LX", "", "TMS390S10" },
+    { "sparc", "SS-4", "", "MB86904" },
+    { "sparc", "SS-600MP", "", "TMS390Z55" },
+    { "sparc64", "sun4u", "", "UltraSPARC" },
     { "s390x", "s390-ccw-virtio",
       "-nodefaults -device sclpconsole,chardev=serial0", "virtio device" },
     { "m68k", "mcf5208evb", "", "TT", sizeof(kernel_mcf5208), kernel_mcf5208 },
-- 
1.8.3.1
