Received: from eggs.gnu.org ([2001:4830:134:3::10]:44255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ca1OX-0004p8-JR
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 09:32:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ca1OU-0002AW-Gj
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 09:32:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ca1OU-0002AK-Am
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 09:32:50 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4BABAC057FA5
	for <qemu-devel@nongnu.org>; Sat,  4 Feb 2017 14:32:50 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Sat,  4 Feb 2017 22:32:45 +0800
Message-Id: <20170204143245.15974-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] Makefile: Make "install" depend on
 "trace-events-all"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, stefanha@redhat.com

We install this file to data dir but since 0ab8ed18 it's no longer
required by any objects during "make". List it explicitly as a depended
target of install and fix the broken "make install" command.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 4b72a4c..b993741 100644
--- a/Makefile
+++ b/Makefile
@@ -589,7 +589,7 @@ endif
 endif
 
 
-install: all $(if $(BUILD_DOCS),install-doc) \
+install: all $(if $(BUILD_DOCS),install-doc) $(BUILD_DIR)/trace-events-all \
 install-datadir install-localstatedir
 ifneq ($(TOOLS),)
 	$(call install-prog,$(subst qemu-ga,qemu-ga$(EXESUF),$(TOOLS)),$(DESTDIR)$(bindir))
-- 
2.9.3
