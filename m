Received: from eggs.gnu.org ([2001:4830:134:3::10]:54319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cQJKu-0005NL-5v
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 14:41:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cQJKr-0008O7-0A
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 14:41:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cQJKq-0008Nn-RU
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 14:40:56 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F039961B92
	for <qemu-devel@nongnu.org>; Sun,  8 Jan 2017 19:40:56 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Sun,  8 Jan 2017 17:40:37 -0200
Message-Id: <20170108194041.10908-2-ehabkost@redhat.com>
In-Reply-To: <20170108194041.10908-1-ehabkost@redhat.com>
References: <20170108194041.10908-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] i386: Add explicit array size to
 x86_cpu_vendor_words2str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com

Add explicit array size to x86_cpu_vendor_words2str() to let the
compiler check if we are really passing an array of the right
size.

GCC still doesn't print a warning when the array is too small[1],
but clang already does.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=50584

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a149c8dc42..25b802bb06 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -169,7 +169,7 @@
 
 
 
-static void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
+static void x86_cpu_vendor_words2str(char dst[static (CPUID_VENDOR_SZ + 1)], uint32_t vendor1,
                                      uint32_t vendor2, uint32_t vendor3)
 {
     int i;
-- 
2.11.0.259.g40922b1
