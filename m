Received: from eggs.gnu.org ([2001:4830:134:3::10]:33596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciqDt-00056T-Rv
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciqDq-0000W5-HM
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ciqDq-0000Vd-CF
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:18 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7AAB03B71B
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 22:26:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 46B241DCC0
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 22:26:18 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 23:25:53 +0100
Message-Id: <1488320775-9849-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1488320775-9849-1-git-send-email-armbru@redhat.com>
References: <1488320775-9849-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 02/24] tests: Fix gcov-files-test-qemu-opts-y,
 gcov-files-test-logging-y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <1488317230-26248-3-git-send-email-armbru@redhat.com>
---
 tests/Makefile.include | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 8b3e2bd..35d07e4 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -93,7 +93,7 @@ gcov-files-check-qom-interface-y = qom/object.c
 check-unit-y += tests/check-qom-proplist$(EXESUF)
 gcov-files-check-qom-proplist-y = qom/object.c
 check-unit-y += tests/test-qemu-opts$(EXESUF)
-gcov-files-test-qemu-opts-y = qom/test-qemu-opts.c
+gcov-files-test-qemu-opts-y = util/qemu-option.c
 check-unit-y += tests/test-write-threshold$(EXESUF)
 gcov-files-test-write-threshold-y = block/write-threshold.c
 check-unit-y += tests/test-crypto-hash$(EXESUF)
@@ -118,8 +118,8 @@ check-unit-y += tests/test-crypto-ivgen$(EXESUF)
 check-unit-y += tests/test-crypto-afsplit$(EXESUF)
 check-unit-y += tests/test-crypto-xts$(EXESUF)
 check-unit-y += tests/test-crypto-block$(EXESUF)
-gcov-files-test-logging-y = tests/test-logging.c
 check-unit-y += tests/test-logging$(EXESUF)
+gcov-files-test-logging-y = util/log.c
 check-unit-$(CONFIG_REPLICATION) += tests/test-replication$(EXESUF)
 check-unit-y += tests/test-bufferiszero$(EXESUF)
 gcov-files-check-bufferiszero-y = util/bufferiszero.c
-- 
2.7.4
