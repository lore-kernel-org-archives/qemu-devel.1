Received: from eggs.gnu.org ([2001:4830:134:3::10]:60938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTRbF-0001F6-5M
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTRbB-0005K7-5k
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:43:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41786 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fTRbB-0005Jh-1d
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:43:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 47238401EF06
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 12:43:32 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 14 Jun 2018 14:43:28 +0200
Message-Id: <20180614124330.12224-2-armbru@redhat.com>
In-Reply-To: <20180614124330.12224-1-armbru@redhat.com>
References: <20180614124330.12224-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 1/3] Revert "Makefile: add target to print
 generated files"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>

This reverts commit 9578f8cc3e8bd71de8e3f543dc7b95644d64824e.

The patch snuck in by accident without having been posted to
qemu-devel.  It's entirely redundant: existing target print-% already
serves the purpose.

Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180504054241.6833-1-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Makefile b/Makefile
index 6c6664d9a3..355b44ff37 100644
--- a/Makefile
+++ b/Makefile
@@ -1055,9 +1055,6 @@ endif
 include $(SRC_PATH)/tests/docker/Makefile.include
 include $(SRC_PATH)/tests/vm/Makefile.include
 
-printgen:
-	@echo $(GENERATED_FILES)
-
 .PHONY: help
 help:
 	@echo  'Generic targets:'
-- 
2.17.1
