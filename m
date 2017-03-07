Received: from eggs.gnu.org ([2001:4830:134:3::10]:34626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1clGv0-0003UZ-SF
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:20:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1clGuz-0003P1-8Q
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:20:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:11974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1clGuz-0003OJ-2o
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:20:53 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E9188F02B
	for <qemu-devel@nongnu.org>; Tue,  7 Mar 2017 15:20:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v27FKmq5007487
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 7 Mar 2017 10:20:49 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  7 Mar 2017 16:20:23 +0100
Message-Id: <1488900045-26344-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1488900045-26344-1-git-send-email-armbru@redhat.com>
References: <1488900045-26344-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v4 02/24] tests: Fix gcov-files-test-qemu-opts-y,
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
index ace4e80..b65c2b5 100644
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
