Received: from eggs.gnu.org ([2001:4830:134:3::10]:56997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dSf8j-0004XC-Vi
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dSf8f-0006uT-PL
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:54:26 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1dSf8f-0006u2-Jm
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:54:21 -0400
Received: by mail-wm0-x244.google.com with SMTP id j85so30641254wmj.0
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:54:19 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Wed,  5 Jul 2017 10:54:07 +0300
Message-Id: <20170705075411.6556-2-sameeh@daynix.com>
In-Reply-To: <20170705075411.6556-1-sameeh@daynix.com>
References: <20170705075411.6556-1-sameeh@daynix.com>
Subject: [Qemu-devel] [PATCH 1/5] Makefile: clean: Clean exe files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>

From: Sameeh Jubran <sjubran@redhat.com>

Clean exe files such as qemu-ga.exe

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 16a0430..22d29d6 100644
--- a/Makefile
+++ b/Makefile
@@ -487,6 +487,7 @@ clean:
 	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h gen-op-arm.h
 	rm -f qemu-options.def
 	rm -f *.msi
+	rm -f *${EXESUF}
 	find . \( -name '*.so' -o -name '*.dll' -o -name '*.mo' -o -name '*.[oda]' \) -type f -exec rm {} +
 	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga TAGS cscope.* *.pod *~ */*~
 	rm -f fsdev/*.pod
-- 
2.9.4
