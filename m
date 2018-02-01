Received: from eggs.gnu.org ([2001:4830:134:3::10]:39790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ehBo2-00008L-B0
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:09:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ehBnx-0001t1-Gv
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:09:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ehBnx-0001rt-BW
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:09:17 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  1 Feb 2018 11:09:10 +0100
Message-Id: <1517479750-16770-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1517479750-16770-1-git-send-email-thuth@redhat.com>
References: <1517479750-16770-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] tests/boot-serial: Add a test for the new
 hppa-softmmu target
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

The hppa machine comes with a firmware image, so we can easily
include this in the boot-serial tester, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include   | 2 ++
 tests/boot-serial-test.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 0b98dd7..6609276 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -299,6 +299,8 @@ gcov-files-x86_64-y = $(subst i386-softmmu/,x86_64-softmmu/,$(gcov-files-i386-y)
 
 check-qtest-alpha-y = tests/boot-serial-test$(EXESUF)
 
+check-qtest-hppa-y = tests/boot-serial-test$(EXESUF)
+
 check-qtest-m68k-y = tests/boot-serial-test$(EXESUF)
 
 check-qtest-microblaze-y = tests/boot-serial-test$(EXESUF)
diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 12bf6ec..ddaa78f 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -67,6 +67,7 @@ typedef struct testdef {
 
 static testdef_t tests[] = {
     { "alpha", "clipper", "", "PCI:" },
+    { "hppa", "hppa", "", "Firmware Version" },
     { "ppc", "ppce500", "", "U-Boot" },
     { "ppc", "prep", "", "Open Hack'Ware BIOS" },
     { "ppc", "g3beige", "", "PowerPC,750" },
-- 
1.8.3.1
