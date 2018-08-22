Received: from eggs.gnu.org ([2001:4830:134:3::10]:33995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsPqf-0007pt-WD
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsPqb-0004sp-4W
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:54:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39754 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsPqa-0004sL-Va
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:54:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A04E98076894
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 09:54:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Aug 2018 11:54:18 +0200
Message-Id: <20180822095421.11765-8-quintela@redhat.com>
In-Reply-To: <20180822095421.11765-1-quintela@redhat.com>
References: <20180822095421.11765-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v3 07/10] check: Only test boot-serial when sga
 is compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

This is only for x86* architecture.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 116e93cdb6..d524e1bdeb 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -257,7 +257,7 @@ check-qtest-i386-y += tests/hd-geo-test$(EXESUF)
 gcov-files-i386-y += hw/block/hd-geometry.c
 check-qtest-i386-y += tests/boot-order-test$(EXESUF)
 check-qtest-i386-y += tests/bios-tables-test$(EXESUF)
-check-qtest-i386-y += tests/boot-serial-test$(EXESUF)
+check-qtest-i386-$(CONFIG_SGA) += tests/boot-serial-test$(EXESUF)
 check-qtest-i386-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
 check-qtest-i386-y += tests/rtc-test$(EXESUF)
 check-qtest-i386-y += tests/ipmi-kcs-test$(EXESUF)
-- 
2.17.1
