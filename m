Received: from eggs.gnu.org ([2001:4830:134:3::10]:47534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuEOK-0001Xn-UT
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuEOF-0005En-UV
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:05:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59756 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fuEOF-0005EX-Og
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:04:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6DE788010FDF
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 10:04:55 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 27 Aug 2018 12:04:28 +0200
Message-Id: <20180827100431.7915-7-quintela@redhat.com>
In-Reply-To: <20180827100431.7915-1-quintela@redhat.com>
References: <20180827100431.7915-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 6/9] check: Only test boot-serial when sga is
 compiled in
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 9edfdbe56f..d0c0a92e67 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -265,7 +265,7 @@ check-qtest-i386-y += tests/hd-geo-test$(EXESUF)
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
